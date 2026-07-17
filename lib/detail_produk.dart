import 'package:flutter/material.dart';

class HalamanDetail extends StatefulWidget {
  final Map<String, dynamic> produk;
  HalamanDetail({required this.produk});

  @override
  _HalamanDetailState createState() => _HalamanDetailState();
}

class _HalamanDetailState extends State<HalamanDetail> {
  int quantity = 1;
  String _selectedVarian = "Tanpa Varian"; // Default aman

  @override
  Widget build(BuildContext context) {
    int harga = widget.produk['harga'];
    int total = harga * quantity;

    return Scaffold(
      appBar: AppBar(title: Text(widget.produk['nama'])),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Image.asset(widget.produk['gambar'], height: 250, width: double.infinity, fit: BoxFit.cover),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.produk['nama'], style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                      Text("Rp $harga", style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold)),
                      
                      // Opsi hanya muncul jika produk memiliki varian (contoh: Bakso/Sate)
                      if (widget.produk['nama'] == 'Sate Ayam Madura' || widget.produk['nama'] == 'Bakso Mercon') ...[
                        SizedBox(height: 20),
                        Text("Pilih Varian:", style: TextStyle(fontWeight: FontWeight.bold)),
                        RadioListTile(title: Text("Bumbu kacang"), value: "Kuah Pedas", groupValue: _selectedVarian, onChanged: (v) => setState(() => _selectedVarian = v!)),
                        RadioListTile(title: Text("Bumbu Kecap"), value: "Kuah Biasa", groupValue: _selectedVarian, onChanged: (v) => setState(() => _selectedVarian = v!)),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(icon: Icon(Icons.remove_circle_outline, color: Colors.green, size: 35), onPressed: () => setState(() { if (quantity > 1) quantity--; })),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 15), child: Text("$quantity", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                    IconButton(icon: Icon(Icons.add_circle_outline, color: Colors.green, size: 35), onPressed: () => setState(() => quantity++)),
                  ],
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.all(15)),
                    onPressed: () {
                      // MENGIRIM DATA LENGKAP KE KATALOG
                      Navigator.pop(context, {
                        'jumlah': quantity,
                        'total': total,
                        'opsi': _selectedVarian
                      });
                    },
                    child: Text("TAMBAH (Rp $total)", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}