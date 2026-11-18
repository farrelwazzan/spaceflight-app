
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Mendaftarkan akun baru
  Future<bool> register(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    // Cek apakah username sudah digunakan
    if (prefs.containsKey('username')) {
      return false;
    }

    await prefs.setString('username', username);
    await prefs.setString('password', password);

    return true;
  }

  // Memeriksa login
  Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    String? savedUsername = prefs.getString('username');
    String? savedPassword = prefs.getString('password');

    if (username == savedUsername &&
        password == savedPassword) {
      await prefs.setBool('isLogin', true);
      await prefs.setString('currentUsername', username);

      return true;
    }

    return false;
  }

  // Memeriksa apakah pengguna sudah login
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool('isLogin') ?? false;
  }

  // Mengambil username yang sedang login
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('currentUsername');
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLogin', false);
    await prefs.remove('currentUsername');
  }
}
