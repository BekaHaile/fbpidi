import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:fbpidi/models/research.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/services/remove_tag.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ResearchDetail extends StatefulWidget {
  final data;
  ResearchDetail(this.data);

  @override
  _ResearchDetailState createState() => _ResearchDetailState();
}

class _ResearchDetailState extends State<ResearchDetail> {
  ReceivePort receivePort = ReceivePort();
  @override
  void initState() {
    IsolateNameServer.registerPortWithName(
        receivePort.sendPort, "Downloading File");
    receivePort.listen((message) {
      print(message);
    });
    FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
  }

  static downloadCallback(id, status, progress) {
    SendPort sendPort = IsolateNameServer.lookupPortByName("Downloading File");
    sendPort.send(progress);
  }

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
          future: CollaborationsApi().getResearchDetail(widget.data['id']),
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
              File file = File(CollaborationsApi().baseUrl +
                  research.attachements[0]["attachement"]);

              String basename = file.path.split("/").last;
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
                              _buildContent(context, "By",
                                  research.createdBy["username"], false),
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
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                height: 5.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        basename,
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          _downloadFile(file.path, basename);
                                        },
                                        child: Text(
                                          "Download File",
                                          style: TextStyle(fontSize: 16),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25,
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

  void _downloadFile(url, filename) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final baseStorage = await getExternalStorageDirectory();

      print(baseStorage.path + '********************');

      await FlutterDownloader.enqueue(
          url: url, savedDir: baseStorage.path, fileName: filename);
    } else {
      print("Permission denied");
    }
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
                onPressed: () async {
                  await CollaborationsApi().getLoginStatus().then((status) {
                    if (status == "true")
                      Navigator.pushNamed(context, '/addResearch');
                    else
                      Navigator.pushNamed(context, "/login",
                          arguments: {'route': '/addResearch'});
                  });
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
