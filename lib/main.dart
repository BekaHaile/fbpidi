import 'package:fbpidi/widgets/screens/credential/login.dart';
import 'package:fbpidi/widgets/screens/credential/signUp.dart';
import 'package:fbpidi/widgets/screens/homeMenu.dart';
import 'package:fbpidi/widgets/screens/products.dart';
import 'package:fbpidi/widgets/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromRGBO(235, 240, 243, 1),
          primaryColor: Color.fromRGBO(16, 70, 176, 1),
          highlightColor: Color.fromRGBO(253, 130, 14, 1),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          buttonColor: Color.fromRGBO(253, 130, 14, 1),
          disabledColor: Color.fromRGBO(253, 130, 14, 0.3),
        ),
        home: Home(),
        routes: {
          '/homePage': (BuildContext context) => HomePage(),
          '/products': (BuildContext context) => ProductsPage(),
          '/signUp': (BuildContext context) => SignUp(),
          '/login': (BuildContext context) => LoginPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          // final requests = settings.arguments;

          switch (settings.name) {
            // case '/phoneNo':
            //   return MaterialPageRoute(
            //       builder: (_) => PhoneNo(
            //             type: requests,
            //           ));
            default:
              return null;
          }
        });
  }
}
