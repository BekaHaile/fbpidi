import 'package:fbpidi/models/paginator.dart';
import 'package:fbpidi/models/product.dart';
import 'package:fbpidi/services/company_and_product_api.dart';
import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
import 'package:fbpidi/widgets/components/fbpidi_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  Paginator paginator;
  String loadMore = "Load More";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      appBar: AppBar(
        title: Text("Products"),
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
              _buildProductList(context),
            ],
          ),
        )),
      ),
    );
  }

  void searchCallback(String searchValue) {
    searchedProducts.clear();
    if (products.length > 0) {
      products.forEach((element) {
        if (element.name.toLowerCase().contains(searchValue.toLowerCase()))
          searchedProducts.add(element);
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
  //                     onPrimary: Colors.white.withOpacity(0.3),
  //                     primary: Colors.white,
  //                     shape: RoundedRectangleBorder(
  //                         side: BorderSide(
  //                             color: selected[0]
  //                                 ? Theme.of(context).buttonColor
  //                                 : Colors.black38))),
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
  //           setState(() {
  //             for (int i = 0; i < 4; i++) selected[i] = false;
  //             selected[index] = true;
  //           });
  //         },
  //         style: ElevatedButton.styleFrom(
  //           onPrimary: Colors.white.withOpacity(0.3),
  //           primary: Colors.white,
  //           shape: RoundedRectangleBorder(
  //             side: BorderSide(
  //                 color: selected[index]
  //                     ? Theme.of(context).buttonColor
  //                     : Colors.grey),
  //           ),
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

  Widget _buildProductList(context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: CompanyAndProductAPI()
            .getProductsByMainCategory(widget.data['type'], "1"),
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
                  onTap: () {
                    Navigator.pushNamed(context, '/productDetail',
                        arguments: {'id': products[index].id});
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
                                            width: 70,
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
                                                  products[index].categoryName,
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
                                    child: Text(
                                      products[index].name,
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
                                      color: Theme.of(context).buttonColor,
                                      size: 22)
                                ],
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
                                        'Addis Ababa',
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
                                        'Addis Ababa, Ethiopia',
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
                                  'Timings : 10am - 10pm',
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
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Container(
                                      height: 34,
                                      width: 34,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(247, 247, 251, 1),
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.mail,
                                        color: Colors.black,
                                        size: 19,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      height: 34,
                                      width: 34,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(247, 247, 251, 1),
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.phone,
                                        color: Colors.black,
                                        size: 19,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      height: 34,
                                      width: 34,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(247, 247, 251, 1),
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        FontAwesomeIcons.globe,
                                        color: Colors.black,
                                        size: 19,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      height: 34,
                                      width: 34,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(247, 247, 251, 1),
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        FontAwesomeIcons.solidComments,
                                        color: Theme.of(context).primaryColor,
                                        size: 19,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      height: 34,
                                      width: 34,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(247, 247, 251, 1),
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
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Container(
                                      height: 34,
                                      width: 34,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(247, 247, 251, 1),
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
              itemCount: products.length),
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
      ),
    );
  }

  Future<bool> _loadMore(page) async {
    await CompanyAndProductAPI()
        .getProductsByMainCategory(widget.data['type'], page)
        .then((value) {
      products.addAll(value["products"]);
      setState(() {
        paginator = value["paginator"];
        addingMore = true;
      });
    });

    return true;
  }
}
