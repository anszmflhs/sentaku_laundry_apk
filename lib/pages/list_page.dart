import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sentaku_laundry_apk/pages/add_order_page.dart';
import 'package:sentaku_laundry_apk/pages/detail_page.dart';
import 'package:sentaku_laundry_apk/services/order_service.dart';

import '../models/order.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool _isLoading = true;
  List<Order> orders = [];

  @override
  void initState() {
    OrderService.getOrders().then((value) {
      log('$value');
      setState(() {
        orders = value!;
        _isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const AddOrderPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 16, top: 24, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('image/burger.png', scale: 3.5),
                      Image.asset('image/sentaku-logo.png', scale: 4),
                      Image.asset('image/settings.png', scale: 12.5),
                    ],
                  ),
                ),
                Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          log('${order.toJson()}');
                          return GestureDetector( onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => DetailPage(order: order))
                          ),
                            child: Card(
                              margin: EdgeInsets.only(left: 16, right: 16),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, top: 8, bottom: 8),
                                    child: Image.asset('image/laundry.png',
                                        width: 80),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Customer Name : ' + order.user.name ??
                                              '',
                                          style:
                                              TextStyle(fontFamily: 'Poppins')),
                                      Text(
                                          'Quantity : ' +
                                                  order.quantity +
                                                  ' Kg' ??
                                              '',
                                          style:
                                              TextStyle(fontFamily: 'Poppins')),
                                      Text(
                                          'Service Name : ' +
                                                  order.servicemanage.title ??
                                              '',
                                          style:
                                              TextStyle(fontFamily: 'Poppins')),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: orders.length))
              ],
            ),
    );
  }
}
