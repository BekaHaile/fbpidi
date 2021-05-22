import 'package:fbpidi/models/blog.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/services/launch_app.dart';
import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
import 'package:fbpidi/widgets/components/fbpidi_search.dart';
import 'package:flutter/material.dart';

class Blogs extends StatefulWidget {
  @override
  _BlogsState createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  List<Blog> blogs, searchedBlogs = [];

  bool isBeingSearhced = false;
  TextEditingController editingController = TextEditingController();

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
              FbpidiSearch(
                callback: searchCallback,
                editingController: editingController,
              ),
              _buildBlogList(context),
            ],
          ),
        )),
      ),
    );
  }

  void searchCallback(String searchValue) {
    searchedBlogs.clear();
    if (blogs.length > 0) {
      blogs.forEach((element) {
        if (element.title.toLowerCase().contains(searchValue.toLowerCase()) ||
            element.tag.toLowerCase().contains(searchValue.toLowerCase()))
          searchedBlogs.add(element);
      });

      setState(() {
        isBeingSearhced = true;
      });
    }
  }

  Widget _buildBlogList(context) {
    return FutureBuilder<List<Blog>>(
        future: CollaborationsApi().getBlogs(),
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
            blogs = snapshot.data;
            if (blogs.length == 0)
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("No data"),
              ));
            else
              return isBeingSearhced
                  ? _listviewBuildBlogs(searchedBlogs)
                  : _listviewBuildBlogs(blogs);
          }
        });
  }

  Widget _listviewBuildBlogs(List<Blog> blogs) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.95,
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        scrollDirection: Axis.vertical,
        itemBuilder: (_, int index) {
          return Column(
            children: [
              Card(
                color: Colors.white,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.network(
                            CollaborationsApi().baseUrl +
                                blogs[index].blogImage,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, top: 20, bottom: 20),
                        child: Text(
                          blogs[index].title,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 5, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "By: ",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            CircleAvatar(
                              radius: 20,
                              child: ClipOval(
                                  child: Image.network(
                                CollaborationsApi().baseUrl +
                                    blogs[index].blogImage,
                                fit: BoxFit.cover,
                                width: 90.0,
                                height: 90.0,
                              )),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            if (blogs[index].company.companyAddress != null)
                              if (blogs[index]
                                      .company
                                      .companyAddress["phone_number"] !=
                                  null)
                                InkWell(
                                  onTap: () {
                                    LaunchApp().launchInBrowser(
                                        "tel:${blogs[index].company.companyAddress["phone_number"]}");
                                  },
                                  child: Container(
                                    height: 34,
                                    width: 34,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(247, 247, 251, 1),
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.black,
                                      size: 19,
                                    ),
                                  ),
                                ),
                            SizedBox(
                              width: 5.0,
                            ),
                            // Container(
                            //   height: 34,
                            //   width: 34,
                            //   decoration: BoxDecoration(
                            //       color: Color.fromRGBO(247, 247, 251, 1),
                            //       shape: BoxShape.circle),
                            //   child: Icon(
                            //     Icons.location_on,
                            //     color: Colors.black,
                            //     size: 19,
                            //   ),
                            // ),
                            // SizedBox(
                            //   width: 5.0,
                            // ),
                            // Container(
                            //   height: 34,
                            //   width: 34,
                            //   decoration: BoxDecoration(
                            //       color: Color.fromRGBO(247, 247, 251, 1),
                            //       shape: BoxShape.circle),
                            //   child: Icon(
                            //     FontAwesomeIcons.solidComments,
                            //     color: Color.fromRGBO(0, 0, 255, 1),
                            //     size: 19,
                            //   ),
                            // ),
                            // SizedBox(
                            //   width: 5.0,
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/blogDetail",
                                      arguments: {'id': blogs[index].id});
                                },
                                style: ElevatedButton.styleFrom(
                                  onPrimary: Theme.of(context)
                                      .buttonColor
                                      .withOpacity(0.3),
                                  primary: Theme.of(context).buttonColor,
                                ),
                                child: Text(
                                  "Blog Detail",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 5),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "At: ",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      blogs[index]
                                              .createdDate
                                              .substring(0, 10) +
                                          ', ' +
                                          blogs[index]
                                              .createdDate
                                              .substring(11, 16) +
                                          ' a.m.',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ]),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        itemCount: blogs.length,
      ),
    );
  }
}
