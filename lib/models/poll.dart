import 'package:fbpidi/models/company.dart';

class Poll {
  String id;
  String title;
  String titleAm;
  String noOfChoices;
  String noOfVotes;
  Company company;
  dynamic createdBy;
  String createdDate;
  List<Choice> choices = [];
  String description;
  String descriptionAm;
  String lastUpdatedDate;
  bool expired;
  bool isActive;
  String lastUpdatedBy;

  Poll(
      {this.id,
      this.title,
      this.titleAm,
      this.noOfChoices,
      this.company,
      this.createdBy,
      this.createdDate,
      this.choices,
      this.description,
      this.descriptionAm,
      this.noOfVotes,
      this.expired,
      this.isActive,
      this.lastUpdatedBy,
      this.lastUpdatedDate});

  Poll.fromMap(Map<dynamic, dynamic> map, bool isDetail) {
    id = map["id"].toString();
    title = map["title"].toString();
    titleAm = map["title_am"].toString();
    noOfChoices = map["no_of_choices"].toString();
    company = Company.fromMap(map["company"]);
    createdDate = map["created_date"].toString();
    createdBy = map["created_by"];
    print(map['choices']);
    if (isDetail)
      map['choices'].forEach((choice) {
        choices.add(Choice.fromMap(choice));
      });
    description = map["description"].toString();
    descriptionAm = map["description_am"].toString();
    noOfVotes = map['no_of_votes'].toString();
    lastUpdatedDate = map['last_updated_date'].toString();
    expired = map['expired'];
    isActive = map['is_active'];
    lastUpdatedBy = map['last_updated_by'].toString();
  }
}

class Choice {
  String id;
  String noOfVotes;
  String createdDate;
  String choiceName;
  String choiceNameAm;
  String description;
  String descriptionAm;
  String lastUpdatedDate;
  String expired;
  String createdBy;
  String lastUpdatedBy;

  Choice(
    this.id,
    this.noOfVotes,
    this.createdDate,
    this.choiceName,
    this.choiceNameAm,
    this.description,
    this.descriptionAm,
    this.lastUpdatedDate,
    this.expired,
    this.createdBy,
    this.lastUpdatedBy,
  );

  Choice.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    noOfVotes = map["no_of_votes"].toString();
    createdDate = map["created_date"].toString();
    choiceName = map["choice_name"].toString();
    choiceNameAm = map["choice_name_am"].toString();
    description = map["description"].toString();
    descriptionAm = map["description_am"].toString();
    lastUpdatedDate = map["last_updated_date"].toString();
    expired = map["expired"].toString();
    createdBy = map["created_by"].toString();
    lastUpdatedBy = map["last_updated_by"].toString();
  }
}
