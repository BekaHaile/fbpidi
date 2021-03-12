import 'package:fbpidi/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApi {
  //Get profile data
  Future<User> getProfile() async {
    var response = await http.get(
        Uri.encodeFull("http://127.0.0.1:8000/client/mydash/"), //uri of api
        headers: {"Accept": "application/json"});

    //ToDo - add token into the api call

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data); //Response from the api
    User user = User.fromMap(data);
    return user;
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

  //user login
  userLogin(username, password) async {
    Map<dynamic, String> data = {
      "username": username,
      "password": username.password,
    };
    var response;
    try {
      response = await http.post(
        Uri.encodeFull(
            "http://192.168.1.115:8000/client/accounts/login/"), //uri of api
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
