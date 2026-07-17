import 'package:flutter/material.dart';
import 'checkout_page.dart';
import 'detail_produk.dart';
import 'data_transaksi.dart'; // Pastikan import ini benar

class KatalogPelanggan extends StatefulWidget {
  @override
  _KatalogPelangganState createState() => _KatalogPelangganState();
}

class _KatalogPelangganState extends State<KatalogPelanggan> {
  final List<Map<String, dynamic>> menu = [
    {"nama": "Banana bomb", "harga": 15000, "gambar": "gambar/banana_bomb.jpg"},
    {"nama": "Sate Ayam Madura", "harga": 20000, "gambar": "gambar/sate_ayam_madura.jpg"},
    {"nama": "Bakso Mercon", "harga": 18000, "gambar": "gambar/bakso_mercon.jpg"},
    {"nama": "Nasi Goreng Spesial", "harga": 30000, "gambar": "gambar/nasi_goreng_spesial.jpg"},
  ];

  List<Map<String, dynamic>> keranjang = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu Resto"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                if (keranjang.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      child: Text('${keranjang.length}', style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              if (keranjang.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Keranjang masih kosong!")));
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (_) => HalamanCheckout(
                  keranjang: keranjang, 
                  onCheckoutSuccess: () {
                    // 1. Hitung total
                    int grandTotal = keranjang.fold(0, (sum, item) => sum + (item['total'] as int));
                    
                    // 2. Gabungkan nama menu
                    String daftarMenu = keranjang.map((item) => item['nama']).join(", ");

                    // 3. Simpan ke daftarTransaksi (sesuai 5 parameter di data_transaksi.dart)
                    Transaksi.tambahTransaksi("Pelanggan", daftarMenu, grandTotal, "Tunai", "Selesai");
                    
                    // 4. Bersihkan tampilan
                    setState(() => keranjang.clear());
                  }
                )));
              }
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          childAspectRatio: 0.75,
          crossAxisSpacing: 10, 
          mainAxisSpacing: 10
        ),
        itemCount: menu.length,
        itemBuilder: (context, i) => Card(
          child: InkWell(
            onTap: () async {
              final hasil = await Navigator.push(
                context, 
                MaterialPageRoute(builder: (_) => HalamanDetail(produk: menu[i]))
              );

              if (hasil != null) {
                setState(() {
                  keranjang.add({
                    "nama": menu[i]['nama'],
                    "harga": menu[i]['harga'],
                    "gambar": menu[i]['gambar'],
                    "jumlah": hasil['jumlah'],
                    "opsi": hasil['opsi'],
                    "total": hasil['total']
                  });
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${menu[i]['nama']} ditambahkan!")));
              }
            },
            child: Column(
              children: [
                Expanded(child: Image.asset(menu[i]['gambar'], fit: BoxFit.cover, width: double.infinity)),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(menu[i]['nama'], style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Rp ${menu[i]['harga']}", style: TextStyle(color: Colors.green)),
                      SizedBox(height: 5),
                      Text("Klik untuk pesan", style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}