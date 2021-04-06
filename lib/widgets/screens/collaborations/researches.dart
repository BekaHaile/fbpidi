import 'package:fbpidi/models/research.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
import 'package:fbpidi/widgets/components/fbpidi_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Researches extends StatefulWidget {
  @override
  _ResearchesState createState() => _ResearchesState();
}

class _ResearchesState extends State<Researches> {
  List selected = [true, false, false, false];
  List<Research> researches, searchedResearches = [];
  bool isBeingSearhced = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: FbpidiDrawer("Researches")),
      appBar: AppBar(
        title: Text("Researches"),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            children: [
              FbpidiSearch(
                callback: searchCallback,
              ),
              _sortList(context),
              _buildResearchList(context),
              _addNewResearch(context)
            ],
          ),
        )),
      ),
    );
  }

  void searchCallback(String searchValue) {
    if (researches.length > 0) {
      researches.forEach((element) {
        if (element.title.contains(searchValue))
          searchedResearches.add(element);
      });

      setState(() {
        isBeingSearhced = true;
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
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResearchList(context) {
    return FutureBuilder<List<Research>>(
        future: CollaborationsApi().getResearches(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            );
          else {
            List<Research> researches = snapshot.data;
            if (researches.length == 0)
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("No data"),
              ));
            else
              return isBeingSearhced
                  ? _listviewBuildResearches(searchedResearches)
                  : _listviewBuildResearches(researches);
          }
        });
  }

  Widget _listviewBuildResearches(List<Research> researches) {
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
                            height: 160,
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image.network(
                                "https://www.autocar.co.uk/sites/autocar.co.uk/files/styles/body-image/public/1-corvette-stingray-c8-2019-fd-hr-hero-front_0.jpg?itok=SEYe_vLy",
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
                                  "https://images.unsplash.com/photo-1455390582262-044cdead277a?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NXx8d3JpdGVyfGVufDB8fDB8&ixlib=rb-1.2.1&w=1000&q=80",
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
                                        context, "/researchDetail", arguments: {
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

  Widget _addNewResearch(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.55,
            height: 40.0,
            child: SizedBox.expand(
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Add new Research",
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
        ),
      ),
    );
  }
}
