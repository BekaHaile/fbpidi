import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FbpidiDrawer extends StatefulWidget {
  final String selected;
  final String mainMenu;
  FbpidiDrawer(this.selected, {this.mainMenu});
  @override
  _FbpidiDrawerState createState() => _FbpidiDrawerState();
}

class _FbpidiDrawerState extends State<FbpidiDrawer> {
  final Color active = Color.fromRGBO(115, 115, 115, 1);
  // int _currentSelected = 0;
  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return _buildDrawer();
  }

  _buildDrawer() {
    bool expandedCompany = false;
    bool expandedProduct = false;
    if (widget.selected == "Beverage" ||
        widget.selected == "Food" ||
        widget.selected == "Pharmaceuticals") {
      if (widget.mainMenu == "Manufacturers")
        expandedCompany = true;
      else
        expandedProduct = true;
    }
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, boxShadow: [BoxShadow(color: Colors.black45)]),
        width: 250,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      boxShadow: [BoxShadow(color: Colors.black45)]),
                  child: Column(
                    children: [
                      Container(
                        height: 90,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                colors: [Colors.pink, Colors.deepPurple])),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage("assets/user_icon.png"),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      FutureBuilder<String>(
                          future: storage.read(key: 'loginStatus'),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData)
                              return CircularProgressIndicator();
                            else {
                              if (snapshot.data == 'false')
                                return Text(
                                  'username',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                );
                              else
                                return FutureBuilder<String>(
                                    future: storage.read(key: 'name'),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData)
                                        return CircularProgressIndicator();
                                      else
                                        return Text(
                                          snapshot.data,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0),
                                        );
                                    });
                            }
                          }),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),
                _buildRow(Icons.home, "Home", 15),
                ExpansionTile(
                  initiallyExpanded: expandedCompany,
                  title:
                      _buildRow(FontAwesomeIcons.building, "Manufacturers", 0),
                  children: <Widget>[
                    _buildRow(FontAwesomeIcons.glassCheers, "Beverage", 20,
                        mainMenu: "Manufacturers"),
                    _buildRow(FontAwesomeIcons.utensils, "Food", 20,
                        mainMenu: "Manufacturers"),
                    _buildRow(
                        FontAwesomeIcons.clinicMedical, "Pharmaceuticals", 20,
                        mainMenu: "Manufacturers")
                  ],
                ),
                ExpansionTile(
                  initiallyExpanded: expandedProduct,
                  title: _buildRow(FontAwesomeIcons.productHunt, "Products", 0),
                  children: <Widget>[
                    _buildRow(FontAwesomeIcons.glassCheers, "Beverage", 20,
                        mainMenu: "Products"),
                    _buildRow(FontAwesomeIcons.utensils, "Food", 20,
                        mainMenu: "Products"),
                    _buildRow(
                        FontAwesomeIcons.clinicMedical, "Pharmaceuticals", 20,
                        mainMenu: "Products")
                  ],
                ),
                // _buildRow(
                //     FontAwesomeIcons.utensils, "Investment Opportunities", 15),
                _buildRow(FontAwesomeIcons.projectDiagram, "Projects", 15),
                _buildRow(FontAwesomeIcons.researchgate, "Researches", 15),
                _buildRow(FontAwesomeIcons.vaadin, "Vacancies", 15),
                _buildRow(FontAwesomeIcons.chartLine, "Tenders", 15),
                _buildDivider(),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Collaborations",
                    style: TextStyle(fontSize: 19, color: Colors.black87),
                    textAlign: TextAlign.left,
                  ),
                ),
                _buildRow(FontAwesomeIcons.newspaper, "News", 15),
                _buildRow(FontAwesomeIcons.calendarDay, "Events", 15),

                _buildRow(FontAwesomeIcons.bullhorn, "Announcements", 15),
                _buildRow(FontAwesomeIcons.blog, "Blogs", 15),
                _buildRow(FontAwesomeIcons.forumbee, "Forums", 15),
                _buildRow(FontAwesomeIcons.poll, "Polls", 15),
                _buildRow(FontAwesomeIcons.solidQuestionCircle, "Faqs", 15),
                _buildDivider(),
                _buildRow(FontAwesomeIcons.infoCircle, "Help and Support", 15),
                FutureBuilder<String>(
                    future: storage.read(key: 'loginStatus'),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return CircularProgressIndicator();
                      else {
                        if (snapshot.data == "false")
                          return _buildRow(
                              FontAwesomeIcons.signInAlt, "Login", 15);
                        else
                          return _buildRow(
                              FontAwesomeIcons.powerOff, "Logout", 15);
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: active,
    );
  }

  Widget _buildRow(IconData icon, String title, double padding,
      {String mainMenu}) {
    bool selected = false;
    if (title == "Beverage" || title == "Food" || title == "Pharmaceuticals") {
      if (widget.selected == title && widget.mainMenu == mainMenu)
        selected = true;
    } else {
      if (widget.selected == title) selected = true;
    }

    final TextStyle tStyle = TextStyle(
        color: selected ? Colors.white : Colors.black87, fontSize: 17.0);
    return InkWell(
      onTap: () async {
        Navigator.pop(context);
        if (title == "Products")
          Navigator.pushReplacementNamed(context, "/products",
              arguments: {'type': 'All'});
        else if (title == "Home")
          Navigator.pushReplacementNamed(
            context,
            "/homePage",
          );
        else if (title == "Announcements")
          Navigator.pushReplacementNamed(
            context,
            "/announcements",
          );
        else if (title == "Blogs")
          Navigator.pushReplacementNamed(
            context,
            "/blogs",
          );
        else if (title == "Forums")
          Navigator.pushReplacementNamed(
            context,
            "/forums",
          );
        else if (title == "News")
          Navigator.pushReplacementNamed(
            context,
            "/news",
          );
        else if (title == "Polls")
          Navigator.pushReplacementNamed(
            context,
            "/polls",
          );
        else if (title == "Tenders")
          Navigator.pushReplacementNamed(
            context,
            "/tenders",
          );
        else if (title == "Vacancies")
          Navigator.pushReplacementNamed(
            context,
            "/vacancies",
          );
        else if (title == "Events")
          Navigator.pushReplacementNamed(
            context,
            "/events",
          );
        else if (title == "Faqs")
          Navigator.pushReplacementNamed(
            context,
            "/faqs",
          );
        else if (title == "Projects")
          Navigator.pushReplacementNamed(
            context,
            "/projects",
          );
        else if (title == "Researches")
          Navigator.pushReplacementNamed(
            context,
            "/researches",
          );
        else if (title == "Logout") {
          final storage = new FlutterSecureStorage();
          await storage.delete(key: 'loginStatus').then((value) async {
            await storage.write(key: 'name', value: '');
            await storage.write(key: 'loginStatus', value: 'false');
            Navigator.pushReplacementNamed(context, '/homePage');
          });
        } else if (title == "Login") {
          Navigator.pushNamed(context, '/login',
              arguments: {"route": "/homePage"});
        } else if (title == "Manufacturers")
          Navigator.pushReplacementNamed(context, "/companies",
              arguments: {'type': 'All'});
        else if (title == "Beverage") {
          if (mainMenu == "Manufacturers")
            Navigator.pushReplacementNamed(context, "/companies",
                arguments: {'type': 'Beverage'});
          else
            Navigator.pushReplacementNamed(context, "/products",
                arguments: {'type': 'Beverage'});
        } else if (title == "Food") {
          if (mainMenu == "Manufacturers")
            Navigator.pushReplacementNamed(context, "/companies",
                arguments: {'type': 'Food'});
          else
            Navigator.pushReplacementNamed(context, "/products",
                arguments: {'type': 'Food'});
        } else if (title == "Pharmaceuticals") {
          if (mainMenu == "Manufacturers")
            Navigator.pushReplacementNamed(context, "/companies",
                arguments: {'type': 'Pharmaceuticals'});
          else
            Navigator.pushReplacementNamed(context, "/products",
                arguments: {'type': 'Pharmaceuticals'});
        }
      },
      child: Padding(
        padding: EdgeInsets.only(left: padding),
        child: Container(
          color: selected ? Theme.of(context).primaryColor : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          child: Row(children: [
            Icon(
              icon,
              color: selected ? Colors.white : active,
            ),
            SizedBox(width: 15.0),
            Text(
              title,
              style: tStyle,
            ),
          ]),
        ),
      ),
    );
  }
}
