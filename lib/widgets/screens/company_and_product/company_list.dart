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
  List<Company> companies, searchedCompanies = [];
  bool isBeingSearhced = false;
  TextEditingController editingController = TextEditingController();

  bool addingMore = false;
  Paginator paginator, searchPaginator;
  String loadMore = "Load More", searchValueMain = "";
  List<bool> likedList = [];

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
    searchValueMain = searchValue;
    loadMore = "Load More";
    if (companies.length > 0) {
      CompanyAndProductAPI().searchCompany(searchValue, "1").then((value) {
        searchedCompanies = value["companies"];
        searchPaginator = value["paginator"];
      });
      // companies.forEach((element) {
      //   if (element.name.toLowerCase().contains(searchValue.toLowerCase()))
      //     searchedCompanies.add(element);
      // });

      setState(() {
        isBeingSearhced = true;
      });
    }
  }

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
                likedList.add(false);
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
                                            child: FutureBuilder<
                                                    Map<String, dynamic>>(
                                                future: CompanyAndProductAPI()
                                                    .getLikedCompanies(),
                                                builder: (BuildContext context,
                                                    snapshot) {
                                                  // _fetchLanguage(context);
                                                  if (!snapshot.hasData)
                                                    return Container();
                                                  else {
                                                    List<dynamic>
                                                        likedCompanies =
                                                        snapshot.data[
                                                            "liked_companies"];
                                                    if (likedCompanies.contains(
                                                        int.parse(
                                                            companies[index]
                                                                .id)))
                                                      likedList[index] = true;
                                                    else
                                                      likedList[index] = false;
                                                    return Container(
                                                      height: 34,
                                                      width: 34,
                                                      decoration: BoxDecoration(
                                                          color: likedList[
                                                                  index]
                                                              ? Color.fromRGBO(
                                                                  230,
                                                                  42,
                                                                  114,
                                                                  1)
                                                              : Colors.black,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: IconButton(
                                                          icon: Icon(
                                                            FontAwesomeIcons
                                                                .heart,
                                                            size: 18,
                                                            color: Colors.white,
                                                          ),
                                                          onPressed: () async {
                                                            await CompanyAndProductAPI()
                                                                .likeCompany(
                                                                    companies[
                                                                            index]
                                                                        .id,
                                                                    likedList[
                                                                            index]
                                                                        ? "dislike"
                                                                        : "like")
                                                                .then((value) {
                                                              if (value[
                                                                      "error"] ==
                                                                  false)
                                                                setState(() {
                                                                  likedList[
                                                                          index] =
                                                                      !likedList[
                                                                          index];
                                                                });
                                                            });
                                                          }),
                                                    );
                                                  }
                                                })),
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
                                                          'city_town'] !=
                                                      null
                                                  ? companies[index]
                                                          .companyAddress[
                                                      'city_town']
                                                  : "" +
                                                              ', ' +
                                                              companies[index]
                                                                      .companyAddress[
                                                                  'local_area'] !=
                                                          null
                                                      ? companies[index]
                                                              .companyAddress[
                                                          'local_area']
                                                      : "" +
                                                                  ', ' +
                                                                  companies[index]
                                                                          .companyAddress[
                                                                      'fax'] !=
                                                              null
                                                          ? companies[index]
                                                                  .companyAddress[
                                                              'fax']
                                                          : null,
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
              if (isBeingSearhced) {
                if (searchPaginator.next != null)
                  _loadMore(searchPaginator.next);
                else
                  setState(() {
                    loadMore = "No more data";
                  });
              } else {
                if (paginator.next != null)
                  _loadMore(paginator.next);
                else
                  setState(() {
                    loadMore = "No more data";
                  });
              }
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
    if (isBeingSearhced) {
      await CompanyAndProductAPI()
          .searchCompany(searchValueMain, page)
          .then((value) {
        searchedCompanies.addAll(value["companies"]);
        setState(() {
          searchPaginator = value["paginator"];
          addingMore = true;
        });
      });
    } else {
      await CompanyAndProductAPI()
          .getCompanies(widget.data['type'], page)
          .then((value) {
        companies.addAll(value["companies"]);
        setState(() {
          paginator = value["paginator"];
          addingMore = true;
        });
      });
    }

    return true;
  }
}
