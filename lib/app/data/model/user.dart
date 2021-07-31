import 'dart:convert';

class User {
  String id = "";
  String name = "";
  String email = "";

  User({this.id = "", this.email = "", this.name = ""});

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;

    return data;
  }

  String toJsonString(){
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;

    return json.encode(data);
  }

  User fromJsonString(String json){
    final Map<String, dynamic> data = jsonDecode(json);

    return User.fromJson(data);
  }
}