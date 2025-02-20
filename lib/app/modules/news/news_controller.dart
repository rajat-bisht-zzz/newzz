import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:newzz/app/data/models/news.dart';

class NewsController extends GetxController {
  // Observable variables
  var articles = <NewsArticle>[].obs; // Full list of articles
  var filteredArticles = <NewsArticle>[].obs; // Filtered list for search
  var isLoading = true.obs; // Loading state for initial fetch
  var isLoadingMore = false.obs; // Loading state for pagination
  var currentTab = 0.obs; // For animated bottom navigation bar
  var currentPage = 1.obs; // Pagination page tracker
  var isDarkMode = false.obs; // Observable for theme state

  // API configuration
  final String apiKey = '4cc872e46f0d4e3eacc9f30c83b600e1';
  final String baseUrl = 'https://newsapi.org/v2/top-headlines?country=us';

  @override
  void onInit() {
    GetStorage().initStorage;
    isDarkMode.value = GetStorage().read('isDarkMode') ?? false;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    fetchNews();
    super.onInit();
  }

  // Fetch news from NewsAPI with pagination
  Future<void> fetchNews({bool loadMore = false}) async {
    try {
      if (loadMore) {
        isLoadingMore(true);
        currentPage.value++;
      } else {
        isLoading(true);
      }

      final response = await http.get(Uri.parse('$baseUrl&apiKey=$apiKey&page=${currentPage.value}&pageSize=20'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newArticles = (data['articles'] as List).map((article) => NewsArticle.fromJson(article)).toList();

        if (loadMore) {
          articles.addAll(newArticles);
        } else {
          articles.value = newArticles;
        }
        filteredArticles.value = articles; // Sync filtered list
      } else {
        Get.snackbar('Error', 'Failed to load news');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      if (loadMore) {
        isLoadingMore(false);
      } else {
        isLoading(false);
      }
    }
  }

  // Search functionality
  void searchArticles(String query) {
    if (query.isEmpty) {
      filteredArticles.value = articles;
    } else {
      filteredArticles.value = articles
          .where((article) =>
              article.title.toLowerCase().contains(query.toLowerCase()) ||
              article.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  // Remove article (for swipe-to-dismiss)
  void removeArticle(NewsArticle article) {
    articles.remove(article);
    filteredArticles.remove(article);
    Get.snackbar('Removed', '${article.title} dismissed');
  }

  // Refresh news
  Future<void> refreshNews() async {
    currentPage.value = 1;
    await fetchNews();
  }

  // Toggle theme
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    GetStorage().write('isDarkMode', isDarkMode.value);
  }
}
