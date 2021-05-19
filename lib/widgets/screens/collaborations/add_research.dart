import 'package:fbpidi/models/research.dart';
import 'package:fbpidi/models/researchCategory.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddResearch extends StatefulWidget {
  @override
  _AddResearchState createState() => _AddResearchState();
}

class _AddResearchState extends State<AddResearch> {
  List<String> statusList = ['Completed', 'Inprogress'];
  String statusValue = 'Completed';
  List<String> categoryList = [];
  String categoryValue = '-------';
  TextEditingController titleController = TextEditingController(),
      descriptionController = TextEditingController();
  String fileName = "Pick file";
  String path;
  List<ResearchCategory> categories = [];

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
                  'Add a Research',
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
                        "Research Title *",
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
                              hintText: "Title of the Research",
                              hintStyle: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    _buildStatusDropdown(context, "Research Status *"),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildCategoryDropdown(context, "Research Category *"),
                    SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Research Description *",
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
                              hintText: "Short Description",
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
                    _addNewResearch(context),
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

  Widget _buildStatusDropdown(context, String title) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 19,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(border: Border.all()),
                child: DropdownButton<String>(
                  value: statusValue,
                  isExpanded: true,
                  icon: const Icon(FontAwesomeIcons.chevronDown),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  onChanged: (String newValue) {
                    setState(() {
                      statusValue = newValue;
                    });
                  },
                  items:
                      statusList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown(context, String title) {
    return FutureBuilder<List<ResearchCategory>>(
        future: CollaborationsApi().getResearchCategory(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return CircularProgressIndicator();
          else {
            categoryList.clear();
            categoryList.add('-------');
            categories = snapshot.data;

            categories.forEach((category) {
              categoryList.add(category.categoryName);
            });
            return Container(
              padding: EdgeInsets.only(left: 20),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$title: ',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(border: Border.all()),
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: DropdownButton<String>(
                          value: categoryValue,
                          isExpanded: true,
                          icon: const Icon(FontAwesomeIcons.chevronDown),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          // underline: Container(
                          //   height: 2,
                          //   color: Colors.black,
                          // ),
                          onChanged: (String newValue) {
                            setState(() {
                              categoryValue = newValue;
                            });
                          },
                          items: categoryList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )),
                  ),
                ],
              ),
            );
          }
        });
  }

  Widget _addNewResearch(context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.3),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        height: 40.0,
        child: SizedBox.expand(
          child: ElevatedButton(
            onPressed: () async {
              String id = "";
              categories.forEach((element) {
                if (categoryValue == element.categoryName) id = element.id;
              });
              Research research = Research(
                  title: titleController.text,
                  status: statusValue,
                  category: id,
                  description: descriptionController.text);
              await CollaborationsApi()
                  .addResearch(research, path)
                  .then((value) {
                if (value["error"] == false)
                  _confirmationDialogue(
                      context, "Research has been added successfully", false);
                else
                  _confirmationDialogue(
                      context, "Error adding research", false);
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
                    Navigator.pushReplacementNamed(context, "/researches");
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
