
import 'package:flutter/material.dart';

import '../services/favourite_service.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final FavouriteService favouriteService = FavouriteService();

  List<Map<String, dynamic>> favourites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFavourites();
  }

  // Mengambil data favourite
  void loadFavourites() async {
    List<Map<String, dynamic>> data =
        await favouriteService.getFavourites();

    if (!mounted) return;

    setState(() {
      favourites = data;
      isLoading = false;
    });
  }

  // Menghapus favourite
  void removeFavourite(int id, String type) async {
    await favouriteService.removeFavourite(id, type);

    loadFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite'),
      ),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : favourites.isEmpty
              ? const Center(
                  child: Text('Belum ada artikel Favourite'),
                )
              : ListView.builder(
                  itemCount: favourites.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> item = favourites[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),

                        leading: SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.network(
                            item['imageUrl'] ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.image_not_supported,
                                  size: 35,
                                ),
                              );
                            },
                          ),
                        ),

                        title: Text(
                          item['title'] ?? 'No Title',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            '${item['type']} • ${item['author']}',
                          ),
                        ),

                        trailing: IconButton(
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            removeFavourite(
                              item['id'],
                              item['type'],
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
