import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

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
        ],
      ),
    );
  }
}
