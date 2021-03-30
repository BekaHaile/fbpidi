import 'package:fbpidi/models/event.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/services/remove_tag.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventDetail extends StatelessWidget {
  final data;
  EventDetail(this.data);
  @override
  Widget build(BuildContext context) {
    print(data['id'] + ' /////is the id of the event');
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<Event>(
                future: CollaborationsApi().getEventDetail(data['id']),
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
                    Event event = snapshot.data;
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
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Image.network(
                                            "https://www.autocar.co.uk/sites/autocar.co.uk/files/styles/body-image/public/1-corvette-stingray-c8-2019-fd-hr-hero-front_0.jpg?itok=SEYe_vLy",
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
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      height: 3.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 10.0),
                                      child: Text(
                                        RemoveTag().removeAllHtmlTags(
                                            event.description),
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
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Text(
                                  "Other Events from ${event.company.name}",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            _otherEvent(context),
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
                    "https://www.autocar.co.uk/sites/autocar.co.uk/files/styles/body-image/public/1-corvette-stingray-c8-2019-fd-hr-hero-front_0.jpg?itok=SEYe_vLy",
                  ),
                  radius: MediaQuery.of(context).size.width * 0.23,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 15),
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
              _contactInfo(context, Icons.mail, 'anten@gmail.com'),
              SizedBox(
                height: 15.0,
              ),
              _contactInfo(context, Icons.phone,
                  event.company.companyAddress['phone_number']),
              SizedBox(
                height: 15.0,
              ),
              Container(
                  height: 3, color: Theme.of(context).scaffoldBackgroundColor),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 15.0),
                child: _buildButtons(context),
              ),
              SizedBox(
                height: 25.0,
              ),
            ]),
      ),
    );
  }

  Widget _otherEvent(context) {
    return Card(
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 30.0,
                ),
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(
                          "https://www.autocar.co.uk/sites/autocar.co.uk/files/styles/body-image/public/1-corvette-stingray-c8-2019-fd-hr-hero-front_0.jpg?itok=SEYe_vLy",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 5, bottom: 20),
                child: Text(
                  'Event name',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              _productIcons(context, Icons.location_on, "Ethiopia"),
              SizedBox(height: 10),
              _productIcons(context, Icons.calendar_today, "March 14, 2021"),
              SizedBox(height: 10),
              _productIcons(context, Icons.person, "MelfanTech"),
              SizedBox(height: 10),
              _productIcons(context, Icons.phone, "+251-92458-9558"),
              SizedBox(height: 20),
            ]),
      ),
    );
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

  Widget _buildButtons(context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 50,
        width: 100,
        child: SizedBox.expand(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              onPrimary: Color.fromRGBO(10, 178, 230, 0.5),
              primary: Color.fromRGBO(10, 178, 230, 1),
              padding: EdgeInsets.symmetric(horizontal: 16),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.mail, color: Colors.white),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Chat",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
