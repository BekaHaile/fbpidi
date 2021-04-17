import 'package:fbpidi/models/news.dart';
import 'package:fbpidi/services/collaborations_api.dart';
import 'package:fbpidi/widgets/components/fbpidi_drawer.dart';
import 'package:fbpidi/widgets/components/fbpidi_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<NewsPage> {
  List selected = [true, false, false, false];
  List<News> news, searchedNews = [];
  bool isBeingSearhced = false;

  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: FbpidiDrawer("News")),
      appBar: AppBar(
        title: Text("News"),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            children: [
              FbpidiSearch(
                  callback: searchCallback,
                  editingController: editingController),
              _sortList(context),
              _buildNewsList(context),
            ],
          ),
        )),
      ),
    );
  }

  void searchCallback(String searchValue) {
    searchedNews.clear();
    if (news.length > 0) {
      news.forEach((element) {
        if (element.title.toLowerCase().contains(searchValue.toLowerCase()))
          searchedNews.add(element);
      });

      setState(() {
        isBeingSearhced = true;
      });
    }
  }

  Widget _sortList(context) {
    return Card(
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 10),
              child: Text(
                'Showing 1 to 10 of 30 entries',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 10),
              child: Text(
                'Sort by: ',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 55,
              padding: EdgeInsets.only(bottom: 5),
              child: SizedBox.expand(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      for (int i = 0; i < 4; i++) selected[i] = false;
                      selected[0] = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: selected[0]
                                ? Theme.of(context).buttonColor
                                : Colors.black38)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.32),
                    child: Row(children: [
                      Text(
                        "All",
                        style: TextStyle(
                            color: selected[0]
                                ? Theme.of(context).buttonColor
                                : Colors.black54,
                            fontSize: 18),
                      ),
                      Icon(
                        FontAwesomeIcons.sort,
                        color: selected[0]
                            ? Theme.of(context).buttonColor
                            : Colors.black54,
                      ),
                    ]),
                  ),
                ),
              ),
            ),
            _sortButton("Distance", context, 1),
            _sortButton("Latest", context, 2),
            _sortButton("Rating", context, 3),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _sortButton(title, context, index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 55,
      padding: EdgeInsets.only(bottom: 5),
      child: SizedBox.expand(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              for (int i = 0; i < 4; i++) selected[i] = false;
              selected[index] = true;
            });
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: selected[index]
                        ? Theme.of(context).buttonColor
                        : Colors.grey)),
          ),
          child: Text(
            title,
            style: TextStyle(
                color: selected[index]
                    ? Theme.of(context).buttonColor
                    : Colors.black54,
                fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget _buildNewsList(context) {
    return FutureBuilder<List<News>>(
        future: CollaborationsApi().getNews(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            );
          else {
            news = snapshot.data;
            if (news.length == 0)
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("No data"),
              ));
            else
              return isBeingSearhced
                  ? _listviewBuildNews(searchedNews)
                  : _listviewBuildNews(news);
          }
        });
  }

  Widget _listviewBuildNews(List<News> news) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.95,
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        scrollDirection: Axis.vertical,
        itemBuilder: (_, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
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
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: Stack(
                            children: [
                              Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.network(
                                    CollaborationsApi().baseUrl +
                                        news[index].images[0],
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Theme.of(context).buttonColor,
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        news[index].catagory,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 5, bottom: 10),
                          child: Text(
                            news[index].title,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 5, bottom: 20),
                          child: Text(
                            'Posted at: ' +
                                news[index].createdDate.substring(0, 10) +
                                ', ' +
                                news[index].createdDate.substring(12, 16) +
                                ' a.m.',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 19,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          height: 3,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 5, top: 10, bottom: 15),
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
                                      news[index].company.logo,
                                  fit: BoxFit.cover,
                                  width: 90.0,
                                  height: 90.0,
                                )),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Container(
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
                              SizedBox(
                                width: 5.0,
                              ),
                              Container(
                                height: 34,
                                width: 34,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(247, 247, 251, 1),
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                  size: 19,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Container(
                                height: 34,
                                width: 34,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(247, 247, 251, 1),
                                    shape: BoxShape.circle),
                                child: Icon(
                                  FontAwesomeIcons.solidComments,
                                  color: Color.fromRGBO(0, 0, 255, 1),
                                  size: 19,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/newsDetail',
                                        arguments: {'id': news[index].id});
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Theme.of(context).buttonColor,
                                  ),
                                  child: Text(
                                    "News Detail",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: news.length,
      ),
    );
  }
}
