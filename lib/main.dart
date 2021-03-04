import 'package:fbpidi/widgets/screens/all_categories.dart';
import 'package:fbpidi/widgets/screens/collaborations/blog.dart';
import 'package:fbpidi/widgets/screens/collaborations/events.dart';
import 'package:fbpidi/widgets/screens/collaborations/forums.dart';
import 'package:fbpidi/widgets/screens/collaborations/news.dart';
import 'package:fbpidi/widgets/screens/collaborations/polls.dart';
import 'package:fbpidi/widgets/screens/collaborations/projects.dart';
import 'package:fbpidi/widgets/screens/collaborations/tenders.dart';
import 'package:fbpidi/widgets/screens/collaborations/vacancies.dart';
import 'package:fbpidi/widgets/screens/credential/login.dart';
import 'package:fbpidi/widgets/screens/credential/signUp.dart';
import 'package:fbpidi/widgets/screens/home_menu.dart';
import 'package:fbpidi/widgets/screens/products_page.dart';
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
          highlightColor: Color.fromRGBO(16, 70, 176, 0.7),
          // highlightColor: Color.fromRGBO(253, 130, 14, 1),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          buttonColor: Color.fromRGBO(253, 130, 14, 1),
          disabledColor: Color.fromRGBO(253, 130, 14, 0.3),
        ),
        home: Home(),
        routes: {
          '/homePage': (BuildContext context) => HomePage(),
          '/signUp': (BuildContext context) => SignUp(),
          '/login': (BuildContext context) => LoginPage(),
          '/blogs': (BuildContext context) => Blog(),
          '/forums': (BuildContext context) => Forum(),
          '/news': (BuildContext context) => News(),
          '/polls': (BuildContext context) => Polls(),
          '/tenders': (BuildContext context) => Tenders(),
          '/vacancies': (BuildContext context) => Vacancies(),
          '/events': (BuildContext context) => Events(),
          '/projects': (BuildContext context) => Projects(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final requests = settings.arguments;

          switch (settings.name) {
            case '/allCategories':
              return MaterialPageRoute(
                  builder: (_) => AllCategories(
                        requests,
                      ));
            case '/products':
              return MaterialPageRoute(
                  builder: (_) => ProductsPage(
                        requests,
                      ));
            default:
              return null;
          }
        });
  }
}
