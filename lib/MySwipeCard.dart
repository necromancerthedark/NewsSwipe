import 'dart:convert';
import 'package:swipeable/NewsCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'news_api_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MySwipeCard extends StatefulWidget {
  @override
  _MySwipeCardState createState() => _MySwipeCardState();
}

class _MySwipeCardState extends State<MySwipeCard> {
  late Future<News> newsData;

  String URL = "https://newsapi.org/v2/top-headlines?country=in&apiKey=" +
      env['API_KEY']!;

  Future<News> fetchNews() async {
    final response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      return News.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch");
    }
  }

  @override
  void initState() {
    super.initState();
    newsData = fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<News>(
      future: newsData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return PageView.builder(
            itemCount: 19,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              Article article = snapshot.data!.articles[index];

              return NewsCard(
                  article.title!,
                  article.description!,
                  article.urlToImage!,
                  article.source.name.toString(),
                  article.url!);
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Uh oh! Internet Please"),
              ],
            ),
          );
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Brewing Coffee☕...."),
              Container(
                height: 20.0,
              ),
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}
