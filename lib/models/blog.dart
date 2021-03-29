class Blog {
  String id;
  String title;
  String titleAm;
  String tag;
  String tagAm;
  String blogImage;
  String content;
  String contentAm;
  String createdDate;
  bool publish;
  String createdBy;
  String lastUpdatedDate;
  bool expired;
  String company;
  String lastUpdatedBy;

  Blog({
    this.id,
    this.title,
    this.titleAm,
    this.tag,
    this.tagAm,
    this.blogImage,
    this.content,
    this.contentAm,
    this.createdDate,
    this.publish,
    this.createdBy,
    this.lastUpdatedDate,
    this.expired,
    this.company,
    this.lastUpdatedBy,
  });

  Blog.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    title = map["title"].toString();
    titleAm = map["title_am"].toString();
    tag = map["tag"].toString();
    tagAm = map["tag_am"].toString();
    blogImage = map["blogImage"].toString();
    content = map["content"].toString();
    contentAm = map["content_am"].toString();
    createdDate = map["created_date"].toString();
    publish = map["publish"];
    createdBy = map["created_by"].toString();
    lastUpdatedDate = map["last_updated_date"].toString();
    expired = map["expired"];
    company = map["company"].toString();
    lastUpdatedBy = map["last_updated_by"].toString();
  }
}
