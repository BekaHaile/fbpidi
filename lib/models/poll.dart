class Poll {
  String id;
  String title;
  String titleAm;
  String totalVotes;
  String noOfChoices;
  Map<String, dynamic> companyInfo;
  String user;
  String timestamp;
  List<dynamic> choices;
  String description;
  String descriptionAm;

  Poll(
      {this.id,
      this.title,
      this.titleAm,
      this.totalVotes,
      this.noOfChoices,
      this.companyInfo,
      this.user,
      this.timestamp,
      this.choices,
      this.description,
      this.descriptionAm});

  Poll.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"];
    title = map["title"];
    titleAm = map["title_am"];
    totalVotes = map["total_votes"];
    noOfChoices = map["no_of_choices"];
    companyInfo = map["company_info"];
    timestamp = map["timestamp"];
    user = map["user"];
    choices = map["choices"]; //should have a class of its own
    description = map["description"];
    descriptionAm = map["description_am"];
  }
}
