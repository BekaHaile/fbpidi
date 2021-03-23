import 'package:fbpidi/models/vacancy.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
import 'package:flutter/material.dart';

class Vacancies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: FbpidiDrawer("Vacancies")),
      appBar: AppBar(
        title: Text("Vacancies"),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0, top: 20, bottom: 20),
                            child: Text(
                              'Computer Science',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 19,
                              ),
                              textAlign: TextAlign.left,
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
      child: FutureBuilder<List<Vacancy>>(
          future: CollaborationsApi().getVacancies(),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
              );
            else {
              List<Vacancy> vacancies = snapshot.data;
              if (vacancies.length == 0)
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("No data"),
                ));
              else
                return Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.9,
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
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18.0, top: 20, bottom: 20),
                                    child: Text(
                                      vacancies[index].jobTitle,
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 20),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          child: Row(
                                            children: [
                                              Text(
                                                'Category: ',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                color: Color.fromRGBO(
                                                    247, 247, 247, 1),
                                                child: Text(
                                                  vacancies[index].categoryName,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          child: Row(
                                            children: [
                                              Text(
                                                'Employee type: ',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                vacancies[index]
                                                    .employementType,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          child: Row(
                                            children: [
                                              Text(
                                                'Company: ',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                vacancies[index]
                                                    .companyInfo
                                                    .name,
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
                                                  top: 10,
                                                  left: 20.0,
                                                  bottom: 15.0),
                                              child: RaisedButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          5.0),
                                                ),
                                                onPressed: () {},
                                                color: Theme.of(context)
                                                    .buttonColor,
                                                child: Text(
                                                  "View Job Details",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  left: 20.0,
                                                  bottom: 15.0),
                                              child: RaisedButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          5.0),
                                                ),
                                                onPressed: () {},
                                                color: Theme.of(context)
                                                    .buttonColor,
                                                child: Text(
                                                  "Apply",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17),
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
                    },
                    itemCount: vacancies.length,
                  ),
                );
            }
          }),
    );
  }
}
