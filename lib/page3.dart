import 'package:flutter/material.dart';
import 'package:tgs1_progmob/page1.dart';
import 'package:tgs1_progmob/page2.dart';
import 'package:tgs1_progmob/page4.dart';
import 'package:tgs1_progmob/typo.dart';

void main() {
  runApp(const Page3());
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

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
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _emailError = false;
  bool _passwordError = false;

  void _validateEmail(String value) {
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    RegExp phoneRegex = RegExp(r'^[0-9]+$');

    bool isEmail = emailRegex.hasMatch(value);
    bool isPhone = phoneRegex.hasMatch(value);

    setState(() {
      _emailError = !(isEmail || isPhone);
    });
  }

  void _validatePassword(String value) {
    bool isValid = value.length >= 1;
    setState(() {
      _passwordError = !isValid;
    });
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
                          'Selamat Datang Kembali!',
                          textAlign: TextAlign.left,
                          style: headerTwo,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17.0),
                        child: Text(
                            'Masuk dengan akunmu agar bisa menggunakan semua fitur yang disediakan oleh Finease!',
                            textAlign: TextAlign.left,
                            style: subheaderOne),
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Image.asset(
                            'assets/images/finance.jpg',
                            width: 250,
                            height: 250,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, left: 18.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/userBlack.png',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Akun',
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
                                controller: _emailController,
                                style: inputField,
                                onChanged: _validateEmail,
                                decoration: InputDecoration(
                                  hintText:
                                      'Masukkan email atau nomor telepon',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0,
                                left: 9.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/padlock.png',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(
                                    height:
                                        4),
                                Text('Password', style: judulTextField2),
                              ],
                            ),
                          ),
                          SizedBox(width: 9),
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 20.0),
                                child: PasswordTextField(
                                  controller: _passwordController,
                                )),
                          ),
                        ],
                      ),
                      if (_emailError)
                        Padding(
                          padding: const EdgeInsets.only(top: 7.0, left: 7.0),
                          child: Text('Email atau nomor telepon tidak valid',
                              style: errorMsg),
                        ),

                      SizedBox(height: 120),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_emailController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty &&
                                !_emailError &&
                                !_passwordError) {
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
                                        SizedBox(
                                            height:
                                                12),
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
                                            'Terima kasih sudah kembali. Selamat menggunakan Finease!',
                                            textAlign: TextAlign
                                                .center,
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
                                        SizedBox(
                                            height:
                                                12),
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
                                            textAlign: TextAlign
                                                .center,
                                            style: inputField,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(
                                0xFF131F20),
                            foregroundColor: Color(0xFFE9EBEB), // Warna teks
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  50.0),
                            ),
                            fixedSize:
                                Size(320, 50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                    width: 8),
                                Text(
                                  'Masuk',
                                  style: teksButtonOne.copyWith(
                                      color: Color(0xFFE9EBEB)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 45.0, right: 45.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Belum punya akun? ',
                                textAlign: TextAlign.center,
                                style: penjelasanOne),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Page2()),
                                );
                              },
                              child: Text('Buat Akun',
                                  textAlign: TextAlign.center,
                                  style: teksMasuk),
                            ),
                          ],
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
                        MaterialPageRoute(builder: (context) => Page1()),
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

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordTextField({Key? key, required this.controller})
      : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: TextField(
              controller: widget.controller,
              style: inputField,
              obscureText: _obscureText,
              decoration: InputDecoration(
                hintText: 'Masukkan password',
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Image.asset(
            _obscureText ? 'assets/images/view.png' : 'assets/images/hide.png',
            width: 20,
            height: 20,
          ),
        ),
      ],
    );
  }
}
