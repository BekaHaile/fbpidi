import 'package:fbpidi/models/company.dart';

class News {
  String id;
  String image;
  Company company;
  String title;
  String titleAm;
  String description;
  String descriptionAm;
  String catagory;
  String createdDate;
  String createdBy;
  String lastUpdatedDate;
  String lastUpdatedBy;
  bool expired;

  News(
      {this.id,
      this.image,
      this.company,
      this.title,
      this.titleAm,
      this.description,
      this.descriptionAm,
      this.catagory,
      this.createdDate,
      this.createdBy,
      this.lastUpdatedDate,
      this.expired,
      this.lastUpdatedBy});

  News.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    image = map["image"].toString();
    company = Company.fromMap(map["company"]);
    title = map["title"].toString();
    titleAm = map["title_am"].toString();
    description = map["description"].toString();
    descriptionAm = map["description_am"].toString();
    catagory = map["catagory"].toString();
    createdDate = map["created_date"].toString();
    createdBy = map["created_by"].toString();
    lastUpdatedDate = map["last_updated_date"].toString();
    lastUpdatedBy = map["last_updated_by"].toString();
    expired = map["expired"];
  }
}
