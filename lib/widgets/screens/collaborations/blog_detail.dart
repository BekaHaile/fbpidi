import 'package:fbpidi/models/blog.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/services/remove_tag.dart';
import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BlogDetail extends StatelessWidget {
  final data;
  BlogDetail(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: FbpidiDrawer("Blogs")),
      appBar: AppBar(
        title: Text("Blogs"),
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
                                  fontSize: 19,
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
                                  "https://www.autocar.co.uk/sites/autocar.co.uk/files/styles/body-image/public/1-corvette-stingray-c8-2019-fd-hr-hero-front_0.jpg?itok=SEYe_vLy",
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
                                        '0',
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
                  _buildCommentList(context, []),
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
                                        0.85,
                                    child: Text(
                                      comments[index]['content'],
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
