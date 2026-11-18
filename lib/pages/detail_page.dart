import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/spaceflight.dart';
import '../services/favourite_service.dart';

class DetailPage extends StatefulWidget {
  final Spaceflight item;
  final String type;

  const DetailPage({
    super.key,
    required this.item,
    required this.type,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final FavouriteService favouriteService = FavouriteService();

  bool isFavourite = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    checkFavourite();
  }

  // Memeriksa apakah artikel sudah menjadi favourite
  void checkFavourite() async {
    bool result = await favouriteService.isFavourite(
      widget.item.id,
      widget.type,
    );

    if (!mounted) return;

    setState(() {
      isFavourite = result;
      isLoading = false;
    });
  }

  void openArticle() async {
    final Uri url = Uri.parse(widget.item.url);

    try {
      bool result = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );

      if (!result && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal membuka artikel'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
        ),
      );
    }
  }

  // Menambahkan atau menghapus favourite
  void toggleFavourite() async {
    if (isFavourite) {
      await favouriteService.removeFavourite(
        widget.item.id,
        widget.type,
      );
    } else {
      await favouriteService.addFavourite({
        'id': widget.item.id,
        'type': widget.type,
        'title': widget.item.title,
        'imageUrl': widget.item.imageUrl,
        'author': widget.item.author,
        'summary': widget.item.summary,
        'publishedAt': widget.item.publishedAt,
        'url': widget.item.url,
      });
    }

    if (!mounted) return;

    setState(() {
      isFavourite = !isFavourite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavourite
              ? 'Berhasil ditambahkan ke Favourite'
              : 'Favourite berhasil dihapus',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Artikel'),
        actions: [
          IconButton(
            onPressed: isLoading ? null : toggleFavourite,
            icon: Icon(
              isFavourite ? Icons.favorite : Icons.favorite_border,
              color: isFavourite ? Colors.red : null,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar artikel
            Image.network(
              widget.item.imageUrl,
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 220,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 50,
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Kategori artikel
            Text(
              widget.type,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // Judul artikel
            Text(
              widget.item.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Penulis dan tanggal
            Text('Author: ${widget.item.author}'),
            const SizedBox(height: 5),
            Text('Published: ${widget.item.publishedAt}'),

            const SizedBox(height: 20),

            const Text(
              'Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // Ringkasan artikel
            Text(
              widget.item.summary,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 25),

            // Tombol favourite
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isLoading ? null : toggleFavourite,
                icon: Icon(
                  isFavourite ? Icons.favorite : Icons.favorite_border,
                ),
                label: Text(
                  isFavourite
                      ? 'Remove Favourite'
                      : 'Add to Favourite',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFavourite ? Colors.red : Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: openArticle,
                icon: const Icon(Icons.open_in_browser),
                label: const Text('Read Full Article'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
