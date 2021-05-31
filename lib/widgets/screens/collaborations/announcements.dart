import 'package:fbpidi/models/announcement.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/services/launch_app.dart';
import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
import 'package:fbpidi/widgets/components/fbpidi_search.dart';
import 'package:flutter/material.dart';

class Announcements extends StatefulWidget {
  @override
  _AnnouncementsState createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  List selected = [true, false, false, false];
  List<Announcement> announcement, searchedAnnouncements = [];
  bool isBeingSearhced = false;
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: FbpidiDrawer("Announcements")),
      appBar: AppBar(
        title: Text("Announcements"),
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
              // _sortList(context),
              _buildResearchList(context),
            ],
          ),
        )),
      ),
    );
  }

  void searchCallback(String searchValue) {
    searchedAnnouncements.clear();
    if (announcement != null) {
      announcement.forEach((element) {
        if (element.title.toLowerCase().contains(searchValue.toLowerCase()))
          searchedAnnouncements.add(element);
      });

      setState(() {
        isBeingSearhced = true;
      });
    }
  }

  Widget _buildResearchList(context) {
    return FutureBuilder<List<Announcement>>(
        future: CollaborationsApi().getAnnuoncement(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            );
          else {
            announcement = snapshot.data;
            if (announcement.length == 0)
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("No data"),
              ));
            else
              return isBeingSearhced
                  ? _listviewBuildResearches(searchedAnnouncements)
                  : _listviewBuildResearches(announcement);
          }
        });
  }

  Widget _listviewBuildResearches(List<Announcement> researches) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.95,
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        scrollDirection: Axis.vertical,
        itemBuilder: (_, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.94,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 30.0,
                          ),
                          child: Container(
                            height: 280,
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image.network(
                                CollaborationsApi().baseUrl +
                                    announcement[index].image,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 5, bottom: 10),
                          child: Text(
                            researches[index].title,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          height: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 5, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "By: ",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              CircleAvatar(
                                radius: 20,
                                child: ClipOval(
                                    child: Image.network(
                                  CollaborationsApi().baseUrl +
                                      announcement[index].company.logo,
                                  fit: BoxFit.cover,
                                  width: 90.0,
                                  height: 90.0,
                                )),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              if (announcement[index].company.companyAddress !=
                                  null)
                                if (announcement[index]
                                        .company
                                        .companyAddress["phone_number"] !=
                                    null)
                                  InkWell(
                                    onTap: () {
                                      LaunchApp().launchInBrowser(
                                          "tel:${announcement[index].company.companyAddress["phone_number"]}");
                                    },
                                    child: Container(
                                      height: 34,
                                      width: 34,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(247, 247, 251, 1),
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.phone,
                                        color: Colors.black,
                                        size: 19,
                                      ),
                                    ),
                                  ),
                              SizedBox(
                                width: 5.0,
                              ),
                              // Container(
                              //   height: 34,
                              //   width: 34,
                              //   decoration: BoxDecoration(
                              //       color: Color.fromRGBO(247, 247, 251, 1),
                              //       shape: BoxShape.circle),
                              //   child: Icon(
                              //     FontAwesomeIcons.solidComments,
                              //     color: Color.fromRGBO(0, 0, 255, 1),
                              //     size: 19,
                              //   ),
                              // ),
                              // SizedBox(
                              //   width: 5.0,
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, "/announcementDetail",
                                        arguments: {
                                          'id': researches[index].id
                                        });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    onPrimary: Theme.of(context)
                                        .buttonColor
                                        .withOpacity(0.3),
                                    primary: Theme.of(context).buttonColor,
                                  ),
                                  child: Text(
                                    "Read More",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 20.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, right: 5),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "At: ",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        researches[index]
                                                .createdDate
                                                .substring(0, 10) +
                                            ', ' +
                                            researches[index]
                                                .createdDate
                                                .substring(11, 16) +
                                            ' a.m.',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ]),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: researches.length,
      ),
    );
  }
}
