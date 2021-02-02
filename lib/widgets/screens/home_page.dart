import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> isSelected = List.generate(3, (index) => false);
  String dropdownValue = "One";
  final TextEditingController _controller = new TextEditingController();
  var items = [
    'Working a lot harder',
    'Being a lot smarter',
    'Being a self-starter',
    'Placed in charge of trading charter'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Header'),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(slivers: <Widget>[
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return iconAppBar(context);
              },
              childCount: 1,
            ),
          ),
          SliverAppBar(
            expandedHeight: 70.0,
            pinned: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Image.asset(
                    "assets/frontpages/images/brand/logo2.png",
                    height: 60.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.04,
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.plusCircle,
                    color: Theme.of(context).highlightColor,
                    size: 20.0,
                  ),
                ),
              ],
            ),
          ),
          SliverFixedExtentList(
            itemExtent: MediaQuery.of(context).size.height * 0.8,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.7,
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
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          'Welcome To The Biggest Business Directory',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 45,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(
                          'It is a long established fact that a reader will be distracted by the readable.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ToggleButtons(
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Products",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21.0,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Company",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Tender",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                        onPressed: (int index) {
                          setState(() {
                            for (int buttonIndex = 0;
                                buttonIndex < isSelected.length;
                                buttonIndex++) {
                              if (buttonIndex == index) {
                                isSelected[buttonIndex] = true;
                              } else {
                                isSelected[buttonIndex] = false;
                              }
                            }
                          });
                        },
                        isSelected: isSelected,
                        renderBorder: false,
                        selectedColor: Color.fromRGBO(0, 0, 0, .2),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextField(
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(5.0),
                                ),
                              ),
                              filled: true,
                              hintStyle: new TextStyle(
                                  color: Colors.grey[500], fontSize: 18.0),
                              hintText: "Enter Your Keywords",
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Row(
                          children: <Widget>[
                            new Expanded(
                                child: new TextField(
                              controller: _controller,
                              decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(5.0),
                                  ),
                                ),
                                filled: true,
                                hintStyle: new TextStyle(
                                    color: Colors.black, fontSize: 18.0),
                                hintText: "Select Category",
                                fillColor: Colors.white,
                              ),
                            )),

                            //drop down to be edited
                            Container(
                              color: Colors.white,
                              height: 60,
                              child: PopupMenuButton<String>(
                                color: Colors.white,
                                icon: const Icon(Icons.arrow_drop_down),
                                onSelected: (String value) {
                                  _controller.text = value;
                                },
                                itemBuilder: (BuildContext context) {
                                  return items.map<PopupMenuItem<String>>(
                                      (String value) {
                                    return new PopupMenuItem(
                                        child: new Text(value), value: value);
                                  }).toList();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        color: Theme.of(context).highlightColor,
                        child: Text(
                          "Search Now",
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ]),
      ),
    );
  }

  Widget iconAppBar(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05),
                    child: FaIcon(
                      FontAwesomeIcons.facebookF,
                      color: Theme.of(context).highlightColor,
                      size: 23.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05),
                    child: FaIcon(
                      FontAwesomeIcons.twitter,
                      color: Theme.of(context).highlightColor,
                      size: 23.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05),
                    child: FaIcon(
                      FontAwesomeIcons.linkedinIn,
                      color: Theme.of(context).highlightColor,
                      size: 23.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05),
                    child: FaIcon(
                      FontAwesomeIcons.googlePlusG,
                      color: Theme.of(context).highlightColor,
                      size: 23.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.userAlt,
                    color: Theme.of(context).highlightColor,
                    size: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.signInAlt,
                      color: Theme.of(context).highlightColor,
                      size: 20.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.04,
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.globe,
                      color: Theme.of(context).highlightColor,
                      size: 20.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: Colors.grey,
        ),
      ],
    );
  }
}
