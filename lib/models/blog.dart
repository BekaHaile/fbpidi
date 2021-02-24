class Blog {
  String id;
  String title;
  String titleAm;
  String tag;
  String tagAm;
  String blogImage;
  String content;
  String contentAm;
  String timestamp;
  String publish;
  String user;

  Blog({
    this.id,
    this.title,
    this.titleAm,
    this.tag,
    this.tagAm,
    this.blogImage,
    this.content,
    this.contentAm,
    this.timestamp,
    this.publish,
    this.user,
  });

  Blog.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"];
    title = map["title"];
    titleAm = map["title_am"];
    tag = map["tag"];
    tagAm = map["tag_am"];
    blogImage = map["blogImage"];
    content = map["content"];
    contentAm = map["content_am"];
    timestamp = map["timestamp"];
    publish = map["publish"];
    user = map["user"];
  }
}
