import 'package:flutter/material.dart';

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.developer_mode),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Lorem ipsum'),
                  subtitle: Text('Lorem ipsum'),
                  leading: Image.network("https://picsum.photos/200", width: 100, fit: BoxFit.cover),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
