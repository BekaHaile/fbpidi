import 'dart:async';

import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/widgets/screens/credential/login.dart';
import 'package:fbpidi/widgets/screens/home_page.dart';
import 'package:fbpidi/widgets/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    writeStatus();
  }

  @override
  void dispose() {
    indexcontroller.close();
    super.dispose();
  }

  writeStatus() async {
    try {
      await storage.write(key: 'loginStatus', value: 'false');
    } catch (e) {
      print("Exception: " + e.toString());
    }
  }

  PageController pageController = PageController(initialPage: 0);
  StreamController<int> indexcontroller = StreamController<int>.broadcast();
  int index = 0;
  String isLoggedIn = 'false';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          indexcontroller.add(index);
        },
        controller: pageController,
        children: <Widget>[
          HomePage(),
          WebView(
            initialUrl: CollaborationsApi().baseUrl + "/about/",
          ),
          Center(
            child: Text('News'),
          ),
          FutureBuilder<String>(
              future: storage.read(key: 'loginStatus'),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                else {
                  String status = snapshot.data;
                  if (status == "false")
                    return LoginPage({"": ""});
                  else
                    return Profile();
                }
              }),
        ],
      ),
      bottomNavigationBar: StreamBuilder<Object>(
        initialData: 0,
        stream: indexcontroller.stream,
        builder: (context, snapshot) {
          int cIndex = snapshot.data;
          return FancyBottomNavigation(
            currentIndex: cIndex,
            items: <FancyBottomNavigationItem>[
              FancyBottomNavigationItem(
                  icon: Icon(
                    Icons.home,
                    color: Color.fromRGBO(115, 115, 115, 1),
                  ),
                  title: Text('Home')),
              FancyBottomNavigationItem(
                  icon: Icon(
                    Icons.info,
                    color: Color.fromRGBO(115, 115, 115, 1),
                  ),
                  title: Text('About')),
              FancyBottomNavigationItem(
                  icon: Icon(
                    FontAwesomeIcons.globe,
                    color: Color.fromRGBO(115, 115, 115, 1),
                  ),
                  title: Text('News')),
              FancyBottomNavigationItem(
                  icon: Icon(
                    FontAwesomeIcons.userCircle,
                    color: Color.fromRGBO(115, 115, 115, 1),
                  ),
                  title: Text('Account')),
            ],
            onItemSelected: (int value) {
              indexcontroller.add(value);
              pageController.jumpToPage(value);
            },
          );
        },
      ),
    );
  }
}

class FancyBottomNavigation extends StatefulWidget {
  final int currentIndex;
  final double iconSize;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;
  final List<FancyBottomNavigationItem> items;
  final ValueChanged<int> onItemSelected;

  FancyBottomNavigation(
      {Key key,
      this.currentIndex = 0,
      this.iconSize = 24,
      this.activeColor,
      this.inactiveColor,
      this.backgroundColor,
      @required this.items,
      @required this.onItemSelected}) {
    assert(items != null);
    assert(onItemSelected != null);
  }

  @override
  _FancyBottomNavigationState createState() {
    return _FancyBottomNavigationState(
        items: items,
        backgroundColor: backgroundColor,
        currentIndex: currentIndex,
        iconSize: iconSize,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        onItemSelected: onItemSelected);
  }
}

class _FancyBottomNavigationState extends State<FancyBottomNavigation> {
  final int currentIndex;
  final double iconSize;
  Color activeColor;
  Color inactiveColor;
  Color backgroundColor;
  List<FancyBottomNavigationItem> items;
  int _selectedIndex;
  ValueChanged<int> onItemSelected;

  _FancyBottomNavigationState(
      {@required this.items,
      this.currentIndex,
      this.activeColor,
      this.inactiveColor = Colors.black,
      this.backgroundColor,
      this.iconSize,
      @required this.onItemSelected}) {
    _selectedIndex = currentIndex;
  }

  Widget _buildItem(FancyBottomNavigationItem item, bool isSelected) {
    return AnimatedContainer(
      width: isSelected ? 124 : 50,
      height: double.maxFinite,
      duration: Duration(milliseconds: 250),
      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              color: activeColor,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconTheme(
                  data: IconThemeData(
                      size: iconSize,
                      color: isSelected ? backgroundColor : inactiveColor),
                  child: item.icon,
                ),
              ),
              isSelected
                  ? DefaultTextStyle.merge(
                      style: TextStyle(color: backgroundColor),
                      child: item.title,
                    )
                  : SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    activeColor =
        (activeColor == null) ? Theme.of(context).primaryColor : activeColor;

    backgroundColor = (backgroundColor == null)
        ? Theme.of(context).bottomAppBarColor
        : backgroundColor;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 56,
      padding: EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          var index = items.indexOf(item);
          return GestureDetector(
            onTap: () {
              onItemSelected(index);

              setState(() {
                _selectedIndex = index;
              });
            },
            child: _buildItem(item, _selectedIndex == index),
          );
        }).toList(),
      ),
    );
  }
}

class FancyBottomNavigationItem {
  final Icon icon;
  final Text title;

  FancyBottomNavigationItem({
    @required this.icon,
    @required this.title,
  }) {
    assert(icon != null);
    assert(title != null);
  }
}
