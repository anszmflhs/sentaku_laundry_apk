import 'package:sentaku_laundry_apk/pages/login_page.dart';
import 'package:sentaku_laundry_apk/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nohpController = TextEditingController();
  final _alamatController = TextEditingController();
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
                    'Sign up',
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
                    controller: _nameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name cannot be empty!!';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Name',
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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
                        return 'Email cannot be empty!!';
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
                    controller: _nohpController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone Number cannot be empty!!';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _alamatController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Address cannot be empty!!';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Address',
                      labelText: 'Address',
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
                        return 'Password cannot be empty!!';
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
                          final registerValid = await AuthService.register(
                              name: _nameController.text,
                              email: _emailController.text,
                              nohp: _nohpController.text,
                              alamat: _alamatController.text,
                              password: _passwordController.text);
                          setState(() {
                            _isLoading = false;
                          });
                          if (registerValid) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginPage(),
                                ),
                                    (_) => false);
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
                        'Sign up'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),),
                  const SizedBox(
                    height: 20,
                  ),
                  Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                        TextSpan(
                          text: 'Sign in',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}