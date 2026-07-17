// lib/whatsapp_service.dart
import 'dart:html' as html;

class WhatsAppService {
  // Fungsi ini harus menerima 4 variabel agar sama dengan yang dipanggil di katalog_page.dart
  static void kirimPesanan(String namaMenu, int harga, String namaPelanggan, String alamat) {
    String nomorKasir = "6281344756135"; // Ganti dengan nomor WhatsApp kamu
    
    String pesan = "Halo Kasir! Saya ingin memesan:\n"
                   "*Menu:* $namaMenu\n"
                   "*Total:* Rp $harga\n"
                   "*Nama:* $namaPelanggan\n"
                   "*Alamat:* $alamat";
                 
    String url = "https://wa.me/$nomorKasir?text=${Uri.encodeComponent(pesan)}";
    
    // Membuka WhatsApp di tab baru
    html.window.open(url, "_blank");
  }
}