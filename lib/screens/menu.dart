import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/experience_list_screen.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String npm = "2506534636";
  final String nama = "Dimas Bayu Nugroho";
  final String kelas = "PBP B";

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;
    final items = <ItemHomepage>[
      ItemHomepage("Experiences", Icons.work_outline, Colors.indigo),
      ItemHomepage("Add Education", Icons.add_circle, Colors.cyan),
      ItemHomepage("Add Experience", Icons.add_circle, Colors.deepOrange),
      if (isLoggedIn)
        ItemHomepage("Logout", Icons.logout, Colors.lightGreenAccent)
      else
        ItemHomepage("Login", Icons.login, Colors.lightGreenAccent),
    ];

    // Scaffold menyediakan struktur visual dasar halaman (AppBar, Body, SnackBar).
    return Scaffold(
      // AppBar menampilkan bar bagian atas halaman aplikasi.
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      // Body halaman utama dengan padding di sekelilingnya.
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Baris horizontal untuk menampilkan 3 InfoCard secara sejajar.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),

            const SizedBox(height: 16.0),

            // Bagian tengah: pesan sambutan dan kisi tombol menu portofolio.
            Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Selamat datang di MyPortfolio Mobile!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),

                  // GridView menampilkan kartu tombol dalam tata letak kisi 3 kolom.
                  GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    // shrinkWrap agar ukuran kisi menyesuaikan tinggi konten anak.
                    shrinkWrap: true,
                    children: items.map((ItemHomepage item) {
                      return ItemCard(
                        item,
                        onTap: () => _handleMenuAction(context, item.name),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleMenuAction(BuildContext context, String action) async {
    switch (action) {
      case 'Experiences':
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ExperienceListScreen()),
        );
        return;
      case 'Add Education':
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EducationFormPage()),
        );
        return;
      case 'Add Experience':
        if (!await ensureLoggedIn(context) || !context.mounted) return;
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ExperienceFormPage()),
        );
        return;
      case 'Login':
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
        return;
      case 'Logout':
        try {
          await context.read<AuthState>().logout();
          if (!context.mounted) return;
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Logged out.')));
        } on ApiException catch (error) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Logged out locally; server returned ${error.statusCode}.',
              ),
            ),
          );
        } catch (error) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Logout request failed: $error')),
          );
        }
        return;
    }
  }
}

class InfoCard extends StatelessWidget {
  // Kartu informasi yang menampilkan judul (title) dan isi (content).
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      // Memberikan efek bayangan kartu elevasi 2 unit.
      elevation: 2.0,
      child: Container(
        // Menyesuaikan lebar kartu dengan proporsi layar (dibagi 3.5).
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
        // Menyusun teks title dan content secara vertikal.
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;
  ItemHomepage(this.name, this.icon, this.color);
}
