class NewsArticle {
  final String title;
  final String description;
  final String url;
  final String? imageUrl;

  NewsArticle({
    required this.title,
    required this.description,
    required this.url,
    this.imageUrl,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'],
    );
  }
}
