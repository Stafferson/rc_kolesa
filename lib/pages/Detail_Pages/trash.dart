import 'package:flutter/material.dart';

class AddApartmentScreen extends StatefulWidget {
  @override
  _AddApartmentScreenState createState() => _AddApartmentScreenState();
}

class _AddApartmentScreenState extends State<AddApartmentScreen> {
  final _formKey = GlobalKey<FormState>();
  String _apartmentId = '';
  String _block = '';
  int _number = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Apartment'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Apartment ID'),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter the apartment ID';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _apartmentId = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Block'),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter the block';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _block = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Apartment Number'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null) {
                    return 'Please enter the apartment number';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _number = int.parse(value);
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Save the apartment to the database
                      // and return to the previous screen
                      Navigator.pop(context, {
                        'apartmentId': _apartmentId,
                        'block': _block,
                        'number': _number
                      });
                    }
                  },
                  child: Text('Add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
