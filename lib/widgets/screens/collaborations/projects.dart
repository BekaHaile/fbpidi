import 'package:fbpidi/models/project.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/services/remove_tag.dart';
import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
import 'package:flutter/material.dart';

class Projects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: FbpidiDrawer("Projects")),
      appBar: AppBar(
        title: Text("Projects"),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildProjectList(context),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildProjectList(context) {
    return FutureBuilder<List<Project>>(
        future: CollaborationsApi().getProjects(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            List<Project> projects = snapshot.data;
            if (projects.length == 0)
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
                                  padding: const EdgeInsets.only(bottom: 30.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 320,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.95,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Image.network(
                                            CollaborationsApi().baseUrl +
                                                projects[index].image,
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.green),
                                              onPressed: () {},
                                              child: Text(
                                                projects[index].sector,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.black54,
                                              size: 19,
                                            ),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            Text(
                                              projects[index].siteLocationName,
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  color: Colors.black87),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 20),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.95,
                                        child: Text(
                                          RemoveTag().removeAllHtmlTags(
                                              projects[index].projectName),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 20.0, bottom: 15.0),
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
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, "/projectDetail",
                                                arguments: {
                                                  "id": projects[index].id
                                                });
                                          },
                                          child: Text(
                                            "Read More",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17),
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
                  itemCount: projects.length,
                ),
              );
          }
        });
  }
}
