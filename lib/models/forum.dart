class Forum {
  String id;
  String noOfComments;
  String title;
  List commentsList;
  String description;
  String detail;
  String timeStamp;
  String attachements;
  String user;
  Forum(
      {this.id,
      this.noOfComments,
      this.title,
      this.commentsList,
      this.description,
      this.detail,
      this.timeStamp,
      this.attachements,
      this.user});

  Forum.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    noOfComments = map["no_of_comments"].toString();
    title = map["title"].toString();
    commentsList = map["comments_list"];
    description = map["description"].toString();
    detail = map["detail"].toString();
    timeStamp = map["timestamp"].toString();
    attachements = map["attachements"].toString();
    user = map["user"].toString();
  }
}
