import 'package:flutter/material.dart';

class SelectCar extends StatefulWidget {
  @override
  _SelectCarState createState() => _SelectCarState();
}

class _SelectCarState extends State<SelectCar> {
  String dropdownValue = 'Chọn';
  List<String> _items = <String>['Chọn', '4 chỗ', '7 chỗ', '16 chỗ'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200,
            ),
            _dropdownSelectCar(_items),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButton(
        onPressed: () {},
      ),
    );
  }

  Widget _dropdownSelectCar(List<String> _itemss) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
            ),
            isEmpty: dropdownValue == '',
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: dropdownValue,
                isDense: true,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    state.didChange(newValue);
                  });
                },
                items: _itemss.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _buildBottomButton({Function onPressed}) {
  return Container(
    height: 56,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(14),
        topRight: Radius.circular(14),
      ),
      boxShadow: [
        BoxShadow(blurRadius: 4, color: Colors.grey, spreadRadius: 0),
      ],
    ),
    padding: EdgeInsets.all(12),
    child: MaterialButton(
      elevation: 5,
      onPressed: onPressed,
      color: Colors.blueAccent,
      child: Text(
        'Next',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
