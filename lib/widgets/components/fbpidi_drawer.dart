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
        widget.selected == "Pharmaceutical") {
      if (widget.mainMenu == "Manufacturers")
        expandedCompany = true;
      else
        expandedProduct = true;
    }
    final String image =
        "https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png";
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
                          backgroundImage: NetworkImage(image),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      FutureBuilder<String>(
                          future: storage.read(key: 'name'),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData)
                              return CircularProgressIndicator();
                            else {
                              return Text(
                                snapshot.data,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              );
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
                        FontAwesomeIcons.clinicMedical, "Pharmaceutical", 20,
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
                        FontAwesomeIcons.clinicMedical, "Pharmaceutical", 20,
                        mainMenu: "Products")
                  ],
                ),
                // _buildRow(
                //     FontAwesomeIcons.utensils, "Investment Opportunities", 15),
                // _buildRow(FontAwesomeIcons.projectDiagram, "Projects", 15),
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
                _buildRow(FontAwesomeIcons.powerOff, "Logout", 15)
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
    if (title == "Beverage" || title == "Food" || title == "Pharmaceutical") {
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
          Navigator.pushNamed(context, "/products", arguments: {'type': 'All'});
        else if (title == "Home")
          Navigator.pushNamed(
            context,
            "/homePage",
          );
        else if (title == "Announcements")
          Navigator.pushNamed(
            context,
            "/announcements",
          );
        else if (title == "Blogs")
          Navigator.pushNamed(
            context,
            "/blogs",
          );
        else if (title == "Forums")
          Navigator.pushNamed(
            context,
            "/forums",
          );
        else if (title == "News")
          Navigator.pushNamed(
            context,
            "/news",
          );
        else if (title == "Polls")
          Navigator.pushNamed(
            context,
            "/polls",
          );
        else if (title == "Tenders")
          Navigator.pushNamed(
            context,
            "/tenders",
          );
        else if (title == "Vacancies")
          Navigator.pushNamed(
            context,
            "/vacancies",
          );
        else if (title == "Events")
          Navigator.pushNamed(
            context,
            "/events",
          );
        else if (title == "Faqs")
          Navigator.pushNamed(
            context,
            "/faqs",
          );
        else if (title == "Projects")
          Navigator.pushNamed(
            context,
            "/projects",
          );
        else if (title == "Researches")
          Navigator.pushNamed(
            context,
            "/researches",
          );
        else if (title == "Logout") {
          final storage = new FlutterSecureStorage();
          await storage.delete(key: 'loginStatus').then((value) async {
            await storage.write(key: 'loginStatus', value: 'false');
            Navigator.pushNamed(context, '/login');
          });
        } else if (title == "Manufacturers")
          Navigator.pushNamed(context, "/companies",
              arguments: {'type': 'All'});
        else if (title == "Beverage") {
          if (mainMenu == "Manufacturers")
            Navigator.pushNamed(context, "/companies",
                arguments: {'type': 'Beverage'});
          else
            Navigator.pushNamed(context, "/products",
                arguments: {'type': 'Beverage'});
        } else if (title == "Food") {
          if (mainMenu == "Manufacturers")
            Navigator.pushNamed(context, "/companies",
                arguments: {'type': 'Food'});
          else
            Navigator.pushNamed(context, "/products",
                arguments: {'type': 'Food'});
        } else if (title == "Pharmaceutical") {
          if (mainMenu == "Manufacturers")
            Navigator.pushNamed(context, "/companies",
                arguments: {'type': 'Pharmaceutical'});
          else
            Navigator.pushNamed(context, "/products",
                arguments: {'type': 'Pharmaceutical'});
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
