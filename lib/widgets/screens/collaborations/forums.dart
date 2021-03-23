import 'package:fbpidi/models/forum.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
import 'package:fbpidi/widgets/components/fbpidi_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Forums extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: FbpidiDrawer("Forums")),
      appBar: AppBar(
        title: Text("Forums"),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            children: [
              FbpidiSearch(),
              _buildForumList(context),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildForumList(context) {
    return IgnorePointer(
      child: FutureBuilder<List<Forum>>(
          future: CollaborationsApi().getForums(),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            else {
              List<Forum> forums = snapshot.data;
              if (forums.length == 0)
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("No data"),
                ));
              else
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
                                        left: 18.0, top: 20, bottom: 20),
                                    child: Text(
                                      forums[index].title,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.57,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          height: 10.0,
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
                                                size: 18,
                                              ),
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                              Text(
                                                forums[index]
                                                    .timeStamp
                                                    .substring(0, 10),
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
                                          padding: const EdgeInsets.only(
                                              left: 20.0, right: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                                forums[index].noOfComments,
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
                                            forums[index].description,
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
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                              ),
                                              primary:
                                                  Theme.of(context).buttonColor,
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              "Read More",
                                              style: TextStyle(
                                                  color: Colors.white),
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
                    itemCount: forums.length,
                  ),
                );
            }
          }),
    );
  }
}
