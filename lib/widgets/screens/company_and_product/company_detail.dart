import 'package:fbpidi/models/company.dart';
import 'package:fbpidi/services/company_and_product_api.dart';
import 'package:fbpidi/services/remove_tag.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyDetail extends StatelessWidget {
  final data;
  CompanyDetail(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<Company>(
                // future: CompanyAndProductAPI().getProduct(data['id']),
                future: CompanyAndProductAPI().getCompany(data['id']),
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
                    Company company = snapshot.data;
                    return Center(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 1.0),
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 15.0,
                                      left: MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                    child: Container(
                                      height: 200,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Image.network(
                                            CompanyAndProductAPI().baseUrl +
                                                company.logo),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 5, bottom: 10),
                                    child: Text(
                                      company.name,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Row(
                                      children: [
                                        if (company.companyAddress != null &&
                                            company.companyAddress[
                                                    "facebooklink"] !=
                                                null)
                                          InkWell(
                                            onTap: () {
                                              _launchInBrowser(
                                                  company.companyAddress[
                                                      "facebooklink"]);
                                            },
                                            child: _iconWithCircleBackground(
                                                FontAwesomeIcons.facebookF,
                                                Colors.black),
                                          ),
                                        if (company.companyAddress != null &&
                                            company.companyAddress[
                                                    "twitterlink"] !=
                                                null)
                                          InkWell(
                                            onTap: () {
                                              _launchInBrowser(
                                                  company.companyAddress[
                                                      "twitterlink"]);
                                            },
                                            child: _iconWithCircleBackground(
                                                FontAwesomeIcons.twitter,
                                                Colors.black),
                                          ),
                                        if (company.companyAddress != null &&
                                            company.companyAddress[
                                                    "googlelink"] !=
                                                null)
                                          InkWell(
                                            onTap: () {
                                              _launchInBrowser(
                                                  company.companyAddress[
                                                      "googlelink"]);
                                            },
                                            child: _iconWithCircleBackground(
                                                FontAwesomeIcons.googlePlusG,
                                                Colors.black),
                                          ),
                                        if (company.companyAddress != null &&
                                            company.companyAddress[
                                                    "instagramlink"] !=
                                                null)
                                          InkWell(
                                            onTap: () {
                                              _launchInBrowser(
                                                  company.companyAddress[
                                                      "instagramlink"]);
                                            },
                                            child: _iconWithCircleBackground(
                                                FontAwesomeIcons.instagram,
                                                Colors.black),
                                          )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 3,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Row(
                                      children: [
                                        _iconWithCircleBackground(
                                            FontAwesomeIcons.solidFlag,
                                            Theme.of(context).buttonColor),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        company.companyAddress != null
                                            ? Text(company.companyAddress[
                                                    "city_town"] +
                                                ", " +
                                                company.companyAddress[
                                                    "local_area"])
                                            : Text('Address')
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Row(
                                      children: [
                                        _iconWithCircleBackground(
                                            FontAwesomeIcons.phone,
                                            Theme.of(context).buttonColor),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(company.companyAddress != null
                                            ? company
                                                .companyAddress['phone_number']
                                                .toString()
                                            : '')
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            overviewCard(context, company),
                            _buildButtons(context),
                            SizedBox(
                              height: 15,
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

  // Widget _iconButton(icon, color, text) {
  //   return Padding(
  //     padding: const EdgeInsets.all(10.0),
  //     child: Container(
  //       height: 45,
  //       width: 175,
  //       child: SizedBox.expand(
  //         child: ElevatedButton(
  //           onPressed: () {},
  //           style: ElevatedButton.styleFrom(
  //             onPrimary: color,
  //             primary: color.withOpacity(0.7),
  //             padding: EdgeInsets.symmetric(horizontal: 16),
  //             shape: const RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(2)),
  //             ),
  //           ),
  //           child: Row(
  //             children: [
  //               Icon(
  //                 icon,
  //                 color: Colors.white,
  //               ),
  //               SizedBox(
  //                 width: 5,
  //               ),
  //               Text(
  //                 text,
  //                 style: TextStyle(color: Colors.white, fontSize: 17),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Future<void> _launchInBrowser(String url) async {
    if (!url.contains("http") &&
        !url.contains("mailto") &&
        !url.contains("tel")) url = "http://" + url;
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _iconWithCircleBackground(icon, color) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        height: 38,
        width: 38,
        decoration: BoxDecoration(
            color: Color.fromRGBO(247, 247, 251, 1), shape: BoxShape.circle),
        child: Icon(
          icon,
          color: color,
          size: 19,
        ),
      ),
    );
  }

  Widget overviewCard(context, Company company) {
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
                  'Overview',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                  height: 3, color: Theme.of(context).scaffoldBackgroundColor),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, top: 15, bottom: 15, right: 15),
                child: Text(
                  RemoveTag().removeAllHtmlTags(company.detail),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
                child: Text(
                  'Contact info',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
              _contactInfo(
                  context,
                  Icons.flag,
                  company.companyAddress != null
                      ? company.companyAddress['city_town'] +
                          ', ' +
                          company.companyAddress['local_area']
                      : 'No Address'),
              SizedBox(
                height: 15.0,
              ),
              _contactInfo(
                  context,
                  Icons.mail,
                  company.companyAddress != null
                      ? company.companyAddress['email']
                      : 'Email'),
              SizedBox(
                height: 15.0,
              ),
              _contactInfo(
                  context,
                  Icons.phone,
                  company.companyAddress != null
                      ? company.companyAddress['phone_number']
                      : ''),
              SizedBox(
                height: 15.0,
              ),
              _contactInfo(
                  context,
                  Icons.file_copy,
                  company.companyAddress != null
                      ? company.companyAddress['fax']
                      : ''),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
                child: Text(
                  'More Company info',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
              _businessInfo(context, "Established Year",
                  company.establishedYear.toString()),
              SizedBox(
                height: 15.0,
              ),
              _businessInfo(context, "Services", ""),
              SizedBox(
                height: 15.0,
              ),
              _businessInfo(
                  context,
                  "Fax",
                  company.companyAddress != null
                      ? company.companyAddress['fax']
                      : ''),
              SizedBox(
                height: 15.0,
              ),
              _businessInfo(
                  context,
                  "Certification",
                  company.certification.length > 0
                      ? company.certification[0].toString()
                      : ""),
              SizedBox(
                height: 15.0,
              ),
            ]),
      ),
    );
  }

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

  Widget _businessInfo(context, mainText, subText) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            mainText,
            style: TextStyle(
                color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 30.0,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              subText,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 19,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(context) {
    return Card(
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
              child: Text(
                'Contact Manufacturer',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
                height: 3, color: Theme.of(context).scaffoldBackgroundColor),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: <
                Widget>[
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: Container(
              //     height: 45,
              //     width: 100,
              //     child: SizedBox.expand(
              //       child: ElevatedButton(
              //         onPressed: () {},
              //         style: ElevatedButton.styleFrom(
              //           onPrimary: Color.fromRGBO(10, 178, 230, 0.5),
              //           primary: Color.fromRGBO(10, 178, 230, 1),
              //           padding: EdgeInsets.symmetric(horizontal: 16),
              //           shape: const RoundedRectangleBorder(
              //             borderRadius: BorderRadius.all(Radius.circular(2)),
              //           ),
              //         ),
              //         child: Row(
              //           children: [
              //             Icon(Icons.mail, color: Colors.white),
              //             SizedBox(
              //               width: 5,
              //             ),
              //             Text(
              //               "Chat",
              //               style: TextStyle(color: Colors.white, fontSize: 17),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 45,
                  width: 150,
                  child: SizedBox.expand(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/contactUs",
                            arguments: {"id": data['id']});
                      },
                      style: ElevatedButton.styleFrom(
                        onPrimary: Color.fromRGBO(255, 136, 25, 0.5),
                        primary: Color.fromRGBO(255, 136, 25, 1),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Contact Us",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
