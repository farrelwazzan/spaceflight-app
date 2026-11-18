class Spaceflight {
  final int id;
  final String title;
  final String imageUrl;
  final String author;
  final String summary;
  final String publishedAt;
  final String url;

  Spaceflight({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.author,
    required this.summary,
    required this.publishedAt,
    required this.url,
  });

  // Mengubah JSON menjadi objek Spaceflight
  factory Spaceflight.fromJson(Map<String, dynamic> json) {
    List authors = json['authors'] ?? [];

    String author = 'Unknown';

    if (authors.isNotEmpty) {
      author = authors[0]['name'] ?? 'Unknown';
    }

    return Spaceflight(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      imageUrl: json['image_url'] ?? '',
      author: author,
      summary: json['summary'] ?? '',
      publishedAt: json['published_at'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
