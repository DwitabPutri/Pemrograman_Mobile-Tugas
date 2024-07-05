import 'package:flutter/material.dart';
import 'package:tgs1_progmob/buatAkun.dart';
import 'package:tgs1_progmob/masukAkun.dart';
import 'package:tgs1_progmob/typo.dart';

void main() {
  runApp(const landingPage());
}

class landingPage extends StatelessWidget {
  const landingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _landingPage();
  }
}

class _landingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 25.0),
                child: Image.asset(
                  'assets/images/Card.png',
                  width: 250,
                  height: 250,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  'Lebih Mudah dan Nyaman dengan Finease',
                  textAlign: TextAlign.center,
                  style: headerOne,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 45.0, right: 45.0),
                child: Text(
                  'Dapatkan pengalaman menyenangkan dalam simpan pinjam dengan Finease di manapun dan kapanpun!',
                  textAlign: TextAlign.center,
                  style: penjelasanOne,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => buatAkun()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF131F20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  fixedSize: Size(320, 50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/user.png',
                        width: 14,
                        height: 14,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Buat Akun Baru',
                        style: teksButtonOne.copyWith(color: Color(0xFFE9EBEB)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 241, 249, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  fixedSize: Size(320, 50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/google.png',
                        width: 14,
                        height: 14,
                      ),
                      SizedBox(width: 8),
                      Text('Lanjutkan dengan Google', style: teksButtonOne),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 30.0, left: 45.0, right: 45.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Sudah punya akun? ',
                        textAlign: TextAlign.center, style: penjelasanOne),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => masukAkun()),
                        );
                      },
                      child: Text('Masuk',
                          textAlign: TextAlign.center, style: teksMasuk),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
              child: Padding(
                padding: EdgeInsets.only(left: 20.0, top: 50.0),
                child: Text('Kembali', style: teksKembaliLanjut),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
