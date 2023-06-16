import 'package:dio/dio.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:sentaku_laundry_apk/constants/api_config.dart';
import 'package:sentaku_laundry_apk/locals/secure_storage.dart';
import 'package:sentaku_laundry_apk/pages/list_page.dart';
import 'package:sentaku_laundry_apk/pages/login_page.dart';
import 'package:sentaku_laundry_apk/pages/order_page.dart';
import 'package:sentaku_laundry_apk/pages/profile_page.dart';
import 'package:sentaku_laundry_apk/routes/app_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true
  ));
  // await SecureStorage.deleteDataLokal();
  final token = await SecureStorage.getToken();
  final isLogin = token != null;
  runApp(MyAppMaterial(
    home: isLogin ? MyApp() : LoginPage(),
  ));
}

class MyAppMaterial extends StatelessWidget {
  MyAppMaterial({Key? key, required this.home}) : super(key: key);
  Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
        home: home);
  }
}

class MyApp extends StatefulWidget {
  final int i;
  const MyApp({Key? key, this.i = 0}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final pages = [
    OrderPage(),
    ListPage(),
    ProfilePage(),
  ];
  int _index = 0;

  @override
  Widget build(BuildContext context) {

   if(widget.i != 0){
     setState(() {
       _index = widget.i;
     });
   }
    return Scaffold(
      body: DoubleBackToCloseApp(child: pages[_index],
      snackBar: SnackBar(content: Text('Tekan lagi untuk keluar aplikasi')),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xffCCE1EA),
        unselectedItemColor: Colors.grey,
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Image.asset('image/clothes-hanger.png',
                  width: 30, height: 30),
              label: 'Order'),
          BottomNavigationBarItem(
              icon: Image.asset('image/delivery-truck.png',
                  width: 35, height: 35),
              label: 'List'),
          BottomNavigationBarItem(
              icon: Image.asset('image/profile.png', width: 30, height: 30),
              label: 'Profile'),
        ],
      ),
    );
  }
}
