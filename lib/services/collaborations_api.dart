import 'package:fbpidi/models/announcement.dart';
import 'package:fbpidi/models/blog.dart';
import 'package:fbpidi/models/event.dart';
import 'package:fbpidi/models/forum.dart';
import 'package:fbpidi/models/jobcategory.dart';
import 'package:fbpidi/models/news.dart';
import 'package:fbpidi/models/poll.dart';
import 'package:fbpidi/models/project.dart';
import 'package:fbpidi/models/research.dart';
import 'package:fbpidi/models/researchCategory.dart';
import 'package:fbpidi/models/tender.dart';
import 'package:fbpidi/models/vacancy.dart';
import 'package:fbpidi/strings/strings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CollaborationsApi {
  String baseUrl = Strings().baseUrl;

  //Get all projects
  Future<List<Project>> getProjects() async {
    try {
      var response = await http.get(
          Uri.encodeFull(
              "$baseUrl/api/collaborations/projects_list/"), //uri of api
          headers: {"Accept": "application/json"});

      Map<dynamic, dynamic> data = jsonDecode(response.body);
      print(data); //Response from the api
      List<Project> projects = [];
      data['projects'].forEach((project) {
        projects.add(Project.fromMap(project));
      });
      return projects;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  //Get all researches
  Future<List<Research>> getResearches() async {
    try {
      var response = await http.get(
          Uri.encodeFull(
              "$baseUrl/api/collaborations/research_list/"), //uri of api
          headers: {"Accept": "application/json"});

      Map<dynamic, dynamic> data = jsonDecode(response.body);
      // print(data); //Response from the api
      List<Research> researches = [];
      data['researchs'].forEach((research) {
        researches.add(Research.fromMap(research));
      });
      return researches;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  ///Pass an id of a research to get the detail
  Future<Research> getResearchDetail(id) async {
    try {
      var response = await http.get(
          Uri.encodeFull(
              "$baseUrl/api/collaborations/research_detail/?id=$id"), //uri of api
          headers: {"Accept": "application/json"});

      Map<String, dynamic> data = jsonDecode(response.body);
      // print(data); //Response from the api
      Research research = Research.fromMap(data["research"]);

      return research;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  //Get research category
  Future<List<ResearchCategory>> getResearchCategory() async {
    try {
      final storage = new FlutterSecureStorage();
      String token = await storage.read(key: 'token');

      var response = await http.get(
          Uri.encodeFull(
              "$baseUrl/api/collaborations/create_research"), //uri of api
          headers: {"Authorization": "Token " + token});

      List<ResearchCategory> categories = [];

      Map<String, dynamic> data = jsonDecode(response.body);

      data['category'].forEach((category) {
        categories.add(ResearchCategory.fromMap(category));
      });
      return categories;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  //research registration
  Future<dynamic> addResearch(Research research, String path) async {
    // Map<dynamic, dynamic> data = {
    //   "title": research.title,
    //   "status": research.status,
    //   "category": research.category,
    //   "description": research.description,
    // };
    var response;
    try {
      var uri = Uri.parse("$baseUrl/api/collaborations/create_research/");
      var request = http.MultipartRequest('POST', uri);
      print('data is the following ***** = ' +
          research.title +
          ' ' +
          research.status +
          ' ' +
          research.category +
          ' ' +
          research.description +
          ' ' +
          path);
      request.files
          .add(await http.MultipartFile.fromPath('attachements', path));
      request.fields['title'] = research.title;
      request.fields['status'] = research.status;
      request.fields['category'] = research.category;
      request.fields['description'] = research.description;
      // request.fields['detail'] = research.detail;
      final storage = new FlutterSecureStorage();
      String token = await storage.read(key: 'token');

      request.headers['Authorization'] = "Token " + token;

      response = await request.send();
      print("about to decode response /////////");
      final respStr = await response.stream.bytesToString();
      // Map<dynamic, dynamic> data2 = jsonDecode(response);
      print("******" + respStr + "is the response *****");
      return respStr;

      // response = await http.post(
      //   Uri.encodeFull(
      //       "$baseUrl/api/collaborations/create_research"), //uri of api
      //   headers: {
      //     "Authorization": "application/json",
      //   },
      //   body: jsonEncode(data),
      // );
    } catch (e) {
      print(e.toString() + 'has occured ****');
    }
  }

  //Get all vacancies
  Future<List<Vacancy>> getVacancies() async {
    try {
      var response = await http.get(
          Uri.encodeFull(
              "$baseUrl/api/collaborations/vacancy_list/"), //uri of api
          headers: {"Accept": "application/json"});

      Map<dynamic, dynamic> data = jsonDecode(response.body);
      print(data); //Response from the api
      List<Vacancy> vacancies = [];
      data['vacancies'].forEach((vacancy) {
        vacancies.add(Vacancy.fromMap(vacancy));
      });
      return vacancies;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception(e);
    }
  }

  //Get all vacancies
  Future<List<dynamic>> getCategories() async {
    try {
      var response = await http.get(
          Uri.encodeFull(
              "$baseUrl/api/collaborations/vacancy_list/"), //uri of api
          headers: {"Accept": "application/json"});

      Map<dynamic, dynamic> data = jsonDecode(response.body);
      print(data); //Response from the api

      return data['jobcategory'];
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception(e);
    }
  }

  ///Pass an id of a vacancy to get the detail
  Future<Vacancy> getVacancyDetail(id) async {
    try {
      var response = await http.get(
          Uri.encodeFull(
              "$baseUrl/api/collaborations/vacancy_detail/?id=$id"), //uri of api
          headers: {"Accept": "application/json"});

      Map<String, dynamic> data = jsonDecode(response.body);
      print(data); //Response from the api
      Vacancy vacancy = Vacancy.fromMap(data["vacancy"]);

      return vacancy;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  Future<Map<String, dynamic>> getJobCategory() async {
    try {
      var response = await http.get(
          Uri.encodeFull(
              "$baseUrl/api/collaborations/vacancy_list/"), //uri of api
          headers: {"Accept": "application/json"});

      Map<dynamic, dynamic> data = jsonDecode(response.body);
      print(data); //Response from the api
      List<Vacancy> vacancies = [];
      data['vacancies'].forEach((vacancy) {
        vacancies.add(Vacancy.fromMap(vacancy));
      });
      List<JobCategory> jobCategories = [];
      data['jobcategory'].forEach((jobCategory) {
        jobCategories.add(JobCategory.fromMap(jobCategory));
      });
      return {'vacancies': vacancies, 'jobCategory': jobCategories};
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception(e);
    }
  }

  //Apply for vacancy
  Future<dynamic> vacancyApply(Map<String, dynamic> userApplying) async {
    var response;
    try {
      var uri = Uri.parse("$baseUrl/api/collaborations/vacancy_apply/");
      var request = http.MultipartRequest('POST', uri);
      request.files
          .add(await http.MultipartFile.fromPath('CV', userApplying['CV']));
      request.files.add(await http.MultipartFile.fromPath(
          'Documents', userApplying['Documents']));
      request.fields['id'] = userApplying['id'];
      request.fields['institiute'] = userApplying['institiute'];
      request.fields['grade'] = userApplying['grade'];
      request.fields['field'] = userApplying['field'];
      request.fields['status'] = userApplying['status'];
      request.fields['bio'] = userApplying['bio'];
      request.fields['experience'] = userApplying['experience'];

      final storage = new FlutterSecureStorage();
      String token = await storage.read(key: 'token');

      request.headers['Authorization'] = "Token " + token;

      response = await request.send();
      print("about to decode response /////////");
      final respStr = await response.stream.bytesToString();
      // Map<dynamic, dynamic> data2 = jsonDecode(response);
      print("******" + respStr + "is the response *****");
      return respStr;
    } catch (e) {
      print(e.toString() + 'has occured ****');
    }
    Map<dynamic, dynamic> data2 = jsonDecode(response.body);
    print(data2);
    return data2;
  }

  //Get all tenders
  Future<List<Tender>> getTenders() async {
    try {
      var response = await http.get(
          Uri.encodeFull(
              "$baseUrl/api/collaborations/tender_list/"), //uri of api
          headers: {"Accept": "application/json"});

      Map<dynamic, dynamic> data = jsonDecode(response.body);
      print(data); //Response from the api
      List<Tender> tenders = [];
      data['tenders'].forEach((tender) {
        tenders.add(Tender.fromMap(tender));
      });
      return tenders;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  ///Pass an id of a tender to get the detail
  Future<Tender> getTenderDetail(id) async {
    try {
      var response = await http.get(
          Uri.encodeFull(
              "$baseUrl/api/collaborations/tender_detail/?id=$id"), //uri of api
          headers: {"Accept": "application/json"});

      Map<String, dynamic> data = jsonDecode(response.body);
      print(data); //Response from the api
      Tender tender = Tender.fromMap(data["tender"]);

      return tender;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  //Get all forums
  Future<List<Forum>> getForums() async {
    try {
      var response = await http.get(
          Uri.encodeFull(
              "$baseUrl/api/collaborations/forum_list/"), //uri of api
          headers: {"Accept": "application/json"});

      Map<dynamic, dynamic> data = jsonDecode(response.body);
      print(data); //Response from the api
      List<Forum> forums = [];
      data['forums'].forEach((forum) {
        forums.add(Forum.fromMap(forum));
      });
      return forums;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  ///Pass an id of a forum to get the detail
  Future<Forum> getForumDetail(id) async {
    try {
      var response = await http.get(
          Uri.encodeFull(
              "$baseUrl/api/collaborations/forum_detail/?id=$id"), //uri of api
          headers: {"Accept": "application/json"});

      Map<String, dynamic> data = jsonDecode(response.body);
      print(data); //Response from the api
      Forum forum = Forum.fromMap(data["forum"]);

      return forum;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  //Get all polls
  Future<List<Poll>> getPolls() async {
    var response = await http
        .get(Uri.encodeFull("$baseUrl/api/collaborations/polls/"), //uri of api
            headers: {"Accept": "application/json"});

    Map<dynamic, dynamic> data = jsonDecode(response.body);

    List<Poll> polls = [];
    data["polls"].forEach((poll) {
      polls.add(Poll.fromMap(poll));
    });
    return polls;
  }

  //Get poll detail
  Future<Poll> getPollDetail(id) async {
    var response = await http.get(
        Uri.encodeFull(
            "$baseUrl/client/collaborations/poll_detail/$id/"), //uri of api
        headers: {
          "Authorization Token": "99b43761704f6994a5bd6cd0fc93b1f542db5e73"
        });

    //ToDo - add token into the api call

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data); //Response from the api
    Poll poll = Poll.fromMap(data["data"]);

    return poll;
  }

  //vote for a specific poll
  voteForAPoll(id, selectedChoice, remark) async {
    var response = await http.get(
        Uri.encodeFull(
            "http://127.0.0.1:8000/client/collaborations/poll_detail/$id/?selected_choice=$selectedChoice&remark=$remark"), //uri of api
        headers: {
          "Authorization Token": "99b43761704f6994a5bd6cd0fc93b1f542db5e73"
        });

    //ToDo - add token into the api call

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data); //Response from the api

    return data;
  }

//Get list of news
  Future<List<News>> getNews() async {
    var response = await http
        .get(Uri.encodeFull("$baseUrl/api/collaborations/news/"), //uri of api
            headers: {"Accept": "application/json"});

    Map<dynamic, dynamic> data = jsonDecode(response.body);
    print(data); //Response from the api
    List<News> newsList = [];
    data['news_list'].forEach((news) {
      newsList.add(News.fromMap(news));
    });
    return newsList;
  }

  //Get news detail
  Future<News> getNewsDetail(id) async {
    var response = await http.get(
        Uri.encodeFull(
            "$baseUrl/api/collaborations/news_detail/?id=$id"), //uri of api
        headers: {"Accept": "application/json"});

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data); //Response from the api
    News news = News.fromMap(data['news']);

    return news;
  }

//Get list of events
  Future<List<Event>> getEvents() async {
    try {
      var response = await http.get(
          Uri.encodeFull("$baseUrl/api/collaborations/events/"), //uri of api
          headers: {"Accept": "application/json"});

      Map<String, dynamic> data = jsonDecode(response.body);
      print(data); //Response from the api
      List<Event> events = [];
      data["event_list"].forEach((event) {
        events.add(Event.fromMap(event));
      });
      return events;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  ///Pass an id of an event to get the detail
  Future<Event> getEventDetail(id) async {
    try {
      var response = await http.get(
          Uri.encodeFull(
              "$baseUrl/api/collaborations/event_detail/?id=$id"), //uri of api
          headers: {"Accept": "application/json"});

      Map<String, dynamic> data = jsonDecode(response.body);
      print(data); //Response from the api
      Event event = Event.fromMap(data["event"]);

      return event;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  //Notify for event
  notifyForEvent(id, email, notifyIn) async {
    var response = await http.post(
        Uri.encodeFull(
            "http://127.0.0.1:8000/client/collaborations/event_notify/22/"), //uri of api
        headers: {"Accept": "application/json"},
        body: {"email": email, "notify_in": notifyIn});

    return response.body;
  }

  //Get all announcements
  Future<List<Announcement>> getAnnuoncement() async {
    try {
      var response = await http.get(
          Uri.encodeFull(
              "$baseUrl/api/collaborations/announcement-list/"), //uri of api
          headers: {"Accept": "application/json"});

      Map<dynamic, dynamic> data = jsonDecode(response.body);
      // print(data); //Response from the api
      List<Announcement> announcements = [];
      data['object_list'].forEach((announcement) {
        announcements.add(Announcement.fromMap(announcement));
      });
      return announcements;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  ///Pass an id of a announcement to get the detail
  Future<Announcement> getAnnouncementDetail(id) async {
    try {
      var response = await http.get(
          Uri.encodeFull(
              "$baseUrl/api/collaborations/announcement-detail/?id=$id"), //uri of api
          headers: {"Accept": "application/json"});

      Map<String, dynamic> data = jsonDecode(response.body);
      // print(data); //Response from the api
      Announcement announcement = Announcement.fromMap(data["announcement"]);

      return announcement;
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception('Unable to Connect to Server');
    }
  }

  //Get list of blogs
  Future<List<Blog>> getBlogs() async {
    var response = await http.get(
        Uri.encodeFull("$baseUrl/api/collaborations/blog-list/"), //uri of api
        headers: {"Accept": "application/json"});

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data); //Response from the api
    List<Blog> blogs = [];
    data["blogs"].forEach((blog) {
      blogs.add(Blog.fromMap(blog));
    });
    return blogs;
  }

  //Get blog detail
  Future<Blog> getBlogDetail(id) async {
    var response = await http.get(
        Uri.encodeFull(
            "$baseUrl/api/collaborations/blog-details/?id=$id"), //uri of api
        headers: {"Accept": "application/json"});

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data); //Response from the api
    Blog blog = Blog.fromMap(data["blog"]);
    //todo: return comments for the blog using a map<String, dynamic> and combining with the blog
    return blog;
  }

  //Comment on a blog
  commentOnBlog(id, content) async {
    var response = await http.post(
        Uri.encodeFull(
            " http://127.0.0.1:8000/client/collaborations/blog-comment/ "), //uri of api
        headers: {"Accept": "application/json"},
        body: {"id": id, "content": content});

    return response.body;
  }
}
