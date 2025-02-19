import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  final List<String> categories = [
    'Sports',
    'Entertainment',
    'Politics',
    'Technology',
    'Business',
    'Health',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // On tap, navigate to news list for that category
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsCategoryScreen(
                            category: categories[index],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: categories.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.2,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsCategoryScreen extends StatefulWidget {
  final String category;
  NewsCategoryScreen({required this.category});

  @override
  _NewsCategoryScreenState createState() => _NewsCategoryScreenState();
}

class _NewsCategoryScreenState extends State<NewsCategoryScreen> {
  List<String> newsArticles = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadNews(); // Load initial news articles
  }

  // Simulate loading news articles for the category
  void _loadNews() {
    setState(() {
      isLoading = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        newsArticles = List.generate(
          10,
          (index) => '${widget.category} News Article ${index + 1}',
        );
        isLoading = false;
      });
    });
  }

  // Simulate loading more articles when swipe-up is detected
  void _loadMoreNews() {
    setState(() {
      isLoading = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        newsArticles.addAll(List.generate(
          10,
          (index) => '${widget.category} News Article ${newsArticles.length + index + 1}',
        ));
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} News'),
      ),
      body: isLoading && newsArticles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                  // Trigger loading more news when swiped to the end
                  _loadMoreNews();
                }
                return true;
              },
              child: ListView.builder(
                itemCount: newsArticles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(newsArticles[index]),
                    subtitle: Text('Description of the article here'),
                  );
                },
              ),
            ),
    );
  }
}
