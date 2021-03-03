import 'package:fbpidi/widgets/components/fbpidi_search.dart';
import 'package:flutter/material.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
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
                          padding: const EdgeInsets.only(
                              bottom: 30.0, left: 5, right: 5),
                          child: Stack(
                            children: [
                              Container(
                                height: 160,
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.network(
                                    "https://www.autocar.co.uk/sites/autocar.co.uk/files/styles/body-image/public/1-corvette-stingray-c8-2019-fd-hr-hero-front_0.jpg?itok=SEYe_vLy",
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: RaisedButton(
                                      onPressed: () {},
                                      color: Theme.of(context)
                                          .buttonColor
                                          .withOpacity(0.7),
                                      child: Text(
                                        "Beverage",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 5, bottom: 10),
                          child: Text(
                            'News',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 5, bottom: 20),
                          child: Text(
                            'Ethiopian Food, Beverage and Pharmaseutical Institute has officially launched the IIMP project. …',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 19,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Divider(
                          height: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 5, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "By: ",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              CircleAvatar(
                                radius: 20,
                                child: ClipOval(
                                    child: Image.network(
                                  "https://images.unsplash.com/photo-1455390582262-044cdead277a?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NXx8d3JpdGVyfGVufDB8fDB8&ixlib=rb-1.2.1&w=1000&q=80",
                                  fit: BoxFit.cover,
                                  width: 90.0,
                                  height: 90.0,
                                )),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Container(
                                height: 34,
                                width: 34,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(247, 247, 251, 1),
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.black,
                                  size: 19,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Container(
                                height: 34,
                                width: 34,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(247, 247, 251, 1),
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                  size: 19,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: RaisedButton(
                                  onPressed: () {},
                                  color: Theme.of(context).buttonColor,
                                  child: Text(
                                    "News Detail",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.57,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 20.0,
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
                                      size: 19,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      'Feb 23, 2021, 8:31pm',
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          color: Colors.black87),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
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
