import 'package:fbpidi/models/faq.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/services/remove_tag.dart';
import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
import 'package:flutter/material.dart';

class Faqs extends StatefulWidget {
  @override
  _FaqsState createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
  List<Faq> faqs = [];
  List<bool> showDetail = [];
  bool initialSet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FbpidiDrawer("Faqs"),
      appBar: AppBar(
        title: Text("FAQ"),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
          future: CollaborationsApi().getFaqs("1"),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              faqs = snapshot.data["faqs"];
              if (!initialSet) {
                faqs.forEach((element) {
                  showDetail.add(false);
                });
                initialSet = true;
              }
              return Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          scrollDirection: Axis.vertical,
                          itemCount: faqs.length,
                          itemBuilder: (_, int index) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    if (showDetail[index])
                                      showDetail[index] = false;
                                    else
                                      showDetail[index] = true;
                                  });
                                },
                                child: Card(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Text(
                                              faqs[index].questions,
                                              style: TextStyle(fontSize: 17),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.add),
                                          )
                                        ],
                                      ),
                                      showDetail[index]
                                          ? Container(
                                              height: 3,
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                            )
                                          : Container(),
                                      showDetail[index]
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Text(
                                                RemoveTag().removeAllHtmlTags(
                                                    faqs[index].answers),
                                                style: TextStyle(fontSize: 17),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })));
            }
          }),
    );
  }
}
