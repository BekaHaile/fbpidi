class Research {
  String id;
  String categoryName;
  String title;
  String accepted;
  String description;
  String detail;
  String createdDate;
  List<dynamic> attachements;
  String createdBy;
  String status;
  String category;
  String lastUpdatedDate;
  String lastUpdatedBy;
  bool expired;
  String company;

  Research(
      {this.id,
      this.categoryName,
      this.title,
      this.accepted,
      this.description,
      this.detail,
      this.createdDate,
      this.attachements,
      this.createdBy,
      this.status,
      this.category,
      this.expired,
      this.lastUpdatedDate,
      this.lastUpdatedBy,
      this.company});

  Research.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    categoryName = map["category_name"].toString();
    title = map["title"].toString();
    accepted = map["accepted"].toString();
    description = map["description"].toString();
    detail = map["detail"].toString();
    createdDate = map["created_date"].toString();
    attachements = map["attachements"];
    createdBy = map["created_by"].toString();
    status = map["status"].toString();
    category = map["category"].toString();
    expired = map['expired'];
    lastUpdatedDate = map['last_updated_date'].toString();
    lastUpdatedBy = map['last_updated_by'].toString();
    company = map['company'].toString();
  }
}
