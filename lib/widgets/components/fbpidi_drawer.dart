import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FbpidiDrawer extends StatefulWidget {
  final String selected;
  FbpidiDrawer(this.selected);
  @override
  _FbpidiDrawerState createState() => _FbpidiDrawerState();
}

class _FbpidiDrawerState extends State<FbpidiDrawer> {
  final Color active = Color.fromRGBO(115, 115, 115, 1);
  // int _currentSelected = 0;
  @override
  Widget build(BuildContext context) {
    return _buildDrawer();
  }

  _buildDrawer() {
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
                      Text(
                        "Mukesh Mitiku",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),
                _buildRow(Icons.home, "Home"),
                _buildRow(FontAwesomeIcons.building, "Companies"),
                _buildRow(FontAwesomeIcons.productHunt, "Products"),
                _buildRow(
                    FontAwesomeIcons.utensils, "Investment Opportunities"),
                _buildRow(FontAwesomeIcons.projectDiagram, "Projects"),
                _buildRow(FontAwesomeIcons.researchgate, "Researchs"),
                _buildRow(FontAwesomeIcons.vaadin, "Vacancies"),
                _buildRow(FontAwesomeIcons.chartLine, "Tenders"),
                _buildDivider(),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Collaborations",
                    style: TextStyle(fontSize: 19, color: Colors.black87),
                    textAlign: TextAlign.left,
                  ),
                ),
                _buildRow(FontAwesomeIcons.newspaper, "News"),
                _buildRow(FontAwesomeIcons.calendarDay, "Events"),
                _buildRow(FontAwesomeIcons.blog, "Blogs"),
                _buildRow(FontAwesomeIcons.forumbee, "Forums"),
                _buildRow(FontAwesomeIcons.poll, "Polls"),
                _buildDivider(),
                _buildRow(FontAwesomeIcons.infoCircle, "Help and Support"),
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

  Widget _buildRow(IconData icon, String title) {
    bool selected = false;
    if (widget.selected == title) selected = true;
    final TextStyle tStyle = TextStyle(
        color: selected ? Colors.white : Colors.black87, fontSize: 17.0);
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        if (title == "Products")
          Navigator.pushNamed(context, "/products",
              arguments: {"isSubcategory": false});
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
      },
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
    );
  }
}
