import 'package:fbpidi/models/news.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/services/remove_tag.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewsDetail extends StatelessWidget {
  final data;
  NewsDetail(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<News>(
                future: CollaborationsApi().getNewsDetail(data['id']),
                builder: (BuildContext context, snapshot) {
                  // _fetchLanguage(context);
                  if (!snapshot.hasData)
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  else {
                    News news = snapshot.data;
                    return Center(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.95,
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Column(
                          children: [
                            Card(
                              color: Colors.white,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 15, bottom: 10),
                                      child: Text(
                                        news.title,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        'By: ${news.company.name}',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7.0,
                                    ),
                                    _productIcons(
                                        context,
                                        FontAwesomeIcons.calendar,
                                        "${news.createdDate.substring(0, 10)}, ${news.createdDate.substring(12, 16)} p.m."),
                                    SizedBox(
                                      height: 7.0,
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 15.0,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                      child: Container(
                                        height: 280,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.95,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Image.network(
                                            CollaborationsApi().baseUrl +
                                                news.company.logo,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "News Description",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Container(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      height: 3.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 10.0),
                                      child: Text(
                                        RemoveTag().removeAllHtmlTags(
                                            news.description),
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(top: 15, bottom: 15),
                            //   child: Container(
                            //     width: MediaQuery.of(context).size.width * 0.9,
                            //     child: Text(
                            //       "Other News from ${news.company.name}",
                            //       style: TextStyle(
                            //           color: Colors.black87,
                            //           fontSize: 23,
                            //           fontWeight: FontWeight.bold),
                            //       textAlign: TextAlign.left,
                            //     ),
                            //   ),
                            // ),
                            // _otherEvent(context, news),
                            _companyCard(context, news),
                            SizedBox(
                              height: 25,
                            )
                          ],
                        ),
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget _productIcons(context, icon, title) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Icon(
            icon,
            color: Colors.black54,
            size: 17,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 17,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }

  Widget _companyCard(context, News news) {
    return Card(
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
                child: Text(
                  'Company Information',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                  height: 3, color: Theme.of(context).scaffoldBackgroundColor),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    CollaborationsApi().baseUrl + news.company.logo,
                  ),
                  radius: MediaQuery.of(context).size.width * 0.23,
                ),
              ),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 10, bottom: 15, left: 20.0),
                  child: Text(
                    news.company.name,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
                child: Text(
                  'Company Contact info',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
              _contactInfo(context, Icons.flag,
                  news.company.companyAddress['city_town']),
              SizedBox(
                height: 15.0,
              ),
              _contactInfo(
                  context, Icons.mail, news.company.companyAddress['email']),
              SizedBox(
                height: 15.0,
              ),
              _contactInfo(context, Icons.phone,
                  news.company.companyAddress['phone_number']),
              SizedBox(
                height: 15.0,
              ),
              // Container(
              //     height: 3, color: Theme.of(context).scaffoldBackgroundColor),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20.0, top: 15.0),
              //   child: _buildButtons(context),
              // ),
              SizedBox(
                height: 25.0,
              ),
            ]),
      ),
    );
  }

  // Widget _otherEvent(context, News news) {
  //   return Card(
  //     color: Colors.white,
  //     child: Container(
  //       width: MediaQuery.of(context).size.width * 0.95,
  //       child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Padding(
  //               padding: const EdgeInsets.only(
  //                 bottom: 30.0,
  //               ),
  //               child: Stack(
  //                 children: [
  //                   Container(
  //                     height: 200,
  //                     width: MediaQuery.of(context).size.width * 0.95,
  //                     child: FittedBox(
  //                       fit: BoxFit.fill,
  //                       child: Image.network(
  //                         CollaborationsApi().baseUrl + news.image,
  //                       ),
  //                     ),
  //                   ),
  //                   Positioned.fill(
  //                     child: Align(
  //                       alignment: Alignment.bottomRight,
  //                       child: Padding(
  //                         padding: const EdgeInsets.only(right: 5),
  //                         child: ElevatedButton(
  //                           style: ElevatedButton.styleFrom(
  //                             primary: Theme.of(context).buttonColor,
  //                           ),
  //                           onPressed: () {},
  //                           child: Text(
  //                             "Business",
  //                             style:
  //                                 TextStyle(color: Colors.white, fontSize: 17),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(left: 20.0, top: 5, bottom: 20),
  //               child: Text(
  //                 'News name',
  //                 style: TextStyle(
  //                     color: Colors.black87,
  //                     fontSize: 24,
  //                     fontWeight: FontWeight.bold),
  //                 textAlign: TextAlign.left,
  //               ),
  //             ),
  //             _productIcons(context, Icons.location_on, "Ethiopia"),
  //             SizedBox(height: 10),
  //             _productIcons(context, Icons.calendar_today, "March 14, 2021"),
  //             SizedBox(height: 10),
  //             _productIcons(context, Icons.person, "MelfanTech"),
  //             SizedBox(height: 10),
  //             _productIcons(context, Icons.phone, "+251-92458-9558"),
  //             SizedBox(height: 20),
  //           ]),
  //     ),
  //   );
  // }

  Widget _contactInfo(context, icon, title) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
                color: Color.fromRGBO(247, 247, 251, 1),
                shape: BoxShape.circle),
            child: Icon(
              icon,
              color: Colors.black54,
              size: 19,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildButtons(context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(10.0),
  //     child: Container(
  //       height: 50,
  //       width: 100,
  //       child: SizedBox.expand(
  //         child: ElevatedButton(
  //           onPressed: () {},
  //           style: ElevatedButton.styleFrom(
  //             onPrimary: Color.fromRGBO(10, 178, 230, 0.5),
  //             primary: Color.fromRGBO(10, 178, 230, 1),
  //             padding: EdgeInsets.symmetric(horizontal: 16),
  //             shape: const RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(2)),
  //             ),
  //           ),
  //           child: Row(
  //             children: [
  //               Icon(Icons.mail, color: Colors.white),
  //               SizedBox(
  //                 width: 5,
  //               ),
  //               Text(
  //                 "Chat",
  //                 style: TextStyle(color: Colors.white, fontSize: 17),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
