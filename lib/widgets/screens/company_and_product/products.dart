import 'package:fbpidi/models/paginator.dart';
import 'package:fbpidi/models/product.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/services/company_and_product_api.dart';
import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
import 'package:fbpidi/widgets/components/fbpidi_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Products extends StatefulWidget {
  final data;
  Products(this.data);
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List selected = [true, false, false, false];
  List<Product> products, searchedProducts = [];
  bool isBeingSearhced = false;
  TextEditingController editingController = TextEditingController();

  bool addingMore = false;
  Paginator paginator, searchPaginator;
  String loadMore = "Load More", searchValueMain = "";

  @override
  Widget build(BuildContext context) {
    return widget.data["isInquiry"] == null
        ? Scaffold(
            drawer: Drawer(
              child: widget.data['type'] == 'All'
                  ? FbpidiDrawer(
                      "Products",
                    )
                  : FbpidiDrawer(
                      widget.data['type'],
                      mainMenu: "Products",
                    ),
            ),
            appBar: AppBar(title: Text("Products")),
            body: body())
        : Scaffold(
            appBar: AppBar(
              title: Text("Inquire"),
            ),
            body: body());
  }

  Widget body() {
    return SingleChildScrollView(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Column(
          children: [
            widget.data["isInquiry"] == null
                ? FbpidiSearch(
                    callback: searchCallback,
                    editingController: editingController,
                  )
                : Container(),
            // _sortList(context),
            _buildProductList(context),
          ],
        ),
      )),
    );
  }

  void searchCallback(String searchValue) {
    searchedProducts.clear();
    searchValueMain = searchValue;
    loadMore = "Load More";
    if (searchValue == "")
      setState(() {
        isBeingSearhced = false;
      });
    else {
      if (products.length > 0) {
        CompanyAndProductAPI()
            .getProductsByMainCategory(
                widget.data['type'], "1", searchValueMain)
            .then((value) {
          searchedProducts = value["products"];
        });

        setState(() {
          isBeingSearhced = true;
        });
      }
    }
  }

  Widget _buildProductList(context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: CompanyAndProductAPI()
            .getProductsByMainCategory(widget.data['type'], "1", ""),
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
              products = snapshot.data["products"];
              paginator = snapshot.data["paginator"];
            }

            if (products.length == 0)
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("No data"),
              ));
            else
              return isBeingSearhced
                  ? _listviewBuildProduct(searchedProducts)
                  : _listviewBuildProduct(products);
          }
        });
  }

  Widget _listviewBuildProduct(List<Product> products) {
    bool liked = false;
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.95,
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.vertical,
              itemBuilder: (_, int index) {
                return InkWell(
                  onTap: () async {
                    if (widget.data["isInquiry"] == null)
                      Navigator.pushNamed(context, '/productDetail',
                          arguments: {'id': products[index].id});
                    else {
                      await CollaborationsApi().getLoginStatus().then((status) {
                        if (status == "true")
                          Navigator.pushNamed(context, "/inquire",
                              arguments: {"product": products[index]});
                        else
                          Navigator.pushNamed(context, "/login", arguments: {
                            'route': '/inquire',
                            "product": products[index]
                          });
                      });
                    }
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
                                              products[index].image,
                                        ),
                                      ),
                                    ),
                                    widget.data["isInquiry"] == null
                                        ? Positioned.fill(
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
                                                        onPressed: () {
                                                          setState(() {
                                                            liked = true;
                                                          });
                                                        },
                                                      ))),
                                            ),
                                          )
                                        : Container(),
                                    if (products[index].brand != null)
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
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    onPrimary: Theme.of(context)
                                                        .buttonColor
                                                        .withOpacity(1),
                                                    primary: Theme.of(context)
                                                        .buttonColor
                                                        .withOpacity(0.9),
                                                  ),
                                                  child: Text(
                                                    products[index]
                                                                .brand
                                                                .productType[
                                                            "category_name"]
                                                        ["category_type"],
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 5, bottom: 10),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Text(
                                    products[index].name,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.only(left: 20.0, right: 5),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     children: [
                              //       Icon(
                              //         Icons.star,
                              //         size: 23,
                              //         color: Color.fromRGBO(241, 196, 16, 1),
                              //       ),
                              //       Icon(
                              //         Icons.star,
                              //         size: 23,
                              //         color: Color.fromRGBO(241, 196, 16, 1),
                              //       ),
                              //       Icon(
                              //         Icons.star,
                              //         size: 23,
                              //         color: Color.fromRGBO(241, 196, 16, 1),
                              //       ),
                              //       Icon(
                              //         Icons.star,
                              //         size: 23,
                              //       ),
                              //       Icon(
                              //         Icons.star,
                              //         size: 23,
                              //       ),
                              //       SizedBox(
                              //         width: 5,
                              //       ),
                              //       Text(
                              //         "52 Reviews",
                              //         style: TextStyle(
                              //             color: Colors.black87, fontSize: 18),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Icon(
                                      FontAwesomeIcons.globeAfrica,
                                      color: Colors.black,
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
                                      child: Text(
                                        products[index]
                                                    .company
                                                    .companyAddress !=
                                                null
                                            ? products[index]
                                                .company
                                                .companyAddress["city_town"]
                                            : "Address",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 7.0,
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
                                      child: Text(
                                        products[index]
                                                    .company
                                                    .companyAddress !=
                                                null
                                            ? products[index]
                                                        .company
                                                        .companyAddress[
                                                    "local_area"] +
                                                " " +
                                                products[index]
                                                        .company
                                                        .companyAddress[
                                                    "phone_number"]
                                            : "Address",
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
                              SizedBox(
                                height: 15,
                              ),
                              widget.data["isInquiry"] == null
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 3,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            if (products[index]
                                                    .company
                                                    .companyAddress !=
                                                null)
                                              if (products[index]
                                                          .company
                                                          .companyAddress[
                                                      "email"] !=
                                                  null)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 18.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      final Uri
                                                          _emailLaunchUri = Uri(
                                                        scheme: 'mailto',
                                                        path: products[index]
                                                                .company
                                                                .companyAddress[
                                                            "email"],
                                                      );
                                                      _launchInBrowser(
                                                          _emailLaunchUri
                                                              .toString());
                                                    },
                                                    child: Container(
                                                      height: 34,
                                                      width: 34,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              247, 247, 251, 1),
                                                          shape:
                                                              BoxShape.circle),
                                                      child: Icon(
                                                        Icons.mail,
                                                        color: Colors.black,
                                                        size: 19,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            if (products[index]
                                                    .company
                                                    .companyAddress !=
                                                null)
                                              if (products[index]
                                                          .company
                                                          .companyAddress[
                                                      "phone_number"] !=
                                                  null)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      _launchInBrowser(
                                                          "tel:${products[index].company.companyAddress["phone_number"]}");
                                                    },
                                                    child: Container(
                                                      height: 34,
                                                      width: 34,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              247, 247, 251, 1),
                                                          shape:
                                                              BoxShape.circle),
                                                      child: Icon(
                                                        Icons.phone,
                                                        color: Colors.black,
                                                        size: 19,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            if (products[index]
                                                    .company
                                                    .companyAddress !=
                                                null)
                                              if (products[index]
                                                          .company
                                                          .companyAddress[
                                                      "website"] !=
                                                  null)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      _launchInBrowser(products[
                                                                  index]
                                                              .company
                                                              .companyAddress[
                                                          "website"]);
                                                    },
                                                    child: Container(
                                                      height: 34,
                                                      width: 34,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              247, 247, 251, 1),
                                                          shape:
                                                              BoxShape.circle),
                                                      child: Icon(
                                                        FontAwesomeIcons.globe,
                                                        color: Colors.black,
                                                        size: 19,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            // Padding(
                                            //   padding: const EdgeInsets.only(left: 8.0),
                                            //   child: Container(
                                            //     height: 34,
                                            //     width: 34,
                                            //     decoration: BoxDecoration(
                                            //         color:
                                            //             Color.fromRGBO(247, 247, 251, 1),
                                            //         shape: BoxShape.circle),
                                            //     child: Icon(
                                            //       FontAwesomeIcons.solidComments,
                                            //       color: Theme.of(context).primaryColor,
                                            //       size: 19,
                                            //     ),
                                            //   ),
                                            // ),
                                            // Padding(
                                            //   padding: const EdgeInsets.only(left: 8.0),
                                            //   child: Container(
                                            //     height: 34,
                                            //     width: 34,
                                            //     decoration: BoxDecoration(
                                            //         color:
                                            //             Color.fromRGBO(247, 247, 251, 1),
                                            //         shape: BoxShape.circle),
                                            //     child: Icon(
                                            //       Icons.share,
                                            //       color: Colors.black,
                                            //       size: 19,
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.35,
                                            height: 40.0,
                                            child: SizedBox.expand(
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  await CollaborationsApi()
                                                      .getLoginStatus()
                                                      .then((status) {
                                                    if (status == "true")
                                                      Navigator.pushNamed(
                                                          context, "/inquire",
                                                          arguments: {
                                                            "product":
                                                                products[index]
                                                          });
                                                    else
                                                      Navigator.pushNamed(
                                                          context, "/login",
                                                          arguments: {
                                                            'route': '/inquire',
                                                            "product":
                                                                products[index]
                                                          });
                                                  });
                                                },
                                                child: Text(
                                                  "Inquire Now",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Theme.of(context)
                                                      .primaryColor,
                                                  onPrimary: Theme.of(context)
                                                      .disabledColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: products.length),
          Center(
            child: TextButton(
              child: Text(
                loadMore,
                style: TextStyle(fontSize: 17),
              ),
              onPressed: () {
                if (isBeingSearhced) {
                  if (paginator.next != null)
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
      ),
    );
  }

  Future<bool> _loadMore(page) async {
    await CompanyAndProductAPI()
        .getProductsByMainCategory(widget.data['type'], page, searchValueMain)
        .then((value) {
      if (isBeingSearhced)
        searchedProducts.addAll(value["products"]);
      else
        products.addAll(value["products"]);
      setState(() {
        if (isBeingSearhced)
          searchPaginator = value["paginator"];
        else
          paginator = value["paginator"];
        addingMore = true;
      });
    });

    return true;
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
}
