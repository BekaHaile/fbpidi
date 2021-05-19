import 'package:fbpidi/models/user.dart';
import 'package:fbpidi/strings/strings.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApi {
  String baseUrl = Strings().baseUrl;

  Future<String> getToken() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    return token;
  }

  //Get profile data
  Future<Map<String, dynamic>> getProfile(token) async {
    var response =
        await http.get(Uri.encodeFull("$baseUrl/api/mydash/"), //uri of api
            headers: {
          "Authorization": "Token $token",
        });

    String body = utf8.decode(response.bodyBytes);

    Map<String, dynamic> data = jsonDecode(body);
    // print(data); //Response from the api

    return data;
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
    // print(data2);
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

  //update profile
  Future<dynamic> updateUser(User user) async {
    var response;
    String token = await getToken();
    try {
      var uri = Uri.parse("$baseUrl/api/mydash/");
      var request = http.MultipartRequest('POST', uri);
      if (user.profileImage != null)
        request.files.add(await http.MultipartFile.fromPath(
            'profile_image ', user.profileImage));
      request.fields['username'] = user.username;
      request.fields['first_name'] = user.firstName;
      request.fields['last_name'] = user.lastName;
      request.fields['phone_number'] = user.phoneNumber;
      request.fields['email'] = user.email;
      request.fields['address'] = "";
      request.fields['city'] = "";
      request.fields['postal_code'] = "";
      request.fields['country'] = "";
      request.fields['facebook_link'] = "";
      request.fields['twiter_link'] = "";
      request.fields['google_link'] = "";
      request.fields['pintrest_link'] = "";
      request.fields['bio'] = "";
      request.headers['Authorization'] = "Token " + token;

      response = await request.send();
      // print("about to decode response /////////");

      final respStr = await response.stream.bytesToString();

      print("******" + respStr + "is the response *****");
      return jsonDecode(respStr);
    } catch (e) {
      print(e.toString() + 'has occured ****');
    }
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

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  // ignore: missing_return
  Future<Map<dynamic, dynamic>> loginWithGoogle() async {
    Map<dynamic, dynamic> data2 = Map<dynamic, dynamic>();
    await _googleSignIn.signIn().then((result) async {
      await result.authentication.then((googleKey) async {
        print('sing in google *******00');
        print(googleKey.accessToken);
        print(googleKey.idToken);
        print(_googleSignIn.currentUser.displayName);

        Map<dynamic, String> data = {
          "access_token": googleKey.accessToken,
        };
        var response;
        try {
          response = await http.post(
            Uri.encodeFull(
                "$baseUrl/api/accounts/social/google-oauth2/"), //uri of api
            headers: {
              "Content-Type": "application/json",
            },
            body: jsonEncode(data),
          );
        } catch (e) {
          print(e + 'has occured ****');
          return {'error': true};
        }
        data2 = jsonDecode(response.body);
        print(data2);
      }).catchError((err) {
        print('inner error: ' + err.toString());
        return {'error': true};
      });
    }).catchError((err) {
      print('error occured: ' + err.toString());
      return {'error': true};
    });

    return data2;
  }

  Future<Map<String, dynamic>> loginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login(permissions: [
      'public_profile',
      'email'
    ]); // by default we request the email and the public profile
    print(result);
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken;
      print(accessToken.token);

      Map<dynamic, String> data = {
        "access_token": accessToken.token,
      };
      var response;
      try {
        response = await http.post(
          Uri.encodeFull("$baseUrl/api/accounts/social/facebook/"), //uri of api
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode(data),
        );
      } catch (e) {
        print(e + 'has occured ****');
        return {'error': true};
      }
      Map<String, dynamic> data2 = jsonDecode(response.body);
      print(data2);

      return data2;
    } else
      return {'error': true};
  }
}
