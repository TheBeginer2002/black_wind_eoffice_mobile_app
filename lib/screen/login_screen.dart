import 'package:black_wind_eoffice_mobile_app/provider/login_provider.dart';
import 'package:black_wind_eoffice_mobile_app/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();

  final _changeTextField = FocusNode();
  bool _obscureText = true;
  bool _onTextField = false;
  // final _errorLogin = false;

  final Map<String, String> _infoAccount = {'user_name': '', 'password': ''};
  void _changeObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _changeTextField.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Có lỗi xảy ra'),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'))
              ],
            ));
  }

  Future<void> _submit() async {
    _formKey.currentState!.save();
    try {
      await Provider.of<LoginAuth>(context, listen: false).signIn(
          _infoAccount['user_name'] as String,
          _infoAccount['password'] as String);
      if (!mounted) return;
      Navigator.of(context).pushNamed(MainScreen.routeName);
    } on Exception catch (error) {
      // var errorMessage = 'Lỗi không xác định';
      if (error
          .toString()
          .contains('Tên đăng nhập hoặc Mật khẩu đã nhập sai.')) {
        // setState(() {
        //   _errorLogin = true;
        // });
        _showErrorDialog(
            'Tên đăng nhập hoặc Mật khẩu đã nhập sai\nVui Lòng nhập lại');
      } else if (error.toString().contains('validation error')) {
        _showErrorDialog('Không được để tài khoản hoặc mật khẩu để trống');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() {
            _onTextField = false;
          });
        },
        child: Stack(fit: StackFit.expand, children: [
          Positioned(
            top: -100,
            right: -50,
            child: Image.asset(
              'assets/images/login/topImgBg.png',
              height: 300,
              width: 300,
            ),
          ),
          Positioned(
            bottom: -60,
            left: -10,
            child: Image.asset(
              'assets/images/login/bottomImgBg.png',
              height: 300,
              width: 300,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    alignment: Alignment.topCenter,
                    'assets/images/logo.png',
                    height: 100,
                    width: 100,
                  ),
                  Image.asset(
                    alignment: Alignment.bottomCenter,
                    'assets/images/login/BWName.png',
                    height: 200,
                    width: 200,
                  ),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                _onTextField ? 'Đăng Nhập' : 'Chào mừng bạn đến với BLACKWIND',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.85,
                        child: TextFormField(
                          onTap: () {
                            setState(() {
                              _onTextField = true;
                            });
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_changeTextField);
                          },
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15),
                              prefixIcon: SizedBox(
                                  child: Image.asset(
                                'assets/images/login/userName.png',
                                height: 5,
                                width: 5,
                              )),
                              labelText: 'Mã nhân viên',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0))),
                          onSaved: (value) {
                            _infoAccount['user_name'] = value.toString();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Không được để trống';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: sizeScreen.width * 0.85,
                        child: TextFormField(
                          onTap: () {
                            setState(() {
                              _onTextField = true;
                            });
                          },
                          focusNode: _changeTextField,
                          // textAlignVertical: TextAlignVertical.center,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15),
                              prefixIcon: SizedBox(
                                  child: Image.asset(
                                'assets/images/login/pass.png',
                                height: 5,
                                width: 5,
                              )),
                              suffixIcon: IconButton(
                                  onPressed: _changeObscureText,
                                  icon: _obscureText
                                      ? const Icon(Icons.remove_red_eye)
                                      : const Icon(
                                          Icons.remove_red_eye_outlined)),
                              labelText: 'Mật khẩu',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0))),
                          obscureText: _obscureText,
                          onSaved: (value) {
                            _infoAccount['password'] = value.toString();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Không được để trống';
                            }
                            return null;
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(sizeScreen.width * 0.7, 0),
                            shape: const StadiumBorder()),
                        child: const Text('Đăng nhập'),
                      ),
                    ],
                  )),
            ],
          ),
        ]),
      ),
    );
  }
}
