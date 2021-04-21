import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/company.dart';
import '../../services/company_and_product_api.dart';

class ManufacturerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Company>>(
        future: CompanyAndProductAPI().getCompanies("All"),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            List<Company> companies = snapshot.data;
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
                                        companies[index]
                                            .companyAddress["city_town"],
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
                              productByManufacturer(context),
                              productByManufacturer(context),
                              productByManufacturer(context),
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

  Widget productByManufacturer(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.325,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 15.0, bottom: 10.0, left: 5, right: 5),
            child: Container(
              height: 135,
              width: MediaQuery.of(context).size.width * 0.3,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.network(
                  "https://www.autocar.co.uk/sites/autocar.co.uk/files/styles/body-image/public/1-corvette-stingray-c8-2019-fd-hr-hero-front_0.jpg?itok=SEYe_vLy",
                ),
              ),
            ),
          ),
          Text(
            '2, 4-D Acid 720g/L agricultural chemicals fo...',
            style: TextStyle(fontSize: 15.0, color: Colors.black54),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
