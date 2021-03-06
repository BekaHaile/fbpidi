import 'dart:io';

import 'package:fbpidi/models/user.dart';
import 'package:fbpidi/services/user_api.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Profile extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<Profile>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  TextEditingController controllerName = TextEditingController(),
      controllerLastName = TextEditingController(),
      controllerPhone = TextEditingController(),
      controllerEmail = TextEditingController(),
      controllerUsername = TextEditingController();
  String token = "";
  final storage = new FlutterSecureStorage();
  String profilePath =
      'https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png';
  String path;
  bool isLocal = false;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
      color: Colors.white,
      child: new ListView(
        children: <Widget>[
          FutureBuilder<String>(
              future: storage.read(key: 'loginStatus'),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator()),
                    ),
                  );
                else {
                  String status = snapshot.data;
                  if (status == "false")
                    return Center(
                      child: Text('User Not Logged in'),
                    );
                  else
                    return FutureBuilder<String>(
                        future: storage.read(key: 'token'),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Container(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator()),
                              ),
                            );
                          else {
                            token = snapshot.data;
                            return FutureBuilder<Map<String, dynamic>>(
                                future: UserApi().getProfile(token),
                                builder: (BuildContext context, snapshot) {
                                  if (!snapshot.hasData)
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Container(
                                            width: 30,
                                            height: 30,
                                            child: CircularProgressIndicator()),
                                      ),
                                    );
                                  else {
                                    User user = User.fromMap(
                                        snapshot.data["user_detail"]);
                                    controllerName.text = user.firstName;
                                    controllerLastName.text = user.lastName;
                                    controllerPhone.text = user.phoneNumber;
                                    controllerUsername.text = user.username;
                                    controllerEmail.text = user.email;
                                    if (user.profileImage != "null")
                                      profilePath =
                                          UserApi().baseUrl + user.profileImage;
                                    return Column(
                                      children: <Widget>[
                                        new Container(
                                          height: 250.0,
                                          color: Colors.white,
                                          child: new Column(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 20.0),
                                                child: new Stack(
                                                    fit: StackFit.loose,
                                                    children: <Widget>[
                                                      new Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          new Container(
                                                              width: 140.0,
                                                              height: 140.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                image:
                                                                    DecorationImage(
                                                                  image: isLocal
                                                                      ? FileImage(
                                                                          File(
                                                                              path))
                                                                      : NetworkImage(
                                                                          profilePath),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              )),
                                                        ],
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 90.0,
                                                                  right: 100.0),
                                                          child: new Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  FilePickerResult
                                                                      result =
                                                                      await FilePicker
                                                                          .platform
                                                                          .pickFiles(
                                                                    type: FileType
                                                                        .custom,
                                                                    allowedExtensions: [
                                                                      'jpg',
                                                                      'png',
                                                                    ],
                                                                  );

                                                                  if (result !=
                                                                      null) {
                                                                    PlatformFile
                                                                        file =
                                                                        result
                                                                            .files
                                                                            .first;

                                                                    setState(
                                                                        () {
                                                                      path = file
                                                                          .path;
                                                                      isLocal =
                                                                          true;
                                                                    });
                                                                  } else {
                                                                    // User canceled the picker
                                                                  }
                                                                },
                                                                child: _status
                                                                    ? Container()
                                                                    : CircleAvatar(
                                                                        backgroundColor:
                                                                            Colors.deepPurple,
                                                                        radius:
                                                                            25.0,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .camera_alt,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                              )
                                                            ],
                                                          )),
                                                    ]),
                                              )
                                            ],
                                          ),
                                        ),
                                        new Container(
                                          color: Color(0xffFFFFFF),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 25.0),
                                            child: new Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 25.0,
                                                        right: 25.0,
                                                        top: 25.0),
                                                    child: new Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: <Widget>[
                                                        new Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            new Text(
                                                              'Personal Information',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      18.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                        new Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            _status
                                                                ? _getEditIcon()
                                                                : new Container(),
                                                          ],
                                                        )
                                                      ],
                                                    )),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 25.0,
                                                                right: 25.0,
                                                                top: 25.0),
                                                        child: new Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: <Widget>[
                                                            new Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                new Text(
                                                                  'First Name',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 25.0,
                                                                right: 25.0,
                                                                top: 2.0),
                                                        child: new Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: <Widget>[
                                                            new Flexible(
                                                              child:
                                                                  new TextField(
                                                                controller:
                                                                    controllerName,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  hintText:
                                                                      "Enter Your Name",
                                                                ),
                                                                enabled:
                                                                    !_status,
                                                                autofocus:
                                                                    !_status,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 25.0,
                                                                right: 25.0,
                                                                top: 5.0),
                                                        child: new Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: <Widget>[
                                                            new Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                new Text(
                                                                  'Last Name',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 25.0,
                                                                right: 25.0,
                                                                top: 2.0),
                                                        child: new Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: <Widget>[
                                                            new Flexible(
                                                              child:
                                                                  new TextField(
                                                                controller:
                                                                    controllerLastName,
                                                                decoration:
                                                                    const InputDecoration(
                                                                        hintText:
                                                                            "Last Name"),
                                                                enabled:
                                                                    !_status,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 25.0,
                                                                right: 25.0,
                                                                top: 5.0),
                                                        child: new Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: <Widget>[
                                                            new Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                new Text(
                                                                  'Phone Number',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 25.0,
                                                                right: 25.0,
                                                                top: 2.0),
                                                        child: new Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: <Widget>[
                                                            new Flexible(
                                                              child:
                                                                  new TextField(
                                                                controller:
                                                                    controllerPhone,
                                                                decoration:
                                                                    const InputDecoration(
                                                                        hintText:
                                                                            "Enter Mobile Number"),
                                                                enabled:
                                                                    !_status,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 25.0,
                                                          right: 25.0,
                                                          top: 5.0),
                                                      child: Container(
                                                        child: new Text(
                                                          'Username',
                                                          style: TextStyle(
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 25.0,
                                                                right: 25.0,
                                                                top: 2.0),
                                                        child: new Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: <Widget>[
                                                            new Flexible(
                                                              child:
                                                                  new TextField(
                                                                readOnly: true,
                                                                controller:
                                                                    controllerUsername,
                                                                decoration:
                                                                    const InputDecoration(
                                                                        hintText:
                                                                            "Username"),
                                                                enabled:
                                                                    !_status,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 25.0,
                                                          right: 25.0,
                                                          top: 5.0),
                                                      child: Container(
                                                        child: new Text(
                                                          'Email',
                                                          style: TextStyle(
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 25.0,
                                                                right: 25.0,
                                                                top: 2.0),
                                                        child: new Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: <Widget>[
                                                            new Flexible(
                                                              child:
                                                                  new TextField(
                                                                controller:
                                                                    controllerEmail,
                                                                decoration:
                                                                    const InputDecoration(
                                                                        hintText:
                                                                            "Email address"),
                                                                enabled:
                                                                    !_status,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                                !_status
                                                    ? _getActionButtons()
                                                    : new Container(),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                });
                          }
                        });
                }
              }),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                child: Text("Save"),
                onPressed: () async {
                  User user = User(
                    firstName: controllerName.text,
                    lastName: controllerLastName.text,
                    username: controllerUsername.text,
                    email: controllerEmail.text,
                    phoneNumber: controllerPhone.text,
                    profileImage: path,
                  );
                  try {
                    await UserApi().updateUser(user).then((response) async {
                      if (response['error'] == false) {
                        _signUpDialogue(
                            context, "Profile updated successfully");
                      } else {
                        _signUpDialogue(context, "Error updating profile");
                      }
                    });
                  } catch (e) {
                    print("Error: " + e.toString());
                  }
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                  primary: Colors.red[400],
                ),
                child: new Text("Cancel"),
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.deepPurple,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  _signUpDialogue(context, text) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(text),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Continue',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 165, 81, 1), fontSize: 17),
                ),
              ),
            ],
          );
        });
  }
}
