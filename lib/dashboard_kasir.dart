import 'package:flutter/material.dart';
import 'data_transaksi.dart';
import 'login_page.dart';

class MainKasir extends StatefulWidget {
  @override
  _MainKasirState createState() => _MainKasirState();
}

class _MainKasirState extends State<MainKasir> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _halaman = [
      HalamanBeranda(),
      HalamanTransaksi(),
      HalamanUlasan(),
      HalamanProfil(),
    ];

    return Scaffold(
      body: _halaman[_index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        selectedItemColor: Colors.green,
        onTap: (i) => setState(() => _index = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: "Transaksi"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Ulasan"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}

// 1. HALAMAN BERANDA
class HalamanBeranda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int totalOrder = Transaksi.daftarTransaksi.length;
    int totalCuan = Transaksi.daftarTransaksi.fold(0, (sum, item) => sum + (item['total'] as int));

    return Scaffold(
      appBar: AppBar(title: Text("Dashboard Kasir"), backgroundColor: Colors.green),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            _buildCard("Total Pesanan", "$totalOrder", Icons.shopping_bag, Colors.blue),
            _buildCard("Pendapatan", "Rp $totalCuan", Icons.attach_money, Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String value, IconData icon, Color color) {
    return Expanded(child: Card(child: Padding(padding: EdgeInsets.all(20), child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: color), Text(title), Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))]))));
  }
}

// 2. HALAMAN TRANSAKSI
class HalamanTransaksi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daftar Pesanan"), backgroundColor: Colors.green, automaticallyImplyLeading: false),
      body: Transaksi.daftarTransaksi.isEmpty ? Center(child: Text("Belum ada transaksi")) : ListView.builder(
        itemCount: Transaksi.daftarTransaksi.length,
        itemBuilder: (context, i) {
          final item = Transaksi.daftarTransaksi[i];
          return Card(margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5), child: ListTile(leading: CircleAvatar(child: Icon(Icons.person)), title: Text(item['nama']), subtitle: Text("Menu: ${item['menu']}"), trailing: Text("Rp ${item['total']}", style: TextStyle(fontWeight: FontWeight.bold))));
        },
      ),
    );
  }
}

// 3. HALAMAN ULASAN
class HalamanUlasan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ulasan Pelanggan"), backgroundColor: Colors.green),
      body: Transaksi.daftarUlasan.isEmpty ? Center(child: Text("Belum ada ulasan")) : ListView.builder(
        itemCount: Transaksi.daftarUlasan.length,
        itemBuilder: (context, i) {
          final ulasan = Transaksi.daftarUlasan[i];
          return ListTile(leading: CircleAvatar(child: Text(ulasan['nama']![0])), title: Text(ulasan['nama']!), subtitle: Text(ulasan['pesan']!));
        },
      ),
    );
  }
}

// 4. HALAMAN PROFIL
class HalamanProfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profil & Pengaturan"), backgroundColor: Colors.green),
      body: ListView(
        children: [
          SizedBox(height: 20),
          Center(child: CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50))),
          Center(child: Text("Admin Kasir", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          Divider(),
          ListTile(leading: Icon(Icons.store), title: Text("Kelola Toko")),
          ListTile(leading: Icon(Icons.color_lens), title: Text("Tema")),
          ListTile(leading: Icon(Icons.lock), title: Text("Ubah Password")),
          ListTile(leading: Icon(Icons.exit_to_app, color: Colors.red), title: Text("Keluar", style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}