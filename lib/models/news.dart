class News {
  String id;
  List<String> images;
  Map<String, dynamic> companyInfo;
  String title;
  String titleAm;
  String description;
  String descriptionAm;
  String catagory;
  String timestamp;
  String user;

  News({
    this.id,
    this.images,
    this.companyInfo,
    this.title,
    this.titleAm,
    this.description,
    this.descriptionAm,
    this.catagory,
    this.timestamp,
    this.user,
  });

  News.fromMap(Map<dynamic, dynamic> map) {
    id = map["news"]["id"];
    images = map["news"]["images"];
    companyInfo = map["news"]["company_info"];
    title = map["news"]["title"];
    titleAm = map["news"]["title_am"];
    description = map["news"]["description"];
    descriptionAm = map["news"]["description_am"];
    catagory = map["news"]["catagory"];
    timestamp = map["news"]["timestamp"];
    user = map["news"]["user"];
  }
}
