import 'package:flutter/material.dart';
import 'package:tgs1_progmob/typo.dart';

void main() {
  runApp(const Page4());
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintStyle: penjelasanSearch,
                      hintText: 'Cari pengguna, layanan, inf....',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search,
                          color: Colors
                              .grey),
                      contentPadding: EdgeInsets.only(
                          bottom: 19.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/fotodiri.jpeg'),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('Halo, Dwita!',
                  textAlign: TextAlign.left, style: headerTwo),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                  'Bagaimana kondisi keuanganmu belakangan ini? Jika ada masalah, selesaikan dengan Finease, ya!',
                  textAlign: TextAlign.left,
                  style: penjelasanHome),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 25,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0),
                    child: Image.asset(
                      'assets/images/userBlack.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                  title: Text('Pengguna ${index + 1}', style: namaPengguna),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Colors.grey.withOpacity(0.8),
                              BlendMode.srcATop,
                            ),
                            child: Image.asset(
                              'assets/images/emaillogo.png',
                              width: 11,
                              height: 11,
                            ),
                          ),
                          SizedBox(width: 7),
                          Text('putrisuastini22@gmail.com ',
                              style: subheaderOne),
                        ],
                      ),
                      Row(
                        children: [
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Colors.grey.withOpacity(0.8),
                              BlendMode.srcATop,
                            ),
                            child: Image.asset(
                              'assets/images/call.png',
                              width: 11,
                              height: 11,
                            ),
                          ),
                          SizedBox(width: 9),
                          Text('08973953510 ', style: subheaderOne),
                        ],
                      ),
                    ],
                  ),
                  trailing: Image.asset(
                    'assets/images/hamburger.png',
                    width: 15,
                    height: 15,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 55,
        color: const Color.fromARGB(
            255, 255, 255, 255),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {

              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/home.png',
                      width: 21,
                      height: 21),
                  SizedBox(height: 4),
                  Text('Beranda',
                      style:
                          labelNavbar),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/kartu.png',
                      width: 21,
                      height: 21),
                  SizedBox(height: 4),
                  Text('Transaksi',
                      style:
                          labelNavbar),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/kalender.png',
                      width: 21,
                      height: 21),
                  SizedBox(height: 4), 
                  Text('Rencana',
                      style:
                          labelNavbar),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/notifikasi.png',
                      width: 21,
                      height: 21),
                  SizedBox(height: 4),
                  Text('Notifikasi',
                      style:
                          labelNavbar),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
