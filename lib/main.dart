import 'package:flutter/material.dart';
import 'package:tgs1_progmob/page1.dart';
import 'package:tgs1_progmob/typo.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false, home: new HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                  child: Text('Mudahkan Pengelolaan Keuangan dengan Finease',
                      textAlign: TextAlign.center, style: penjelasanOne),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Page1()),
                  );
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
