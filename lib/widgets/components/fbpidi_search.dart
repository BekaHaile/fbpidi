import 'package:flutter/material.dart';

class FbpidiSearch extends StatelessWidget {
  final dynamic callback;
  FbpidiSearch({this.callback});
  @override
  Widget build(BuildContext context) {
    TextEditingController editingController = TextEditingController();
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
                controller: editingController,
                decoration: InputDecoration(
                  hintText: "search",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                callback(editingController.text);
              },
              style: ElevatedButton.styleFrom(
                onPrimary: Theme.of(context).buttonColor.withOpacity(0.3),
                primary: Theme.of(context).buttonColor,
              ),
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
