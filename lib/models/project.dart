import 'package:fbpidi/models/company.dart';

class Project {
  String id;
  String categoryName;
  String projectName;
  String projectNameAm;
  String geoLocation;

  Company company;
  String image;
  Project(
      {this.id,
      this.categoryName,
      this.projectName,
      this.projectNameAm,
      this.geoLocation,
      this.company,
      this.image});

  Project.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    categoryName = map["category_name"].toString();
    projectName = map["project_name"].toString();
    projectNameAm = map["project_name_am"].toString();
    geoLocation = map["geo_location"].toString();
    company = Company.fromMap(map["company"]);
    image = map["image"].toString();
  }
}
