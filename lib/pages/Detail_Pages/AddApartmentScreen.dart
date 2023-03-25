import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
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
                                SnackBar(
                                  backgroundColor: Color(0xff5a43f3),
                                  content: Text('Apartment ID already exists', style: TextStyle(color: Colors.white))
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Apartment added', style: TextStyle(color: Colors.white))
                                ),
                              );
                            }
                            //Navigator.pop(context, {
                            //  'apartmentId': _apartmentId,
                            //  'block': _block,
                            //  'number': _number,
                            //});
                          }
                        },
                        child: Text('Add'),
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
        child: Text("Apartments",
            style: TextStyle(
                color: Colors.black,
                fontSize: 34.sp,
                fontWeight: FontWeight.bold)),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: 16.h,
          ),
          child: AnimateIcons(
            startIcon: Icons.refresh_rounded,
            endIcon: Icons.refresh_rounded,
            size: 28.0,
            // add this tooltip for the start icon
            startTooltip: 'Icons.add_circle',
            // add this tooltip for the end icon
            endTooltip: 'Icons.add_circle_outline',
            controller: _controller,
            onStartIconPress: () {
              setState(() {});
              return true;
            },
            onEndIconPress: () {
              setState(() {});
              return true;
            },
            startIconColor: Colors.white,
            endIconColor: Colors.white,
            duration: Duration(milliseconds: 500),
            clockwise: true,
          ),
        ),
      ],
    );
  }

}
