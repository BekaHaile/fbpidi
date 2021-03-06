import 'package:fbpidi/models/poll.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/services/launch_app.dart';
import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
import 'package:fbpidi/widgets/components/fbpidi_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Polls extends StatefulWidget {
  @override
  _PollsState createState() => _PollsState();
}

class _PollsState extends State<Polls> {
  List selected = [true, false];
  List<Poll> polls, searchedPolls = [];
  bool isBeingSearhced = false;
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: FbpidiDrawer("Polls")),
      appBar: AppBar(
        title: Text("Polls"),
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
              _buildPollsList(context),
            ],
          ),
        )),
      ),
    );
  }

  void searchCallback(String searchValue) {
    searchedPolls.clear();
    if (polls.length > 0) {
      polls.forEach((element) {
        if (element.title.toLowerCase().contains(searchValue.toLowerCase()) ||
            element.noOfVotes
                .toLowerCase()
                .contains(searchValue.toLowerCase()) ||
            element.company.name
                .toLowerCase()
                .contains(searchValue.toLowerCase()))
          searchedPolls.add(element);
      });

      setState(() {
        isBeingSearhced = true;
      });
    }
  }

  // Widget _sortList(context) {
  //   return Card(
  //     color: Colors.white,
  //     child: Container(
  //       width: MediaQuery.of(context).size.width * 0.95,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: <Widget>[
  //           Padding(
  //             padding: const EdgeInsets.only(top: 15, bottom: 10),
  //             child: Text(
  //               'Showing 1 to 10 of 30 entries',
  //               style: TextStyle(
  //                 color: Colors.black87,
  //                 fontSize: 18,
  //               ),
  //               textAlign: TextAlign.left,
  //             ),
  //           ),
  //           SizedBox(
  //             width: 5.0,
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(top: 15, bottom: 10),
  //             child: Text(
  //               'Sort by: ',
  //               style: TextStyle(
  //                 color: Colors.black87,
  //                 fontSize: 18,
  //               ),
  //               textAlign: TextAlign.left,
  //             ),
  //           ),
  //           SizedBox(
  //             width: 10.0,
  //           ),
  //           Container(
  //             width: MediaQuery.of(context).size.width * 0.85,
  //             height: 55,
  //             padding: EdgeInsets.only(bottom: 5),
  //             child: SizedBox.expand(
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   setState(() {
  //                     for (int i = 0; i < 4; i++) selected[i] = false;
  //                     selected[0] = true;
  //                   });
  //                 },
  //                 style: ElevatedButton.styleFrom(
  //                   primary: Colors.white,
  //                   shape: RoundedRectangleBorder(
  //                       side: BorderSide(
  //                           color: selected[0]
  //                               ? Theme.of(context).buttonColor
  //                               : Colors.black38)),
  //                 ),
  //                 child: Padding(
  //                   padding: EdgeInsets.only(
  //                       left: MediaQuery.of(context).size.width * 0.32),
  //                   child: Row(children: [
  //                     Text(
  //                       "All",
  //                       style: TextStyle(
  //                           color: selected[0]
  //                               ? Theme.of(context).buttonColor
  //                               : Colors.black54,
  //                           fontSize: 18),
  //                     ),
  //                     Icon(
  //                       FontAwesomeIcons.sort,
  //                       color: selected[0]
  //                           ? Theme.of(context).buttonColor
  //                           : Colors.black54,
  //                     ),
  //                   ]),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           _sortButton("Highest votes", context, 1),
  //           SizedBox(
  //             height: 20.0,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _sortButton(title, context, index) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width * 0.85,
  //     height: 55,
  //     padding: EdgeInsets.only(bottom: 5),
  //     child: SizedBox.expand(
  //       child: ElevatedButton(
  //         style: ElevatedButton.styleFrom(
  //           primary: Colors.white,
  //           shape: RoundedRectangleBorder(
  //               side: BorderSide(
  //                   color: selected[index]
  //                       ? Theme.of(context).buttonColor
  //                       : Colors.grey)),
  //         ),
  //         onPressed: () {
  //           setState(() {
  //             for (int i = 0; i < 4; i++) selected[i] = false;
  //             selected[index] = true;
  //           });
  //         },
  //         child: Text(
  //           title,
  //           style: TextStyle(
  //               color: selected[index]
  //                   ? Theme.of(context).buttonColor
  //                   : Colors.black54,
  //               fontSize: 18),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildPollsList(context) {
    return FutureBuilder<List<Poll>>(
        future: CollaborationsApi().getPolls(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            );
          else {
            polls = snapshot.data;
            if (polls.length == 0)
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("No data"),
              ));
            else
              return isBeingSearhced
                  ? _listviewBuildPolls(searchedPolls)
                  : _listviewBuildPolls(polls);
          }
        });
  }

  Widget _listviewBuildPolls(List<Poll> polls) {
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Container(
                          height: 280,
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Image.network(
                              CollaborationsApi().baseUrl +
                                  polls[index].company.logo,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 5, bottom: 5),
                        child: Text(
                          polls[index].title,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, bottom: 5),
                        child: Text(
                          polls[index].noOfChoices + ' choice',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 19,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, bottom: 5),
                        child: Row(
                          children: [
                            Text(
                              polls[index].noOfVotes + ' Vote',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 19,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(FontAwesomeIcons.handPointUp)
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Divider(
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
                                    polls[index].company.logo,
                                fit: BoxFit.cover,
                                width: 90.0,
                                height: 90.0,
                              )),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            if (polls[index].company.companyAddress != null)
                              if (polls[index]
                                      .company
                                      .companyAddress["phone_number"] !=
                                  null)
                                InkWell(
                                  onTap: () {
                                    LaunchApp().launchInBrowser(
                                        "tel:${polls[index].company.companyAddress["phone_number"]}");
                                  },
                                  child: Container(
                                    height: 34,
                                    width: 34,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(247, 247, 251, 1),
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
                            //     Icons.location_on,
                            //     color: Colors.black,
                            //     size: 19,
                            //   ),
                            // ),
                            // SizedBox(
                            //   width: 5.0,
                            // ),
                            // Container(
                            //   height: 34,
                            //   width: 34,
                            //   decoration: BoxDecoration(
                            //       color: Color.fromRGBO(247, 247, 251, 1),
                            //       shape: BoxShape.circle),
                            //   child: Icon(
                            //     FontAwesomeIcons.solidComments,
                            //     color: Colors.blue,
                            //     size: 19,
                            //   ),
                            // ),
                            // SizedBox(
                            //   width: 5.0,
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await CollaborationsApi()
                                      .getLoginStatus()
                                      .then((status) {
                                    if (status == "true")
                                      Navigator.pushNamed(
                                          context, '/pollDetail',
                                          arguments: {'id': polls[index].id});
                                    else
                                      Navigator.pushNamed(context, "/login",
                                          arguments: {
                                            'route': '/pollDetail',
                                            'id': polls[index].id
                                          });
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).buttonColor,
                                ),
                                child: Text(
                                  "Poll Detail",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.57,
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
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.black54,
                                    size: 19,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    'Feb 23, 2021, 8:31pm',
                                    style: TextStyle(
                                        fontSize: 17.0, color: Colors.black87),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 25.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        itemCount: polls.length,
      ),
    );
  }
}
