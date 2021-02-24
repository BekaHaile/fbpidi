class Comment {
  String id;
  String content;
  String timestamp;
  String blog;
  String sender;

  Comment({this. id,
  this. content,
  this. timestamp,
  this. blog,
  this. sender,
  });

  Comment.fromMap(Map<dynamic, dynamic> map){
     id = map["id"];
   content = map["content"];
   timestamp = map["timestamp"];
   blog = map["blog"];
   sender = map["sender"];
  }

}
