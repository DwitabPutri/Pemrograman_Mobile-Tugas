import 'package:flutter/material.dart';
import 'package:tgs1_progmob/page1.dart';
import 'package:tgs1_progmob/page5.dart';
import 'package:tgs1_progmob/typo.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

GetStorage _storage = GetStorage();

void main() {
  GetStorage _storage = GetStorage();
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
          MaterialPageRoute(builder: (context) => Page1()),
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

  void _getAnggotaDetails(BuildContext context) async {
    try {
      final _response = await Dio().get(
        'https://mobileapis.manpits.xyz/api/anggota',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );

      print(_response.data);

      if (_response.statusCode == 200) {
        List<dynamic> anggotaList = _response.data['data']['anggotas'];

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnggotaList(anggotaList: anggotaList),
          ),
        );
      }
    } on DioException catch (e) {
      print('Dio error: $e');
    } catch (error) {
      print('Error: $error');
    }
  }

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
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      contentPadding: EdgeInsets.only(bottom: 19.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                _getUserDetails(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
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
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Page5()),
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
                            Text('Tambah Anggota',
                                style: teksButtonTwo),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        goLogout(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF131F20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.logout, color: Colors.white),
                            SizedBox(width: 8),
                            Text('Logout',
                                style: teksButtonTwo),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
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
                _getAnggotaDetails(context);
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
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/kalender.png',
                      width: 21, height: 21),
                  SizedBox(height: 4),
                  Text('Rencana', style: labelNavbar),
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

class AnggotaList extends StatelessWidget {
  void _navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  final List<dynamic> anggotaList;

