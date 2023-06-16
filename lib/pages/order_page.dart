import 'package:flutter/material.dart';
import 'package:sentaku_laundry_apk/pages/add_order_page.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 16, top: 24, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('image/burger.png', scale: 3.5),
                Image.asset('image/sentaku-logo.png', scale: 4),
                Image.asset('image/settings.png', scale: 12.5)
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset('image/laundry-basket.png', scale: 3),
                ),
                Text(
                  'You have no queue',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xffCCE1EA),
                    fontSize: (18),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(left: 32, right: 32),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AddOrderPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff38AAFE),
                        side: BorderSide.none),
                    child: const Text(
                      'Order',
                      style:
                          TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
