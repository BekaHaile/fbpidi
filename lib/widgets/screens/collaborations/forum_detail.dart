import 'package:fbpidi/models/forum.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForumDetail extends StatelessWidget {
  final data;
  ForumDetail(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forum Detail"),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            children: [
              _buildForumList(context),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildForumList(context) {
    return FutureBuilder<Forum>(
        future: CollaborationsApi().getForumDetail(data['id']),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          else {
            Forum forum = snapshot.data;
            return Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 1.0),
              child: Column(
                children: [
                  Card(
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
                              forum.title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            height: 3,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: Colors.black54,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        'Post',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black),
                                        textAlign: TextAlign.justify,
                                      ),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                      Icon(
                                        Icons.calendar_today,
                                        color: Colors.black54,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        forum.createdDate.substring(0, 10) +
                                            ', ' +
                                            forum.createdDate
                                                .substring(12, 16) +
                                            ' p.m.',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 7.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.comment,
                                        color: Colors.black54,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        forum.noOfComments,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black54),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 5, bottom: 10),
                                  child: Text(
                                    forum.description,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 19,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 25.0),
                                  child: Text('Attachments',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildCommentList(context, forum.commentsList),
                ],
              ),
            );
          }
        });
  }

  Widget _buildCommentList(context, List comments) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.85,
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Comments',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (_, int index) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: Colors.black54,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        'Post',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black),
                                        textAlign: TextAlign.justify,
                                      ),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                      Icon(
                                        Icons.calendar_today,
                                        color: Colors.black54,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        comments[index]['created_date']
                                                .substring(0, 10) +
                                            ', ' +
                                            comments[index]['created_date']
                                                .substring(12, 16) +
                                            ' a.m.',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 5),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                    child: Text(
                                      comments[index]['comment'],
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.black),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: TextButton(
                                    child: Row(
                                      children: [
                                        Icon(Icons.reply_all),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Reply')
                                      ],
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    );
                  },
                  itemCount: comments.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
