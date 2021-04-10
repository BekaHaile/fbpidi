import 'package:fbpidi/models/company.dart';

class Vacancy {
  String id;
  Company company;
  String description;
  String requirement;
  String requirementAm;
  String categoryName;
  String location;
  String salary;
  String employmentType;
  String startingDate;
  String createdDate;
  String endingDate;
  String title;
  String titleAm;
  String descriptionAm;
  String category;
  String closed;
  String lastUpdatedDate;
  String expired;
  String createdBy;
  String lastUpdatedBy;

  Vacancy(
      {this.id,
      this.categoryName,
      this.location,
      this.salary,
      this.employmentType,
      this.startingDate,
      this.createdDate,
      this.endingDate,
      this.title,
      this.titleAm,
      this.category,
      this.closed,
      this.company,
      this.description,
      this.requirement,
      this.descriptionAm,
      this.requirementAm,
      this.lastUpdatedDate,
      this.expired,
      this.createdBy,
      this.lastUpdatedBy});

  Vacancy.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    company = Company.fromMap(map["company"]);
    categoryName = map["category_name"].toString();
    location = map["location"].toString();
    salary = map["salary"].toString();
    employmentType = map["employement_type"].toString();
    startingDate = map["starting_date"].toString();
    createdDate = map["created_date"].toString();
    endingDate = map["ending_date"].toString();
    title = map["title"].toString();
    titleAm = map["title_am"].toString();
    descriptionAm = map["description_am"].toString();
    requirementAm = map["requirementAm"].toString();
    description = map["description"].toString();
    requirement = map["requirement"].toString();
    category = map["category"].toString();
    closed = map["closed"].toString();
    lastUpdatedDate = map["last_updated_date"].toString();
    expired = map["expired"].toString();
    createdBy = map["createdBy"].toString();
    lastUpdatedBy = map["last_updated_by"].toString();
  }
}
