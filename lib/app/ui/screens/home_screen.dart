import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzz/app/modules/news/news_controller.dart';
import 'package:newzz/app/ui/screens/news_detail/news_detail_screen.dart';
import 'package:newzz/app/ui/screens/settings/settings_screen.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  final NewsController controller = Get.put(NewsController());
  final ScrollController scrollController = ScrollController();

  HomeScreen({super.key}) {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
          !controller.isLoadingMore.value) {
        controller.fetchNews(loadMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News App')),
      body: Obx(() {
        return IndexedStack(
          index: controller.currentTab.value,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search news...',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: controller.searchArticles,
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: ListTile(
                            leading: Container(width: 50, height: 50, color: Colors.white),
                            title: Container(width: double.infinity, height: 10, color: Colors.white),
                            subtitle: Container(width: double.infinity, height: 10, color: Colors.white),
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: controller.filteredArticles.length + 1,
                      itemBuilder: (context, index) {
                        if (index == controller.filteredArticles.length) {
                          return Obx(() => controller.isLoadingMore.value
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(child: CircularProgressIndicator()),
                                )
                              : SizedBox.shrink());
                        }
                        final article = controller.filteredArticles[index];
                        return Dismissible(
                          key: Key(article.url),
                          onDismissed: (direction) => controller.removeArticle(article),
                          background: Container(color: Colors.red),
                          child: ListTile(
                            title: Text(article.title),
                            subtitle: Text(article.description),
                            leading: article.imageUrl != null ? Image.network(article.imageUrl!, width: 50) : null,
                            onTap: () {
                              Get.to(() => DetailScreen(article: article));
                            },
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
            // Settings (Tab 1)
            SizedBox.expand(
              child: SettingsScreen(),
            ),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.currentTab.value,
          onTap: (index) => controller.currentTab.value = index,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        );
      }),
    );
  }
}
