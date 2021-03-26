import 'package:fbpidi/models/vacancy.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/services/remove_tag.dart';
import 'package:flutter/material.dart';

class VacancyDetail extends StatelessWidget {
  final data;
  VacancyDetail(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Vacancy Detail'),
        ),
        body: SingleChildScrollView(
          child: _buildDetail(context),
        ));
  }

  Widget _buildDetail(context) {
    return Center(
      child: FutureBuilder<Vacancy>(
          future: CollaborationsApi().getVacancyDetail(data['id']),
          builder: (BuildContext context, snapshot) {
            // _fetchLanguage(context);
            if (!snapshot.hasData)
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
              );
            else {
              Vacancy vacancy = snapshot.data;
              return Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Card(
                  color: Colors.white,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 18.0, top: 20, bottom: 20),
                          child: Text(
                            vacancy.jobTitle,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 27,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          height: 5,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 15.0,
                              ),
                              _buildContent(context, "Category",
                                  vacancy.categoryName, true),
                              SizedBox(
                                height: 10.0,
                              ),
                              _buildContent(context, "Employee type",
                                  vacancy.employementType, false),
                              SizedBox(
                                height: 10.0,
                              ),
                              _buildContent(context, "Company",
                                  vacancy.company.name, false),
                              SizedBox(
                                height: 10.0,
                              ),
                              _buildContent(
                                  context, "Location", vacancy.location, false),
                              SizedBox(
                                height: 10.0,
                              ),
                              _buildContent(
                                  context, "Salary", vacancy.salary, false),
                              SizedBox(
                                height: 10.0,
                              ),
                              _buildContentInColumn(
                                  context,
                                  "Requirement",
                                  RemoveTag()
                                      .removeAllHtmlTags(vacancy.requirement),
                                  false),
                              SizedBox(
                                height: 10.0,
                              ),
                              _buildContent(context, "Starting Date",
                                  vacancy.startingDate.substring(0, 10), false),
                              SizedBox(
                                height: 10.0,
                              ),
                              _buildContent(context, "Ending Date",
                                  vacancy.endingDate.substring(0, 10), false),
                              SizedBox(
                                height: 10.0,
                              ),
                              _buildContentInColumn(
                                  context,
                                  "Description",
                                  RemoveTag()
                                      .removeAllHtmlTags(vacancy.description),
                                  false),
                              SizedBox(
                                height: 15.0,
                              ),
                              Container(
                                height: 5,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 20.0, bottom: 15.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0),
                                    ),
                                    primary: Theme.of(context).buttonColor,
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "Apply",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }

  Widget _buildContent(context, title, content, background) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 19,
                fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.5,
            color: background ? Color.fromRGBO(247, 247, 247, 1) : Colors.white,
            child: Text(
              content,
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentInColumn(context, title, content, background) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 19,
                fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.9,
            color: background ? Color.fromRGBO(247, 247, 247, 1) : Colors.white,
            child: Text(
              content,
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
