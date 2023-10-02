import 'package:flutter/material.dart';
import 'package:news_cloud/model/Article.dart';
import 'dart:convert';

import 'package:http/http.dart'  as http;
class HTTPHandler{
  String url = "https://jsonplaceholder.typicode.com/comments";
  Future<List<Article>> fetchData() async{
    List<Article> myList =[];
    final respond = await http.get(Uri.parse(url));
    if(respond.statusCode==200)
    {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(respond.body);
      for(Map<String, dynamic> d in data)
      {
        Article article= Article.fromJson(d);
        myList.add(article);
      }
      return myList;
    }
    else{
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('${respond.statusCode}');
    }
  }
}


