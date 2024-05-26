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

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
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
      }
    } on DioException catch (e) {
      print('Dio error: $e');
    } catch (error) {
      print('Error: $error');
    }
  }

  void _SaldoTabungan(BuildContext context, int anggotaId) async {
    try {
      final _response = await Dio().get(
        'https://mobileapis.manpits.xyz/api/saldo/$anggotaId',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );

      print(_response.data);

      if (_response.statusCode == 200) {
        final saldo = _response.data['data']['saldo'];

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Saldo Tabungan', style: headerTwo),
              content: Text('Saldo Tabunganmu: $saldo', style: headerXMed),
              actions: <Widget>[
                TextButton(
                  child: Text('Tutup', style: simpan),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } on DioException catch (e) {
      print('Dio error: $e');
    } catch (error) {
      print('Error: $error');
    }
  }

  void addTransaction(BuildContext context, int anggotaId) async {
    try {
      // Fetch jenis transaksi
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

    storage.write('anggota_id', anggotaId);
    storage.write('trx_id', trxId);
    storage.write('trx_nominal', trxNominal);
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
              icon: Icon(Icons.add),
              onPressed: () {
                addTransaction(context, widget.memberId);
              },
            ),
            SizedBox(width: 10),
            IconButton(
              icon: Icon(Icons.money),
              onPressed: () {
                _SaldoTabungan(context, widget.memberId);
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
            Text(
              'Berapa Banyak Tabunganmu?',
              textAlign: TextAlign.left,
              style: headerBig,
            ),
            SizedBox(height: 8),
            Text(
              'Cek dan kontrol tabungamu di sini ya! Kamu bisa melihat transaksi yang kamu lakukan dengan lengkap!',
              textAlign: TextAlign.left,
              style: penjelasanHome,
            ),
            SizedBox(height: 16), // Space between text and transaction list
            Expanded(
              child: _transactions.isNotEmpty
                  ? ListView.builder(
                      itemCount: _transactions.length,
                      itemBuilder: (context, index) {
                        var transaction = _transactions[index];
                        return ListTile(
                          title: Text('ID Transaksi: ${transaction['id']}',
                              style: headerXMed),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'ID Jenis Transaksi: ${transaction['trx_id']}',
                                  style: headerMed),
                              Text('Nominal: ${transaction['trx_nominal']}',
                                  style: headerMed),
                              Text('Tanggal: ${transaction['trx_tanggal']}',
                                  style: headerMed),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
