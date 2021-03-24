import 'package:fbpidi/models/company.dart';
import 'package:fbpidi/services/company_and_product_api.dart';
import 'package:fbpidi/services/remove_tag.dart';
import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
import 'package:fbpidi/widgets/components/fbpidi_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CompanyPage extends StatefulWidget {
  final data;
  CompanyPage(this.data);
  @override
  _CompanyState createState() => _CompanyState();
}

class _CompanyState extends State<CompanyPage> {
  List selected = [true, false, false, false];
  List<Company> companies = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: widget.data['type'] == 'all'
            ? FbpidiDrawer("Companies")
            : FbpidiDrawer(
                widget.data['type'],
                mainMenu: "Companies",
              ),
      ),
      appBar: AppBar(
        title: Text("Company"),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            children: [
              FbpidiSearch(),
              _sortList(context),
              _buildCompanyList(context),
            ],
          ),
        )),
      ),
    );
  }

  Widget _sortList(context) {
    return Card(
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 10),
              child: Text(
                'Showing 1 to 10 of 30 entries',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 10),
              child: Text(
                'Sort by: ',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 55,
              padding: EdgeInsets.only(bottom: 5),
              child: SizedBox.expand(
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      for (int i = 0; i < 4; i++) selected[i] = false;
                      selected[0] = true;
                    });
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: selected[0]
                              ? Theme.of(context).buttonColor
                              : Colors.black38)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.32),
                    child: Row(children: [
                      Text(
                        "All",
                        style: TextStyle(
                            color: selected[0]
                                ? Theme.of(context).buttonColor
                                : Colors.black54,
                            fontSize: 18),
                      ),
                      Icon(
                        FontAwesomeIcons.sort,
                        color: selected[0]
                            ? Theme.of(context).buttonColor
                            : Colors.black54,
                      ),
                    ]),
                  ),
                ),
              ),
            ),
            _sortButton("Distance", context, 1),
            _sortButton("Latest", context, 2),
            _sortButton("Rating", context, 3),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _sortButton(title, context, index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 55,
      padding: EdgeInsets.only(bottom: 5),
      child: SizedBox.expand(
        child: RaisedButton(
          onPressed: () {
            if (title == 'Distance') {
              setState(() {
                // companies.sort((a, b) =>
                //     a.numberOfEmployees.compareTo(b.numberOfEmployees));
              });
            }
            setState(() {
              for (int i = 0; i < 4; i++) selected[i] = false;
              selected[index] = true;
            });
          },
          color: Colors.white,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: selected[index]
                      ? Theme.of(context).buttonColor
                      : Colors.grey)),
          child: Text(
            title,
            style: TextStyle(
                color: selected[index]
                    ? Theme.of(context).buttonColor
                    : Colors.black54,
                fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyList(context) {
    bool liked = false;
    return FutureBuilder<List<Company>>(
        future: CompanyAndProductAPI()
            .getCompanies("manufacturer", widget.data['type']),
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
            List<Company> companies = snapshot.data;
            if (companies.length == 0)
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
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/companyDetail',
                              arguments: {'id': companies[index].id});
                        },
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
                                      padding: const EdgeInsets.only(
                                        bottom: 15.0,
                                      ),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 200,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.95,
                                            child: FittedBox(
                                              fit: BoxFit.fill,
                                              child: Image.network(
                                                "https://www.autocar.co.uk/sites/autocar.co.uk/files/styles/body-image/public/1-corvette-stingray-c8-2019-fd-hr-hero-front_0.jpg?itok=SEYe_vLy",
                                              ),
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5, top: 5),
                                                  child: Container(
                                                    height: 34,
                                                    width: 34,
                                                    decoration: BoxDecoration(
                                                        color: liked
                                                            ? Color.fromRGBO(
                                                                230, 42, 114, 1)
                                                            : Colors.black,
                                                        shape: BoxShape.circle),
                                                    child: IconButton(
                                                      icon: Icon(
                                                        FontAwesomeIcons.heart,
                                                        size: 18,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          liked = true;
                                                        });
                                                      },
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 5,
                                                  bottom: 5,
                                                ),
                                                child: Container(
                                                  height: 30,
                                                  width: 70,
                                                  child: SizedBox.expand(
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        onPrimary:
                                                            Theme.of(context)
                                                                .buttonColor
                                                                .withOpacity(1),
                                                        primary: Theme.of(
                                                                context)
                                                            .buttonColor
                                                            .withOpacity(0.9),
                                                      ),
                                                      child: Text(
                                                        companies[index]
                                                            .mainCategory,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, top: 5, bottom: 10),
                                          child: Text(
                                            companies[index].name,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(FontAwesomeIcons.exclamationCircle,
                                            color:
                                                Theme.of(context).buttonColor,
                                            size: 22)
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 5),
                                        child: Text(
                                          "0 Products",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 17),
                                        )),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Icon(
                                            Icons.location_on,
                                            color: Colors.black54,
                                            size: 19,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10.0,
                                          ),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            child: Text(
                                              companies[index].companyAddress[
                                                      'city_town'] +
                                                  ', ' +
                                                  companies[index]
                                                          .companyAddress[
                                                      'local_area'] +
                                                  ', ' +
                                                  companies[index]
                                                      .companyAddress['fax'],
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 20,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 5, bottom: 20),
                                      child: Text(
                                        RemoveTag().removeAllHtmlTags(
                                            companies[index].detail),
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        height: 3,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 18.0),
                                          child: Container(
                                            height: 34,
                                            width: 34,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    247, 247, 251, 1),
                                                shape: BoxShape.circle),
                                            child: Icon(
                                              Icons.mail,
                                              color: Colors.black,
                                              size: 19,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Container(
                                            height: 34,
                                            width: 34,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    247, 247, 251, 1),
                                                shape: BoxShape.circle),
                                            child: Icon(
                                              Icons.phone,
                                              color: Colors.black,
                                              size: 19,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Container(
                                            height: 34,
                                            width: 34,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    247, 247, 251, 1),
                                                shape: BoxShape.circle),
                                            child: Icon(
                                              FontAwesomeIcons.globe,
                                              color: Colors.black,
                                              size: 19,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Container(
                                            height: 34,
                                            width: 34,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    247, 247, 251, 1),
                                                shape: BoxShape.circle),
                                            child: Icon(
                                              FontAwesomeIcons.solidComments,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 19,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Container(
                                            height: 34,
                                            width: 34,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    247, 247, 251, 1),
                                                shape: BoxShape.circle),
                                            child: Icon(
                                              Icons.share,
                                              color: Colors.black,
                                              size: 19,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 18.0),
                                          child: Container(
                                            height: 34,
                                            width: 34,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    247, 247, 251, 1),
                                                shape: BoxShape.circle),
                                            child: Icon(
                                              Icons.directions,
                                              color: Colors.black,
                                              size: 19,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          'Get Directions',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: companies.length),
              );
          }
        });
  }
}
