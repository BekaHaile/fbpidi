import 'package:fbpidi/services/company_and_product_api.dart';
import 'package:flutter/material.dart';

class AllCategories extends StatelessWidget {
  final type;
  AllCategories(this.type);
  final Color active = Color.fromRGBO(115, 115, 115, 1);
  @override
  Widget build(BuildContext context) {
    List<dynamic> list = [];
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
          FutureBuilder<Map<String, dynamic>>(
            future:
                CompanyAndProductAPI().getProductsByMainCategory("All", "1"),
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              else {
                list = snapshot.data['categories'];
                if (list.length == 0)
                  return Center(
                    child: Text("No data"),
                  );
                return Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  color: Colors.white,
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            _buildRow(
                                CompanyAndProductAPI().baseUrl +
                                    list[index]["icons"],
                                list[index]["category_name"],
                                context,
                                list[index]["id"]),
                            _buildDivider(context)
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

  Widget _buildDivider(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        height: 3,
      ),
    );
  }

  Widget _buildRow(image, String title, context, id) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 20.0);
    return TextButton(
      onPressed: () {
        // if (type["type"] == "sub")
        Navigator.pushNamed(context, "/productsPage",
            arguments: {"id": id.toString()});
        // else
        //   Navigator.pushNamed(context, "/allCategories",
        //       arguments: {"type": "sub"});
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
            title.length < 25 ? title : title.substring(0, 28) + '..',
            style: tStyle,
          ),
        ]),
      ),
    );
  }
}
