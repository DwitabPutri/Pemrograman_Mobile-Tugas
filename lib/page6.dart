import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tgs1_progmob/typo.dart';

GetStorage _storage = GetStorage();

class Page6 extends StatefulWidget {
  @override
  _Page6State createState() => _Page6State();
}

class _Page6State extends State<Page6> {
  List<Map<String, dynamic>> _settingsBunga = [];
  TextEditingController _persenController = TextEditingController();
  TextEditingController _isaktifController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSettingsBunga();
  }

  void _fetchSettingsBunga() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await Dio().get(
        'https://mobileapis.manpits.xyz/api/settingbunga',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        if (data != null &&
            data['settingbungas'] != null &&
            data['settingbungas'] is List) {
          setState(() {
            _settingsBunga =
                List<Map<String, dynamic>>.from(data['settingbungas']);
          });
        } else {
          print('Invalid data format');
        }
      } else {
        print('Failed to load settings bunga');
      }
    } catch (error) {
      print('Error: $error');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _addSettingBunga(BuildContext context) async {
    try {
      final persen = double.parse(_persenController.text);
      final isaktif = int.parse(_isaktifController.text);

      if (isaktif != 0 && isaktif != 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Nilai isaktif harus 0 atau 1.')),
        );
        return;
      }

      final response = await Dio().post(
        'https://mobileapis.manpits.xyz/api/addsettingbunga',
        data: {
          'persen': persen,
          'isaktif': isaktif,
        },
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );

      if (response.statusCode == 200) {
        print('Setting bunga berhasil ditambahkan');
        _fetchSettingsBunga();
      } else {
        print('Gagal menambahkan setting bunga');
      }
    } catch (error) {
      print('Error: $error');
    }

    Navigator.of(context).pop();
  }

  void _showAddSettingBungaDialog(BuildContext context) {
    _persenController.clear();
    _isaktifController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Tambah Setting Bunga',
            style: headerOne,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _persenController,
                decoration: InputDecoration(
                    labelText: 'Persen', hintStyle: penjelasanSearch),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                controller: _isaktifController,
                decoration: InputDecoration(
                    labelText: 'Isaktif', hintStyle: penjelasanSearch),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal', style: batal),
            ),
            TextButton(
              onPressed: () {
                _addSettingBunga(context);
              },
              child: Text('Simpan', style: simpan),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Pisahkan bunga yang aktif dari yang tidak aktif
    List<Map<String, dynamic>> activeBunga =
        _settingsBunga.where((setting) => setting['isaktif'] == 1).toList();
    List<Map<String, dynamic>> inactiveBunga =
        _settingsBunga.where((setting) => setting['isaktif'] == 0).toList();

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
            SizedBox(width: 10),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _fetchSettingsBunga();
              },
            ),
          ],
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _settingsBunga.isNotEmpty
                        ? ListView(
                            children: [
                              if (activeBunga.isNotEmpty) ...[
                                Text(
                                  'Bunga Aktif',
                                  style: headerOne,
                                ),
                                Text(
                                  'Ini adalah bunga yang saat ini berstatus aktif ya!',
                                  textAlign: TextAlign.left,
                                  style: penjelasanHome,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: activeBunga.length,
                                  itemBuilder: (context, index) {
                                    var setting = activeBunga[index];
                                    return ListTile(
                                      title: Text('Id Bunga: ${setting['id']}',
                                          style: tutup),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Persen: ${setting['persen']}%',
                                              style: inputField),
                                          Text(
                                              'Aktif: ${setting['isaktif'] == 1 ? "Ya" : "Tidak"}',
                                              style: inputField),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                              SizedBox(height: 16),
                              Text(
                                'Semua Pengaturan Bunga',
                                style: headerMini,
                              ),
                              Text(
                                'Ini adalah semua setting bunga yang pernah ditambahkan',
                                textAlign: TextAlign.left,
                                style: penjelasanHome,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: inactiveBunga.length,
                                itemBuilder: (context, index) {
                                  var setting = inactiveBunga[index];
                                  return ListTile(
                                    title: Text('Id Bunga: ${setting['id']}',
                                        style: tutup),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Persen: ${setting['persen']}%',
                                            style: inputField),
                                        Text(
                                            'Aktif: ${setting['isaktif'] == 1 ? "Ya" : "Tidak"}',
                                            style: inputField),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                        : Center(
                            child: Text('Tidak ada pengaturan bunga',
                                style: tutup)),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSettingBungaDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
