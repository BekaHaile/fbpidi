import 'package:fbpidi/models/company.dart';
import 'package:fbpidi/models/paginator.dart';
import 'package:fbpidi/services/company_and_product_api.dart';
import 'package:fbpidi/services/remove_tag.dart';
import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
import 'package:fbpidi/widgets/components/fbpidi_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyPage extends StatefulWidget {
  final data;
  CompanyPage(this.data);
  @override
  _CompanyState createState() => _CompanyState();
}

class _CompanyState extends State<CompanyPage> {
  List selected = [true, false, false, false];
  List<Company> companies, searchedCompanies = [];
  bool isBeingSearhced = false;
  TextEditingController editingController = TextEditingController();

  bool addingMore = false;
  Paginator paginator;
  String loadMore = "Load More";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: widget.data['type'] == 'all'
            ? FbpidiDrawer("Manufacturers")
            : FbpidiDrawer(
                widget.data['type'],
                mainMenu: "Manufacturers",
              ),
      ),
      appBar: AppBar(
        title: Text("Manufacturer"),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            children: [
              FbpidiSearch(
                callback: searchCallback,
                editingController: editingController,
              ),
              // _sortList(context),
              _buildCompanyList(context),
            ],
          ),
        )),
      ),
    );
  }

  void searchCallback(String searchValue) {
    searchedCompanies.clear();
    if (companies.length > 0) {
      companies.forEach((element) {
        if (element.name.toLowerCase().contains(searchValue.toLowerCase()))
          searchedCompanies.add(element);
      });

      setState(() {
        isBeingSearhced = true;
      });
    }
  }

  // Widget _sortList(context) {
  //   return Card(
  //     color: Colors.white,
  //     child: Container(
  //       width: MediaQuery.of(context).size.width * 0.95,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: <Widget>[
  //           Padding(
  //             padding: const EdgeInsets.only(top: 15, bottom: 10),
  //             child: Text(
  //               'Showing 1 to 10 of 30 entries',
  //               style: TextStyle(
  //                 color: Colors.black87,
  //                 fontSize: 18,
  //               ),
  //               textAlign: TextAlign.left,
  //             ),
  //           ),
  //           SizedBox(
  //             width: 5.0,
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(top: 15, bottom: 10),
  //             child: Text(
  //               'Sort by: ',
  //               style: TextStyle(
  //                 color: Colors.black87,
  //                 fontSize: 18,
  //               ),
  //               textAlign: TextAlign.left,
  //             ),
  //           ),
  //           SizedBox(
  //             width: 10.0,
  //           ),
  //           Container(
  //             width: MediaQuery.of(context).size.width * 0.85,
  //             height: 55,
  //             padding: EdgeInsets.only(bottom: 5),
  //             child: SizedBox.expand(
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   setState(() {
  //                     for (int i = 0; i < 4; i++) selected[i] = false;
  //                     selected[0] = true;
  //                   });
  //                 },
  //                 style: ElevatedButton.styleFrom(
  //                   primary: Colors.white,
  //                   shape: RoundedRectangleBorder(
  //                       side: BorderSide(
  //                           color: selected[0]
  //                               ? Theme.of(context).buttonColor
  //                               : Colors.black38)),
  //                 ),
  //                 child: Padding(
  //                   padding: EdgeInsets.only(
  //                       left: MediaQuery.of(context).size.width * 0.32),
  //                   child: Row(children: [
  //                     Text(
  //                       "All",
  //                       style: TextStyle(
  //                           color: selected[0]
  //                               ? Theme.of(context).buttonColor
  //                               : Colors.black54,
  //                           fontSize: 18),
  //                     ),
  //                     Icon(
  //                       FontAwesomeIcons.sort,
  //                       color: selected[0]
  //                           ? Theme.of(context).buttonColor
  //                           : Colors.black54,
  //                     ),
  //                   ]),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           _sortButton("Distance", context, 1),
  //           _sortButton("Latest", context, 2),
  //           _sortButton("Rating", context, 3),
  //           SizedBox(
  //             height: 20.0,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _sortButton(title, context, index) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width * 0.85,
  //     height: 55,
  //     padding: EdgeInsets.only(bottom: 5),
  //     child: SizedBox.expand(
  //       child: ElevatedButton(
  //         onPressed: () {
  //           if (title == 'Distance') {
  //             setState(() {
  //               // companies.sort((a, b) =>
  //               //     a.numberOfEmployees.compareTo(b.numberOfEmployees));
  //             });
  //           }
  //           setState(() {
  //             for (int i = 0; i < 4; i++) selected[i] = false;
  //             selected[index] = true;
  //           });
  //         },
  //         style: ElevatedButton.styleFrom(
  //           primary: Colors.white,
  //           shape: RoundedRectangleBorder(
  //               side: BorderSide(
  //                   color: selected[index]
  //                       ? Theme.of(context).buttonColor
  //                       : Colors.grey)),
  //         ),
  //         child: Text(
  //           title,
  //           style: TextStyle(
  //               color: selected[index]
  //                   ? Theme.of(context).buttonColor
  //                   : Colors.black54,
  //               fontSize: 18),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildCompanyList(context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: CompanyAndProductAPI().getCompanies(widget.data['type'], "1"),
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
            if (!addingMore) {
              companies = snapshot.data["companies"];
              paginator = snapshot.data["paginator"];
            }

            if (companies.length == 0)
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("No data"),
              ));
            else
              return isBeingSearhced
                  ? _listviewBuildCompany(searchedCompanies, paginator)
                  : _listviewBuildCompany(companies, paginator);
          }
        });
  }

  Widget _listviewBuildCompany(List<Company> companies, Paginator paginator) {
    bool liked = false;
    return Column(
      children: [
        Container(
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
                                      height: 280,
                                      width: MediaQuery.of(context).size.width *
                                          0.95,
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Image.network(
                                          CompanyAndProductAPI().baseUrl +
                                              companies[index].logo,
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                            padding: const EdgeInsets.only(
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
                                            width: 100,
                                            child: SizedBox.expand(
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                  onPrimary: Theme.of(context)
                                                      .buttonColor
                                                      .withOpacity(1),
                                                  primary: Theme.of(context)
                                                      .buttonColor
                                                      .withOpacity(0.9),
                                                ),
                                                child: Text(
                                                  companies[index]
                                                              .category
                                                              .length >
                                                          0
                                                      ? companies[index]
                                                              .category[0]
                                                          ['category_type']
                                                      : "Unknown",
                                                  style: TextStyle(
                                                      color: Colors.white),
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
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Text(
                                        companies[index].name,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  )
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
                                        color: Colors.black87, fontSize: 17),
                                  )),
                              SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: companies[index].companyAddress !=
                                              null
                                          ? Text(
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
                                            )
                                          : Text(
                                              'Address Missing',
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
                                  companies[index].category.length > 0
                                      ? RemoveTag().removeAllHtmlTags(
                                          companies[index].category[0]
                                              ['description'])
                                      : "No description",
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
                                  if (companies[index].companyAddress != null)
                                    if (companies[index]
                                            .companyAddress["email"] !=
                                        null)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 18.0),
                                        child: InkWell(
                                          onTap: () {
                                            final Uri _emailLaunchUri = Uri(
                                              scheme: 'mailto',
                                              path: companies[index]
                                                  .companyAddress["email"],
                                            );
                                            _launchInBrowser(
                                                _emailLaunchUri.toString());
                                          },
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
                                      ),
                                  if (companies[index].companyAddress != null)
                                    if (companies[index]
                                            .companyAddress["phone_number"] !=
                                        null)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: InkWell(
                                          onTap: () {
                                            _launchInBrowser(
                                                "tel:${companies[index].companyAddress["phone_number"]}");
                                          },
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
                                      ),
                                  if (companies[index].companyAddress != null)
                                    if (companies[index]
                                            .companyAddress["website"] !=
                                        null)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: InkWell(
                                          onTap: () {
                                            _launchInBrowser(companies[index]
                                                .companyAddress["website"]);
                                          },
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
        ),
        Center(
          child: TextButton(
            child: Text(
              loadMore,
              style: TextStyle(fontSize: 17),
            ),
            onPressed: () {
              if (paginator.next != null)
                _loadMore(paginator.next);
              else
                setState(() {
                  loadMore = "No more data";
                });
            },
          ),
        )
      ],
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (!url.contains("http") &&
        !url.contains("mailto") &&
        !url.contains("tel")) url = "http://" + url;
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<bool> _loadMore(page) async {
    await CompanyAndProductAPI()
        .getCompanies(widget.data['type'], page)
        .then((value) {
      companies.addAll(value["companies"]);
      setState(() {
        paginator = value["paginator"];
        addingMore = true;
      });
    });

    return true;
  }
}
