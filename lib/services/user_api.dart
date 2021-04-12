import 'package:fbpidi/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApi {
  String baseUrl = "http://192.168.1.159:8000";

  //Get profile data
  Future<User> getProfile() async {
    var response =
        await http.get(Uri.encodeFull("$baseUrl/client/mydash/"), //uri of api
            headers: {"Accept": "application/json"});

    //ToDo - add token into the api call

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data); //Response from the api
    User user = User.fromMap(data);
    return user;
  }

//user registration
  Future<dynamic> registerUser(User user) async {
    Map<dynamic, String> data = {
      "username": user.username,
      "first_name": user.firstName,
      "last_name": user.lastName,
      "phone_number": user.phoneNumber,
      "email": user.email,
      "password": user.password,
      "password2": user.password,
    };
    var response;
    try {
      response = await http.post(
        Uri.encodeFull("$baseUrl/api/accounts/register/"), //uri of api
        headers: {
          "Content-Type": "application/json;",
        },
        body: jsonEncode(data),
      );
    } catch (e) {
      print(e.toString() + 'has occured ****');
    }
    return response.body;
  }

  //user login
  Future<Map<dynamic, dynamic>> userLogin(username, password) async {
    Map<dynamic, String> data = {
      "username": username,
      "password": password,
    };
    var response;
    try {
      response = await http.post(
        Uri.encodeFull("$baseUrl/api/accounts/login/"), //uri of api
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );
    } catch (e) {
      print(e + 'has occured ****');
    }
    return response.body;
  }
}
