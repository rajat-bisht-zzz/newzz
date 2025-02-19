import 'package:flutter/material.dart';
import 'package:newzz/app/ui/screens/news_screen.dart';
import 'package:newzz/app/ui/widgets/basic_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      title: '',
      child: NewsScreen(),
    );
  }
}