import 'package:carousel_slider/carousel_slider.dart';
import 'package:fbpidi/models/product.dart';
import 'package:fbpidi/models/company.dart';
import 'package:fbpidi/models/research.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/services/company_and_product_api.dart';
import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
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

  List<Widget> companyCardList = [], researchCardList;

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
          _buildHorizontalList(
              "Manufacturer", Color.fromRGBO(203, 217, 230, 1)),
          // _buildHorizontalList(
          //     "Investment Opportunities", Color.fromRGBO(230, 221, 216, 1)),
          _buildHorizontalList("Researches", Color.fromRGBO(217, 226, 241, 1)),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Products",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/products",
                            arguments: {'type': 'All'});
                      },
                      child: Text("More"),
                    ),
                  ],
                ),
              ),
              _buildProductGrid(context),
            ],
          ),
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
            onTap: () async {
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

  Widget _buildCarousel(context, List<Widget> cardList) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: true,
        aspectRatio: 2.0,
        enableInfiniteScroll: true,
        onPageChanged: (index, reason) {
          setState(() {});
        },
      ),
      items: cardList.map((card) {
        return Builder(builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width * 0.9,
            child: card,
          );
        });
      }).toList(),
    );
  }

  Widget buildCompanyCard(Company company) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/companyDetail',
            arguments: {"id": company.id});
      },
      child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            child: Column(
              children: [
                Container(
                  width: 105,
                  height: 110,
                  child: FittedBox(
                    child: Image.network(
                        CollaborationsApi().baseUrl + company.logo),
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: 80,
                    child: Text(
                      company.name.length > 12
                          ? company.name.substring(0, 12) + '..'
                          : company.name,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget buildResearchCard(Research research) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/researchDetail',
            arguments: {"id": research.id});
      },
      child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            child: Column(
              children: [
                Container(
                  width: 105,
                  height: 110,
                  child: FittedBox(
                    child: Image.network(
                        CollaborationsApi().baseUrl + research.company),
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: 80,
                    child: Text(
                      research.title.length > 12
                          ? research.title.substring(0, 12) + '..'
                          : research.title,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          )),
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
                      if (title == "Manufacturer")
                        Navigator.pushReplacementNamed(context, '/companies',
                            arguments: {'type': 'All'});
                      else
                        Navigator.pushReplacementNamed(context, "/researches");
                    },
                    child: Text("More"),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                // Icon(FontAwesomeIcons.chevronCircleLeft),
                Expanded(
                  child: FutureBuilder<Map<String, dynamic>>(
                    future: title == "Manufacturer"
                        ? CompanyAndProductAPI().getCompanies("All", "1")
                        : CollaborationsApi().getResearches("1"),
                    builder: (BuildContext context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      else {
                        List<Company> companies = [];
                        List<Research> researches = [];
                        if (title == "Manufacturer")
                          companies = snapshot.data["companies"];
                        else
                          researches = snapshot.data["researches"];
                        if (title == "Manufacturer" && companies.length == 0)
                          return Center(
                              child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text("No data"),
                          ));
                        else if (title != "Manufacturer" &&
                            researches.length == 0)
                          return Center(
                              child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text("No data"),
                          ));
                        else {
                          if (title == "Manufacturer") {
                            companyCardList.clear();
                            companies.forEach((company) {
                              companyCardList.add(buildCompanyCard(company));
                            });
                            return _buildCarousel(context, companyCardList);
                          } else {
                            researchCardList.clear();
                            researches.forEach((research) {
                              researchCardList.add(buildResearchCard(research));
                            });
                            return _buildCarousel(context, researchCardList);
                          }
                        }
                      }
                    },
                  ),
                ),
                // Icon(FontAwesomeIcons.chevronCircleRight),
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

  Widget _buildProductGrid(context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: CompanyAndProductAPI().getProductsByMainCategory("All", "1"),
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            ),
          );
        else {
          List<Product> products = snapshot.data["products"];
          if (products.length == 0)
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("No data"),
            ));
          else
            return Container(
              padding: EdgeInsets.symmetric(vertical: 1.0),
              child: GridView.builder(
                shrinkWrap: true,
                primary: false,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 0.7),
                itemBuilder: (_, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/productDetail',
                          arguments: {"id": products[index].id});
                    },
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Image.network(
                              CompanyAndProductAPI().baseUrl +
                                  products[index].image,
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 18.0, right: 5),
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
                                            MediaQuery.of(context).size.width *
                                                0.08),
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
                    ),
                  );
                },
                itemCount: products.length,
              ),
            );
        }
      },
    );
  }
}
