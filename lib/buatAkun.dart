import 'package:flutter/material.dart';
import 'package:tgs1_progmob/masukAkun.dart';
import 'package:tgs1_progmob/typo.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const buatAkun());
}

class buatAkun extends StatelessWidget {
  const buatAkun({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  bool _passwordError = false;
  bool _confirmPasswordError = false;
  bool _agreedToTerms = false;
  bool _confirmObscureText = true;

  void _validatePassword(String value) {
    bool isValid = value.length >= 6;
    setState(() {
      _passwordError = !isValid;
    });
  }

  void _validateConfirmPassword(String value) {
    bool isValid = value == _passwordController.text;
    setState(() {
      _confirmPasswordError = !isValid;
    });
  }

  Future<void> _register() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      Response response = await Dio().post(
        'https://mobileapis.manpits.xyz/api/register',
        data: {
          'name': username,
          'email': email,
          'password': password,
        },
        options: Options(
          contentType: 'application/x-www-form-urlencoded',
        ),
      );

      if (response.statusCode == 200) {
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
                      'Akunmu telah terdaftar. Login terlebih dahulu, ya!',
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
            MaterialPageRoute(builder: (context) => masukAkun()),
          );
        });
      }

      print(response.data);
    } catch (error) {
      print('Error: $error');
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
  }

  void _saveUserData() {
    final storage = GetStorage();

    storage.write('name', _usernameController.text);
    storage.write('email', _emailController.text);
    storage.write('password', _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                            'Buat akun agar bisa menggunakan semua fitur yang disediakan oleh Finease!',
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
                                const EdgeInsets.only(top: 10.0, left: 10.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/userBlack.png',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Username',
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
                                controller: _usernameController,
                                style: inputField,
                                decoration: InputDecoration(
                                  hintText: 'Masukkan user name',
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
                                const EdgeInsets.only(top: 10.0, left: 20.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/emaillogo.png',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Email',
                                  style: judulTextField2,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 17),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 20.0),
                              child: TextField(
                                controller: _emailController,
                                style: inputField,
                                decoration: InputDecoration(
                                  hintText: 'Masukkan alamat email',
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
                                const EdgeInsets.only(top: 10.0, left: 11.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/padlock.png',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(height: 4),
                                Text('Password', style: judulTextField2),
                              ],
                            ),
                          ),
                          SizedBox(width: 9),
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 20.0),
                                child: PasswordTextField(
                                  controller: _passwordController,
                                )),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, left: 8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: Image.asset(
                                    'assets/images/padlock.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text('Konfirmasi', style: judulTextField2),
                              ],
                            ),
                          ),
                          SizedBox(width: 7),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 20.0),
                              child: TextField(
                                controller: _confirmPasswordController,
                                style: inputField,
                                obscureText: _confirmObscureText,
                                decoration: InputDecoration(
                                  hintText: 'Ulangi password',
                                ),
                                onChanged: _validateConfirmPassword,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _confirmObscureText = !_confirmObscureText;
                                });
                              },
                              child: Image.asset(
                                _confirmObscureText
                                    ? 'assets/images/view.png'
                                    : 'assets/images/hide.png',
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_confirmPasswordError)
                        Padding(
                          padding: const EdgeInsets.only(top: 7.0, left: 7.0),
                          child: Text('Password tidak sesuai', style: errorMsg),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0, right: 10.0),
                        child: Row(
                          children: [
                            Checkbox(
                              value: _agreedToTerms,
                              onChanged: (bool? value) {
                                setState(() {
                                  _agreedToTerms = value ?? false;
                                });
                              },
                              activeColor: Color.fromARGB(255, 0, 115, 15),
                            ),
                            Expanded(
                              child: Text(
                                'Dengan mengakses atau menggunakan layanan kami, Anda menyetujui syarat dan ketentuan yang berlaku.',
                                style: termsandCondition,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 17),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_emailController.text.isNotEmpty &&
                                _emailController.text.contains('@') &&
                                _emailController.text.contains('.')) {
                              if (_passwordController.text.isNotEmpty &&
                                  _confirmPasswordController.text.isNotEmpty &&
                                  _usernameController.text.isNotEmpty) {
                                await _register();
                                _saveUserData();
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
                                            'Alamat email tidak valid. Harap periksa kembali.',
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
                                  'Buat Akun Baru',
                                  style: teksButtonOne.copyWith(
                                    color: Color(0xFFE9EBEB),
                                  ),
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
                            Text('Sudah punya akun? ',
                                textAlign: TextAlign.center,
                                style: penjelasanOne),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => masukAkun()),
                                );
                              },
                              child: Text('Masuk',
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
                      Navigator.pushNamed(context, '/utama');
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
              onChanged: (value) {
                _HomeScreenState homeScreenState =
                    context.findAncestorStateOfType<_HomeScreenState>()!;
                homeScreenState._validatePassword(value);
              },
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
