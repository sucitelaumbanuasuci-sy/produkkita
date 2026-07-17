import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data_transaksi.dart';

class HalamanCheckout extends StatefulWidget {
  final List<Map<String, dynamic>> keranjang;
  final VoidCallback onCheckoutSuccess;

  HalamanCheckout({required this.keranjang, required this.onCheckoutSuccess});

  @override
  _HalamanCheckoutState createState() => _HalamanCheckoutState();
}

class _HalamanCheckoutState extends State<HalamanCheckout> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  String _metodePengiriman = "Ambil Sendiri";
  String? _metodePembayaran;

  Future<void> kirimKeWhatsApp(int grandTotal) async {
    String nomorAdmin = "6281344756135";
    String pesan = "Halo Admin, pesanan baru:\n\nNama: ${_namaController.text}\nAlamat: ${_alamatController.text}\nPengiriman: $_metodePengiriman\nPembayaran: $_metodePembayaran\n\nDetail:\n";
    
    for (var item in widget.keranjang) {
      pesan += "• ${item['nama']} (x${item['jumlah']})\n";
    }
    pesan += "\nTOTAL: Rp $grandTotal";

    final Uri url = Uri.parse("https://wa.me/$nomorAdmin?text=${Uri.encodeComponent(pesan)}");
    if (await canLaunchUrl(url)) await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    int grandTotal = widget.keranjang.fold(0, (sum, item) => sum + (item['total'] as int));

    return Scaffold(
      appBar: AppBar(title: Text("Checkout Pesanan"), backgroundColor: Colors.green),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(controller: _namaController, decoration: InputDecoration(labelText: "Nama Pemesan", border: OutlineInputBorder())),
          SizedBox(height: 10),
          TextField(controller: _alamatController, decoration: InputDecoration(labelText: "Alamat Lengkap", border: OutlineInputBorder())),
          SizedBox(height: 20),
          Text("Metode Pengiriman:"),
          RadioListTile(title: Text("Ambil Sendiri"), value: "Ambil Sendiri", groupValue: _metodePengiriman, onChanged: (v) => setState(() => _metodePengiriman = v!)),
          RadioListTile(title: Text("Diantar Kurir"), value: "Diantar Kurir", groupValue: _metodePengiriman, onChanged: (v) => setState(() => _metodePengiriman = v!)),
          DropdownButtonFormField(
            items: ["OVO", "BANK BCA", "Gopay"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => _metodePembayaran = v as String),
            decoration: InputDecoration(labelText: "Metode Pembayaran", border: OutlineInputBorder()),
          ),
          SizedBox(height: 30),
          Text("Total: Rp $grandTotal", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.all(15)),
            onPressed: () {
              if (_namaController.text.isEmpty || _metodePembayaran == null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Lengkapi data pemesan & pembayaran!")));
                return;
              }

              // SIMPAN KE DATA TRANSAKSI
              String daftarMenu = widget.keranjang.map((item) => item['nama']).join(", ");
              Transaksi.tambahTransaksi(_namaController.text, daftarMenu, grandTotal, _metodePembayaran!, "Selesai");

              kirimKeWhatsApp(grandTotal);
              widget.onCheckoutSuccess();
              Navigator.pop(context);
            },
            child: Text("BAYAR SEKARANG", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}