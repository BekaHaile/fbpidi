import 'package:fbpidi/models/paginator.dart';
import 'package:fbpidi/services/remove_tag.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/company.dart';
import '../../services/company_and_product_api.dart';

class ManufacturerList extends StatefulWidget {
  final String id;
  ManufacturerList(this.id);

  @override
  _ManufacturerListState createState() => _ManufacturerListState();
}

class _ManufacturerListState extends State<ManufacturerList> {
  List<Company> companies = [];
  bool addingMore = false;
  Paginator paginator;
  String loadMore = "Load More";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: CompanyAndProductAPI().searchCompany(widget.id, "1"),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            if (!addingMore) {
              companies = snapshot.data["companies"];
              paginator = snapshot.data["paginator"];
            }
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 1.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (_, int index) {
                      return Card(
                        color: Colors.white,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 10.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(
                                          companies[index].name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 5),
                                      child: Text(
                                        'Member Since: ' +
                                            companies[index].establishedYear,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black54),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Row(
                                        children: [
                                          Icon(FontAwesomeIcons.mapMarkerAlt,
                                              color: Colors.black54),
                                          SizedBox(
                                            width: 3.0,
                                          ),
                                          Text(
                                            companies[index].companyAddress !=
                                                    null
                                                ? companies[index]
                                                    .companyAddress["city_town"]
                                                : "City",
                                            softWrap: true,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 16),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  productByManufacturer(
                                      context, companies[index]),
                                  // productByManufacturer(context),
                                  // productByManufacturer(context),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: companies.length,
                  ),
                ),
                _loadMoreButton()
              ],
            );
          }
        });
  }

  Widget productByManufacturer(context, Company company) {
    String detail = RemoveTag().removeAllHtmlTags(company.detail);
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 15.0, bottom: 10.0, left: 5, right: 5),
            child: Container(
              height: 135,
              width: MediaQuery.of(context).size.width * 0.5,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.network(
                  CompanyAndProductAPI().baseUrl + company.logo,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              detail.length > 35 ? detail.substring(0, 35) + '...' : detail,
              style: TextStyle(fontSize: 15.0, color: Colors.black54),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget _loadMoreButton() {
    return Center(
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
    );
  }

  Future<bool> _loadMore(page) async {
    await CompanyAndProductAPI().searchCompany(widget.id, page).then((value) {
      companies.addAll(value["products"]);
      setState(() {
        paginator = value["paginator"];
        addingMore = true;
      });
    });

    return true;
  }
}
