import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
import 'package:fbpidi/widgets/screens/products.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> categories = [
    'All Categories',
    'Request for Quotation',
    'New User Guide',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: FbpidiDrawer("Home")),
      appBar: AppBar(
        title: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 47,
          child: TextField(
            autocorrect: true,
            decoration: InputDecoration(
              hintText: 'Search Products/Company',
              prefixIcon: Icon(Icons.search),
              hintStyle:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              FontAwesomeIcons.comments,
              size: 27,
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: ListView(
        children: [
          _buildCategoriesGrid(),
          _buildHorizontalList("Companies", Color.fromRGBO(203, 217, 230, 1)),
          _buildHorizontalList(
              "Investment Opportunities", Color.fromRGBO(230, 221, 216, 1)),
          _buildHorizontalList("Researches", Color.fromRGBO(217, 226, 241, 1)),
          ProductsPage(),
          _buildBottomCards(),
        ],
      )),
    );
  }

  Widget _buildCategoriesGrid() {
    return Container(
      height: 120.0,
      child: GridView.builder(
        padding: EdgeInsets.all(10.0),
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 25.0,
        ),
        itemBuilder: (_, int index) {
          return GestureDetector(
            onTap: () {
              if (index == 0)
                Navigator.pushNamed(context, "/allCategories",
                    arguments: {"type": "all"});
            },
            child: Column(
              children: <Widget>[
                CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    maxRadius: 30.0,
                    child: buildIcon(index)),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  categories[index % categories.length],
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        },
        itemCount: categories.length,
      ),
    );
  }

  Widget buildIcon(index) {
    if (index == 0)
      return Icon(
        Icons.list,
        color: Colors.white,
        size: 33,
      );
    else if (index == 1)
      return Icon(
        FontAwesomeIcons.registered,
        color: Colors.white,
        size: 33,
      );
    else
      return Icon(
        FontAwesomeIcons.flag,
        color: Colors.white,
        size: 33,
      );
  }

  Widget _buildHorizontalList(title, color) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      print("hello");
                    },
                    child: Text("More"),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Icon(FontAwesomeIcons.chevronCircleLeft),
                Expanded(
                  child: Container(
                    height: 135,
                    child: GridView.builder(
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 5.0,
                          childAspectRatio: 1.1),
                      itemBuilder: (_, int index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  width: 105,
                                  height: 110,
                                  child: FittedBox(
                                    child: Image.network(
                                      title == "Investment Opportunities"
                                          ? "https://researchleap.com/wp-content/uploads/2019/12/2019-12-13-17.13.50.jpg"
                                          : "http://www.akabi.eu/Content/images/black-and-white-city-man-people.jpg",
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                )),
                          ],
                        );
                      },
                      itemCount: 9,
                    ),
                  ),
                ),
                Icon(FontAwesomeIcons.chevronCircleRight),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomCards() {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(44, 52, 155, 1),
            Color.fromRGBO(76, 45, 141, 1),
            Color.fromRGBO(97, 39, 131, 1),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            createCard(Icons.copy_outlined, "Total Viewers", "1"),
            createCard(FontAwesomeIcons.rocket, "Total Products", "0"),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              createCard(Icons.people, "Total Companies", "0"),
              createCard(FontAwesomeIcons.smile, "Happy Customers", "0"),
            ],
          )
        ],
      ),
    );
  }

  Widget createCard(icon, name, count) {
    return Padding(
      padding: EdgeInsets.only(left: 5, top: 40),
      child: Container(
        color: Color.fromRGBO(0, 0, 0, .2),
        width: MediaQuery.of(context).size.width * 0.45,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 34,
              width: 34,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.15),
                  shape: BoxShape.circle),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(name,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(count,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
