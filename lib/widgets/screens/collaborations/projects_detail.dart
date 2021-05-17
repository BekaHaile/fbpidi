import 'package:fbpidi/models/project.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/services/remove_tag.dart';
import 'package:flutter/material.dart';

class ProjectDetial extends StatelessWidget {
  final data;
  ProjectDetial(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    return FutureBuilder<Map<String, dynamic>>(
        future: CollaborationsApi().getProjects(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            List<Project> project = snapshot.data["projects"];
            return Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.95,
              padding: EdgeInsets.symmetric(vertical: 1.0),
              child: Column(
                children: [
                  Card(
                    color: Colors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: Text(
                                RemoveTag()
                                    .removeAllHtmlTags(project[0].projectName),
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Container(
                              height: 350,
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.network(
                                  CollaborationsApi().baseUrl +
                                      project[0].image,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 5, bottom: 15.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.95,
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
                                    project[0].createdDate.substring(0, 10),
                                    style: TextStyle(
                                        fontSize: 17.0, color: Colors.black87),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 5),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Colors.black54,
                                    size: 19,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    project[0].contactPerson["first_name"] +
                                        " " +
                                        project[0].contactPerson["last_name"],
                                    style: TextStyle(
                                        fontSize: 17.0, color: Colors.black87),
                                    textAlign: TextAlign.justify,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Icon(
                                    Icons.mail,
                                    color: Colors.black54,
                                    size: 19,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    project[0].contactPerson["first_name"] +
                                        " " +
                                        project[0].contactPerson["last_name"],
                                    style: TextStyle(
                                        fontSize: 17.0, color: Colors.black87),
                                    textAlign: TextAlign.justify,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 5, top: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.black54,
                                    size: 19,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    project[0].contactPerson["first_name"],
                                    style: TextStyle(
                                        fontSize: 17.0, color: Colors.black87),
                                    textAlign: TextAlign.justify,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.black54,
                                    size: 19,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    project[0].siteLocationName,
                                    style: TextStyle(
                                        fontSize: 17.0, color: Colors.black87),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: Text(
                                RemoveTag()
                                    .removeAllHtmlTags(project[0].description),
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
