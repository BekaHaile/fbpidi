import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Theme.of(context).highlightColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: FaIcon(FontAwesomeIcons.twitter,
                      color: Theme.of(context).highlightColor),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: FaIcon(FontAwesomeIcons.linkedin,
                    color: Theme.of(context).highlightColor), ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: FaIcon(FontAwesomeIcons.googlePlus,
                    color: Theme.of(context).highlightColor), ),
              ],
            ),
            Row(
              children: [
                FaIcon(FontAwesomeIcons.user,
                    color: Theme.of(context).highlightColor),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: FaIcon(FontAwesomeIcons.signInAlt,
                    color: Theme.of(context).highlightColor),),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: FaIcon(FontAwesomeIcons.globe,
                    color: Theme.of(context).highlightColor),),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
