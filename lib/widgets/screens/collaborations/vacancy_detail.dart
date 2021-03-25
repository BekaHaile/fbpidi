import 'package:fbpidi/models/vacancy.dart';
import 'package:fbpidi/services/collaborations_api.dart';
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
    return FutureBuilder<Vacancy>(
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
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
                                fontSize: 21,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Divider(
                          height: 5,
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
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Row(
                                  children: [
                                    Text(
                                      'Category: ',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      color: Color.fromRGBO(247, 247, 247, 1),
                                      child: Text(
                                        vacancy.categoryName,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 19,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Row(
                                  children: [
                                    Text(
                                      'Employee type: ',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      vacancy.employementType,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 19,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Row(
                                  children: [
                                    Text(
                                      'Company: ',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      vacancy.company.name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 19,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Divider(
                                height: 5,
                              ),
                              Row(
                                children: [
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
                                        "View Job Details",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      ),
                                    ),
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
                                            color: Colors.white, fontSize: 17),
                                      ),
                                    ),
                                  ),
                                ],
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
          }
        });
  }
}
