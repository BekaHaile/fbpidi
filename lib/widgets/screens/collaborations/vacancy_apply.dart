import 'package:fbpidi/services/collaborations_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VacancyApply extends StatefulWidget {
  final data;
  VacancyApply(this.data);
  @override
  _VacancyApplyState createState() => _VacancyApplyState();
}

class _VacancyApplyState extends State<VacancyApply> {
  List<String> statusList = ["Select Current Status"];
  String statusValue = "Select Current Status";
  List<String> categoryList = [
    '-------',
    'Coca Research Category',
    'Research Category'
  ];
  String categoryValue = '-------';
  TextEditingController instituteController = TextEditingController(),
      fieldController = TextEditingController(),
      gradeController = TextEditingController(),
      experienceController = TextEditingController(),
      descriptionController = TextEditingController();
  String cvFilename = "Filename";
  String cvPath;
  String documentFilename = "Filename";
  String documentPath;
  String message = "";
  bool error = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Applying for vacancy'),
        ),
        body: error
            ? Center(
                child: Text(
                message,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.red,
                ),
              ))
            : SingleChildScrollView(
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
                  'Job application form',
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
                    _buildStatusDropdown(
                        context, "Status *", widget.data['id']),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildTextFields(context, "The institute you learned in *",
                        "School you learned in", instituteController),
                    SizedBox(
                      height: 15.0,
                    ),
                    _buildTextFields(
                        context,
                        "The field you are an expert in *",
                        "The field you learned",
                        fieldController),
                    SizedBox(
                      height: 15.0,
                    ),
                    _buildTextFields(
                        context, "Grade *", "Your grade", gradeController),
                    SizedBox(
                      height: 15.0,
                    ),
                    _buildTextFields(context, "Experience (in years) * ", "2",
                        experienceController),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Introduce yourself *",
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
                              hintText:
                                  "Introduce yourself and write why you are applying",
                              hintStyle: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "CV *",
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
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              cvFilename,
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
                                    cvFilename = file.name;
                                  });
                                  cvPath = file.path;
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
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Documents *",
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
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              documentFilename,
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
                                    documentFilename = file.name;
                                  });
                                  documentPath = file.path;
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

  Widget _buildStatusDropdown(context, String title, String id) {
    return FutureBuilder<Map<dynamic, dynamic>>(
        future: CollaborationsApi().getVacancyStatus(id),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return CircularProgressIndicator();
          else {
            if (snapshot.data["error"])
              setState(() {
                error = true;
                message = snapshot.data["message"];
              });
            statusList.clear();
            statusList.add("Select Current Status");
            List<dynamic> statuses = snapshot.data["current_status"];
            int count = 0;

            statuses.forEach((status) {
              if (count == 0) {
                statusList.add(status[1]);
              } else {
                statusList.add(status[0]);
              }
              count++;
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
                        width: MediaQuery.of(context).size.width * 0.75,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(border: Border.all()),
                        child: DropdownButton<String>(
                          value: statusValue,
                          isExpanded: true,
                          icon: const Icon(FontAwesomeIcons.chevronDown),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          onChanged: (String newValue) {
                            setState(() {
                              statusValue = newValue;
                            });
                          },
                          items: statusList
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

  Widget _buildTextFields(
      context, String title, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            title,
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
              keyboardType:
                  title.contains("Experience") || title.contains("Grade")
                      ? TextInputType.number
                      : TextInputType.text,
              controller: controller,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  hintText: hint,
                  hintStyle: TextStyle(fontSize: 18)),
            ),
          ),
        ),
      ],
    );
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
              if (cvPath == null || documentPath == null)
                _confirmationDialogue(
                    context,
                    "Please fill all the fields provided and submit all documents required to apply.",
                    true);
              else {
                Map<String, dynamic> userApplying = {
                  "id": widget.data['id'],
                  "institiute": instituteController.text,
                  "field": fieldController.text,
                  "status": statusValue,
                  "bio": descriptionController.text,
                  "grade": gradeController.text,
                  "experiance": experienceController.text,
                  "cv": cvPath,
                  "documents": documentPath
                };

                await CollaborationsApi()
                    .vacancyApply(userApplying)
                    .then((value) {
                  if (value["error"] == false)
                    _confirmationDialogue(
                        context,
                        "You have successfully applied for this vacancy.",
                        false);
                  else
                    _confirmationDialogue(
                        context, "Error applying for the vacancy", true);
                });
              }
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
                    Navigator.pushReplacementNamed(context, "/vacancies");
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
