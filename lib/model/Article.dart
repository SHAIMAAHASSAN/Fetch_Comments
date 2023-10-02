import 'package:http/http.dart' as http;
import 'dart:convert';

class Article {
  final int id;
  final String name;
  final String email;
  final String body;

  Article(
      { required this.id,
        required this.name,
        required this.email,
        required this.body,
      });

  factory Article.fromJson(Map<String,dynamic>jsonData){

    return Article( id:jsonData["id"]as int ,name: jsonData["name"] , email:jsonData["email"], body: jsonData["body"]);
  }
}

