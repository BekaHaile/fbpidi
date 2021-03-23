import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
import 'package:fbpidi/widgets/components/fbpidi_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Blog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: FbpidiDrawer("Blogs")),
      appBar: AppBar(
        title: Text("Blogs"),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            children: [
              FbpidiSearch(),
              _buildBlogList(context),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildBlogList(context) {
    return IgnorePointer(
      child: Container(
        alignment: Alignment.center,
        height: 1800,
        width: MediaQuery.of(context).size.width * 0.95,
        padding: EdgeInsets.symmetric(vertical: 1.0),
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          scrollDirection: Axis.vertical,
          itemBuilder: (_, int index) {
            return Column(
              children: [
                Card(
                  color: Colors.white,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0, top: 20),
                          child: Text(
                            'Blog 1',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 30.0, left: 5, right: 5),
                          child: Container(
                            height: 160,
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image.network(
                                "https://www.autocar.co.uk/sites/autocar.co.uk/files/styles/body-image/public/1-corvette-stingray-c8-2019-fd-hr-hero-front_0.jpg?itok=SEYe_vLy",
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.57,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, right: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: Colors.black54,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      'Feb 23, 2021, 8:31pm',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black54),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 7.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, right: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.comment,
                                      color: Colors.black54,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      '0',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black54),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 5, bottom: 10),
                                child: Text(
                                  'Blog 1 detail',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 19,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, bottom: 15.0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    primary: Theme.of(context).buttonColor,
                                  ),
                                  child: Text(
                                    "Read More",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          itemCount: 10,
        ),
      ),
    );
  }
}
