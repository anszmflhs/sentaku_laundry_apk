import 'package:flutter/material.dart';
import 'package:sentaku_laundry_apk/locals/secure_storage.dart';
import 'package:sentaku_laundry_apk/main.dart';
import 'package:sentaku_laundry_apk/pages/list_page.dart';
import 'package:sentaku_laundry_apk/services/order_service.dart';
import 'package:sentaku_laundry_apk/services/service_manages_list_service.dart';
import '../models/order.dart';
import '../models/user.dart';

class DetailPage extends StatefulWidget {
  final Order order;

  const DetailPage({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final nameController = TextEditingController();
  final phoneNumController = TextEditingController();
  final quantityController = TextEditingController();
  final otherController = TextEditingController();
  final serviceNameController = TextEditingController();
  bool _isLoading = true;
   User? user;

  // List<Order> orderList = [];
  List<Servicemanage> serviceManage = [];

  @override
  void initState() {
    SecureStorage.getUser().then((value) {
      setState(() {
        user = value!;
        nameController.text = value.name ?? '';
        phoneNumController.text = value.customer.nohp ?? '';
      });
    });
    OrderService.getOrders().then((value) {
      if (value != null) {
        setState(() {
          // orderList = value;
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
  // void initState() {
  //   OrderService.getOrders().then((value) {
  //     log('$value');
  //     setState(() {
  //       order = value!;
  //       _isLoading = false;
  //     });
  //   }).catchError((e) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  //   super.initState();
  // }

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 16, top: 8),
                child: Text(
                  user?.name ?? '',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 4, top: 4),
                child: Image.asset(
                  'image/laundry.png',
                  width: 100,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 8, top: 8),
                    child: Text(
                      'Phone Number : ${widget.order.user.customer.nohp}' ,
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8, top: 2),
                    child: Text(
                      'Quantity : ${widget.order.quantity} Kg',
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8, top: 2),
                    child: Text(
                      'Other : ${widget.order.pricelist.another}',
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8, top: 2),
                    child: Text(
                      'Service Name : ${widget.order.servicemanage.title}',
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    await OrderService.deleteOrder(widget.order.id);
                    if(!mounted) return;
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_){
                      return MyApp(i: 1,);
                    }), (_)=> false);
                  },
                  child: Text('Delete Order')),
            ],
          ),
        ],
      ),
    );
  }
}
