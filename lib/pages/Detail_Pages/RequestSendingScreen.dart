import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rc_kolesa/pages/HomeScreen.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../utilities/Database_Manager.dart';
import '../HomePages/ProfileScreen.dart';

class RequestSendingScreen extends StatefulWidget {
  final String apartmentId;

  RequestSendingScreen({required this.apartmentId});

  @override
  _RequestSendingScreenState createState() => _RequestSendingScreenState();
}

class _RequestSendingScreenState extends State<RequestSendingScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _place = '';
  bool _isPublic = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar_builder(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Apartment ID: ${widget.apartmentId}',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the title';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Place'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the place';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _place = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: ToggleSwitch(
                  activeBgColor: [Color(0xff5a43f3)],
                  cornerRadius: 20.0,
                  minWidth: 90.0,
                  customTextStyles: [
                    TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp),
                  ],
                  initialLabelIndex: 0,
                  totalSwitches: 2,
                  labels: ['Public', 'Private'],
                  onToggle: (index) {
                    _isPublic = index == 0;
                    print('switched to: $index');
                    print('public?: $_isPublic');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: FloatingActionButton.extended(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      //print(_title);
                      //print(_description);
                      //print(_place);
                      //print(_isPublic);
                      DatabaseManager.sendRequest(
                          widget.apartmentId,
                          user!.email.toString(),
                          _title,
                          _description,
                          _place,
                          _isPublic
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: Color(0xff5a43f3),
                            content: Text('Added successfully!', style: TextStyle(color: Colors.white))
                        ),
                      );
                      Get.to(HomeScreen());
                    }
                  },
                  backgroundColor: Color(0xff5a43f3),
                  label: Text(
                    "Send Request",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                  icon: const Icon(Icons.email_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appbar_builder() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 50.w,
      title: Padding(
        padding: EdgeInsets.only(
          left: 14,
          top: 16,
        ),
        child: Text("Send Request",
            style: TextStyle(
                color: Colors.black,
                fontSize: 34.sp,
                fontWeight: FontWeight.bold)),
      ),
      leading: Padding(
        padding: EdgeInsets.only(
          top: 16,
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
