import 'package:fbpidi/models/forum.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddForum extends StatefulWidget {
  @override
  _AddForumState createState() => _AddForumState();
}

class _AddForumState extends State<AddForum> {
  TextEditingController titleController = TextEditingController(),
      descriptionController = TextEditingController();
  String fileName = "Pick file";
  String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add a Research'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildDetail(context),
            ],
          ),
        ));
  }

  Widget _buildDetail(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Card(
        color: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 20, bottom: 20),
                child: Text(
                  'Add a Forum Question',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 27,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                height: 3,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Forum Title *",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              hintText: "Title of your Forum Question",
                              hintStyle: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Forum Description *",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextField(
                          controller: descriptionController,
                          minLines: 15,
                          maxLines: 30,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              hintText: "Elaborate on your question",
                              hintStyle: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              fileName,
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                FilePickerResult result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['jpg', 'pdf', 'doc'],
                                );

                                if (result != null) {
                                  PlatformFile file = result.files.first;

                                  print(file.name);
                                  print(file.path);
                                  setState(() {
                                    fileName = file.name;
                                  });
                                  path = file.path;
                                } else {
                                  // User canceled the picker
                                }
                              },
                              child: Text(
                                "Pick File",
                                style: TextStyle(fontSize: 16),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _addNewForum(context),
                    SizedBox(
                      height: 5.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addNewForum(context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.3),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        height: 40.0,
        child: SizedBox.expand(
          child: ElevatedButton(
            onPressed: () async {
              Forum forum = Forum(
                  title: titleController.text,
                  description: descriptionController.text);
              await CollaborationsApi().addForum(forum, "create").then((value) {
                if (value["error"] == false)
                  _confirmationDialogue(
                      context, "Forum has been added successfully", false);
                else
                  _confirmationDialogue(context, "Error adding forum", true);
              });
            },
            child: Text(
              "Submit",
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
    );
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
                  if (!isError)
                    Navigator.pushReplacementNamed(context, "/forums");
                  else
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
}
