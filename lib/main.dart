import 'package:fbpidi/widgets/screens/all_categories.dart';
import 'package:fbpidi/widgets/screens/collaborations/add_research.dart';
import 'package:fbpidi/widgets/screens/collaborations/blog_detail.dart';
import 'package:fbpidi/widgets/screens/collaborations/blogs.dart';
import 'package:fbpidi/widgets/screens/collaborations/events.dart';
import 'package:fbpidi/widgets/screens/collaborations/event_detail.dart';
import 'package:fbpidi/widgets/screens/collaborations/forum_detail.dart';
import 'package:fbpidi/widgets/screens/collaborations/forums.dart';
import 'package:fbpidi/widgets/screens/collaborations/news_detail.dart';
import 'package:fbpidi/widgets/screens/collaborations/news_page.dart';
import 'package:fbpidi/widgets/screens/collaborations/polls.dart';
import 'package:fbpidi/widgets/screens/collaborations/projects.dart';
import 'package:fbpidi/widgets/screens/collaborations/research_detail.dart';
import 'package:fbpidi/widgets/screens/collaborations/researches.dart';
import 'package:fbpidi/widgets/screens/collaborations/tender_detail.dart';
import 'package:fbpidi/widgets/screens/collaborations/tenders.dart';
import 'package:fbpidi/widgets/screens/collaborations/vacancies.dart';
import 'package:fbpidi/widgets/screens/collaborations/vacancy_apply.dart';
import 'package:fbpidi/widgets/screens/collaborations/vacancy_detail.dart';
import 'package:fbpidi/widgets/screens/company_and_product/company_detail.dart';
import 'package:fbpidi/widgets/screens/company_and_product/company_list.dart';
import 'package:fbpidi/widgets/screens/company_and_product/product_detail.dart';
import 'package:fbpidi/widgets/screens/company_and_product/products.dart';
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
          '/blogs': (BuildContext context) => Blogs(),
          '/forums': (BuildContext context) => Forums(),
          '/news': (BuildContext context) => NewsPage(),
          '/polls': (BuildContext context) => Polls(),
          '/tenders': (BuildContext context) => Tenders(),
          '/vacancies': (BuildContext context) => Vacancies(),
          '/events': (BuildContext context) => Events(),
          '/projects': (BuildContext context) => Projects(),
          '/researches': (BuildContext context) => Researches(),
          '/addResearch': (BuildContext context) => AddResearch(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final requests = settings.arguments;

          switch (settings.name) {
            case '/allCategories':
              return MaterialPageRoute(
                  builder: (_) => AllCategories(
                        requests,
                      ));
            case '/productsPage':
              return MaterialPageRoute(
                  builder: (_) => ProductsPage(
                        requests,
                      ));
            case '/companies':
              return MaterialPageRoute(
                  builder: (_) => CompanyPage(
                        requests,
                      ));
            case '/products':
              return MaterialPageRoute(
                  builder: (_) => Products(
                        requests,
                      ));
            case '/productDetail':
              return MaterialPageRoute(
                  builder: (_) => ProductDetail(
                        requests,
                      ));
            case '/companyDetail':
              return MaterialPageRoute(
                  builder: (_) => CompanyDetail(
                        requests,
                      ));
            case '/eventDetail':
              return MaterialPageRoute(
                  builder: (_) => EventDetail(
                        requests,
                      ));
            case '/newsDetail':
              return MaterialPageRoute(
                  builder: (_) => NewsDetail(
                        requests,
                      ));
            case '/tenderDetail':
              return MaterialPageRoute(
                  builder: (_) => TenderDetail(
                        requests,
                      ));
            case '/vacancyDetail':
              return MaterialPageRoute(
                  builder: (_) => VacancyDetail(
                        requests,
                      ));
            case '/forumDetail':
              return MaterialPageRoute(
                  builder: (_) => ForumDetail(
                        requests,
                      ));
            case '/blogDetail':
              return MaterialPageRoute(
                  builder: (_) => BlogDetail(
                        requests,
                      ));
            case '/researchDetail':
              return MaterialPageRoute(
                  builder: (_) => ResearchDetail(
                        requests,
                      ));
            case '/vacancyApply':
              return MaterialPageRoute(
                  builder: (_) => VacancyApply(
                        requests,
                      ));

            default:
              return null;
          }
        });
  }
}
