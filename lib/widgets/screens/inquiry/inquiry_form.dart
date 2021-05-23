import 'package:fbpidi/models/product.dart';
import 'package:fbpidi/services/company_and_product_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InquiryForm extends StatefulWidget {
  final data;
  InquiryForm(this.data);

  @override
  _InquiryFormState createState() => _InquiryFormState();
}

class _InquiryFormState extends State<InquiryForm> {
  final TextEditingController controllerFrom = TextEditingController(),
      controllerSubject = TextEditingController(),
      controllerQuantity = TextEditingController(),
      controllerContent = TextEditingController();

  final storage = FlutterSecureStorage();
  String fileName = "Pick file";
  String path;
  Product product;

  List<String> subsectorList = [];
  String subsectorChosen = 'Select subsector';
  List<String> productList = [];
  String productChosen = 'All';
  List<dynamic> subsectors = [];
  Map<String, String> subsectorIdMap = Map<String, String>(),
      productIdMap = Map<String, String>();
  List<Product> products;

  @override
  Widget build(BuildContext context) {
    if (widget.data["type"] == "single") product = widget.data["product"];
    return Scaffold(
      appBar: AppBar(
        title: Text("Inquiry Form"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 28.0, top: 15.0, bottom: 15.0),
                child: Text(
                  "Send Your Inquiry",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 1,
                color: Colors.grey.shade400,
              ),
              FutureBuilder<String>(
                  future: storage.read(key: "email"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) controllerFrom.text = snapshot.data;
                    return _buildTextField(
                        context, "From *", controllerFrom, "", false);
                  }),
              widget.data["type"] == "single"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "For",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Container(
                            padding: EdgeInsets.only(left: 30.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 70,
                                  width: 80,
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Image.network(
                                      CompanyAndProductAPI().baseUrl +
                                          product.image,
                                    ),
                                  ),
                                ),
                                Text(
                                  product.name,
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(
                                  height: 15,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: _buildSubsectorDropdown(context, "Subsector"),
                        ),
                        subsectorChosen == "Select subsector"
                            ? Container()
                            : _buildProductDropdown(context, "Product")
                      ],
                    ),
              _buildTextField(
                  context, "Subject *", controllerSubject, "subject", false),
              _buildTextField(
                  context, "Quantity *", controllerQuantity, "", false),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 5),
                child: Text(
                  "Ton",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              _buildTextField(context, "Content *", controllerContent,
                  "Your inquiry content", true),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 10),
                child: Text("Any Attachments",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        fileName,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          FilePickerResult result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'pdf', 'doc'],
                          );

                          if (result != null) {
                            PlatformFile file = result.files.first;

                            print(file.name);
                            print(file.path);
                            setState(() {
                              fileName = file.name;
                            });
                            path = file.path;
                          } else {
                            // User canceled the picker
                          }
                        },
                        child: Text(
                          "Pick File",
                          style: TextStyle(fontSize: 16),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                child: _sendInquiry(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(context, title, controller, hint, textArea) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            title,
            style: TextStyle(
                color: Colors.black87,
                fontSize: 19,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Container(
            decoration: BoxDecoration(border: Border.all()),
            width: MediaQuery.of(context).size.width * 0.75,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  hintText: hint,
                  hintStyle: TextStyle(fontSize: 18)),
              maxLines: textArea ? 15 : 1,
              minLines: textArea ? 10 : 1,
            ),
          ),
        )
      ],
    );
  }

  Widget _sendInquiry(context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.4),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        height: 40.0,
        child: SizedBox.expand(
          child: ElevatedButton(
            onPressed: () async {
              if (widget.data["type"] == "single") {
                Product product = widget.data["product"];
                Map<String, dynamic> data2 = {
                  "sender_email": controllerFrom.text,
                  "subject": controllerSubject.text,
                  "quantity": controllerQuantity.text,
                  "content": controllerContent.text,
                  "prod_id_list": product.id,
                  "attachment": path
                };
                await CompanyAndProductAPI()
                    .sendInquiry(data2, "product")
                    .then((value) {
                  if (value["error"] == false)
                    _confirmationDialogue(
                        context, "Inquiry has been sent successfully", false);
                  else
                    _confirmationDialogue(
                        context, "Error sending Inquiry", true);
                });
              } else {
                if (subsectorChosen == "Select subsector") {
                  _confirmationDialogue(context,
                      "Please choose a subsector from the drop down", true);
                } else {
                  String type;
                  Map<String, dynamic> data2 = Map<String, dynamic>();
                  if (productChosen != "All") {
                    type = "product";
                    data2 = {
                      "sender_email": controllerFrom.text,
                      "subject": controllerSubject.text,
                      "quantity": controllerQuantity.text,
                      "content": controllerContent.text,
                      "prod_id_list": productIdMap[productChosen],
                      "attachment": path
                    };
                  } else {
                    type = "subsector";
                    data2 = {
                      "sender_email": controllerFrom.text,
                      "subject": controllerSubject.text,
                      "quantity": controllerQuantity.text,
                      "content": controllerContent.text,
                      "category_id": subsectorIdMap[subsectorChosen],
                      "attachment": path
                    };
                  }
                  await CompanyAndProductAPI()
                      .sendInquiry(data2, type)
                      .then((value) {
                    if (value["error"] == false)
                      _confirmationDialogue(
                          context, "Inquiry has been sent successfully", false);
                    else
                      _confirmationDialogue(
                          context, "Error sending Inquiry", true);
                  });
                }
              }
            },
            child: Text(
              "Send Inquiry",
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
    );
  }

  Widget _buildSubsectorDropdown(context, String title) {
    return FutureBuilder<Map<String, dynamic>>(
        future: CompanyAndProductAPI().getCompanies("All", "1"),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            );
          else {
            subsectors = snapshot.data["categories"];
            subsectorList.clear();
            subsectorIdMap.clear();
            subsectorList.add('Select subsector');

            subsectors.forEach((subsector) {
              subsectorList.add(subsector["category_name"]);
              subsectorIdMap.addAll(
                  {subsector["category_name"]: subsector["id"].toString()});
            });

            return Container(
              padding: EdgeInsets.only(left: 20),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$title: ',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(border: Border.all()),
                        child: DropdownButton<String>(
                          value: subsectorChosen,
                          isExpanded: true,
                          icon: const Icon(FontAwesomeIcons.chevronDown),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          onChanged: (String newValue) {
                            setState(() {
                              subsectorChosen = newValue;
                            });
                          },
                          items: subsectorList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(value),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    height: 2,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        )),
                  ),
                ],
              ),
            );
          }
        });
  }

  Widget _buildProductDropdown(context, String title) {
    return FutureBuilder<Map<String, dynamic>>(
        future: CompanyAndProductAPI()
            .getProductsByCategory(subsectorIdMap[subsectorChosen], '1', ""),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            );
          else {
            productList.clear();
            productIdMap.clear();
            productList.add('All');
            products = snapshot.data["products"];

            products.forEach((product) {
              productList.add(product.name);
              productIdMap.addAll({product.name: product.id});
            });

            return Container(
              padding: EdgeInsets.only(left: 20),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$title: ',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(border: Border.all()),
                        child: DropdownButton<String>(
                          value: productChosen,
                          isExpanded: true,
                          icon: const Icon(FontAwesomeIcons.chevronDown),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          onChanged: (String newValue) {
                            setState(() {
                              productChosen = newValue;
                            });
                          },
                          items: productList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(value),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Container(
                                      height: 2,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        )),
                  ),
                ],
              ),
            );
          }
        });
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
                    Navigator.pop(mainContext);
                  } else
                    Navigator.pop(context);
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
