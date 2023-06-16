import 'package:sentaku_laundry_apk/pages/register_page.dart';
import 'package:sentaku_laundry_apk/routes/app_route.dart';
import 'package:sentaku_laundry_apk/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffCCE1EA)
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email cannot be empty';
                      } else if (!isEmail(value)) {
                        return 'Email is invalid';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password cannot be empty';
                      } else if (value.length < 8) {
                        return 'Password minimum 8 letters';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffCCE1EA),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              final loginValid = await AuthService.login(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                              setState(() {
                                _isLoading = false;
                              });
                              if (loginValid) {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    AppRoutes.myApp, (route) => false);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (_) => const AlertDialog(
                                    title: Text('Error'),
                                    content:
                                    Text('Invalid login or server error'),
                                  ),
                                );
                              }
                            }
                          },
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : Text(
                            'Sign in'.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ))),
                  const SizedBox(
                    height: 20,
                  ),
                  Text.rich(TextSpan(children: <InlineSpan>[
                    TextSpan(
                        text: 'Do\'nt Have an Account yet? ',
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                    TextSpan(
                      text: 'Register now',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
                    ),
                  ])),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
