import 'package:flutter/material.dart';
import 'package:tgs1_progmob/landingPage.dart';
import 'package:tgs1_progmob/buatAkun.dart';
import 'package:tgs1_progmob/masukAkun.dart';
import 'package:tgs1_progmob/homepage.dart';
import 'package:tgs1_progmob/tambahAnggota.dart';
import 'package:tgs1_progmob/typo.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Mengatur halaman awal (bisa juga menggunakan home)
      routes: {
        '/': (context) => HomeScreen(), // Halaman awal
        '/utama': (context) => landingPage(),
        '/register': (context) => buatAkun(),
        '/login': (context) => masukAkun(),
        '/home': (context) => homepage(),
        '/tambahanggota': (context) => tambahAnggota(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5.0),
                  child: Image.asset(
                    'assets/images/LogoFinease.png',
                    width: 143,
                    height: 143,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90.0),
                  child: Text(
                    'Simpan Pinjam Mudah dengan Finease',
                    textAlign: TextAlign.center,
                    style: penjelasanOne,
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/utama'); // Navigasi ke halaman Page1
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.0, top: 50.0),
                  child: Text('Lanjut', style: teksKembaliLanjut),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
