import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gsheets/gsheets.dart';
import 'package:rc_kolesa/pages/HomePages/ProfileScreen.dart';
import 'package:rc_kolesa/utilities/Database_Manager.dart';

class AddApartmentScreen extends StatefulWidget {
  @override
  _AddApartmentScreenState createState() => _AddApartmentScreenState();
}

AnimateIconController _controller = AnimateIconController();

class _AddApartmentScreenState extends State<AddApartmentScreen> {
  final _formKey = GlobalKey<FormState>();
  String _apartmentId = '';
  String _block = '';
  int _number = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: appbar_builder(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Apartment ID'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the apartment ID';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        print("$value");
                        setState(() {
                          _apartmentId = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Block'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the block';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        print("$value");
                        setState(() {
                          _block = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Apartment Number'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the apartment number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        print("$value");
                        setState(() {
                          _number = int.parse(value);
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: FloatingActionButton.extended(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            print(_apartmentId);
                            print(_block);
                            print(_number);
                            bool _Exists = await DatabaseManager.checkApartmentID(_apartmentId);
                            print("here $_Exists");
                            if (_Exists == true) {
                              DatabaseManager.addApartmentToUser(_apartmentId, user!.email.toString());
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Color(0xff5a43f3),
                                    content: Text('Added successfully!', style: TextStyle(color: Colors.white))
                                ),
                              );
                              Get.back();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Color(0xff5a43f3),
                                    content: Text('Error. Try again later', style: TextStyle(color: Colors.white))
                                ),
                              );
                            }
                          }
                        },
                        backgroundColor: Color(0xff5a43f3),
                        label: Text(
                          "Add",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                        icon: const Icon(Icons.add),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
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
        child: Text("Add Apartment",
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
