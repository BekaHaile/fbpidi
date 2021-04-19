import 'package:fbpidi/models/user.dart';
import 'package:fbpidi/strings/strings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApi {
  String baseUrl = Strings().baseUrl;

  //Get profile data
  Future<User> getProfile(token) async {
    print(token + ' ****is the token');
    var response =
        await http.get(Uri.encodeFull("$baseUrl/api/mydash/"), //uri of api
            headers: {
          "Authorization": "Token $token",
        });

    print(response.body);

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data); //Response from the api
    User user = User.fromMap(data['user_detail']);
    return user;
  }

//user registration
  Future<dynamic> registerUser(User user, String path) async {
    Map<dynamic, dynamic> data = {
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
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );
    } catch (e) {
      print(e.toString() + 'has occured ****');
    }
    Map<dynamic, dynamic> data2 = jsonDecode(response.body);
    print(data2);
    return data2;

    // var response;
    // path =
    //     "/data/user/0/com.example.fbpidi/cache/file_picker/IMG_20210417_125234.jpg";
    // try {
    //   var uri = Uri.parse("$baseUrl/api/accounts/register/");
    //   var request = http.MultipartRequest('POST', uri);
    //   request.files.add(await http.MultipartFile.fromPath('file', path));
    //   request.fields['username'] = user.username;
    //   request.fields['first_name'] = user.firstName;
    //   request.fields['last_name'] = user.lastName;
    //   request.fields['phone_number'] = user.phoneNumber;
    //   request.fields['email'] = user.email;
    //   request.fields['password'] = user.password;
    //   request.fields['password2'] = user.password;
    //   response = await request.send();
    //   print("about to decode response /////////");
    //   final respStr = await response.stream.bytesToString();
    //   // Map<dynamic, dynamic> data2 = jsonDecode(response);
    //   //
    //   print("******" + respStr + "is the response *****");
    //   return jsonDecode(respStr);
    // } catch (e) {
    //   print(e.toString() + 'has occured ****');
    // }
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
    Map<dynamic, dynamic> data2 = jsonDecode(response.body);
    return data2;
  }
}
