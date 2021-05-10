import 'package:fbpidi/widgets/screens/manufacturer_list.dart';
import 'package:fbpidi/widgets/screens/product_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductsPage extends StatefulWidget {
  final data;
  ProductsPage(this.data);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final Color primaryColor = Color(0xffFD6592);

  final Color secondaryColor = Color(0xff324558);

  String type = "list";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Theme(
        data: ThemeData(
          primaryColor: primaryColor,
          appBarTheme: AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(color: secondaryColor),
            actionsIconTheme: IconThemeData(
              color: secondaryColor,
            ),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 40,
              child: TextField(
                autocorrect: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Products",
                  prefixIcon: Icon(Icons.search),
                  hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(0, 10.0, 20.0, 10.0),
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(FontAwesomeIcons.chevronLeft),
              color: Colors.black54,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TabBar(
                    isScrollable: true,
                    labelColor: Colors.black87,
                    indicatorColor: primaryColor,
                    unselectedLabelColor: Colors.black54,
                    tabs: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Products",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "Manufacturers",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // IconButton(
                      //   icon: type == "list"
                      //       ? Icon(FontAwesomeIcons.thLarge)
                      //       : Icon(FontAwesomeIcons.stream),
                      //   color: Colors.black54,
                      //   onPressed: () {
                      //     // setState(() {
                      //     //   if (type == "list")
                      //     //     type = "grid";
                      //     //   else
                      //     //     type = "list";
                      //     // });
                      //   },
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 8.0, right: 8),
                      //   child: Container(
                      //     width: 2,
                      //     height: 30,
                      //     color: Colors.black38,
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("All Products"),
                  ),
                  ProductsList(widget.data["id"]),
                ],
              )),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("All Companies"),
                    ),
                    ManufacturerList()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // Scaffold(
    //     appBar: AppBar(
    //       title: Text("Products"),
    //     ),
    //     body: SingleChildScrollView(
    //         child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Text("All 20,022 Products"),
    //         ),
    //         ProductsList("list"),
    //       ],
    //     )));
  }
}
