import 'package:fbpidi/models/event.dart';
import 'package:fbpidi/models/paginator.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/services/remove_tag.dart';
import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
import 'package:fbpidi/widgets/components/fbpidi_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  List selected = [true, false, false, false];
  List<Event> events, searchedEvents = [];
  bool isBeingSearhced = false;
  TextEditingController editingController = TextEditingController();
  bool addingMore = false;
  Paginator paginator;
  String loadMore = "Load More";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: FbpidiDrawer("Events")),
      appBar: AppBar(
        title: Text("Events"),
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
              _sortList(context),
              _buildEventList(context),
            ],
          ),
        )),
      ),
    );
  }

  void searchCallback(String searchValue) {
    searchedEvents.clear();
    if (events.length > 0) {
      events.forEach((element) {
        if (element.title.toLowerCase().contains(searchValue.toLowerCase()) ||
            element.status.toLowerCase().contains(searchValue.toLowerCase()) ||
            element.company.name
                .toLowerCase()
                .contains(searchValue.toLowerCase()))
          searchedEvents.add(element);
      });

      setState(() {
        isBeingSearhced = true;
      });
    }
  }

  void filter(String searchValue) {
    searchedEvents.clear();
    if (events != null && searchValue != "All") {
      events.forEach((element) {
        print("filtering " + searchValue + " in " + element.status);
        if (element.status.toLowerCase().contains(searchValue.toLowerCase()))
          searchedEvents.add(element);
      });

      setState(() {
        isBeingSearhced = true;
      });
    } else {
      setState(() {
        isBeingSearhced = false;
      });
    }
  }

  Widget _sortList(context) {
    return Card(
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 10),
              child: Text(
                'Showing 1 to 10 of 30 entries',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 10),
              child: Text(
                'Sort by: ',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 55,
              padding: EdgeInsets.only(bottom: 5),
              child: SizedBox.expand(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      for (int i = 0; i < 4; i++) selected[i] = false;
                      selected[0] = true;
                    });

                    filter("All");
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: selected[0]
                                ? Theme.of(context).buttonColor
                                : Colors.black38)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.32),
                    child: Row(children: [
                      Text(
                        "All",
                        style: TextStyle(
                            color: selected[0]
                                ? Theme.of(context).buttonColor
                                : Colors.black54,
                            fontSize: 18),
                      ),
                      Icon(
                        FontAwesomeIcons.sort,
                        color: selected[0]
                            ? Theme.of(context).buttonColor
                            : Colors.black54,
                      ),
                    ]),
                  ),
                ),
              ),
            ),
            _sortButton("Upcoming Events", context, 1),
            _sortButton("New Events", context, 2),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _sortButton(title, context, index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 55,
      padding: EdgeInsets.only(bottom: 5),
      child: SizedBox.expand(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              for (int i = 0; i < 4; i++) selected[i] = false;
              selected[index] = true;
            });
            switch (title) {
              case "Upcoming Events":
                filter("Upcoming");
                break;
              case "New Events":
                filter("New");
                break;
              default:
                filter("All");
                break;
            }
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: selected[index]
                        ? Theme.of(context).buttonColor
                        : Colors.grey)),
          ),
          child: Text(
            title,
            style: TextStyle(
                color: selected[index]
                    ? Theme.of(context).buttonColor
                    : Colors.black54,
                fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget _buildEventList(context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: CollaborationsApi().getEvents("1"),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            );
          else {
            if (!addingMore) {
              events = snapshot.data["events"];
              paginator = snapshot.data["paginator"];
            }

            if (events.length == 0)
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("No data"),
              ));
            else
              return isBeingSearhced
                  ? _listviewBuildEvents(searchedEvents, paginator)
                  : _listviewBuildEvents(events, paginator);
          }
        });
  }

  Widget _listviewBuildEvents(List<Event> events, Paginator paginator) {
    return Column(
      children: [
        Container(
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
                                        events[index].image,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 5, bottom: 10),
                              child: Text(
                                RemoveTag()
                                    .removeAllHtmlTags(events[index].title),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                events[index].startDate.substring(0, 10) +
                                    ' - ' +
                                    events[index].endDate.substring(0, 10),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: events[index].status == "Upcoming"
                                      ? Colors.yellow
                                      : Color.fromRGBO(0, 128, 0, 1),
                                ),
                                onPressed: () {},
                                child: Text(
                                  events[index].status,
                                  style: TextStyle(
                                      color: events[index].status == "Upcoming"
                                          ? Colors.black87
                                          : Colors.white,
                                      fontSize: 17),
                                ),
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
                                          events[index].company.logo,
                                      fit: BoxFit.cover,
                                      width: 90.0,
                                      height: 90.0,
                                    )),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Container(
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
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Container(
                                    height: 34,
                                    width: 34,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(247, 247, 251, 1),
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.black,
                                      size: 19,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Container(
                                    height: 34,
                                    width: 34,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(247, 247, 251, 1),
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      FontAwesomeIcons.solidComments,
                                      color: Color.fromRGBO(0, 0, 255, 1),
                                      size: 19,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, "/eventDetail",
                                            arguments: {
                                              'id': events[index].id
                                            });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        onPrimary: Theme.of(context)
                                            .buttonColor
                                            .withOpacity(0.3),
                                        primary: Theme.of(context).buttonColor,
                                      ),
                                      child: Text(
                                        "Event Detail",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 5),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                            events[index]
                                                    .createdDate
                                                    .substring(0, 10) +
                                                ', ' +
                                                events[index]
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
            itemCount: events.length,
          ),
        ),
        Center(
          child: TextButton(
            child: Text(
              loadMore,
              style: TextStyle(fontSize: 17),
            ),
            onPressed: () {
              if (paginator.next != null)
                _loadMore(paginator.next);
              else
                setState(() {
                  loadMore = "No more data";
                });
            },
          ),
        )
      ],
    );
  }

  Future<bool> _loadMore(page) async {
    await CollaborationsApi().getEvents(page).then((value) {
      events.addAll(value["events"]);
      setState(() {
        paginator = value["paginator"];
        addingMore = true;
      });
    });

    return true;
  }
}
