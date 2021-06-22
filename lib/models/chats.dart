import 'dart:convert';

import 'package:flutter/cupertino.dart';

List<Chat> chatsFromJson(String str) =>
    List<Chat>.from(json.decode(str).map((x) => Chat.fromJson(x)));

class Chat {
  String id;
  int senderid;
  int receiverid;
  String sendername;
  String senderimage;
  String senderfullname;
  String receiverfullname;
  String message;
  String receivername;
  String receiverimage;
  String time;
  bool seen;

  Chat({
    this.id,
    this.senderid,
    this.receiverid,
    this.sendername,
    this.senderfullname,
    this.senderimage,
    this.receivername,
    this.receiverfullname,
    this.receiverimage,
    this.message,
    this.seen,
    this.time,
  });

  Chat.fromMap(Map<dynamic, dynamic> json) {
    id = json["id"].toString();
    sendername = json["sender_name"].toString();
    senderfullname = json["sender_full_name"].toString();
    senderimage = json["sender_image"].toString();
    receivername = json["receiver_name"].toString();
    receiverfullname = json["receiver_full_name"].toString();
    receiverimage = json["receiver_image"].toString();
    message = json["message"];
    time = json["time"];
    seen = json["seen"];
    senderid = json['sender_id'];
    receiverid = json['receiver_id'];
  }

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["id"].toString(),
        sendername: json["sender_name"].toString(),
        senderimage: json["sender_image"].toString(),
        receivername: json["receiver_name"].toString(),
        receiverimage: json["receiver_image"].toString(),
        message: json["message"],
        time: json["time"],
        seen: json["seen"].toString() as bool,
      );
}

// "other_user":
// {
//         "id": 1,
//         "first_name": "Super",
//         "last_name": "User",
//         "username": "superuser",
//         "p_img": "/static/frontpages/images/clients/unkonwn_user_icon.png",
//         "role": "Superuser"
// },

class ChatUser {
  int id;
  String firstname;
  String lastname;
  String username;
  String email;
  String pimage;

  ChatUser(
      {this.id,
      this.firstname,
      this.lastname,
      this.email,
      this.username,
      this.pimage});

  ChatUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['first_name'];
    lastname = json['last_name'];
    email = json['email'];
    username = json['username'];
    pimage = json['p_img'];
  }
}

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({@required this.messageContent, @required this.messageType});
}

List<ChatMessage> messages = [
  ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
  ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
  ChatMessage(
      messageContent: "Hey Kriss, I am doing fine dude. wbu?",
      messageType: "sender"),
  ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  ChatMessage(
      messageContent: "Is there any thing wrong?", messageType: "sender"),
];
