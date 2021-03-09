import 'package:fbpidi/models/company.dart';

class Vacancy {
  String id;
  String categoryName;
  String location;
  String salary;
  String employementType;
  String startingDate;
  String timeStamp;
  String endingDate;
  String jobTitle;
  String jobTitleAm;
  String category;
  String closed;
  Company companyInfo;

  Vacancy(
      {this.id,
      this.categoryName,
      this.location,
      this.salary,
      this.employementType,
      this.startingDate,
      this.timeStamp,
      this.endingDate,
      this.jobTitle,
      this.jobTitleAm,
      this.category,
      this.closed,
      this.companyInfo});

  Vacancy.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    categoryName = map["category_name"].toString();
    location = map["title"].toString();
    salary = map["salary"].toString();
    employementType = map["employement_type"].toString();
    startingDate = map["starting_date"].toString();
    timeStamp = map["timestamp"].toString();
    endingDate = map["ending_date"].toString();
    jobTitle = map["job_title"].toString();
    jobTitleAm = map["job_Title_am"].toString();
    category = map["category"].toString();
    closed = map["closed"].toString();
    companyInfo = Company.fromMap(map["company_info"]);
  }
}
