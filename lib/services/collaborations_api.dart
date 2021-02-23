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
            "http://127.0.0.2:8000/client/collaborations/poll_detail/$id/"), //uri of api
        headers: {
          "Authorization Token": "99b43761704f6994a5bd6cd0fc93b1f542db5e73"
        });

    //ToDo - add token into the api call

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data); //Response from the api
    Poll poll = Poll.fromMap(data["data"]);

    return poll;
  }

//user registration
  registerUser(User user) async {
    Map<dynamic, String> data = {
      "username": user.username,
      "first_name": user.firstName,
      "last_name": user.lastName,
      "phone_number": user.phoneNumber,
      "email": user.email,
      "password": user.password,
      "password2": user.password
    };
    var response;
    try {
      response = await http.post(
        Uri.encodeFull(
            "http://127.0.0.1:8000/client/accounts/register/"), //uri of api
        headers: {
          "Accept": "application/json; charset=UTF-8",
        },
        body: jsonEncode(data),
      );
    } catch (e) {
      print(e + 'has occured ****');
    }
    return response.body;
  }

  //user registration
  userLogin(username, password) async {
    Map<dynamic, String> data = {
      "username": username,
      "password": username.password,
    };
    var response;
    try {
      response = await http.post(
        Uri.encodeFull(
            "http://127.0.0.2:8000/client/accounts/login/"), //uri of api
        headers: {
          "Accept": "application/json; charset=UTF-8",
        },
        body: jsonEncode(data),
      );
    } catch (e) {
      print(e + 'has occured ****');
    }
    return response.body;
  }
}
