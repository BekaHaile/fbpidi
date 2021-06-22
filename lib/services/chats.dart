import 'package:fbpidi/models/chats.dart';
import 'package:fbpidi/strings/strings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatService {
  static String baseUrl = Strings().baseUrl;

  Future<String> getToken() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    return token;
  }

  Future<int> getUnreadMessage(token) async {
    var response = await http
        .get(Uri.encodeFull("$baseUrl/api/chat/list_unread/"), //uri of api
            headers: {
          "Authorization": "Token $token",
        });
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    int chatcount;
    if (response.statusCode == 200) {
      chatcount = data['num'];
    } else {
      chatcount = 0;
    }
    return chatcount;
  }

  static Future<Map<String, dynamic>> getChatList(token) async {
    var response = await http
        .get(Uri.encodeFull("$baseUrl/api/chat/chat_list/"), //uri of api
            headers: {
          "Authorization": "Token $token",
        });

    List<Chat> chats = [];
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      data["chat_list"].forEach((chat) {
        chats.add(Chat.fromMap(chat));
      });
    } else {
      // ignore: deprecated_member_use
      chats = List<Chat>();
    }
    Map<String, dynamic> chatlist = {'chats_list': chats};
    return chatlist;
  }

  static Future<Map<String, dynamic>> getChatDetail(token, username) async {
    var response = await http.get(
        Uri.encodeFull("$baseUrl/api/chat/with/?name=$username"), //uri of api
        headers: {
          "Authorization": "Token $token",
        });
    List<Chat> chats = [];
    ChatUser chatuser;
    Map<String, dynamic> data;

    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
      data["old_messages"].forEach((chat) {
        chats.add(Chat.fromMap(chat));
      });
      chatuser = ChatUser.fromJson(data['other_user']);
    } else {
      // ignore: deprecated_member_use
      chats = List<Chat>();
      chatuser = ChatUser();
    }

    Map<String, dynamic> chatdetail = {
      'chats_messages': chats,
      'other_user': chatuser
    };
    return chatdetail;
  }

  static Future<Chat> sendMessage(username, message, token) async {
    Map<dynamic, dynamic> data = {'name': username, 'message': message};
    var response = await http.post(
      Uri.encodeFull("$baseUrl/api/chat/"),
      headers: {
        "Authorization": "Token $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(data),
    );

    Chat chat;

    Map<String, dynamic> dataresponse;
    if (response.statusCode == 200) {
      dataresponse = jsonDecode(utf8.decode(response.bodyBytes));
      chat = Chat.fromMap(dataresponse['data']);
    } else {}

    return chat;
  }

  static Future<Map<String, dynamic>> getChatUseList(token, srchstring) async {
    var response = await http.get(
        Uri.encodeFull(
            "$baseUrl/api/chat/check_user/?username=$srchstring"), //uri of api
        headers: {
          "Authorization": "Token $token",
        });

    List<ChatUser> _chatusers = [];
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      data["related"].forEach((chatuser) {
        _chatusers.add(ChatUser.fromJson(chatuser));
      });
    } else {
      // ignore: deprecated_member_use
      _chatusers = List<ChatUser>();
    }
    Map<String, dynamic> chatuserdata = {'chatusers': _chatusers};
    return chatuserdata;
  }
}
