import 'package:fbpidi/models/vacancy.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
import 'package:flutter/material.dart';

class Vacancies extends StatefulWidget {
  @override
  _VacanciesState createState() => _VacanciesState();
}

class _VacanciesState extends State<Vacancies> {
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
                      _buildCategoryList(context)
                    ],
                  ),
                ),
              ),
              _buildVacancyList(context),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildCategoryList(context) {
    return FutureBuilder<Map<String, dynamic>>(
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
            Map<String, dynamic> data = snapshot.data;
            if (data.length == 0)
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("No data"),
              ));
            else
              return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.vertical,
                  itemCount: data['jobCategory'].length,
                  itemBuilder: (_, int index) {
                    int count = 0;
                    data['vacancies'].forEach((vacancy) {
                      if (vacancy.category == data['jobCategory'][index].id)
                        count++;
                    });
                    return Column(
                      children: [
                        Container(
                          height: 3,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18.0, top: 20, bottom: 20),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Text(
                                  data['jobCategory'][index].categoryName,
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
                                  child: Center(child: Text(count.toString()))),
                            ),
                          ],
                        ),
                      ],
                    );
                  });
          }
        });
  }

  Widget _buildVacancyList(context) {
    return FutureBuilder<List<Vacancy>>(
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
                                    vacancies[index].title,
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: Row(
                                          children: [
                                            Text(
                                              'Employee type: ',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: Text(
                                                vacancies[index].employmentType,
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: Row(
                                          children: [
                                            Text(
                                              'Company: ',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              child: Text(
                                                vacancies[index].company.name,
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
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          5.0),
                                                ),
                                                primary: Theme.of(context)
                                                    .buttonColor,
                                              ),
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/vacancyDetail',
                                                    arguments: {
                                                      'id': vacancies[index].id
                                                    });
                                              },
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
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          5.0),
                                                ),
                                                primary: Theme.of(context)
                                                    .buttonColor,
                                              ),
                                              onPressed: () async {
                                                await CollaborationsApi()
                                                    .getLoginStatus()
                                                    .then((status) {
                                                  if (status == "true")
                                                    Navigator.pushNamed(context,
                                                        "/vacancyApply",
                                                        arguments: {
                                                          "id": vacancies[index]
                                                              .id
                                                        });
                                                  else
                                                    Navigator.pushNamed(context,
                                                        "/login", arguments: {
                                                      'route': '/vacancyApply',
                                                      'id': vacancies[index].id
                                                    });
                                                });
                                              },
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
        });
  }
}
