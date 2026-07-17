import 'package:flutter/material.dart';
import 'dashboard_kasir.dart'; // Pastikan file dashboard_kasir.dart ada di folder lib

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void _cekLogin() {
    // Logika login sederhana
    if (_userController.text == "kasir" && _passController.text == "12345") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MainKasir()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Username atau Password salah!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Kasir")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _userController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: _passController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _cekLogin,
              child: const Text("Masuk"),
            ),
          ],
        ),
      ),
    );
  }
}