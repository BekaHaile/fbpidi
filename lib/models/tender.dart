class Tender {
  String id;
  String categoryName;
  String title;
  String accepted;
  String description;
  String detail;
  String timeStamp;
  String attachements;
  String user;
  String status;
  String category;
  Tender({
    this.id,
    this.categoryName,
    this.title,
    this.accepted,
    this.description,
    this.detail,
    this.timeStamp,
    this.attachements,
    this.user,
    this.status,
    this.category,
  });

  Tender.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    categoryName = map["category_name"].toString();
    title = map["title"].toString();
    accepted = map["accepted"].toString();
    description = map["description"].toString();
    detail = map["detail"].toString();
    timeStamp = map["timestamp"].toString();
    attachements = map["attachements"].toString();
    user = map["user"].toString();
    status = map["status"].toString();
    category = map["category"].toString();
  }
}
