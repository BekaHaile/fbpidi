import 'package:fbpidi/models/blog.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/services/remove_tag.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BlogDetail extends StatelessWidget {
  final data;
  BlogDetail(this.data);
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog Detail"),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            children: [
              _buildBlogList(context),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildBlogList(context) {
    return FutureBuilder<Blog>(
        future: CollaborationsApi().getBlogDetail(data['id']),
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
            Blog blog = snapshot.data;

            return Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.95,
              padding: EdgeInsets.symmetric(vertical: 1.0),
              child: Column(
                children: [
                  Card(
                    color: Colors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, top: 20),
                            child: Text(
                              blog.title,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              height: 180,
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.network(
                                  CollaborationsApi().baseUrl + blog.blogImage,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.85,
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
                                        Icons.calendar_today,
                                        color: Colors.black87,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        blog.createdDate.substring(0, 10) +
                                            ', ' +
                                            blog.createdDate.substring(12, 16) +
                                            ' a.m.',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black87),
                                        textAlign: TextAlign.justify,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Icon(
                                        Icons.person,
                                        color: Colors.black87,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        'Pepsi',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black87),
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
                                        color: Colors.black87,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        blog.commentsList != null
                                            ? blog.commentsList.length
                                                .toString()
                                            : '0',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black87),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 15.0, top: 10.0),
                                  child: Text(
                                    RemoveTag().removeAllHtmlTags(blog.content),
                                    style: TextStyle(fontSize: 17),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildCommentList(context, blog.commentsList),
                  SizedBox(
                    height: 15,
                  ),
                  _buildCommentField(context, blog.id),
                ],
              ),
            );
          }
        });
  }

  Widget _buildCommentList(context, List comments) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.95,
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comments.length.toString() + ' Comments',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                height: 3,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              comments.length == 0
                  ? Container(
                      height: 40,
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Container(
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, right: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
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
                                                    .substring(0, 10),
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.85,
                                            child: Text(
                                              comments[index]['content'],
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            );
                          },
                          itemCount: comments.length,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommentField(context, id) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.95,
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Add a comment',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              height: 3,
              color: Theme.of(context).scaffoldBackgroundColor,
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
                  controller: commentController,
                  minLines: 15,
                  maxLines: 30,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.5),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.35,
                height: 40.0,
                child: SizedBox.expand(
                  child: ElevatedButton(
                    onPressed: () async {
                      await CollaborationsApi()
                          .commentOnBlog(id, commentController.text, "create")
                          .then((value) {
                        if (value["error"])
                          _confirmationDialogue(
                              context, value["message"], true);
                        else
                          _confirmationDialogue(
                              context, value["message"], false);
                      });
                    },
                    child: Text(
                      "Submit",
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
            SizedBox(
              height: 20,
            ),
          ]),
        ),
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
                  if (!isError)
                    Navigator.pushNamed(mainContext, '/blogs');
                  else
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
