class Transaksi {
  // 1. Data Transaksi
  static List<Map<String, dynamic>> daftarTransaksi = [];

  static void tambahTransaksi(String nama, String menu, int total, String metode, String status) {
    daftarTransaksi.add({
      "nama": nama,
      "menu": menu,
      "total": total,
      "metode": metode,
      "status": status,
    });
    print("Data transaksi berhasil ditambah: ${daftarTransaksi.length}");
  }

  // 2. Data Ulasan (Agar halaman ulasan tidak error)
  static List<Map<String, String>> daftarUlasan = [
    {"nama": "Andi", "pesan": "Makanannya enak sekali!"},
    {"nama": "Budi", "pesan": "Pelayanan cepat dan ramah."},
  ];

  static void tambahUlasan(String nama, String pesan) {
    daftarUlasan.add({
      "nama": nama,
      "pesan": pesan,
    });
  }
}