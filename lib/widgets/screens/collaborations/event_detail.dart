import 'package:fbpidi/models/event.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/services/remove_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventDetail extends StatefulWidget {
  final data;
  EventDetail(this.data);

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  final TextEditingController emailController = TextEditingController();

  Event event;
  String date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<Event>(
                future: CollaborationsApi().getEventDetail(widget.data['id']),
                builder: (BuildContext context, snapshot) {
                  // _fetchLanguage(context);
                  if (!snapshot.hasData)
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  else {
                    event = snapshot.data;
                    return Center(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.95,
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Column(
                          children: [
                            Card(
                              color: Colors.white,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 15, bottom: 10),
                                      child: Text(
                                        event.title,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        'By: ${event.company.name}',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7.0,
                                    ),
                                    _productIcons(
                                        context,
                                        FontAwesomeIcons.calendar,
                                        "Start Date: ${event.startDate.substring(0, 10)}"),
                                    SizedBox(
                                      height: 7.0,
                                    ),
                                    _productIcons(
                                        context,
                                        FontAwesomeIcons.calendarAlt,
                                        'End Date: ${event.endDate.substring(0, 10)}'),
                                    SizedBox(
                                      height: 7.0,
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 15.0,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                      child: Container(
                                        height: 250,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Image.network(
                                            CollaborationsApi().baseUrl +
                                                event.image,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "Send me a reminder on",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 30.0),
                                      child: TextButton(
                                          onPressed: () {
                                            DatePicker.showDatePicker(
                                              context,
                                              showTitleActions: true,
                                              minTime: DateTime(2021, 1, 1),
                                              maxTime: DateTime(2050, 1, 1),
                                              onChanged: (date) {
                                                print('change $date');
                                              },
                                              onConfirm: (pickedDate) {
                                                print('confirm $date');
                                                setState(() {
                                                  date = pickedDate
                                                      .toString()
                                                      .substring(0, 10);
                                                });
                                              },
                                              currentTime: DateTime.now(),
                                            );
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    date == null
                                                        ? 'mm/dd/yyyy'
                                                        : date,
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.calendar_today,
                                                    color: Colors.black87,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "Your email",
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
                                      padding: const EdgeInsets.only(
                                          left: 30.0, bottom: 15),
                                      child: Container(
                                        decoration:
                                            BoxDecoration(border: Border.all()),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        child: TextField(
                                          controller: emailController,
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.all(5),
                                              hintText: "Email Address",
                                              hintStyle:
                                                  TextStyle(fontSize: 18)),
                                        ),
                                      ),
                                    ),
                                    _remindMe(context),
                                    SizedBox(
                                      height: 15,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            eventDescription(context, event),
                            _companyCard(context, event),
                            SizedBox(
                              height: 25,
                            )
                          ],
                        ),
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget eventDescription(BuildContext context, Event event) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10),
            child: Text(
              "Event Description",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: 3.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10.0),
            child: Text(
              RemoveTag().removeAllHtmlTags(event.description),
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
        ],
      ),
    );
  }

  Widget _productIcons(context, icon, title) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Icon(
            icon,
            color: Colors.black54,
            size: 18,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 19,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }

  Widget _companyCard(context, Event event) {
    return Card(
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
                child: Text(
                  'Company Information',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                  height: 3, color: Theme.of(context).scaffoldBackgroundColor),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    CollaborationsApi().baseUrl + event.company.logo,
                  ),
                  radius: MediaQuery.of(context).size.width * 0.23,
                ),
              ),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 10, bottom: 15, left: 20.0),
                  child: Text(
                    event.company.name,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
                child: Text(
                  'Company Contact info',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
              _contactInfo(context, Icons.flag,
                  event.company.companyAddress['city_town']),
              SizedBox(
                height: 15.0,
              ),
              _contactInfo(
                  context, Icons.mail, event.company.companyAddress['email']),
              SizedBox(
                height: 15.0,
              ),
              _contactInfo(context, Icons.phone,
                  event.company.companyAddress['phone_number']),
              SizedBox(
                height: 15.0,
              ),
              // Container(
              //     height: 3, color: Theme.of(context).scaffoldBackgroundColor),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20.0, top: 15.0),
              //   child: _buildButtons(context),
              // ),
              SizedBox(
                height: 25.0,
              ),
            ]),
      ),
    );
  }

  Widget _remindMe(context) {
    return Padding(
      padding: EdgeInsets.only(left: 30),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        height: 40.0,
        child: SizedBox.expand(
          child: ElevatedButton(
            onPressed: () async {
              Map<String, String> data = {
                "id": event.id,
                "email": emailController.text,
                "date": date
              };
              await CollaborationsApi().notifyForEvent(data).then((value) {
                if (value["error"] == false)
                  _confirmationDialogue(
                      context, "Event reminder set successfully", false);
                else
                  _confirmationDialogue(context, "Error saving reminder", true);
              });
            },
            child: Text(
              "Remind Me",
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
                  if (!isError) {
                    Navigator.pushReplacementNamed(mainContext, "/events");
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

  Widget _contactInfo(context, icon, title) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
                color: Color.fromRGBO(247, 247, 251, 1),
                shape: BoxShape.circle),
            child: Icon(
              icon,
              color: Colors.black54,
              size: 19,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildButtons(context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(10.0),
  //     child: Container(
  //       height: 50,
  //       width: 100,
  //       child: SizedBox.expand(
  //         child: ElevatedButton(
  //           onPressed: () {},
  //           style: ElevatedButton.styleFrom(
  //             onPrimary: Color.fromRGBO(10, 178, 230, 0.5),
  //             primary: Color.fromRGBO(10, 178, 230, 1),
  //             padding: EdgeInsets.symmetric(horizontal: 16),
  //             shape: const RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(2)),
  //             ),
  //           ),
  //           child: Row(
  //             children: [
  //               Icon(Icons.mail, color: Colors.white),
  //               SizedBox(
  //                 width: 5,
  //               ),
  //               Text(
  //                 "Chat",
  //                 style: TextStyle(color: Colors.white, fontSize: 17),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
