import 'package:fbpidi/models/user.dart';
import 'package:fbpidi/services/user_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  final data;
  LoginPage({this.data});
  @override
  _LoginSevenPageState createState() => _LoginSevenPageState();
}

class _LoginSevenPageState extends State<LoginPage> {
  TextEditingController controllerUser = TextEditingController(),
      controllerPassword = TextEditingController();
  bool isError = false;
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipper2(),
                child: Container(
                  child: Column(),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0x22ff3a5a), Color(0x22fe494d)])),
                ),
              ),
              ClipPath(
                clipper: WaveClipper3(),
                child: Container(
                  child: Column(),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0x44ff3a5a), Color(0x44fe494d)])),
                ),
              ),
              ClipPath(
                clipper: WaveClipper1(),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 80,
                      ),
                      Center(
                        child: Text(
                          'FBPIDI',
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.5),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 26),
                        ),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromRGBO(44, 52, 155, 1),
                    Color.fromRGBO(76, 45, 141, 1),
                    Color.fromRGBO(97, 39, 131, 1),
                  ])),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.37,
                  height: 50.0,
                  child: SizedBox.expand(
                    child: ElevatedButton(
                      key: Key('raised'),
                      style: ElevatedButton.styleFrom(
                        onPrimary:
                            Color.fromRGBO(221, 75, 57, 1).withOpacity(0.7),
                        primary: Color.fromRGBO(221, 75, 57, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(7.0),
                        ),
                      ),
                      onPressed: () async {
                        await UserApi().loginWithGoogle().then((response) {
                          loginResponse(response);
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            FontAwesomeIcons.googlePlusG,
                            color: Colors.white,
                          ),
                          Text(
                            "Google",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  width: 60,
                  height: 50.0,
                  child: SizedBox.expand(
                    child: ElevatedButton(
                      key: Key('raised'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(7.0),
                        ),
                        primary: Color.fromRGBO(59, 89, 152, 1),
                        onPrimary: Theme.of(context).disabledColor,
                      ),
                      onPressed: () async {
                        await UserApi().loginWithFacebook().then((response) {
                          if (response['errors'] != null) {
                            setState(() {
                              message = response['errors']['detail'];
                              isError = true;
                            });
                          } else
                            loginResponse(response);
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            FontAwesomeIcons.facebook,
                            color: Colors.white,
                            size: 21,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(6.0),
              //   child: Container(
              //     width: 60,
              //     height: 50.0,
              //     child: SizedBox.expand(
              //       child: ElevatedButton(
              //         key: Key('raised'),
              //         style: ElevatedButton.styleFrom(
              //           shape: RoundedRectangleBorder(
              //             borderRadius: new BorderRadius.circular(7.0),
              //           ),
              //           primary: Color.fromRGBO(24, 23, 23, 1),
              //           onPrimary: Theme.of(context).disabledColor,
              //         ),
              //         onPressed: () {},
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //           children: [
              //             Icon(
              //               FontAwesomeIcons.gitAlt,
              //               color: Colors.white,
              //               size: 21,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("OR",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextField(
                controller: controllerUser,
                onChanged: (String value) {},
                cursorColor: Colors.deepOrange,
                decoration: InputDecoration(
                    hintText: "Username",
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.person,
                        color: Color.fromRGBO(255, 136, 25, 1),
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextField(
                obscureText: true,
                controller: controllerPassword,
                onChanged: (String value) {},
                cursorColor: Colors.deepOrange,
                decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.lock,
                        color: Color.fromRGBO(255, 136, 25, 1),
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          isError
              ? Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Text(
                      message,
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  ),
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Color.fromRGBO(255, 136, 25, 1),
                ),
                child: TextButton(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  onPressed: () async {
                    UserApi()
                        .userLogin(controllerUser.text, controllerPassword.text)
                        .then((response) async {
                      loginResponse(response);
                    });
                  },
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "FORGOT PASSWORD ?",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Don't have an Account ? ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
              InkWell(
                child: Text("Sign Up ",
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        decoration: TextDecoration.underline)),
                onTap: () {
                  Navigator.pushNamed(context, "/signUp");
                },
              ),
            ],
          ),
          SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }

  loginResponse(response) async {
    if (response['token'] != null) {
      Map<String, dynamic> data = await UserApi().getProfile(response['token']);
      if (data["error"]) {
        setState(() {
          message = data['message'];
          isError = true;
        });
      } else {
        User user = User.fromMap(data["user_detail"]);

        final storage = new FlutterSecureStorage();
        await storage.write(
            key: 'name', value: "${user.firstName} ${user.lastName}");
        await storage.write(key: 'id', value: user.id);
        await storage.write(key: 'email', value: "${user.email}");
        await storage.write(key: 'token', value: response['token']);
        await storage.write(key: 'loginStatus', value: 'true');
        if (widget.data != null && widget.data["route"] == "inquire") {
          Navigator.pushReplacementNamed(context, "/inquire",
              arguments: {"product": widget.data["product"]});
        } else if (widget.data != null && widget.data["id"] != null) {
          Navigator.pushReplacementNamed(context, widget.data["route"],
              arguments: {'id': widget.data['id']});
        } else if (widget.data != null)
          Navigator.pushReplacementNamed(context, widget.data["route"]);
        else
          Navigator.pop(context);
      }
    } else {
      print(response['non_field_errors']);
      setState(() {
        message = response['non_field_errors'][0];
        isError = true;
      });
    }
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 29 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 60);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 15 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 40);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * .7, size.height - 40);
    var firstControlPoint = Offset(size.width * .25, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
