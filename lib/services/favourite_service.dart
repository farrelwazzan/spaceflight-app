
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteService {
  // Mengambil semua data favourite
  Future<List<Map<String, dynamic>>> getFavourites() async {
    final prefs = await SharedPreferences.getInstance();

    String? data = prefs.getString('favourites');

    if (data == null) {
      return [];
    }

    List decodedData = jsonDecode(data);

    return decodedData.map((item) {
      return Map<String, dynamic>.from(item);
    }).toList();
  }

  // Menambahkan data favourite
  Future<void> addFavourite(Map<String, dynamic> item) async {
    final prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> favourites = await getFavourites();

    // Memeriksa apakah data sudah ada
    bool alreadyExists = favourites.any((data) {
      return data['id'] == item['id'] &&
          data['type'] == item['type'];
    });

    if (!alreadyExists) {
      favourites.add(item);

      await prefs.setString(
        'favourites',
        jsonEncode(favourites),
      );
    }
  }

  // Menghapus data favourite
  Future<void> removeFavourite(int id, String type) async {
    final prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> favourites = await getFavourites();

    favourites.removeWhere((item) {
      return item['id'] == id && item['type'] == type;
    });

    await prefs.setString(
      'favourites',
      jsonEncode(favourites),
    );
  }

  // Memeriksa apakah data sudah menjadi favourite
  Future<bool> isFavourite(int id, String type) async {
    List<Map<String, dynamic>> favourites = await getFavourites();

    return favourites.any((item) {
      return item['id'] == id && item['type'] == type;
    });
  }
}
