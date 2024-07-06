import 'package:flutter/material.dart';
import 'package:tgs1_progmob/detailAnggota.dart';
import 'package:tgs1_progmob/homepage.dart';
import 'package:tgs1_progmob/tambahAnggota.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tgs1_progmob/typo.dart';

GetStorage _storage = GetStorage();

class AnggotaList extends StatefulWidget {
  @override
  _AnggotaListState createState() => _AnggotaListState();
}

class _AnggotaListState extends State<AnggotaList> {
  List<dynamic> anggotaList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getAnggotaDetails();
  }

  void getAnggotaDetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      final _response = await Dio().get(
        'https://mobileapis.manpits.xyz/api/anggota',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );

      print('Response: ${_response.data}');

      if (_response.statusCode == 200) {
        setState(() {
          anggotaList = _response.data['data']['anggotas'] ?? [];
        });
      } else {
        print('Gagal Mengambil Data Anggota');
      }
    } on DioException catch (e) {
      print('Dio error: $e');
    } catch (error) {
      print('Error: $error');
    }

    setState(() {
      isLoading = false;
    });
  }

  void _deleteAnggota(BuildContext context, int anggotaId) async {
    try {
      final _response = await Dio().delete(
        'https://mobileapis.manpits.xyz/api/anggota/$anggotaId',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );

      if (_response.statusCode == 200) {
        setState(() {
          anggotaList.removeWhere((anggota) => anggota['id'] == anggotaId);
        });
      }
    } on DioException catch (e) {
      print('Dio error: $e');
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> activeAnggota =
        anggotaList.where((anggota) => anggota['status_aktif'] == 1).toList();
    List<dynamic> inactiveAnggota =
        anggotaList.where((anggota) => anggota['status_aktif'] == 0).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: GestureDetector(
                onTap: () {
                  getAnggotaDetails();
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
              MaterialPageRoute(builder: (context) => homepage()),
            );
          },
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: anggotaList.isNotEmpty
                        ? ListView(
                            children: [
                              if (activeAnggota.isNotEmpty) ...[
                                Text(
                                  'Anggota Aktif',
                                  style: headerOne,
                                ),
                                Text(
                                  'Ini adalah anggota yang saat ini berstatus aktif ya!',
                                  textAlign: TextAlign.left,
                                  style: penjelasanHome,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: activeAnggota.length,
                                  itemBuilder: (context, index) {
                                    var anggota = activeAnggota[index];
                                    return ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      leading: anggota['image_url'] != null
                                          ? CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  anggota['image_url']),
                                            )
                                          : CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  'assets/images/ponyo.jpg'),
                                            ),
                                      title: Text(
                                        '${anggota['nama']}',
                                        style: headerMini,
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Status: ${anggota['status_aktif'] == 1 ? "Aktif" : "Tidak Aktif"}',
                                              style: inputField),
                                        ],
                                      ),
                                      trailing: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5.0),
                                          child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            detailPengguna(
                                                                memberId:
                                                                    anggota[
                                                                        'id']),
                                                      ),
                                                    );
                                                  },
                                                  icon: Image.asset(
                                                    'assets/images/info.png',
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                IconButton(
                                                  onPressed: () {
                                                    _deleteAnggota(
                                                        context, anggota['id']);
                                                  },
                                                  icon: Image.asset(
                                                    'assets/images/trashbin.png',
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                ),
                                              ])),
                                    );
                                  },
                                ),
                              ],
                              SizedBox(height: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (inactiveAnggota.isNotEmpty) ...[
                                    Text(
                                      'Anggota Tidak Aktif',
                                      style: headerMini,
                                    ),
                                    Text(
                                      'Ini adalah semua anggota tidak aktif',
                                      textAlign: TextAlign.left,
                                      style: penjelasanHome,
                                    ),
                                  ]
                                ],
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: inactiveAnggota.length,
                                itemBuilder: (context, index) {
                                  var anggota = inactiveAnggota[index];
                                  if (anggota != null) {
                                    return ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      leading: anggota['image_url'] != null
                                          ? CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  anggota['image_url']),
                                            )
                                          : CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  'assets/images/ponyo.jpg'),
                                            ),
                                      title: Text(
                                        '${anggota['nama']}',
                                        style: headerMini,
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Status: ${anggota['status_aktif'] == 1 ? "Aktif" : "Tidak Aktif"}',
                                              style: inputField),
                                        ],
                                      ),
                                      trailing: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5.0),
                                          child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            detailPengguna(
                                                                memberId:
                                                                    anggota[
                                                                        'id']),
                                                      ),
                                                    );
                                                  },
                                                  icon: Image.asset(
                                                    'assets/images/info.png',
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                IconButton(
                                                  onPressed: () async {
                                                    _deleteAnggota(
                                                        context, anggota['id']);
                                                  },
                                                  icon: Image.asset(
                                                    'assets/images/trashbin.png',
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                ),
                                              ])),
                                    );
                                  }
                                },
                              ),
                            ],
                          )
                        : Center(
                            child: Text('Belum ada anggota yang ditambahkan',
                                style: tutup)),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => tambahAnggota()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
