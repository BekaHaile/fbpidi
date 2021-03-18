class Event {
  String id;
  String image;
  Map<String, dynamic> companyInfo;
  String title;
  String titleAm;
  String description;
  String descriptionAm;
  String createdDate;
  String startDate;
  String endDate;
  String status;
  String company;
  String lastUpdatedDate;
  String expired;
  String lastUpdatedBy;

  Event(
      {this.id,
      this.image,
      this.companyInfo,
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

  Event.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    image = map["image"].toString();
    companyInfo = map["company_info"];
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
    company = map["company"].toString();
    lastUpdatedBy = map["last_updated_by"].toString();
  }
}
