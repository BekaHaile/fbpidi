import 'package:fbpidi/models/user.dart';
import 'package:fbpidi/services/user_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController controllerFirst = TextEditingController(),
      controllerLast = TextEditingController(),
      controllerUser = TextEditingController(),
      controllerEmail = TextEditingController(),
      controllerPhone = TextEditingController(),
      controllerPassword = TextEditingController(),
      controllerConfirm = TextEditingController();
  bool isError = false;
  String message = 'Error in your data';
  String path;

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 30),
            child: Column(
              children: <Widget>[
                HeaderContainer("Signup For Free"),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      _textInput(
                          hint: "First Name",
                          icon: Icons.person,
                          controller: controllerFirst),
                      _textInput(
                          hint: "Last Name",
                          icon: Icons.person,
                          controller: controllerLast),
                      _textInput(
                          hint: "Username",
                          icon: Icons.person,
                          controller: controllerUser),
                      _textInput(
                          hint: "Email",
                          icon: Icons.email,
                          controller: controllerEmail),
                      _textInput(
                          hint: "Phone Number",
                          icon: Icons.call,
                          controller: controllerPhone),
                      _textInput(
                          hint: "Password",
                          icon: Icons.vpn_key,
                          controller: controllerPassword),
                      _textInput(
                          hint: "Confirm Password",
                          icon: Icons.vpn_key,
                          controller: controllerConfirm),
                      isError
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                message,
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Center(
                          child: ButtonWidget(
                            btnText: "Register",
                            onClick: () async {
                              if (controllerConfirm.text ==
                                  controllerPassword.text) {
                                User user = User(
                                    firstName: controllerFirst.text,
                                    lastName: controllerLast.text,
                                    username: controllerUser.text,
                                    email: controllerEmail.text,
                                    phoneNumber: controllerPhone.text,
                                    password: controllerPassword.text);
                                try {
                                  await UserApi()
                                      .registerUser(user, path)
                                      .then((response) async {
                                    if (response['error'] == false) {
                                      final storage =
                                          new FlutterSecureStorage();
                                      await storage.delete(key: 'token');
                                      await storage
                                          .write(
                                              key: 'token',
                                              value: response['token'])
                                          .then((value) async {
                                        _signUpDialogue(context);
                                      });
                                    } else {
                                      print('Error');
                                      setState(() {
                                        isError = true;
                                        if (response["message"] != null)
                                          message = response['message'];
                                      });
                                    }
                                  });
                                } catch (e) {
                                  setState(() {
                                    message = e.toString();
                                    isError = true;
                                  });
                                }
                              }
                            },
                          ),
                        ),
                      ),
                      InkWell(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                            TextSpan(
                                text: "Sign In",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    decoration: TextDecoration.underline)),
                          ]),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, "/login");
                        },
                      ),
                      Text("OR",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          )),
                      Text("Login with",
                          style: TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                          )),
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
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(7.0),
                                    ),
                                    primary: Color.fromRGBO(221, 75, 57, 1),
                                    onPrimary: Theme.of(context).disabledColor,
                                  ),
                                  onPressed: () {
                                    UserApi()
                                        .loginWithGoogle()
                                        .then((response) {
                                      loginResponse(response);
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                      borderRadius:
                                          new BorderRadius.circular(7.0),
                                    ),
                                    primary: Color.fromRGBO(59, 89, 152, 1),
                                    onPrimary: Theme.of(context).disabledColor,
                                  ),
                                  onPressed: () async {
                                    await UserApi()
                                        .loginWithFacebook()
                                        .then((response) {
                                      loginResponse(response);
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                          //             borderRadius:
                          //                 new BorderRadius.circular(7.0),
                          //           ),
                          //           primary: Color.fromRGBO(24, 23, 23, 1),
                          //           onPrimary: Theme.of(context).disabledColor,
                          //         ),
                          //         onPressed: () {},
                          //         child: Row(
                          //           mainAxisAlignment:
                          //               MainAxisAlignment.spaceEvenly,
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
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textInput({controller, hint, icon}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextField(
          obscureText:
              hint == "Password" || hint == "Confirm Password" ? true : false,
          controller: controller,
          decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Material(
                elevation: 0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Icon(
                  icon,
                  color: Color.fromRGBO(255, 136, 25, 1),
                ),
              ),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 13))),
    );
  }

  _signUpDialogue(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                'A verification email has been sent to you email address, please verify your email to login to the app'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                  Navigator.pop(context);
                },
                child: Text(
                  'Continue',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 165, 81, 1), fontSize: 17),
                ),
              ),
            ],
          );
        });
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
        await storage.write(key: 'token', value: response['token']);
        await storage.write(key: 'loginStatus', value: 'true');
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

class HeaderContainer extends StatelessWidget {
  final text;

  HeaderContainer(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(44, 52, 155, 1),
            Color.fromRGBO(76, 45, 141, 1),
            Color.fromRGBO(97, 39, 131, 1),
          ], end: Alignment.bottomCenter, begin: Alignment.topCenter),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: 20,
              right: 20,
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
          Center(
              child: Text(
            'FBPIDI',
            style: TextStyle(color: Colors.white, fontSize: 35),
          )
              // Image.asset(
              //   "assets/frontpages/images/brand/logo2.png",
              //   height: 300,
              //   width: 300,
              // ),
              ),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final btnText;
  final onClick;

  ButtonWidget({this.btnText, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 136, 25, 1),
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          btnText,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
