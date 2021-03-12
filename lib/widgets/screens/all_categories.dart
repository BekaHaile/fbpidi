import 'package:fbpidi/models/product.dart';
import 'package:fbpidi/services/company_and_product_api.dart';
import 'package:flutter/material.dart';

class AllCategories extends StatelessWidget {
  final type;
  AllCategories(this.type);
  final Color active = Color.fromRGBO(115, 115, 115, 1);
  @override
  Widget build(BuildContext context) {
    List<String> list = [
      "Agriculture and Food",
      "Apparel and Accessories",
      "Arts and crafts"
    ];
    return Scaffold(
      appBar: AppBar(
        title:
            type["type"] == "all" ? Text("Categories") : Text("Sub Categories"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              type["type"] == "all" ? "All Categories" : "All Sub Categories",
              style: TextStyle(fontSize: 17),
            ),
          ),
          FutureBuilder<List<Product>>(
            future: CompanyAndProductAPI().getProductsByMainCategory("main"),
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
                
                return Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  color: Colors.white,
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            _buildRow(
                              "https://img.icons8.com/ios/452/corn.png",
                              list[index],
                              context,
                            ),
                            _buildDivider()
                          ],
                        );
                      }),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: Divider(
        color: active,
      ),
    );
  }

  Widget _buildRow(image, String title, context) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 20.0);
    return FlatButton(
      onPressed: () {
        if (type["type"] == "sub")
          Navigator.pushNamed(context, "/productsPage",
              arguments: {"isSubcategory": true, "name": title});
        else
          Navigator.pushNamed(context, "/allCategories",
              arguments: {"type": "sub"});
      },
      child: Container(
        child: Row(children: [
          Container(
            width: 30,
            height: 30,
            child: FittedBox(
              child: Image.network(image),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(width: 15.0),
          Text(
            title,
            style: tStyle,
          ),
        ]),
      ),
    );
  }
}
