import 'package:fbpidi/services/remove_tag.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/company.dart';
import '../../services/company_and_product_api.dart';

class ManufacturerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: CompanyAndProductAPI().getCompanies("All", "1"),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            List<Company> companies = snapshot.data["companies"];
            return Container(
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                        fontSize: 16.0, color: Colors.black54),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Row(
                                    children: [
                                      Icon(FontAwesomeIcons.mapMarkerAlt,
                                          color: Colors.black54),
                                      SizedBox(
                                        width: 3.0,
                                      ),
                                      Text(
                                        companies[index].companyAddress != null
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
                              productByManufacturer(context, companies[index]),
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
            );
          }
        });
  }

  Widget productByManufacturer(context, Company company) {
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
              RemoveTag().removeAllHtmlTags(company.detail.length > 35
                  ? company.detail.substring(0, 35) + '...'
                  : company.detail),
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
}
