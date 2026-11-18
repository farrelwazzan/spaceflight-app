
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/spaceflight.dart';

class SpaceflightService {


  Future<List<Spaceflight>> getData(String menu) async {
    String endpoint = '';

    if (menu == 'News') {
      endpoint = 'articles';
    } else if (menu == 'Blog') {
      endpoint = 'blogs';
    } else if (menu == 'Reports') {
      endpoint = 'reports';
    }

    final url = Uri.parse(
      'https://api.spaceflightnewsapi.net/v4/$endpoint/?limit=10',
    );

    print('REQUEST URL: $url');

    final response = await http.get(url);

    print('Status Code: ${response.statusCode}'); 
    print('Response: ${response.body}');
    print('STATUS CODE: ${response.statusCode}');
    print('RESPONSE BODY: ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      List results = data['results'];

      print('JUMLAH DATA: ${results.length}');

      return results.map((item) {
        return Spaceflight.fromJson(item);
      }).toList();
    } else {
      throw Exception(
        'Gagal mengambil data: ${response.statusCode}',
      );
    }
  }
}
