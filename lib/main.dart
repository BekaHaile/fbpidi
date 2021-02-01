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
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
        routes: {
          '/homePage': (BuildContext context) => HomePage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final requests = settings.arguments;

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
