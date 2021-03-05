import 'package:fbpidi/widgets/components/fbpidi_search.dart';
import 'package:flutter/material.dart';

class Researches extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Researches"),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      height: 40.0,
                      child: SizedBox.expand(
                        child: RaisedButton(
                          onPressed: () {},
                          child: Text(
                            "Add new Research",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          color: Theme.of(context).primaryColor,
                          disabledColor: Theme.of(context).disabledColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FbpidiSearch(),
              SizedBox(
                height: 8,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, top: 20, bottom: 20),
                        child: Text(
                          'Categories',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(
                        height: 3,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, top: 20, bottom: 20),
                                child: Text(
                                  'Computer Science projects and researches',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 19,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: Container(
                                  height: 34,
                                  width: 34,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(247, 247, 251, 1),
                                      shape: BoxShape.circle),
                                  child: Center(child: Text("1"))),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildForumList(context),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildForumList(context) {
    return IgnorePointer(
      child: Container(
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
                          padding: const EdgeInsets.only(
                              left: 18.0, top: 20, bottom: 20),
                          child: Text(
                            'Research One',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Divider(
                          height: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 15.0,
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
                                          fontSize: 17.0,
                                          color: Colors.black87),
                                      textAlign: TextAlign.justify,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Icon(
                                      Icons.person,
                                      color: Colors.black54,
                                      size: 19,
                                    ),
                                    Text(
                                      'Superuser',
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          color: Colors.black87),
                                      textAlign: TextAlign.justify,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: Row(
                                  children: [
                                    Text(
                                      'Research one',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 20.0, bottom: 15.0),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0),
                                  ),
                                  onPressed: () {},
                                  color: Theme.of(context).buttonColor,
                                  child: Text(
                                    "Read More",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                ),
                              )
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
      ),
    );
  }
}