  const AnggotaList({Key? key, required this.anggotaList}) : super(key: key);

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
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintStyle: penjelasanSearch,
                            hintText: 'Cari pengguna, layanan, inf....',
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            contentPadding: EdgeInsets.only(bottom: 19.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: GestureDetector(
                onTap: () {
                  _AnggotaDetails(context);
                },
                child: Image.asset('assets/images/refresh.png',
                    width: 20, height: 20),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Page4()),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: anggotaList.length,
        itemBuilder: (context, index) {
          var anggota = anggotaList[index];
          return ListTile(
            leading: anggota['image_url'] != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(anggota['image_url']),
                  )
                : CircleAvatar(
                    backgroundImage: AssetImage('assets/images/userabu.png'),
                  ),
            title: Text('${anggota['nama']}', style: headerOne),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nomor Induk: ${anggota['nomor_induk']}',
                    style: inputField),
                Text('Telepon: ${anggota['telepon']}', style: inputField),
                Text('Status Aktif: ${anggota['status_aktif']}',
                    style: inputField),
              ],
            ),
            trailing: Wrap(
              spacing: 8,
              children: [
                IconButton(
                  onPressed: () {
                    _showAnggotaDetails(context, anggota['id']);
                  },
                  icon: Image.asset('assets/images/info.png',
                      width: 24, height: 24),
                ),
                IconButton(
                  onPressed: () {
                    _editAnggotaDetails(context, anggota['id']);
                  },
                  icon: Image.asset('assets/images/edit.png',
                      width: 24, height: 24),
                ),
                IconButton(
                  onPressed: () {
                    _deleteAnggota(context, anggota['id']);
                  },
                  icon: Image.asset('assets/images/trashbin.png',
                      width: 24, height: 24),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _editAnggotaDetails(BuildContext context, int anggotaId) async {
    try {
      Response response = await Dio().get(
        'https://mobileapis.manpits.xyz/api/anggota/$anggotaId',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );

      if (response.statusCode == 200) {
        var anggotaData = response.data['data']['anggota'];

        // Menampilkan AlertDialog untuk mengedit data anggota
        showDialog(
          context: context,
          builder: (BuildContext context) {
            String nomorInduk = anggotaData['nomor_induk'].toString();
            String nama = anggotaData['nama'].toString();
            String alamat = anggotaData['alamat'].toString();
            String tanggalLahir = anggotaData['tgl_lahir'].toString();
            String telepon = anggotaData['telepon'].toString();

            return AlertDialog(
              title: Text(
                'Edit Anggota',
                style: headerOne,
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      initialValue: nomorInduk,
                      onChanged: (value) {
                        nomorInduk = value;
                      },
                      decoration: InputDecoration(
                          labelText: 'Nomor Induk',
                          hintStyle: penjelasanSearch),
                    ),
                    TextFormField(
                      initialValue: nama,
                      onChanged: (value) {
                        nama = value;
                      },
                      decoration: InputDecoration(
                          labelText: 'Nama', hintStyle: penjelasanSearch),
                    ),
                    TextFormField(
                      initialValue: alamat,
                      onChanged: (value) {
                        alamat = value;
                      },
                      decoration: InputDecoration(
                          labelText: 'Alamat', hintStyle: penjelasanSearch),
                    ),
                    TextFormField(
                      initialValue: tanggalLahir,
                      onChanged: (value) {
                        tanggalLahir = value;
                      },
                      decoration: InputDecoration(
                          labelText: 'Tanggal Lahir',
                          hintStyle: penjelasanSearch),
                    ),
                    TextFormField(
                      initialValue: telepon,
                      onChanged: (value) {
                        telepon = value;
                      },
                      decoration: InputDecoration(
                          labelText: 'Telepon', hintStyle: penjelasanSearch),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Batal', style: batal),
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      Response putResponse = await Dio().put(
                        'https://mobileapis.manpits.xyz/api/anggota/$anggotaId',
                        data: {
                          'nomor_induk': nomorInduk,
                          'nama': nama,
                          'alamat': alamat,
                          'tgl_lahir': tanggalLahir,
                          'telepon': telepon,
                        },
                        options: Options(
                          headers: {
                            'Authorization': 'Bearer ${_storage.read('token')}'
                          },
                        ),
                      );

                      if (putResponse.statusCode == 200) {
                        print('Data anggota berhasil diupdate');
                      } else {
                        print('Gagal mengupdate data anggota');
                      }
                    } catch (error) {
                      print('Error: $error');
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Simpan',
                    style: simpan,
                  ),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _showAnggotaDetails(BuildContext context, int anggotaId) async {
    try {
      Response response = await Dio().get(
        'https://mobileapis.manpits.xyz/api/anggota/$anggotaId',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );

      print(response.data);

      if (response.statusCode == 200) {
        final userData = response.data['data']['anggota'];

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Detail Anggota',
                style: headerOne,
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Nama: ${userData['nama']}', style: inputField),
                  Text('Nomor Induk: ${userData['nomor_induk']}',
                      style: inputField),
                  Text('Alamat: ${userData['alamat']}', style: inputField),
                  Text('Tanggal Lahir: ${userData['tgl_lahir']}',
                      style: inputField),
                  Text('Telepon: ${userData['telepon']}', style: inputField),
                  if (userData['image_url'] != null)
                    Image.network(userData['image_url']),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Tutup',
                    style: simpan,
                  ),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _deleteAnggota(BuildContext context, int anggotaId) async {
    try {
      final _response = await Dio().delete(
        'https://mobileapis.manpits.xyz/api/anggota/$anggotaId',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );

      print(_response.data);

      if (_response.statusCode == 200) {
        print('Anggota berhasil dihapus');
      }
    } on DioException catch (e) {
      print('Dio error: $e');
    } catch (error) {
      print('Error: $error');
    }
  }

  void _AnggotaDetails(BuildContext context) async {
    try {
      final _response = await Dio().get(
        'https://mobileapis.manpits.xyz/api/anggota',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );

      print(_response.data);

      if (_response.statusCode == 200) {
        List<dynamic> anggotaList = _response.data['data']['anggotas'];

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnggotaList(anggotaList: anggotaList),
          ),
        );
      }
    } on DioException catch (e) {
      print('Dio error: $e');
    } catch (error) {
      print('Error: $error');
    }
  }
}
