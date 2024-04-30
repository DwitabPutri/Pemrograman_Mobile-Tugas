import 'package:flutter/material.dart';
import 'package:tgs1_progmob/page3.dart';
import 'package:tgs1_progmob/page4.dart';
import 'package:tgs1_progmob/typo.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';

GetStorage _storage = GetStorage();

void main() {
  runApp(const Page5());
}

class Page5 extends StatelessWidget {
  const Page5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _nomor_indukController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _tanggalController = TextEditingController();
  TextEditingController _teleponController = TextEditingController();
  TextEditingController _imageController = TextEditingController();

  Future<void> _register() async {
    String nomor_induk = _nomor_indukController.text;
    String name = _nameController.text;
    String alamat = _alamatController.text;
    String tanggal = _tanggalController.text;
    String telepon = _teleponController.text;
    //String image = _imageController.text;

    try {
      Response response = await Dio().post(
        'https://mobileapis.manpits.xyz/api/anggota',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
          contentType: 'application/x-www-form-urlencoded',
        ),
        data: {
          'nomor_induk': nomor_induk,
          'nama': name,
          'alamat': alamat,
          'tgl_lahir': tanggal,
          'telepon': telepon,
          //'image_url' : image,
        },
      );

      print(response.data);
    } catch (error) {
      print('Error: $error');
    }
  }

  void _saveUserData() {
    final storage = GetStorage();
    storage.write('nomor_induk', _nomor_indukController.text);
    storage.write('nama', _nameController.text);
    storage.write('alamat', _alamatController.text);
    storage.write('tgl_lahir', _tanggalController.text);
    storage.write('telepon', _teleponController.text);
    storage.write('image_url', _imageController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3.0, top: 80.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17.0),
                        child: Text(
                          'Selamat Datang!',
                          textAlign: TextAlign.left,
                          style: headerTwo,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17.0),
                        child: Text(
                            'Tambah Anggota agar bisa menggunakan semua fitur yang disediakan oleh Finease!',
                            textAlign: TextAlign.left,
                            style: subheaderOne),
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Image.asset(
                            'assets/images/finance.jpg',
                            width: 230,
                            height: 230,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, left: 18.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/idcard.png',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'No Induk',
                                  style: judulTextField2,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 17),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: TextField(
                                controller: _nomor_indukController,
                                style: inputField,
                                decoration: InputDecoration(
                                  hintText: 'Masukkan nomor induk',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, left: 26.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/userBlack.png',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Nama',
                                  style: judulTextField2,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 17),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: TextField(
                                controller: _nameController,
                                style: inputField,
                                decoration: InputDecoration(
                                  hintText: 'Masukkan nama lengkap',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, left: 23.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/home.png',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Alamat',
                                  style: judulTextField2,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 17),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: TextField(
                                controller: _alamatController,
                                style: inputField,
                                decoration: InputDecoration(
                                  hintText: 'Masukkan alamat',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, left: 18.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/kalender.png',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Tgl Lahir',
                                  style: judulTextField2,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 17),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: TextField(
                                controller: _tanggalController,
                                style: inputField,
                                decoration: InputDecoration(
                                  hintText: 'Tahun-bulan-tanggal',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, left: 18.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/call.png',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Telepon',
                                  style: judulTextField2,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 17),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: TextField(
                                controller: _teleponController,
                                style: inputField,
                                decoration: InputDecoration(
                                  hintText: 'Masukkan nomor',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 17),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_nameController.text.isNotEmpty) {
                              if (_nameController.text.isNotEmpty) {
                                try {
                                  await _register();
                                  _saveUserData();
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Column(
                                          children: [
                                            Center(
                                              child: Image.asset(
                                                'assets/images/accept.png',
                                                width: 80,
                                                height: 80,
                                              ),
                                            ),
                                            SizedBox(height: 12),
                                            Text(
                                              'Sukses!',
                                              style: headerThree,
                                            ),
                                          ],
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Center(
                                              child: Text(
                                                'Anggota telah terdaftar. Selamat menggunakan Finease!',
                                                textAlign: TextAlign.center,
                                                style: inputField,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );

                                  Future.delayed(Duration(seconds: 2), () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Page4()),
                                    );
                                  });
                                } catch (error) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Column(
                                          children: [
                                            Center(
                                              child: Image.asset(
                                                'assets/images/cross.png',
                                                width: 80,
                                                height: 80,
                                              ),
                                            ),
                                            SizedBox(height: 12),
                                            Text(
                                              'Gagal',
                                              style: headerThree,
                                            ),
                                          ],
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Center(
                                              child: Text(
                                                'Terjadi kesalahan saat mendaftar. Silakan coba lagi.',
                                                textAlign: TextAlign.center,
                                                style: inputField,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Column(
                                        children: [
                                          Center(
                                            child: Image.asset(
                                              'assets/images/cross.png',
                                              width: 80,
                                              height: 80,
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            'Gagal',
                                            style: headerThree,
                                          ),
                                        ],
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Center(
                                            child: Text(
                                              'Harap lengkapi dan periksa kembali datamu.',
                                              textAlign: TextAlign.center,
                                              style: inputField,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF131F20),
                            foregroundColor: Color(0xFFE9EBEB),
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
                                Text(
                                  'Tambah Anggota Baru',
                                  style: teksButtonOne.copyWith(
                                    color: Color(0xFFE9EBEB),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page4()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 50.0),
                      child: Text('Kembali', style: teksKembaliLanjut),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
