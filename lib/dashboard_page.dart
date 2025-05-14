import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {
        'title': 'Produk',
        'icon': Icons.shopping_cart,
        'color': Colors.blue,
      },
      {
        'title': 'Pesanan',
        'icon': Icons.list_alt,
        'color': Colors.green,
      },
      {
        'title': 'Pelanggan',
        'icon': Icons.people,
        'color': Colors.orange,
      },
      {
        'title': 'Laporan',
        'icon': Icons.bar_chart,
        'color': Colors.red,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Admin'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: features.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final item = features[index];
            return GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Membuka menu ${item['title']}')),
                );
              },
              child: Card(
                color: item['color'],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 6,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(item['icon'], size: 48, color: Colors.white),
                      SizedBox(height: 10),
                      Text(
                        item['title'],
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  final iconList = <IconData>[
    Icons.home,
    Icons.search,
    Icons.shopping_bag,
    Icons.person,
  ];

  void _showWelcomeMessage() {
    String message = '';
    switch (_currentIndex) {
      case 0:
        message = 'Selamat datang di halaman Beranda!';
        break;
      case 1:
        message = 'Mari kita eksplor fitur menarik!';
        break;
      case 2:
        message = 'Berikut adalah daftar pesanan kamu.';
        break;
      case 3:
        message = 'Profil pengguna: Atika Mufidah Mukti';
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();

    _pages.addAll([
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              'Hai, Atika!\nAyo belanja kebutuhanmu di sini!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'Halaman Explore\nCari produk atau fitur baru!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag, size: 100, color: Colors.orange),
            SizedBox(height: 20),
            Text(
              'Halaman Orders\nLihat daftar pesananmu di sini.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 100, color: Colors.purple),
            SizedBox(height: 20),
            Text(
              'Profil Pengguna\nNama: Atika Mufidah Mukti\nNIM: 230101008\nAsal: Sragen',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu Navigasi',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard Admin'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Keluar'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: _showWelcomeMessage,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}