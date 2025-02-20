import 'package:flutter/material.dart';
import 'package:newzz/app/data/models/news.dart';

class DetailScreen extends StatelessWidget {
  final NewsArticle article;

  const DetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (article.imageUrl != null)
              Hero(
                tag: article.url,
                child: Image.network(article.imageUrl!),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(article.description),
            ),
          ],
        ),
      ),
    );
  }
}
