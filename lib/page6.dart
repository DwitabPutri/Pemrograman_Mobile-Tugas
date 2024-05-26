import 'package:flutter/material.dart';
import 'package:tgs1_progmob/page1.dart';
import 'package:tgs1_progmob/page5.dart';
import 'package:tgs1_progmob/page4.dart';
import 'package:tgs1_progmob/page61.dart';
import 'package:tgs1_progmob/typo.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

GetStorage _storage = GetStorage();

void main() {
  GetStorage _storage = GetStorage();
  runApp(const Page6());
}

class Page6 extends StatelessWidget {
  const Page6({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  void getJenisTransaksi(BuildContext context) async {
    try {
      final _response = await Dio().get(
        'https://mobileapis.manpits.xyz/api/jenistransaksi',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );

      print(_response.data);

      if (_response.statusCode == 200) {
        final jenisTransaksi = _response.data['data']['jenistransaksi'];

        List<Widget> transactionWidgets = [];

        for (var transaction in jenisTransaksi) {
          transactionWidgets.add(
            ListTile(
              title: Text(transaction['trx_name'], style: inputField),
              subtitle: Text('ID: ${transaction['id']}', style: inputField),
              trailing: Text('Multiplier: ${transaction['trx_multiply']}',
                  style: inputField),
            ),
          );
        }

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Jenis Transaksi',
                style: headerThree,
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: transactionWidgets,
                ),
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
                'Transaksi Anggota',
                textAlign: TextAlign.left,
                style: headerBig,
              ),
              SizedBox(height: 8),
              Text(
                'Tambah dan lihat transaksi yang dilakukan oleh anggota di sini!',
                textAlign: TextAlign.left,
                style: penjelasanHome,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _getAnggotaDetails(context);
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
                            Text('Tambah Transaksi', style: teksButtonTwo),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        getJenisTransaksi(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 152, 216, 222),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.money, color: Color.fromARGB(255, 8, 1, 50)),
                            SizedBox(width: 8),
                            Text('Jenis Transaksi', style: teksButtonTwoBlck),
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
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Page4()),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/homeline.png', width: 21, height: 21),
                  SizedBox(height: 4),
                  Text('Beranda', style: labelNavbar),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                //_getAnggotaDetails(context);
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
                  Image.asset('assets/images/cardblack.png', width: 21, height: 21),
                  SizedBox(height: 4),
                  Text('Transaksi', style: labelNavbar),
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

class AnggotaList extends StatefulWidget {
  final List<dynamic> anggotaList;

  const AnggotaList({Key? key, required this.anggotaList}) : super(key: key);

  @override
  _AnggotaListState createState() => _AnggotaListState();
}

class _AnggotaListState extends State<AnggotaList> {
  TextEditingController _tanggalLahirController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    _tanggalLahirController.text =
        DateFormat('yyyy-MM-dd').format(_selectedDate);
  }

  void _navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate)
      setState(() {
        _selectedDate = pickedDate;
        _tanggalLahirController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate);
      });
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
              MaterialPageRoute(builder: (context) => Page6()),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: widget.anggotaList.length,
        itemBuilder: (context, index) {
          var anggota = widget.anggotaList[index];
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TransactionDetailPage(memberId: anggota['id']),
                      ),
                    );
                  },
                  icon: Image.asset('assets/images/kartu.png',
                      width: 24, height: 24),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void addTransaction(BuildContext context, int anggotaId) async {
    try {
      Response response = await Dio().get(
        'https://mobileapis.manpits.xyz/api/jenistransaksi',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
          contentType: 'application/x-www-form-urlencoded',
        ),
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> jenistransaksi =
            List<Map<String, dynamic>>.from(
                response.data['data']['jenistransaksi']);

        int selectedTransactionIndex = 0;
        TextEditingController nominalController = TextEditingController();

        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Tambah Transaksi'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    DropdownButtonFormField<int>(
                      value: selectedTransactionIndex,
                      items: List.generate(
                        jenistransaksi.length,
                        (index) => DropdownMenuItem<int>(
                          value: index,
                          child: Text(
                            jenistransaksi[index]['trx_name'],
                            style: inputField,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedTransactionIndex = value!;
                        });
                      },
                    ),
                    TextFormField(
                      controller: nominalController,
                      style: inputField,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Nominal',
                      ),
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
                      Response postResponse = await Dio().post(
                        'https://mobileapis.manpits.xyz/api/tabungan',
                        data: {
                          'anggota_id': anggotaId,
                          'trx_id': jenistransaksi[selectedTransactionIndex]
                              ['id'],
                          'trx_nominal': double.parse(nominalController.text),
                        },
                        options: Options(
                          headers: {
                            'Authorization': 'Bearer ${_storage.read('token')}'
                          },
                        ),
                      );

                      if (postResponse.statusCode == 200) {
                        print('Transaksi berhasil ditambahkan');
                        print(
                            'Detail Transaksi Baru: ${postResponse.data['data']['tabungan']}');
                      } else {
                        print('Gagal menambahkan transaksi');
                      }
                    } catch (error) {
                      print('Error: $error');
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text('Simpan', style: simpan),
                ),
              ],
            );
          },
        );
      } else {
        print('Gagal memuat jenis transaksi.');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _saveUserData(int anggotaId, int trxId, double trxNominal) {
    final storage = GetStorage();

    // Tulis data pengguna yang diperbarui
    storage.write('anggota_id', anggotaId);
    storage.write('trx_id', trxId);
    storage.write('trx_nominal', trxNominal);
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
