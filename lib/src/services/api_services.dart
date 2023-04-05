import 'dart:convert';

import 'package:wave_news/src/models/article_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  // final String category;
  // ApiServices({required this.category});

  //Treanding Articles
  Future<ArticleModel> fetchTreandingArticleRecords() async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=a965d7266a784bd2b1eaf329ad727fc7"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return ArticleModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

//All news
  Future<ArticleModel> fetchAllArticleRecords(String category) async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?q=$category&apiKey=a965d7266a784bd2b1eaf329ad727fc7"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return ArticleModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  //popular news

  // sports news

  //technology news

  //

}
