import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../../services/company_and_product_api.dart';

class ProductsList extends StatelessWidget {
  final String type;
  ProductsList(this.type);
  @override
  Widget build(BuildContext context) {
    if (type == "grid")
      return gridView(context);
    else
      return listView(context);
  }

  Widget listView(context) {
    return FutureBuilder<List<Product>>(
        future: CompanyAndProductAPI().getProductsByMainCategory("all"),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            List<Product> products = snapshot.data;
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, bottom: 30.0, left: 5, right: 5),
                            child: Container(
                              height: 160,
                              width: MediaQuery.of(context).size.width * 0.37,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.network(
                                  CompanyAndProductAPI().baseUrl +
                                      products[index].image,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.57,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      products[index].name,
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 16),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        'ET birr 1-10 ',
                                        style: TextStyle(
                                            fontSize: 19.0, color: Colors.red),
                                        textAlign: TextAlign.justify,
                                      ),
                                      Text(
                                        '/ KG',
                                        style: TextStyle(
                                          fontSize: 19.0,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 7.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      'Min. Order 1,000KG',
                                      softWrap: true,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Image.network(
                                            products[index].company.logo,
                                            height: 20,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              products[index].company.name,
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              products[index]
                                                      .company
                                                      .companyAddress[
                                                  'phone_number'],
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10, left: 9),
                                  width: 160,
                                  height: 40.0,
                                  child: SizedBox.expand(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(12.0),
                                            side:
                                                BorderSide(color: Colors.grey)),
                                        primary:
                                            Color.fromRGBO(249, 249, 249, 1),
                                        elevation: 0,
                                      ),
                                      key: Key('raised'),
                                      onPressed: () {},
                                      child: Text(
                                        "Contact Manufacturer",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: products.length,
              ),
            );
          }
        });
  }

  Widget gridView(context) {
    return Container(
      height: 1800,
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: GridView.builder(
        shrinkWrap: true,
        primary: false,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 5.0, childAspectRatio: 0.58),
        itemBuilder: (_, int index) {
          return Card(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.network(
                    "https://www.autocar.co.uk/sites/autocar.co.uk/files/styles/body-image/public/1-corvette-stingray-c8-2019-fd-hr-hero-front_0.jpg?itok=SEYe_vLy",
                    height: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        'Product Category',
                        softWrap: true,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 5),
                  child: Text(
                    'Tomato Paste for Benin 2200g Tomato Paste ...',
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.network(
                            "https://media.istockphoto.com/photos/oil-refinery-chemical-petrochemical-plant-picture-id932140864?k=6&m=932140864&s=612x612&w=0&h=UujqNqhSsXBOHMd2x-X3YmkMOBLv7g1FZCCr52rC6b4=",
                            height: 20,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              'Manufacturer Company',
                              softWrap: true,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 11),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              'Phone Number',
                              softWrap: true,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 11),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    'Product Category',
                    softWrap: true,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
