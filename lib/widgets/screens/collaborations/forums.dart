import 'package:fbpidi/models/forum.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
import 'package:fbpidi/widgets/components/fbpidi_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Forums extends StatefulWidget {
  @override
  _ForumsState createState() => _ForumsState();
}

class _ForumsState extends State<Forums> {
  List<Forum> forums, searchedForums = [];
  bool isBeingSearhced = false;
  TextEditingController editingController = TextEditingController();

  final storage = new FlutterSecureStorage();
  bool refresh = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: FbpidiDrawer("Forums")),
      appBar: AppBar(
        title: Text("Forums"),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            children: [
              FbpidiSearch(
                callback: searchCallback,
                editingController: editingController,
              ),
              _addNewForum(context),
              _buildForumList(context),
            ],
          ),
        )),
      ),
    );
  }

  void searchCallback(String searchValue) {
    searchedForums.clear();
    if (forums.length > 0 && searchValue != '') {
      forums.forEach((element) {
        if (element.title.toLowerCase().contains(searchValue.toLowerCase()))
          searchedForums.add(element);
      });

      print(searchedForums.length);

      setState(() {
        isBeingSearhced = true;
      });
    } else {
      setState(() {
        isBeingSearhced = false;
      });
    }
  }

  Widget _buildForumList(context) {
    return FutureBuilder<List<Forum>>(
        future: CollaborationsApi().getForums(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          else {
            forums = snapshot.data;
            if (forums.length == 0)
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("No data"),
              ));
            else
              return isBeingSearhced
                  ? _listviewBuildForums(searchedForums)
                  : _listviewBuildForums(forums);
          }
        });
  }

  Widget _listviewBuildForums(List<Forum> forums) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.95,
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        scrollDirection: Axis.vertical,
        itemBuilder: (_, int index) {
          return Column(
            children: [
              Card(
                color: Colors.white,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0, top: 20, bottom: 20),
                            child: Text(
                              forums[index].title,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          FutureBuilder<String>(
                              future: storage.read(key: 'loginStatus'),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return Container();
                                else {
                                  if (snapshot.data == 'false')
                                    return Container();
                                  else
                                    return FutureBuilder<String>(
                                        future: storage.read(key: 'id'),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData)
                                            return Container();
                                          else {
                                            if (snapshot.data ==
                                                forums[index]
                                                    .createdBy["id"]
                                                    .toString())
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15.0),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        await CollaborationsApi()
                                                            .getLoginStatus()
                                                            .then((status) {
                                                          if (status == "true")
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/addForum',
                                                                arguments: {
                                                                  "type":
                                                                      "edit",
                                                                  "forum":
                                                                      forums[
                                                                          index]
                                                                });
                                                          else
                                                            Navigator.pushNamed(
                                                                context,
                                                                "/login",
                                                                arguments: {
                                                                  'route':
                                                                      '/addForum',
                                                                  "type":
                                                                      "edit",
                                                                  "forum":
                                                                      forums[
                                                                          index]
                                                                });
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.edit,
                                                        color: Theme.of(context)
                                                            .buttonColor,
                                                        size: 20,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        _confirmDeletingDialogue(
                                                            context,
                                                            "Are you sure you want to delete this forum?",
                                                            forums[index]);
                                                      },
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: Theme.of(context)
                                                            .buttonColor,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            else
                                              return Container();
                                          }
                                        });
                                }
                              })
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.black54,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    forums[index].createdDate.substring(0, 10) +
                                        ', ' +
                                        forums[index]
                                            .createdDate
                                            .substring(12, 16) +
                                        ' p.m.',
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black54),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 7.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.comment,
                                    color: Colors.black54,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    forums[index].noOfComments,
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black54),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 5, bottom: 10),
                              child: Text(
                                forums[index].description,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 19,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, bottom: 15.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0),
                                  ),
                                  primary: Theme.of(context).buttonColor,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/forumDetail',
                                      arguments: {'id': forums[index].id});
                                },
                                child: Text(
                                  "Read More",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        itemCount: forums.length,
      ),
    );
  }

  Widget _addNewForum(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.55,
            height: 40.0,
            child: SizedBox.expand(
              child: ElevatedButton(
                onPressed: () async {
                  await CollaborationsApi().getLoginStatus().then((status) {
                    if (status == "true")
                      Navigator.pushNamed(context, '/addForum',
                          arguments: {"type": "create"});
                    else
                      Navigator.pushNamed(context, "/login",
                          arguments: {'route': '/addForum', "type": "create"});
                  });
                },
                child: Text(
                  "Start New Forum Question",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  onPrimary: Theme.of(context).disabledColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void refreshPage() {
    setState(() {
      refresh = !refresh;
    });
  }

  _confirmationDialogue(mainContext, message, isError) {
    showDialog(
        context: mainContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  if (!isError) {
                    refreshPage();
                    Navigator.pop(context);
                  } else
                    Navigator.pop(context);
                },
                child: Text(
                  isError ? 'Close' : 'Continue',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 165, 81, 1), fontSize: 17),
                ),
              ),
            ],
          );
        });
  }

  _confirmDeletingDialogue(mainContext, message, forum) {
    showDialog(
        context: mainContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(message),
            actions: [
              TextButton(
                onPressed: () async {
                  await CollaborationsApi()
                      .addForum(forum, "delete")
                      .then((value) {
                    Navigator.pop(context);
                    if (value["error"]) {
                      _confirmationDialogue(
                          mainContext, "Error deleting Forum", true);
                    } else
                      _confirmationDialogue(
                          context, "Forum deleted successfully", false);
                  });
                },
                child: Text(
                  'Continue',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 165, 81, 1), fontSize: 17),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 165, 81, 1), fontSize: 17),
                ),
              ),
            ],
          );
        });
  }
}
