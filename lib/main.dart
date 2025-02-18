import 'package:flutter/material.dart';
import 'package:newzz/app/data/services/news_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NewsApp());
  }
}
