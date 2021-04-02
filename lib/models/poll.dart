import 'package:fbpidi/models/company.dart';

class Poll {
  String id;
  String title;
  String titleAm;
  String totalVotes;
  String noOfChoices;
  String noOfVotes;
  Company company;
  Map<String, dynamic> createdBy;
  String createdDate;
  List<dynamic> choices;
  String description;
  String descriptionAm;
  String lastUpdatedDate;
  bool expired;
  String lastUpdatedBy;

  Poll(
      {this.id,
      this.title,
      this.titleAm,
      this.totalVotes,
      this.noOfChoices,
      this.company,
      this.createdBy,
      this.createdDate,
      this.choices,
      this.description,
      this.descriptionAm,
      this.noOfVotes,
      this.expired,
      this.lastUpdatedBy,
      this.lastUpdatedDate});

  Poll.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    title = map["title"].toString();
    titleAm = map["title_am"].toString();
    totalVotes = map["total_votes"].toString();
    noOfChoices = map["no_of_choices"].toString();
    company = map["company_info"];
    createdDate = map["created_date"].toString();
    createdBy = map["created_by"];
    choices = map["choices"]; //should have a class of its own
    description = map["description"].toString();
    descriptionAm = map["description_am"].toString();
    noOfVotes = map['no_of_votes'].toString();
    lastUpdatedDate = map['last_updated_date'].toString();
    expired = map['expired'];
    lastUpdatedBy = map['last_updated_by'].toString();
  }
}
