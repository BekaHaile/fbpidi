import 'package:fbpidi/models/tender.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
import 'package:fbpidi/widgets/components/fbpidi_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Tenders extends StatefulWidget {
  @override
  _TendersState createState() => _TendersState();
}

class _TendersState extends State<Tenders> {
  List selected = [true, false, false, false];
  List<Tender> tenders, searchedTenders = [];
  bool isBeingSearhced = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: FbpidiDrawer("Tenders")),
      appBar: AppBar(
        title: Text("Tenders"),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            children: [
              FbpidiSearch(
                callback: searchedTenders,
              ),
              _sortList(context),
              _buildTenderList(context),
            ],
          ),
        )),
      ),
    );
  }

  void searchCallback(String searchValue) {
    if (tenders.length > 0) {
      tenders.forEach((element) {
        if (element.title.contains(searchValue)) searchedTenders.add(element);
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
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: selected[0]
                                ? Theme.of(context).buttonColor
                                : Colors.black38)),
                  ),
                  onPressed: () {
                    setState(() {
                      for (int i = 0; i < 4; i++) selected[i] = false;
                      selected[0] = true;
                    });
                  },
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
            _sortButton("Free only", context, 1),
            _sortButton("Paid only", context, 2),
            _sortButton("Open only", context, 3),
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

  Widget _buildTenderList(context) {
    return FutureBuilder<List<Tender>>(
        future: CollaborationsApi().getTenders(),
        builder: (BuildContext context, snapshot) {
          print(snapshot.data);
          if (!snapshot.hasData)
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            );
          else {
            tenders = snapshot.data;
            if (tenders.length == 0)
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("No data"),
              ));
            else
              return isBeingSearhced
                  ? _listviewBuildTenders(searchedTenders)
                  : _listviewBuildTenders(tenders);
          }
        });
  }

  Widget _listviewBuildTenders(List<Tender> tenders) {
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
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 5, bottom: 5),
                        child: Text(
                          tenders[index].title,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 21,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 5, bottom: 20),
                        child: Text(
                          tenders[index].tenderType,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 19,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(0, 128, 0, 1),
                          ),
                          onPressed: () {},
                          child: Text(
                            tenders[index].status,
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
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
                                  Navigator.pushNamed(context, '/tenderDetail',
                                      arguments: {'id': tenders[index].id});
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).buttonColor,
                                ),
                                child: Text(
                                  "Tender Detail",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
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
                                    'Posted: ',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    tenders[index]
                                            .createdDate
                                            .substring(0, 10) +
                                        ', ' +
                                        tenders[index]
                                            .createdDate
                                            .substring(11, 16) +
                                        ' p.m.',
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
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        itemCount: tenders.length,
      ),
    );
  }
}
