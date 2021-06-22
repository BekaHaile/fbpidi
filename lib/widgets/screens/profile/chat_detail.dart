import 'dart:async';

import 'package:fbpidi/models/chats.dart';
import 'package:fbpidi/services/chats.dart';
import 'package:fbpidi/widgets/screens/profile/message_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class ChatDetail extends StatefulWidget {
  final chatdata;
  ChatDetail(this.chatdata);

  State<StatefulWidget> createState() => _ChatDetailState(chatdata);
}

class _ChatDetailState extends State<ChatDetail> {
  TextEditingController messageController = new TextEditingController();
  ScrollController _scrollcontroller = new ScrollController();
  final chatdata;
  final storage = FlutterSecureStorage();
  String token;
  bool _loading = false;
  List<Chat> _messages;
  ChatUser _chatuser;
  _ChatDetailState(this.chatdata);

  String formatedDate(datedata) {
    var formatter1 = new DateFormat("yy/mm/dd HH:mm");
    var formatter = new DateFormat('MMM dd');
    DateTime dateTime = formatter1.parse(datedata);
    String formattedDate = formatter.format(dateTime);

    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    getMessages();
    if (!_loading) {
      _scrollcontroller.jumpTo(_scrollcontroller.position.maxScrollExtent);
    }
  }

  void getMessages() async {
    Timer.periodic(
        Duration(seconds: 5),
        (Timer t) =>
            ChatService.getChatDetail(chatdata['token'], chatdata['chat_name'])
                .then((value) async {
              if (value != null) {
                if (mounted)
                  setState(() {
                    token = chatdata['token'];
                    _chatuser = value['other_user'];
                    _messages = value['chats_messages'];
                    _loading = false;
                  });
              } else {}
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                _loading
                    ? Text("Loading...")
                    : CircleAvatar(
                        // foregroundImage: NetworkImage(
                        //     ChatService.baseUrl + _chatuser.pimage),
                        backgroundImage: NetworkImage(
                            ChatService.baseUrl + _chatuser.pimage.toString()),
                        maxRadius: 20,
                      ),
                SizedBox(
                  width: 12,
                ),
                _loading
                    ? Center()
                    : Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              _chatuser.firstname + " " + _chatuser.lastname,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              _chatuser.email,
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      body: _loading
          ? Center(
              child: Container(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ))
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Expanded(
                    // height: MediaQuery.of(context).size.height - 140,
                    child: ListView.builder(
                      // controller: _scrollcontroller,
                      itemCount: _messages.length,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _messages[index].senderid == _chatuser.id
                            ? ReplyCard(
                                message: _messages[index].message,
                                time: formatedDate(_messages[index].time),
                              )
                            : MyMessageCard(
                                message: _messages[index].message,
                                time: formatedDate(_messages[index].time),
                                seen: _messages[index].seen,
                              );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      height: 60,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              controller: messageController,
                              decoration: InputDecoration(
                                  hintText: "Write message...",
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          FloatingActionButton(
                            onPressed: () async {
                              await ChatService.sendMessage(_chatuser.username,
                                      messageController.text, token)
                                  .then((value) async {
                                setState(() {
                                  messageController.clear();
                                  _messages.add(value);
                                });
                              });
                            },
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                            backgroundColor: Colors.blue,
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}


// FutureBuilder(
//               future: storage.read(key: 'token'),
//               // ignore: missing_return
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData)
//                   // Navigator.pushReplacement(context, MaterialPageRoute(builder: builder));
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Center(
//                       child: Container(
//                           width: 30,
//                           height: 30,
//                           child: CircularProgressIndicator()),
//                     ),
//                   );
//                 else {
//                   token = snapshot.data;
//                   return FutureBuilder<Map<String, dynamic>>(
//                       // ignore: missing_return
//                       future:
//                           ChatService.getChatDetail(token, chatdata['chat_id']),
//                       builder: (context, snapshot) {
//                         if (!snapshot.hasData)
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Center(
//                               child: Container(
//                                   width: 30,
//                                   height: 30,
//                                   child: Center(
//                                     child: CircularProgressIndicator(),
//                                   )),
//                             ),
//                           );
//                         else {
//                           _messages = snapshot.data['chats_messages'];
//                           _chatuser = snapshot.data['other_user'];

//                           return ListView.builder(
//                             itemCount: _messages.length,
//                             // shrinkWrap: true,
//                             // padding: EdgeInsets.only(top: 10, bottom: 10),
//                             physics: AlwaysScrollableScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               return Container(
//                                 padding: EdgeInsets.only(
//                                     left: 14, right: 14, top: 10, bottom: 5),
//                                 child: Align(
//                                   alignment: (_messages[index].receiverid ==
//                                           _chatuser.id
//                                       ? Alignment.topRight
//                                       : Alignment.topLeft),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20),
//                                       color: (_messages[index].receiverid ==
//                                               _chatuser.id
//                                           ? Colors.green[100]
//                                           : Colors.blue[200]),
//                                     ),
//                                     padding: EdgeInsets.all(16),
//                                     child: Text(
//                                       _messages[index].message,
//                                       style: TextStyle(fontSize: 15),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         }
//                       });
//                 }
//               }),