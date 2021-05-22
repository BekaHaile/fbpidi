import 'package:fbpidi/models/paginator.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../../services/company_and_product_api.dart';

class ProductsList extends StatefulWidget {
  final String id;
  ProductsList(this.id);

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  List<Product> products = [];
  bool addingMore = false;
  Paginator paginator;
  String loadMore = "Load More";

  @override
  Widget build(BuildContext context) {
    // if (widget.type == "grid")
    //   return gridView(context);
    // else
    return listView(context);
  }

  Widget listView(context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: CompanyAndProductAPI().getProductsByCategory(widget.id, '1'),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            if (!addingMore) {
              products = snapshot.data["products"];
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 30.0, left: 5, right: 5),
                                child: Container(
                                  height: 160,
                                  width:
                                      MediaQuery.of(context).size.width * 0.37,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(
                                          products[index].name,
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                        color: Colors.grey,
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            products[index].brand.brandName,
                                            softWrap: true,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 5),
                                      child: products[index].latestPrice !=
                                              "null"
                                          ? Text(
                                              'ET birr ' +
                                                  products[index].latestPrice,
                                              style: TextStyle(
                                                  fontSize: 19.0,
                                                  color: Colors.red),
                                              textAlign: TextAlign.justify,
                                            )
                                          : Container(),
                                    ),
                                    SizedBox(
                                      height: 7.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Image.network(
                                                CompanyAndProductAPI().baseUrl +
                                                    products[index]
                                                        .company
                                                        .logo,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  child: Text(
                                                    products[index]
                                                        .company
                                                        .name,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Text(
                                                  products[index]
                                                          .company
                                                          .companyAddress[
                                                      'phone_number'],
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(top: 10, left: 9),
                                      width: 160,
                                      height: 40.0,
                                      child: SizedBox.expand(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        12.0),
                                                side: BorderSide(
                                                    color: Colors.grey)),
                                            primary: Color.fromRGBO(
                                                249, 249, 249, 1),
                                            elevation: 0,
                                          ),
                                          key: Key('raised'),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, "/companyDetail",
                                                arguments: {
                                                  "id":
                                                      products[index].company.id
                                                });
                                          },
                                          child: Text(
                                            "View Manufacturer",
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
                ),
                _loadMoreButton()
              ],
            );
          }
        });
  }

  Widget gridView(context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 1.0),
          child: GridView.builder(
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 5.0, childAspectRatio: 0.7),
            itemBuilder: (_, int index) {
              return Card(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Image.network(
                        CompanyAndProductAPI().baseUrl + products[index].image,
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
                            products[index].brand.brandName,
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
                        products[index].name,
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
                                CompanyAndProductAPI().baseUrl +
                                    products[index].company.logo,
                                height:
                                    MediaQuery.of(context).size.width * 0.08,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  products[index].company.name,
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  products[index]
                                      .company
                                      .companyAddress["phone_number"],
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: products.length,
          ),
        ),
        _loadMoreButton()
      ],
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
    await CompanyAndProductAPI()
        .getProductsByMainCategory("All", page, "")
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
