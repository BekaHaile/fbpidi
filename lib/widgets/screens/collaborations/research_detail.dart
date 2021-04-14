import 'package:fbpidi/models/research.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/services/remove_tag.dart';
import 'package:flutter/material.dart';

class ResearchDetail extends StatelessWidget {
  final data;
  ResearchDetail(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Research Detail'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [_buildDetail(context), _addNewResearch(context)],
          ),
        ));
  }

  Widget _buildDetail(context) {
    return Center(
      child: FutureBuilder<Research>(
          future: CollaborationsApi().getResearchDetail(data['id']),
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
              Research research = snapshot.data;
              return Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Card(
                  color: Colors.white,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 18.0, top: 20, bottom: 20),
                          child: Text(
                            research.title,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 27,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          height: 3,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 15.0,
                              ),
                              _buildContent(
                                  context, "Status", research.status, false),
                              SizedBox(
                                height: 10.0,
                              ),
                              _buildContent(context, "Category",
                                  research.categoryName, false),
                              SizedBox(
                                height: 10.0,
                              ),
                              _buildContent(
                                  context, "By", research.createdBy, false),
                              SizedBox(
                                height: 10.0,
                              ),
                              _buildContentInColumn(
                                  context,
                                  "Detail",
                                  RemoveTag()
                                      .removeAllHtmlTags(research.description),
                                  false),
                              SizedBox(
                                height: 15.0,
                              ),
                              Container(
                                height: 3,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 20.0, bottom: 15.0),
                                  child: Text(
                                    'Research Files',
                                    style: TextStyle(fontSize: 18),
                                  )),
                              SizedBox(
                                height: 5.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }

  Widget _buildContent(context, title, content, background) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 19,
                fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.55,
            color: background ? Color.fromRGBO(247, 247, 247, 1) : Colors.white,
            child: Text(
              content,
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentInColumn(context, title, content, background) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      width: MediaQuery.of(context).size.width * 0.95,
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
          Container(
            padding: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.95,
            color: background ? Color.fromRGBO(247, 247, 247, 1) : Colors.white,
            child: Text(
              content,
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addNewResearch(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.55,
            height: 40.0,
            child: SizedBox.expand(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/addResearch');
                },
                child: Text(
                  "Add new Research",
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
      ),
    );
  }
}
