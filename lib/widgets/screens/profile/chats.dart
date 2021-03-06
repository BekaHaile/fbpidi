import 'dart:async';
import 'dart:math';

import 'package:fbpidi/models/chats.dart';
import 'package:fbpidi/services/chats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class ChatList extends StatefulWidget {
  State<StatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final storage = new FlutterSecureStorage();
  TextEditingController searchFieldController = new TextEditingController();
  bool _loading = false;
  String userid;
  List<Chat> _chats;
  List<ChatUser> _chatusers = [];
  String token = "";
  bool searching = false;
  bool searchenabled = false;
  @override
  void initState() {
    super.initState();
    _loading = true;
    getChatList();
  }

  void getChatList() async {
    await storage.readAll().then((value) async {
      setState(() {
        userid = value['id'];
        token = value['token'];
      });
      Timer.periodic(
          Duration(seconds: 5),
          (Timer t) => ChatService.getChatList(token).then((value) async {
                if (mounted)
                  setState(() {
                    _chats = value['chats_list'];
                    _loading = false;
                  });
              }));
    });
  }

  void searchChatUsers(srchstring) {
    ChatService.getChatUseList(token, srchstring).then((value) {
      if (value != null) {
        setState(() {
          _chatusers = value['chatusers'];
          searching = true;
        });
      }
    });
  }

  String formatedDate(datedata) {
    var formatter1 = new DateFormat("yy/mm/dd HH:mm");
    var formatter = new DateFormat('MMM dd');
    DateTime dateTime = formatter1.parse(datedata);
    String formattedDate = formatter.format(dateTime);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor:
              searchenabled ? Colors.white : Theme.of(context).primaryColor,
          leading: searchenabled
              ? popIcon(() {
                  setState(() {
                    searchenabled = false;
                    searching = false;
                  });
                }, Colors.black)
              : popIcon(() {
                  Navigator.pop(context);
                }, Colors.white),
          title: searchenabled
              ? Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: TextField(
                    style: TextStyle(backgroundColor: Colors.white),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                          backgroundColor: Colors.white, color: Colors.black),
                      hintText: "Write Username Here",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    onChanged: (srchstring) {
                      setState(() {
                        searching = true;
                      });
                      searchChatUsers(srchstring);
                    },
                  ),
                )
              : Text("Your Chats"),
          actions: searchenabled
              ? null
              : [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            searchenabled = true;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("search user"),
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ]),
      body: _loading
          ? Center(
              child: Container(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(),
              ),
            )
          : searching
              ? ListView.builder(
                  itemCount: _chatusers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/chats_detail",
                            arguments: {
                              'chat_name': _chatusers[index].username,
                              'token': token,
                            });
                      },
                      leading: CircleAvatar(
                        foregroundImage: NetworkImage(
                            ChatService.baseUrl + _chatusers[index].pimage),
                      ),
                      title: Text(_chatusers[index].firstname +
                          " " +
                          _chatusers[index].lastname),
                      subtitle: Text(_chatusers[index].email),
                    );
                  })
              : ListView.builder(
                  itemCount: _chats.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () async {
                        Navigator.pushNamed(context, "/chats_detail",
                            arguments: {
                              'chat_name':
                                  userid == _chats[index].senderid.toString()
                                      ? _chats[index].receivername
                                      : _chats[index].sendername,
                              'token': token,
                            });
                      },
                      leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              userid == _chats[index].senderid.toString()
                                  ? ChatService.baseUrl +
                                      _chats[index].receiverimage
                                  : ChatService.baseUrl +
                                      _chats[index].senderimage)),
                      title: Text(userid == _chats[index].senderid.toString()
                          ? _chats[index].receiverfullname
                          : _chats[index].senderfullname),
                      subtitle: Row(
                        children: [
                          Icon(
                            _chats[index].seen ? Icons.done_all : Icons.done,
                            color: Colors.lightBlue,
                          ),
                          SizedBox(width: 10),
                          Text(_chats[index].message.substring(
                              0, min(_chats[index].message.length, 10)))
                        ],
                      ),
                      trailing: Text(formatedDate(_chats[index].time)),
                    );
                  }),
    );
  }

  IconButton popIcon(Function press, Color color) => IconButton(
      onPressed: () {
        press();
      },
      icon: Icon(Icons.arrow_back, color: color));
}
