import 'package:flutter/material.dart';

class AllCategories extends StatelessWidget {
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
        title: Text("Categories"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "All Categories",
              style: TextStyle(fontSize: 17),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.84,
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
        Navigator.pushNamed(context, "/allCategories");
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
