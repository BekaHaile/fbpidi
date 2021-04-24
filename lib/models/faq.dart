import 'package:fbpidi/models/company.dart';

class Faq {
  String id;
  Company company;
  String status;
  String answers;
  String answersAm;
  String questions;
  String questionsAm;
  String createdDate;
  bool isActive;
  String createdBy;
  String lastUpdatedDate;
  String expired;
  String lastUpdatedBy;
  Faq(
      {this.id,
      this.company,
      this.status,
      this.answers,
      this.answersAm,
      this.questions,
      this.questionsAm,
      this.createdDate,
      this.isActive,
      this.createdBy,
      this.lastUpdatedDate,
      this.expired,
      this.lastUpdatedBy});

  Faq.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    status = map["status"].toString();
    answers = map["answers"].toString();
    answersAm = map["answers_am"].toString();
    questions = map["questions"].toString();
    questionsAm = map["questions_am"].toString();
    createdDate = map["created_date"].toString();
    isActive = map["is_active"];
    createdBy = map["created_by"].toString();
    lastUpdatedDate = map["last_updated_date"].toString();
    expired = map["expired"].toString();
    lastUpdatedBy = map["last_updated_by"].toString();
  }
}
