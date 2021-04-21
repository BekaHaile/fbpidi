import 'package:fbpidi/models/tender.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/services/remove_tag.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TenderDetail extends StatefulWidget {
  final data;
  TenderDetail(this.data);

  @override
  _TenderDetailState createState() => _TenderDetailState();
}

class _TenderDetailState extends State<TenderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tender Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<Tender>(
                future: CollaborationsApi().getTenderDetail(widget.data['id']),
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
                    Tender tender = snapshot.data;
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
                                        'Title: ' + tender.title,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    _productIcons(
                                        context,
                                        FontAwesomeIcons.calendar,
                                        "Start Date: ${tender.startDate.substring(0, 10)}"),
                                    SizedBox(
                                      height: 7.0,
                                    ),
                                    _productIcons(
                                        context,
                                        FontAwesomeIcons.calendarAlt,
                                        'End Date: ${tender.endDate.substring(0, 10)}'),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.person),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'By:- ${tender.company.name}',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Type:- ${tender.tenderType}',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          tender.tenderType == "Paid"
                                              ? Text(
                                                  'Price:- ${tender.documentPrice}',
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 25.0),
                                      child: Text(
                                        'Total Applicants:- 0',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: tender.status == "Upcoming"
                                              ? Colors.yellow
                                              : Color.fromRGBO(0, 128, 0, 1),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          tender.status,
                                          style: TextStyle(
                                              color: tender.status == "Upcoming"
                                                  ? Colors.black87
                                                  : Colors.white,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: tender.status == "Upcoming"
                                          ? Text(
                                              "This tender is now in Upcoming status. So, you can't participate in this tender.",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 17),
                                            )
                                          : tender.tenderType == "Paid"
                                              ? Text(
                                                  "This Tender is not Free, You can read the description below and attend the tender in person!",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 17),
                                                )
                                              : ElevatedButton(
                                                  onPressed: () {
                                                    print(
                                                        "Being clicked to open a modal");
                                                    _openParticipateModal(
                                                        context, tender.id);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Theme.of(context)
                                                        .buttonColor,
                                                  ),
                                                  child: Text(
                                                    "Participate in Tender",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "Tender Description",
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
                                            tender.description),
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
                                  ],
                                ),
                              ),
                            ),
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

  _openParticipateModal(context, tenderId) {
    TextEditingController firstController = TextEditingController(),
        lastController = TextEditingController(),
        companyController = TextEditingController(),
        tinController = TextEditingController(),
        emailController = TextEditingController(),
        phoneController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0.0),
            child: AlertDialog(
              scrollable: true,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 3,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildTextField("First Name", firstController),
                  SizedBox(
                    height: 10,
                  ),
                  _buildTextField("Last Name", lastController),
                  SizedBox(
                    height: 10,
                  ),
                  _buildTextField("Company Name", companyController),
                  SizedBox(
                    height: 10,
                  ),
                  _buildTextField("Company tin Number", tinController),
                  SizedBox(
                    height: 10,
                  ),
                  _buildTextField("Email Address", emailController),
                  SizedBox(
                    height: 10,
                  ),
                  _buildTextField("Phone Number", phoneController),
                ],
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () async {
                    Map<String, dynamic> applyData = {
                      "first_name": firstController.text,
                      "last_name": lastController.text,
                      "phone_number": phoneController.text,
                      "email": emailController.text,
                      "company_name": companyController.text,
                      "comany_tin_number": tinController.text,
                      "tender": tenderId,
                    };
                    await CollaborationsApi()
                        .participateInTender(applyData)
                        .then((value) {
                      print(value);
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildTextField(String title, TextEditingController controller) {
    return Theme(
      data: new ThemeData(
        primaryColor: Theme.of(context).buttonColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title + ": ",
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            child: TextField(
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderSide:
                        new BorderSide(color: Theme.of(context).buttonColor)),
                hintText: title,
                labelText: title,
              ),
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
