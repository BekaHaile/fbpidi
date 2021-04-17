import 'package:fbpidi/models/company.dart';

class Announcement {
  String id;
  String image;
  String title;
  String titleAm;
  String description;
  String descriptionAm;
  String createdDate;
  String startDate;
  String endDate;
  String status;
  Company company;
  String lastUpdatedDate;
  String expired;
  String lastUpdatedBy;

  Announcement(
      {this.id,
      this.image,
      this.title,
      this.titleAm,
      this.description,
      this.descriptionAm,
      this.createdDate,
      this.startDate,
      this.endDate,
      this.status,
      this.company,
      this.lastUpdatedDate,
      this.expired,
      this.lastUpdatedBy});

  Announcement.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    image = map["image"].toString();
    createdDate = map["created_date"].toString();
    title = map["title"].toString();
    titleAm = map["title_am"].toString();
    description = map["description"].toString();
    descriptionAm = map["description_am"].toString();
    startDate = map["start_date"].toString();
    endDate = map["end_date"].toString();
    status = map["status"].toString();
    lastUpdatedDate = map["last_updated_date"].toString();
    expired = map["expired"].toString();
    company = Company.fromMap(map["company"]);
    lastUpdatedBy = map["last_updated_by"].toString();
  }
}
