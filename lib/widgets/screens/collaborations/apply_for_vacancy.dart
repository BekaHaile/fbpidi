import 'package:fbpidi/models/jobcategory.dart';
import 'package:fbpidi/models/vacancy.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/services/remove_tag.dart';
import 'package:flutter/material.dart';

class ApplyForVacancy extends StatelessWidget {
  final data;
  ApplyForVacancy(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Apply'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildCategoryList(context),
              _buildDetail(context),
            ],
          ),
        ));
  }

  Widget _buildCategoryList(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Card(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 20, bottom: 20),
                child: Text(
                  'Categories',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                height: 3,
              ),
              FutureBuilder<Map<dynamic, dynamic>>(
                  future: CollaborationsApi().getJobCategory(),
                  builder: (BuildContext context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    else {
                      List<JobCategory> jobCategory =
                          snapshot.data['jobCategory'];
                      List<Vacancy> vacancies = snapshot.data['vacancies'];
                      return ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: jobCategory.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (_, int index) {
                          int count = 0;
                          vacancies.forEach((element) {
                            if (element.categoryName ==
                                jobCategory[index].categoryName) count++;
                          });
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18.0, top: 20, bottom: 20),
                                    child: Text(
                                      jobCategory[index].categoryName,
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
                                          color:
                                              Color.fromRGBO(247, 247, 251, 1),
                                          shape: BoxShape.circle),
                                      child: Center(
                                          child: Text(count.toString()))),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
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
                            'Job Application Form',
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
                                  vacancy.employmentType, false),
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
