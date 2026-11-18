
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_page.dart';
import 'list_page.dart';
import 'favourite_page.dart';

class HomePage extends StatelessWidget {
  final String username;

  HomePage({
    super.key,
    required this.username,
  });

  final AuthService authService = AuthService();

  // Fungsi untuk Logout
  void logout(BuildContext context) async {
    await authService.logout();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
      (route) => false,
    );
  }

  // Membuka halaman sesuai menu
  void openMenu(BuildContext context, String menu) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListPage(menu: menu),
      ),
    );
  }

  void openFavourite(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FavouritePage(),
      ),
    );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hai, $username!'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menu News
            Card(
              child: ListTile(
                leading: const Icon(Icons.newspaper),
                title: const Text('News'),
                subtitle: const Text(
                  'Get the latest spaceflight news.',
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => openMenu(context, 'News'),
              ),
            ),

            const SizedBox(height: 15),

            // Menu Blog
            Card(
              child: ListTile(
                leading: const Icon(Icons.article),
                title: const Text('Blog'),
                subtitle: const Text(
                  'Read articles about spaceflight.',
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => openMenu(context, 'Blog'),
              ),
            ),

            const SizedBox(height: 15),

            // Menu Reports
            Card(
              child: ListTile(
                leading: const Icon(Icons.assessment),
                title: const Text('Reports'),
                subtitle: const Text(
                  'Explore spaceflight reports.',
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => openMenu(context, 'Reports'),
              ),
            ),

            const SizedBox(height: 30),

            Card(
              child: ListTile(
                leading: const Icon(Icons.favorite, color: Colors.red),
                title: const Text('Favourite'),
                subtitle: const Text(
                  'View your favourite articles.',
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => openFavourite(context),
              ),
            ),

            const SizedBox(height: 30),

            // Tombol Logout
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => logout(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
