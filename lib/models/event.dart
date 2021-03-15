class Event {
  String id;
  String image;
  Map<String, dynamic> companyInfo;
  String eventName;
  String eventNameAm;
  String description;
  String descriptionAm;
  String createdDate;
  String startDate;
  String endDate;
  String status;
  String company;

  Event({
    this.id,
    this.image,
    this.companyInfo,
    this.eventName,
    this.eventNameAm,
    this.description,
    this.descriptionAm,
    this.createdDate,
    this.startDate,
    this.endDate,
    this.status,
    this.company,
  });

  Event.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    image = map["image"].toString();
    companyInfo = map["company_info"];
    eventName = map["title"].toString();
    eventNameAm = map["title_am"].toString();
    description = map["description"].toString();
    descriptionAm = map["description_am"].toString();
    createdDate = map["created_date"].toString();
    startDate = map["start_date"].toString();
    endDate = map["end_date"].toString();
    status = map["status"].toString();
    company = map["company"].toString();
  }
}
