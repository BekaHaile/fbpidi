import 'package:fbpidi/widgets/screens/all_categories.dart';
import 'package:fbpidi/widgets/screens/collaborations/add_forum.dart';
import 'package:fbpidi/widgets/screens/collaborations/add_research.dart';
import 'package:fbpidi/widgets/screens/collaborations/announcement_detail.dart';
import 'package:fbpidi/widgets/screens/collaborations/announcements.dart';
import 'package:fbpidi/widgets/screens/collaborations/blog_detail.dart';
import 'package:fbpidi/widgets/screens/collaborations/blogs.dart';
import 'package:fbpidi/widgets/screens/collaborations/events.dart';
import 'package:fbpidi/widgets/screens/collaborations/event_detail.dart';
import 'package:fbpidi/widgets/screens/collaborations/faqs.dart';
import 'package:fbpidi/widgets/screens/collaborations/forum_detail.dart';
import 'package:fbpidi/widgets/screens/collaborations/forums.dart';
import 'package:fbpidi/widgets/screens/collaborations/news_detail.dart';
import 'package:fbpidi/widgets/screens/collaborations/news_page.dart';
import 'package:fbpidi/widgets/screens/collaborations/poll_detail.dart';
import 'package:fbpidi/widgets/screens/collaborations/polls.dart';
import 'package:fbpidi/widgets/screens/collaborations/projects.dart';
import 'package:fbpidi/widgets/screens/collaborations/projects_detail.dart';
import 'package:fbpidi/widgets/screens/collaborations/research_detail.dart';
import 'package:fbpidi/widgets/screens/collaborations/researches.dart';
import 'package:fbpidi/widgets/screens/collaborations/tender_detail.dart';
import 'package:fbpidi/widgets/screens/collaborations/tenders.dart';
import 'package:fbpidi/widgets/screens/collaborations/vacancies.dart';
import 'package:fbpidi/widgets/screens/collaborations/vacancy_apply.dart';
import 'package:fbpidi/widgets/screens/collaborations/vacancy_detail.dart';
import 'package:fbpidi/widgets/screens/company_and_product/company_detail.dart';
import 'package:fbpidi/widgets/screens/company_and_product/company_list.dart';
import 'package:fbpidi/widgets/screens/company_and_product/contact_us.dart';
import 'package:fbpidi/widgets/screens/company_and_product/product_detail.dart';
import 'package:fbpidi/widgets/screens/company_and_product/products.dart';
import 'package:fbpidi/widgets/screens/credential/login.dart';
import 'package:fbpidi/widgets/screens/credential/signUp.dart';
import 'package:fbpidi/widgets/screens/home_menu.dart';
import 'package:fbpidi/widgets/screens/inquiry/inquiry_form.dart';
import 'package:fbpidi/widgets/screens/products_page.dart';
import 'package:fbpidi/widgets/screens/profile/chat_detail.dart';
import 'package:fbpidi/widgets/screens/profile/profile.dart';
import 'package:fbpidi/widgets/screens/profile/chats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final storage = new FlutterSecureStorage();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FBPIDI',
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromRGBO(235, 240, 243, 1),
          primaryColor: Color.fromRGBO(16, 70, 176, 1),
          highlightColor: Color.fromRGBO(16, 70, 176, 0.7),
          // highlightColor: Color.fromRGBO(253, 130, 14, 1),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          buttonColor: Color.fromRGBO(253, 130, 14, 1),
          disabledColor: Color.fromRGBO(253, 130, 14, 0.3),
        ),
        home: Center(
          child: SplashScreen(
            seconds: 3,
            navigateAfterSeconds: FutureBuilder<bool>(
                future: storage.containsKey(key: "loginStatus"),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  else {
                    bool containsKey = snapshot.data;
                    print(containsKey);
                    if (!containsKey) writeStatus();

                    return Home();
                  }
                }),
            title: Text(
              'Food, Beverage and Pharmaceutical Industries Development Institute',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            image: Image.asset('assets/fbpidi.png'),
            backgroundColor: Colors.white,
            styleTextUnderTheLoader: TextStyle(),
            photoSize: 100.0,
            useLoader: false,
          ),
        ),
        routes: {
          '/homePage': (BuildContext context) => Home(),
          '/signUp': (BuildContext context) => SignUp(),
          '/announcements': (BuildContext context) => Announcements(),
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
          '/profile': (BuildContext context) => Profile(),
          '/faqs': (BuildContext context) => Faqs(),
          '/chats': (BuildContext context) => ChatList(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final requests = settings.arguments;

          switch (settings.name) {
            case '/allCategories':
              return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) => AllCategories(
                        requests,
                      ));
            case '/login':
              return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) => LoginPage(
                        data: requests,
                      ));
            case '/productsPage':
              return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) => ProductsPage(
                        requests,
                      ));
            case '/companies':
              return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) => CompanyPage(
                        requests,
                      ));
            case '/products':
              return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) => Products(
                        requests,
                      ));
            case '/productDetail':
              return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) => ProductDetail(
                        requests,
                      ));
            case '/projectDetail':
              return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) => ProjectDetial(
                        requests,
                      ));
            case '/companyDetail':
              return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) => CompanyDetail(
                        requests,
                      ));
            case '/eventDetail':
              return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) => EventDetail(
                        requests,
                      ));
            case '/newsDetail':
              return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) => NewsDetail(
                        requests,
                      ));
            case '/tenderDetail':
              return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) => TenderDetail(
                        requests,
                      ));
            case '/vacancyDetail':
              return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) => VacancyDetail(
                        requests,
                      ));
            case '/forumDetail':
              return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) => ForumDetail(
                        requests,
                      ));
            case '/blogDetail':
              return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) => BlogDetail(
                        requests,
                      ));
            case '/researchDetail':
              return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) => ResearchDetail(
                        requests,
                      ));
            case '/announcementDetail':
              return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) => AnnouncementDetail(
                        requests,
                      ));
            case '/vacancyApply':
              return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) => VacancyApply(
                        requests,
                      ));
            case '/pollDetail':
              return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) => PollDetail(
                        requests,
                      ));
            case '/contactUs':
              return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) => ContactUs(
                        requests,
                      ));
            case '/inquire':
              return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) => InquiryForm(
                        requests,
                      ));
            case '/addForum':
              return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) => AddForum(
                        requests,
                      ));
            case '/chats_detail':
              return MaterialPageRoute(builder: (_) => ChatDetail(requests));
            default:
              return null;
          }
        });
  }

  writeStatus() async {
    try {
      await storage.write(key: 'loginStatus', value: 'false');
    } catch (e) {
      print("Exception: " + e.toString());
    }
  }
}
