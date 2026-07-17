// lib/main.dart
import 'package:flutter/material.dart';
import 'package:pesan_makan/detail_produk.dart';
import 'katalog_page.dart';    // Untuk pelanggan
import 'login_page.dart';      // Import halaman Login
import 'dashboard_kasir.dart'; // Untuk dasbor kasir

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: LoginSelector(),
    );
  }
}

// Halaman Pintu Masuk
class LoginSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pilih Akses")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.storefront, size: 100, color: Colors.green[700]),
            SizedBox(height: 20),
            Text("Selamat Datang di FoodCourt", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 40),
            
            // Tombol Pelanggan
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
              icon: Icon(Icons.shopping_bag),
              label: Text("SAYA PELANGGAN"),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => KatalogPelanggan())),
            ),
            
            SizedBox(height: 20),
            
            // Tombol Kasir - Arahkan ke LoginPage, bukan langsung ke MainKasir
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700], padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
              icon: Icon(Icons.admin_panel_settings, color: Colors.white),
              label: Text("SAYA KASIR", style: TextStyle(color: Colors.white)),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage())),
            ),
          ],
        ),
      ),
    );
  }
}