import 'package:fbpidi/models/news.dart';
import 'package:fbpidi/models/poll.dart';
import 'package:fbpidi/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CollaborationsApi {
  //Get all polls
  Future<List<Poll>> getPolls() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://127.0.0.1:8000/client/collaborations/polls/"), //uri of api
        headers: {"Accept": "application/json"});

    //ToDo - add token into the api call

    List<dynamic> data = jsonDecode(response.body);
    print(data); //Response from the api
    List<Poll> polls = List<Poll>();
    data.forEach((poll) {
      polls.add(Poll.fromMap(poll));
    });
    return polls;
  }

  //Get poll detail
  Future<Poll> getPollDetail(id) async {
    var response = await http.get(
        Uri.encodeFull(
            "http://127.0.0.1:8000/client/collaborations/poll_detail/$id/"), //uri of api
        headers: {
          "Authorization Token": "99b43761704f6994a5bd6cd0fc93b1f542db5e73"
        });

    //ToDo - add token into the api call

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data); //Response from the api
    Poll poll = Poll.fromMap(data["data"]);

    return poll;
  }

  //vote for a specific poll
  voteForAPoll(id, selectedChoice, remark) async {
    var response = await http.get(
        Uri.encodeFull(
            "http://127.0.0.1:8000/client/collaborations/poll_detail/$id/?selected_choice=$selectedChoice&remark=$remark"), //uri of api
        headers: {
          "Authorization Token": "99b43761704f6994a5bd6cd0fc93b1f542db5e73"
        });

    //ToDo - add token into the api call

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data); //Response from the api

    return data;
  }

//get list of news
  Future<List<News>> getNews() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://127.0.0.1:8000/client/collaborations/news/"), //uri of api
        headers: {"Accept": "application/json"});

    //ToDo - add token into the api call

    List<dynamic> data = jsonDecode(response.body);
    print(data); //Response from the api
    List<News> newsList = List<News>();
    data.forEach((news) {
      newsList.add(news.fromMap(news));
    });
    return newsList;
  }

  //Get news detail
  Future<News> getNewsDetail(id) async {
    var response = await http.get(
        Uri.encodeFull(
            "http://127.0.0.2:8000/client/collaborations/news_detail/$id/"), //uri of api
        headers: {
          "Authorization Token": "99b43761704f6994a5bd6cd0fc93b1f542db5e73"
        });

    //ToDo - add token into the api call

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data); //Response from the api
    News news = News.fromMap(data);

    return news;
  }
}