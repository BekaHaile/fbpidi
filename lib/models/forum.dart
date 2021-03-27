class Forum {
  String id;
  String noOfComments;
  String title;
  List commentsList;
  String description;
  String detail;
  String createdDate;
  String attachements;
  String createdBy;
  String lastUpdatedDate;
  String expired;
  String lastUpdatedBy;
  Forum(
      {this.id,
      this.noOfComments,
      this.title,
      this.commentsList,
      this.description,
      this.detail,
      this.createdDate,
      this.attachements,
      this.createdBy,
      this.lastUpdatedDate,
      this.expired,
      this.lastUpdatedBy});

  Forum.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    noOfComments = map["no_of_comments"].toString();
    title = map["title"].toString();
    commentsList = map["comments_list"];
    description = map["description"].toString();
    detail = map["detail"].toString();
    createdDate = map["created_date"].toString();
    attachements = map["attachements"].toString();
    createdBy = map["created_by"].toString();
    lastUpdatedDate = map["last_updated_date"].toString();
    expired = map["expired"].toString();
    lastUpdatedBy = map["last_updated_by"].toString();
  }
}
