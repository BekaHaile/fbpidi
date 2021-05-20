import 'package:fbpidi/models/poll.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/services/remove_tag.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PollDetail extends StatefulWidget {
  final data;
  PollDetail(this.data);

  @override
  _PollDetailState createState() => _PollDetailState();
}

class _PollDetailState extends State<PollDetail> {
  int groupValue = -1;
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Poll Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<Poll>(
                future: CollaborationsApi().getPollDetail(widget.data['id']),
                builder: (BuildContext context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  else {
                    Poll poll = snapshot.data;
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
                                          left: 20.0, top: 15, bottom: 20),
                                      child: Text(
                                        'Title: ' + poll.title,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    _productIcons(context, Icons.person,
                                        'By: ${poll.createdBy['firstName']}'),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    _productIcons(
                                        context,
                                        FontAwesomeIcons.star,
                                        'Total Votes: ${poll.noOfVotes}'),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    _productIcons(
                                        context,
                                        FontAwesomeIcons.calendarAlt,
                                        'Poll created at: ${poll.createdDate.substring(0, 10)}'),
                                    SizedBox(
                                      height: 25.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "Poll Description",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 10.0),
                                      child: Text(
                                        RemoveTag().removeAllHtmlTags(
                                            poll.description),
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 19,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25.0,
                                    ),
                                    ListView.builder(
                                        itemCount: poll.choices.length,
                                        shrinkWrap: true,
                                        primary: false,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (_, index) {
                                          return Column(
                                            children: [
                                              _buildChoice(poll.choices[index]),
                                              SizedBox(
                                                height: 10,
                                              )
                                            ],
                                          );
                                        }),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 18.0),
                                      child: Text(
                                        "Any Remarks?",
                                        style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.w500),
                                      ),
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
                                          controller: editingController,
                                          minLines: 15,
                                          maxLines: 30,
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.all(5),
                                              hintText: "Remark",
                                              hintStyle:
                                                  TextStyle(fontSize: 18)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        height: 40.0,
                                        child: SizedBox.expand(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              if (groupValue != -1)
                                                await CollaborationsApi()
                                                    .voteForAPoll(
                                                        poll.id,
                                                        groupValue.toString(),
                                                        editingController.text)
                                                    .then((value) {
                                                  if (value["error"])
                                                    _confirmationDialogue(
                                                        context,
                                                        "You have already voted for this poll, you can't vote again.",
                                                        true);
                                                  else
                                                    _confirmationDialogue(
                                                        context,
                                                        value["message"],
                                                        false);
                                                });
                                            },
                                            child: Text(
                                              "Submit Vote",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: Theme.of(context)
                                                  .primaryColor,
                                              onPrimary: Theme.of(context)
                                                  .disabledColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
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

  Widget _buildChoice(Choice choice) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).scaffoldBackgroundColor, width: 2)),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  choice.choiceName,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Icon(
                      FontAwesomeIcons.solidStar,
                      color: Theme.of(context).buttonColor,
                      size: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                    ),
                    child: Container(
                      child: Text(
                        choice.noOfVotes + " Vote",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 19,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  RemoveTag().removeAllHtmlTags(choice.description),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 19,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                color: Theme.of(context).buttonColor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio(
                          value: int.parse(choice.id),
                          groupValue: groupValue,
                          onChanged: (value) {
                            setState(() {
                              groupValue = value;
                            });
                          }),
                      Text(
                        "Select Vote",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
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
                    Navigator.pushNamed(mainContext, '/polls');
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
