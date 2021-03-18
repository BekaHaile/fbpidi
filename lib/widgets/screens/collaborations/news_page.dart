import 'package:fbpidi/models/news.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
import 'package:fbpidi/widgets/components/fbpidi_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<NewsPage> {
  List selected = [true, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: FbpidiDrawer("News")),
      appBar: AppBar(
        title: Text("News"),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            children: [
              FbpidiSearch(),
              _sortList(context),
              _buildNewsList(context),
            ],
          ),
        )),
      ),
    );
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
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      for (int i = 0; i < 4; i++) selected[i] = false;
                      selected[0] = true;
                    });
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: selected[0]
                              ? Theme.of(context).buttonColor
                              : Colors.black38)),
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
            _sortButton("Distance", context, 1),
            _sortButton("Latest", context, 2),
            _sortButton("Rating", context, 3),
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
        child: RaisedButton(
          onPressed: () {
            setState(() {
              for (int i = 0; i < 4; i++) selected[i] = false;
              selected[index] = true;
            });
          },
          color: Colors.white,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: selected[index]
                      ? Theme.of(context).buttonColor
                      : Colors.grey)),
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

  Widget _buildNewsList(context) {
    return FutureBuilder<List<News>>(
        future: CollaborationsApi().getNews(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            );
          else {
            List<News> events = snapshot.data;
            if (events.length == 0)
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("No data"),
              ));
            else
              Container(
                alignment: Alignment.center,
                height: 1800,
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
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 180,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.95,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Image.network(
                                            "https://www.autocar.co.uk/sites/autocar.co.uk/files/styles/body-image/public/1-corvette-stingray-c8-2019-fd-hr-hero-front_0.jpg?itok=SEYe_vLy",
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: RaisedButton(
                                              onPressed: () {},
                                              color:
                                                  Theme.of(context).buttonColor,
                                              child: Text(
                                                "Beverage",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 5, bottom: 10),
                                  child: Text(
                                    'News',
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
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 5, bottom: 20),
                                  child: Text(
                                    'Ethiopian Food, Beverage and Pharmaseutical Institute has officially launched the IIMP project. …',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 19,
                                    ),
                                    textAlign: TextAlign.left,
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
                                            color: Color.fromRGBO(
                                                247, 247, 251, 1),
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
                                            color: Color.fromRGBO(
                                                247, 247, 251, 1),
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
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: RaisedButton(
                                          onPressed: () {},
                                          color: Theme.of(context).buttonColor,
                                          child: Text(
                                            "News Detail",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.57,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  fontSize: 17.0,
                                                  color: Colors.black87),
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
                  itemCount: 10,
                ),
              );
          }
        });
  }
}
