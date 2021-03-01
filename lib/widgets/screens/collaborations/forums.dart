import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Forum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forums"),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: _buildForumList(context),
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
                            'Latest forum created',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.57,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 10.0,
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
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      'Feb 23, 2021, 8:31pm',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black54),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 7.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, right: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.comment,
                                      color: Colors.black54,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      '0',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black54),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 5, bottom: 10),
                                child: Text(
                                  'Forum created by a genius',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 19,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, bottom: 15.0),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0),
                                  ),
                                  onPressed: () {},
                                  color: Theme.of(context).buttonColor,
                                  child: Text(
                                    "Read More",
                                    style: TextStyle(color: Colors.white),
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
