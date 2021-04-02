import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 1.2,
            padding: EdgeInsets.only(bottom: 30),
            child: Column(
              children: <Widget>[
                HeaderContainer("Signup For Free"),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        _textInput(hint: "First Name", icon: Icons.person),
                        _textInput(hint: "Last Name", icon: Icons.person),
                        _textInput(hint: "Username", icon: Icons.person),
                        _textInput(hint: "Email", icon: Icons.email),
                        _textInput(hint: "Phone Number", icon: Icons.call),
                        _textInput(hint: "Password", icon: Icons.vpn_key),
                        _textInput(
                            hint: "Confirm Password", icon: Icons.vpn_key),
                        Expanded(
                          child: Center(
                            child: ButtonWidget(
                              btnText: "SIGNUP",
                              onClick: () {
                                Navigator.pop(context);
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
                                  text: "SIGNIN",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(44, 52, 155, 1),
                                  )),
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
                                      onPrimary:
                                          Theme.of(context).disabledColor,
                                    ),
                                    onPressed: () {},
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
                                width: MediaQuery.of(context).size.width * 0.13,
                                height: 50.0,
                                child: SizedBox.expand(
                                  child: ElevatedButton(
                                    key: Key('raised'),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(7.0),
                                      ),
                                      primary: Color.fromRGBO(29, 161, 242, 1),
                                      onPrimary:
                                          Theme.of(context).disabledColor,
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.twitter,
                                          color: Colors.white,
                                          size: 21,
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
                                width: MediaQuery.of(context).size.width * 0.13,
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
                                      onPrimary:
                                          Theme.of(context).disabledColor,
                                    ),
                                    onPressed: () {},
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
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.13,
                                height: 50.0,
                                child: SizedBox.expand(
                                  child: ElevatedButton(
                                    key: Key('raised'),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(7.0),
                                      ),
                                      primary: Color.fromRGBO(24, 23, 23, 1),
                                      onPrimary:
                                          Theme.of(context).disabledColor,
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.gitAlt,
                                          color: Colors.white,
                                          size: 21,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
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
            child: Image.asset(
              "assets/frontpages/images/brand/logo2.png",
              height: 300,
              width: 300,
            ),
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
          gradient: LinearGradient(colors: [
            Color.fromRGBO(44, 52, 155, 1),
            Color.fromRGBO(76, 45, 141, 1),
            Color.fromRGBO(97, 39, 131, 1),
          ], end: Alignment.centerLeft, begin: Alignment.centerRight),
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
