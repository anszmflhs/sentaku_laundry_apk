import 'package:flutter/material.dart';
import 'package:sentaku_laundry_apk/locals/secure_storage.dart';
import 'package:sentaku_laundry_apk/models/user.dart';
import 'package:sentaku_laundry_apk/pages/login_page.dart';
import 'package:sentaku_laundry_apk/services/auth_service.dart';
import 'package:sentaku_laundry_apk/utils/utils.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nohpController = TextEditingController();
  final _alamatController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  late User user;

  void getUser() {
    SecureStorage.getUser().then((value) {
      if (value != null) {
        setState(() {
          user = value;
        });
      }
    });
  }

  @override
  void initState() {
    getUser();
    // if (!mounted) return;
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   log('TIME $timeStamp');
    //   getUser();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        initialData: null,
        future: SecureStorage.getUser(),
        builder: (BuildContext, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                _nameController.text = user.name;
                _emailController.text = user.email;
                _nohpController.text = user.customer.nohp;
                _alamatController.text = user.customer.alamat;
                return Center(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          // borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'image/blankprofile.png',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        user.name,
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 24),
                      ),
                      Text(
                        user.email,
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 26, right: 26, top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              user.customer.nohp,
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                            Text(
                              user.customer.alamat,
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 340,
                        child: ElevatedButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Apakah kamu yakin logout?'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      bool isLogout = false;
                                      Navigator.of(context).pop();
                                      await Utils.dialog(context, () async {
                                        final res = await AuthService.logout();
                                        setState(() {
                                          isLogout = res;
                                        });
                                      });
                                      if (isLogout) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage(),
                                            ));
                                        await SecureStorage.deleteDataLokal();
                                      }
                                    },
                                    child: const Text('Ya'),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Tidak'),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Colors.deepOrangeAccent),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffCF3C3C),
                              side: BorderSide.none),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
