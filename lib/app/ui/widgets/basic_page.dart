import 'package:flutter/material.dart';
import 'package:newzz/app/ui/screens/news_screen.dart';
import 'package:newzz/app/ui/screens/settings.dart';

class BasicPage extends StatelessWidget {
  final List<Widget> screens = [
    NewsScreen(),
    // FavoritesView(),
    const SettingsScreen(),
  ];

  final String title;
  final Widget child;
  BasicPage({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.article), label: "News"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ]),
      body: child,
    );
  }
}
