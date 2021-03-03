import 'package:flutter/material.dart';

class FbpidiSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: 70,
      child: Card(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 10,
              ),
              width: MediaQuery.of(context).size.width * 0.65,
              height: 37,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "search",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {},
              color: Theme.of(context).buttonColor,
              child: Text(
                "Search",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
