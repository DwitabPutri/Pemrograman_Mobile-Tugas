import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tgs1_progmob/typo.dart';
import 'package:intl/intl.dart';

GetStorage _storage = GetStorage();

class TransactionDetailPage extends StatefulWidget {
  final int memberId;

  const TransactionDetailPage({Key? key, required this.memberId})
      : super(key: key);

  @override
  _TransactionDetailPageState createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  List<Map<String, dynamic>> _transactions = [];
  Map<int, String> _jenisTransaksiMap = {};
  TextEditingController _tanggalLahirController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
    _fetchJenisTransaksi();
    _tanggalLahirController.text =
        DateFormat('yyyy-MM-dd').format(_selectedDate);
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

        showDialog(
          context: context,
          builder: (BuildContext context) {
            String nomorInduk = anggotaData['nomor_induk'].toString();
            String nama = anggotaData['nama'].toString();
            String alamat = anggotaData['alamat'].toString();
            String telepon = anggotaData['telepon'].toString();
            String tanggalLahir = anggotaData['tgl_lahir'].toString();
            String statusAktif = anggotaData['status_aktif'].toString();
            _selectedDate = DateTime.parse(tanggalLahir);

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
                      controller: _tanggalLahirController,
                      readOnly: true,
                      onTap: () {
                        _selectDate(context);
                      },
                      decoration: InputDecoration(
                        labelText: 'Tanggal Lahir',
                        hintStyle: penjelasanSearch,
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                    TextFormField(
                      initialValue: telepon,
                      onChanged: (value) {
                        telepon = value;
                      },
                      decoration: InputDecoration(
                          labelText: 'Telepon', hintStyle: penjelasanSearch),
                    ),
                    TextFormField(
                      initialValue: statusAktif,
                      onChanged: (value) {
                        statusAktif = value;
                      },
                      decoration: InputDecoration(
                          labelText: 'Status Aktif',
                          hintStyle: penjelasanSearch),
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
                    if (statusAktif != '0' && statusAktif != '1') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Status harus 0 atau 1.')),
                      );
                      return;
                    }

                    try {
                      Response putResponse = await Dio().put(
                        'https://mobileapis.manpits.xyz/api/anggota/$anggotaId',
                        data: {
                          'nomor_induk': nomorInduk,
                          'nama': nama,
                          'alamat': alamat,
                          'tgl_lahir': tanggalLahir,
                          'telepon': telepon,
                          'status_aktif': statusAktif,
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

  void _fetchJenisTransaksi() async {
    try {
      final response = await Dio().get(
        'https://mobileapis.manpits.xyz/api/jenistransaksi',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );

      if (response.statusCode == 200) {
        final jenisTransaksiList = List<Map<String, dynamic>>.from(
            response.data['data']['jenistransaksi']);
        setState(() {
          _jenisTransaksiMap = {
            for (var jenis in jenisTransaksiList) jenis['id']: jenis['trx_name']
          };
        });
      } else {
        print('Failed to load jenis transaksi');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _fetchTransactions() async {
    try {
      final response = await Dio().get(
        'https://mobileapis.manpits.xyz/api/tabungan/${widget.memberId}',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          _transactions = List<Map<String, dynamic>>.from(
              response.data['data']['tabungan']);
          print(response.data['data']['tabungan']);
        });
      } else {
        print('Failed to load transactions');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _DeleteTransaction(BuildContext context, int anggotaId) async {
    try {
      final _response = await Dio().delete(
        'https://mobileapis.manpits.xyz/api/tabungan/$anggotaId',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );

      print(_response.data);

      if (_response.statusCode == 200) {
        print('Tabungan Berhasil Dihapus');
        _fetchTransactions();
      }
    } on DioException catch (e) {
      print('Dio error: $e');
    } catch (error) {
      print('Error: $error');
    }
  }

  void addTransaction(BuildContext context, int anggotaId) async {
    try {
      final anggotaData = await _fetchAnggotaDetails(anggotaId);

      if (anggotaData['status_aktif'] != 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Anggota tidak aktif, tidak dapat membuat transaksi.')),
        );
        return;
      }

      final response = await Dio().get(
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
                            style: TextStyle(fontSize: 16),
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
                      style: TextStyle(fontSize: 16),
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
                  child: Text('Batal', style: TextStyle(fontSize: 16)),
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
                        _fetchTransactions();
                      } else {
                        print('Gagal menambahkan transaksi');
                      }
                    } catch (error) {
                      print('Error: $error');
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text('Simpan', style: TextStyle(fontSize: 16)),
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

  Future<Map<String, dynamic>> _fetchAnggotaDetails(int anggotaId) async {
    try {
      Response response = await Dio().get(
        'https://mobileapis.manpits.xyz/api/anggota/$anggotaId',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );
      if (response.statusCode == 200) {
        return response.data['data']['anggota'];
      } else {
        throw Exception('Failed to load member details');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<double> _fetchSaldo(int anggotaId) async {
    try {
      final response = await Dio().get(
        'https://mobileapis.manpits.xyz/api/saldo/$anggotaId',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );

      if (response.statusCode == 200) {
        return response.data['data']['saldo'];
      } else {
        throw Exception('Failed to load saldo');
      }
    } catch (error) {
      throw Exception('Error: $error');
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
            SizedBox(width: 10),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editAnggotaDetails(context, widget.memberId);
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _fetchTransactions();
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<Map<String, dynamic>>(
              future: _fetchAnggotaDetails(widget.memberId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final userData = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            userData['image_url'] != null
                                ? CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(userData['image_url']),
                                    radius: 50,
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/ponyo.jpg'),
                                    radius: 50,
                                  ),
                            SizedBox(height: 16),
                            Text('Nama: ${userData['nama']}',
                                style: inputField),
                            Text('Nomor Induk: ${userData['nomor_induk']}',
                                style: inputField),
                            Text('Alamat: ${userData['alamat']}',
                                style: inputField),
                            Text('Tanggal Lahir: ${userData['tgl_lahir']}',
                                style: inputField),
                            Text('Telepon: ${userData['telepon']}',
                                style: inputField),
                            Text('Status Aktif: ${userData['status_aktif']}',
                                style: inputField),
                            SizedBox(height: 16),
                            if (userData['image_url'] != null)
                              Image.network(userData['image_url']),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Text('No data');
                }
              },
            ),
            Text(
              'Berapa Banyak Tabunganmu?',
              textAlign: TextAlign.left,
              style: headerOne,
            ),
            SizedBox(height: 8),
            Text(
              'Cek dan kontrol tabungamu di sini ya! Kamu bisa melihat transaksi yang kamu lakukan dengan lengkap!',
              textAlign: TextAlign.left,
              style: penjelasanHome,
            ),
            SizedBox(height: 16),
            FutureBuilder<double>(
              future: _fetchSaldo(widget.memberId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final saldo = snapshot.data!;
                  return Text(
                    'Saldo Tabunganmu: Rp. $saldo',
                    style: tutup,
                  );
                } else {
                  return Text('No data');
                }
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: _transactions.isNotEmpty
                  ? ListView.builder(
                      itemCount: _transactions.length,
                      itemBuilder: (context, index) {
                        var transaction = _transactions[index];
                        return ListTile(
                          title: Text(
                              '${_jenisTransaksiMap[transaction['trx_id']]}',
                              style: tutup),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ID Transaksi: ${transaction['id']}',
                                  style: inputField),
                              Text('Nominal: Rp. ${transaction['trx_nominal']}',
                                  style: inputField),
                              Text('Tanggal: ${transaction['trx_tanggal']}',
                                  style: inputField),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(child: Text('Tidak ada transaksi', style: tutup)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTransaction(context, widget.memberId),
        child: Icon(Icons.add),
      ),
    );
  }
}
