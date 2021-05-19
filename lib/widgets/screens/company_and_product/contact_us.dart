import 'package:fbpidi/services/company_and_product_api.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  final data;
  ContactUs(this.data);

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
                            context, controllerEmail, "Email Address"),
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
                                onPressed: () async {
                                  Map<String, String> contactData = {
                                    "c_id": data["id"],
                                    "name": controllerName.text,
                                    "email": controllerEmail.text,
                                    "message": controllerMessage.text
                                  };
                                  CompanyAndProductAPI()
                                      .contactUs(contactData)
                                      .then((response) {
                                    _confirmationDialogue(
                                        context,
                                        "Your message has been successfully sent",
                                        false);
                                  });
                                },
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

  _confirmationDialogue(mainContext, message, isError) {
    showDialog(
        context: mainContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  if (!isError) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else
                    Navigator.of(context).pop();
                },
                child: Text(
                  isError ? 'Close' : 'Continue',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 165, 81, 1), fontSize: 17),
                ),
              ),
            ],
          );
        });
  }
}
