import 'package:fbpidi/models/product.dart';
import 'package:fbpidi/services/company_and_product_api.dart';
import 'package:fbpidi/services/remove_tag.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductDetail extends StatelessWidget {
  final data;
  ProductDetail(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<Product>(
                future: CompanyAndProductAPI().getProduct(data['id']),
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
                    Product products = snapshot.data;
                    return Center(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.95,
                        padding: EdgeInsets.symmetric(vertical: 1.0),
                        child: Column(
                          children: [
                            Card(
                              color: Colors.white,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 5, bottom: 10),
                                      child: Text(
                                        products.name,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    if (products.brand.productType != null)
                                      _productIcons(
                                          context,
                                          Icons.badge,
                                          products.brand
                                                  .productType["category_name"]
                                              ["category_type"]),
                                    SizedBox(
                                      height: 7.0,
                                    ),
                                    if (products.company.companyAddress != null)
                                      _productIcons(
                                          context,
                                          Icons.location_on,
                                          products.company
                                              .companyAddress["city_town"]),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 15.0,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 200,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: FittedBox(
                                              fit: BoxFit.fill,
                                              child: Image.network(
                                                CompanyAndProductAPI().baseUrl +
                                                    products.image,
                                              ),
                                            ),
                                          ),
                                          // Positioned.fill(
                                          //   child: Align(
                                          //     alignment: Alignment.topLeft,
                                          //     child: Padding(
                                          //       padding: const EdgeInsets.only(
                                          //         top: 5,
                                          //       ),
                                          //       child: Container(
                                          //         height: 30,
                                          //         width: 70,
                                          //         child: SizedBox.expand(
                                          //           child: ElevatedButton(
                                          //             onPressed: () {},
                                          //             style: ElevatedButton
                                          //                 .styleFrom(
                                          //               onPrimary: Theme.of(
                                          //                       context)
                                          //                   .buttonColor
                                          //                   .withOpacity(0.9),
                                          //               primary: Theme.of(
                                          //                       context)
                                          //                   .buttonColor
                                          //                   .withOpacity(0.7),
                                          //             ),
                                          //             child: Text(
                                          //               products
                                          //                   .brand.brandName,
                                          //               style: TextStyle(
                                          //                   color:
                                          //                       Colors.white),
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            overviewCard(context, products),
                            _buildButtons(context),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget _productIcons(context, icon, title) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Icon(
            icon,
            color: Colors.black54,
            size: 14,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }

  Widget overviewCard(context, Product products) {
    return Card(
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
                child: Text(
                  'Overview',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                  height: 3, color: Theme.of(context).scaffoldBackgroundColor),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, top: 15, bottom: 15, right: 15),
                child: Text(
                  RemoveTag().removeAllHtmlTags(products.description),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
                child: Text(
                  'Contact info',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
              if (products.company.companyAddress != null)
                Column(
                  children: [
                    _contactInfo(
                        context,
                        Icons.flag,
                        products.company.companyAddress["city_town"] +
                            ", " +
                            products.company.companyAddress["local_area"]),
                    SizedBox(
                      height: 15.0,
                    ),
                    _contactInfo(context, Icons.mail,
                        products.company.companyAddress["email"]),
                    SizedBox(
                      height: 15.0,
                    ),
                    _contactInfo(context, Icons.phone,
                        products.company.companyAddress["phone_number"]),
                    SizedBox(
                      height: 15.0,
                    ),
                    _contactInfo(context, Icons.file_copy,
                        products.company.companyAddress["fax"]),
                  ],
                ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
                child: Text(
                  'More Business info',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
              _businessInfo(context, "Established Year",
                  products.company.establishedYear),
              SizedBox(
                height: 15.0,
              ),
              _businessInfo(context, "Services", ""),
              SizedBox(
                height: 15.0,
              ),
              _businessInfo(context, "Certification", "Certified"),
              SizedBox(
                height: 15.0,
              ),
              Container(
                  height: 3, color: Theme.of(context).scaffoldBackgroundColor),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Text(
                    products.company.name,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 19,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Text(
                    "Posted by ${products.company.contactPerson["username"]} / " +
                        products.createDate.substring(0, 10),
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 19,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Container(
                  height: 3, color: Theme.of(context).scaffoldBackgroundColor),
            ]),
      ),
    );
  }

  Widget _contactInfo(context, icon, title) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
                color: Color.fromRGBO(247, 247, 251, 1),
                shape: BoxShape.circle),
            child: Icon(
              icon,
              color: Colors.black54,
              size: 19,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              title != null ? title : "",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }

  Widget _businessInfo(context, mainText, subText) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            mainText,
            style: TextStyle(
                color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 30.0,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              subText,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 19,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(context) {
    return Card(
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 45,
                  width: 140,
                  child: SizedBox.expand(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        onPrimary:
                            Theme.of(context).primaryColor.withOpacity(0.5),
                        primary: Theme.of(context).primaryColor,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                      ),
                      child: Text(
                        "Inquire Now",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: Container(
              //     height: 45,
              //     width: 150,
              //     child: SizedBox.expand(
              //       child: ElevatedButton(
              //         onPressed: () {},
              //         style: ElevatedButton.styleFrom(
              //           onPrimary: Color.fromRGBO(255, 136, 25, 0.5),
              //           primary: Color.fromRGBO(255, 136, 25, 1),
              //           padding: EdgeInsets.symmetric(horizontal: 16),
              //           shape: const RoundedRectangleBorder(
              //             borderRadius: BorderRadius.all(Radius.circular(2)),
              //           ),
              //         ),
              //         child: Text(
              //           "Add to Basket",
              //           style: TextStyle(color: Colors.white, fontSize: 17),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ]),
      ),
    );
  }
}
