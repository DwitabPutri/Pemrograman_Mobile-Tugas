import 'package:flutter/material.dart';
import 'package:tgs1_progmob/landingPage.dart';
import 'package:tgs1_progmob/tambahAnggota.dart';
import 'package:tgs1_progmob/settingBunga.dart';
import 'package:tgs1_progmob/halamanAnggota.dart';
import 'package:tgs1_progmob/typo.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';


GetStorage _storage = GetStorage();

void main() {
  runApp(const homepage());
}

class homepage extends StatelessWidget {
  const homepage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  void goLogout(BuildContext context) async {
    try {
      final _response = await Dio().get(
        'https://mobileapis.manpits.xyz/api/logout',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );

      print(_response.data);

      if (_response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => landingPage()),
        );
      }
    } on DioException catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
    } catch (error) {
      print('Error: $error');
    }
  }

  void _getUserDetails(BuildContext context) async {
    try {
      final _response = await Dio().get(
        'https://mobileapis.manpits.xyz/api/user',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );

      print(_response.data);

      if (_response.statusCode == 200) {
        final userData = _response.data['data']['user'];

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Detail Pengguna',
                style: headerThree,
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Nama: ${userData['name']}',
                    style: inputField,
                  ),
                  Text(
                    'Email: ${userData['email']}',
                    style: inputField,
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    goLogout(context);
                  },
                  child: Text('Logout', style: tutupmerah),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Tutup', style: tutup),
                ),
              ],
            );
          },
        );
      }
    } on DioException catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                _getUserDetails(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 3.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/fotodiri.jpeg'),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Halo!',
                textAlign: TextAlign.left,
                style: headerBig,
              ),
              SizedBox(height: 8),
              Text(
                'Bagaimana kondisi keuanganmu belakangan ini? Jika ada masalah, selesaikan dengan Finease, ya!',
                textAlign: TextAlign.left,
                style: penjelasanHome,
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => tambahAnggota()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            SizedBox(width: 8),
                            Text('Tambah Anggota', style: teksButtonTwo),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sejauh Mana Pengeluaranmu?',
                  textAlign: TextAlign.left,
                  style: headerMini,
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Eits, jangan sampai pengeluaranmu lebih besar dari pendapatanmu, ya. Lihat grafik pengeluaranmu di sini!',
                  textAlign: TextAlign.left,
                  style: penjelasanHome,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/grafik.png',
                    width: 700,
                    height: 700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 55,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/home.png', width: 21, height: 21),
                  SizedBox(height: 4),
                  Text('Beranda', style: labelNavbar),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnggotaList()),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/nofilluser.png',
                      width: 21, height: 21),
                  SizedBox(height: 4),
                  Text('Anggota', style: labelNavbar),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => settingBunga()),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/kartu.png', width: 21, height: 21),
                  SizedBox(height: 4),
                  Text('Bunga', style: labelNavbar),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/notifikasi.png',
                      width: 21, height: 21),
                  SizedBox(height: 4),
                  Text('Notifikasi', style: labelNavbar),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
