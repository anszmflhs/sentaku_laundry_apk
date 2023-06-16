import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentaku_laundry_apk/locals/secure_storage.dart';
import 'package:sentaku_laundry_apk/main.dart';
import 'package:sentaku_laundry_apk/models/order.dart';
import 'package:sentaku_laundry_apk/pages/list_page.dart';
import 'package:sentaku_laundry_apk/services/order_service.dart';
import 'package:sentaku_laundry_apk/services/price_lists_service.dart';
import 'package:sentaku_laundry_apk/services/service_manages_list_service.dart';

import '../models/user.dart' as userval;

class AddOrderPage extends StatefulWidget {
  const AddOrderPage({Key? key}) : super(key: key);

  @override
  State<AddOrderPage> createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  final nameCustomer = TextEditingController();
  final phoneNumber = TextEditingController();
  final quantity = TextEditingController();
  final others = TextEditingController();
  final serviceName = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool _isLoading = true;
  userval.User? user;

  List<Pricelist> priceList = [];
  List<Servicemanage> serviceManage = [];

  String? smId;
  String? plId;

  @override
  void initState() {
    SecureStorage.getUser().then((value) {
      setState(() {
        user = value;
        nameCustomer.text = value!.name ?? '';
        phoneNumber.text = value!.customer.nohp ?? '';
      });
    });

    PriceListService.getPriceLists().then((value) {
      if (value != null) {
        setState(() {
          priceList = value;
        });
      }
      setState(() {
        _isLoading = false;
      });
    });
    ServiceManageService.getServiceManages().then((value) {
      if (value != null) {
        setState(() {
          serviceManage = value;
        });
      }
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Please input your order :',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: nameCustomer,
                            readOnly: true,
                            enabled: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Nama Customer Tidak Boleh Kosong';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              //
                            },
                            decoration: InputDecoration(
                                hintText: 'Customer Name :',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: phoneNumber,
                            readOnly: true,
                            enabled: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Phone Number Tidak Boleh Kosong';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              //
                            },
                            decoration: InputDecoration(
                                hintText: 'Phone Number :',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          SizedBox(height: 10),
                          _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if(value!.isEmpty){
                                return 'Silakan masukan banyaknya';
                              }
                              return null;
                            },
                                  controller: quantity,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                      hintText: 'Quantity :',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                          SizedBox(height: 10),
                          _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : DropdownButtonFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if(value == null){
                                return 'Pilih lagi';
                              }
                              return null;
                            },
                                  hint: Text('Other :'),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  items: List.generate(
                                      priceList.length,
                                      (index) => DropdownMenuItem(
                                          value: priceList[index].id.toString(),
                                          child: Text(
                                              '${priceList[index].another}'))),
                                  onChanged: (val) {
                                    setState(() {
                                      plId = val.toString();
                                    });
                                  }),
                          SizedBox(height: 10),
                          _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : DropdownButtonFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if(value == null){
                                  return 'Pilih lagi';
                                }
                                return null;
                              },
                                  hint: Text('Service Name :'),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  items: List.generate(
                                      serviceManage.length,
                                      (index) => DropdownMenuItem(
                                          value: serviceManage[index]
                                              .id
                                              .toString(),
                                          child: Text(
                                              '${serviceManage[index].title}'))),
                                  onChanged: (val) {
                                    setState(() {
                                      smId = val.toString();
                                    });
                                  }),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              final data = {
                                'user_id': user?.id.toString(),
                                'service_manages_id': smId.toString(),
                                'price_lists_id': plId.toString(),
                                'quantity': quantity.text.toString(),
                                'status': 'unpaid',
                                'total': '10000'
                              };
                              log(data.toString());
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                await OrderService.createOrder(
                                    user_id: user!.id.toString(),
                                    service_manages_id: smId.toString(),
                                    price_lists_id: plId.toString(),
                                    quantity: quantity.text.toString(),
                                    status: 'unpaid',
                                    total: '10000');
                                // await OrderService.getOrders();

                                setState(() {
                                  _isLoading = false;
                                });
                                if (!mounted) return;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const MyApp(
                                      i: 1,
                                    ),
                                  ),
                                );
                                nameCustomer.clear();
                                phoneNumber.clear();
                                quantity.clear();
                                others.clear();
                                serviceName.clear();
                              } else {
                                // log('Nggak valid' as num);
                              }
                            },
                            child: Text('Order'),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
