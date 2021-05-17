import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  final TextEditingController controllerName = TextEditingController(),
      controllerEmail = TextEditingController(),
      controllerMessage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 20),
                    child: Column(
                      children: [
                        buildTextField(context, controllerName, "Your Name"),
                        SizedBox(
                          height: 15,
                        ),
                        buildTextField(
                            context, controllerName, "Email Address"),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(border: Border.all()),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextField(
                            minLines: 10,
                            maxLines: 20,
                            controller: controllerMessage,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                hintText: "Message",
                                hintStyle: TextStyle(
                                    fontSize: 18, color: Colors.black45)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 40.0,
                            child: SizedBox.expand(
                              child: ElevatedButton(
                                onPressed: () async {},
                                child: Text(
                                  "Send Message",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).primaryColor,
                                  onPrimary: Theme.of(context).disabledColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(context, controller, hint) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5),
            hintText: hint,
            hintStyle: TextStyle(fontSize: 18, color: Colors.black45)),
      ),
    );
  }
}
