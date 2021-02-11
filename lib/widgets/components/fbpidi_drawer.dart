import 'package:flutter/material.dart';

class FbpidiDrawer extends StatefulWidget {
  @override
  _FbpidiDrawerState createState() => _FbpidiDrawerState();
}

class _FbpidiDrawerState extends State<FbpidiDrawer> {
  static final List<String> _listViewData = [
    "Home",
    "About Us",
    "Manufacturers",
    "Suppliers",
    "Products",
    "Collaborations",
  ];
  int _currentSelected = 0;
  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text(
            'FBPIDI',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          height: 400,
          child: ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: _listViewData.length,
            itemBuilder: (context, index) {
              return Container(
                color: _currentSelected == index
                    ? Theme.of(context).highlightColor
                    : Colors.white,
                child: ListTile(
                  title: Text(
                    _listViewData[index],
                    style: TextStyle(color: Colors.grey[700], fontSize: 18),
                  ),
                  onTap: () {
                    setState(() {
                      _currentSelected = index;
                    });
                  },
                ),
              );
            },
          ),
        ),
        //     Container(
        //       color: _currentSelected == index ? Colors.deepPurple : Colors.white,
        //       child: ListTile(
        //         selectedTileColor: Theme.of(context).highlightColor,
        //         title: Text(
        //           'Home',
        //           style: TextStyle(fontSize: 18),
        //         ),
        //         onTap: () {
        //           changeColor(0);
        //         },
        //       ),
        //     ),
        //     Container(
        //       color: _currentSelected == index ? Colors.deepPurple : Colors.white,
        //       child: ListTile(
        //         selectedTileColor: Theme.of(context).highlightColor,
        //         title: Text(
        //           'About Us',
        //           style: TextStyle(fontSize: 18),
        //         ),
        //         onTap: () {
        //           // changeColor(1);
        //         },
        //       ),
        //     ),
        //     Container(
        //       color: _currentSelected == index ? Colors.deepPurple : Colors.white,
        //       child: ListTile(
        //         selectedTileColor: Theme.of(context).highlightColor,
        //         title: Text(
        //           'Manufacturers',
        //           style: TextStyle(fontSize: 18),
        //         ),
        //         onTap: () {
        //           changeColor(2);
        //         },
        //       ),
        //     ),
        //     Container(
        //       color: _currentSelected == index ? Colors.deepPurple : Colors.white,
        //       child: ListTile(
        //         selectedTileColor: Theme.of(context).highlightColor,
        //         title: Text(
        //           'Suppliers',
        //           style: TextStyle(fontSize: 18),
        //         ),
        //         onTap: () {
        //           changeColor(3);
        //         },
        //       ),
        //     ),
        //     Container(
        //       color: _currentSelected == index ? Colors.deepPurple : Colors.white,
        //       child: ListTile(
        //         selectedTileColor: Theme.of(context).highlightColor,
        //         title: Text(
        //           'Products',
        //           style: TextStyle(fontSize: 18),
        //         ),
        //         onTap: () {
        //           changeColor(4);
        //         },
        //       ),
        //     ),
        //     Container(
        //       color: _currentSelected == index ? Colors.deepPurple : Colors.white,
        //       child: ListTile(
        //         selectedTileColor: Theme.of(context).highlightColor,
        //         title: Text(
        //           'Collaborations',
        //           style: TextStyle(fontSize: 18),
        //         ),
        //         onTap: () {
        //           changeColor(5);
        //         },
        //       ),
        //     ),
      ],
    );
  }
}
