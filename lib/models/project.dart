class Project {
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
  Project({
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

  Project.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"];
    categoryName = map["category_name"];
    title = map["title"];
    accepted = map["accepted"];
    description = map["description"];
    detail = map["detail"];
    timeStamp = map["time_stamp"];
    attachements = map["attachements"];
    user = map["user"];
    status = map["status"];
    category = map["category"];
  }
}
