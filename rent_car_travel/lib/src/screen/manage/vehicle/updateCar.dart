import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rent_car_travel/src/constants/api_http.dart';
import 'package:rent_car_travel/src/models/vehicle.dart';
import 'package:http/http.dart' as http;

class UpdateCar extends StatefulWidget {
  final Vehicle vehicle;

  const UpdateCar({Key key, this.vehicle}) : super(key: key);

  @override
  _UpdateCarState createState() => _UpdateCarState();
}

class _UpdateCarState extends State<UpdateCar> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerName =
        TextEditingController(text: widget.vehicle.nameCar);
    TextEditingController _controllerNum =
        TextEditingController(text: '${widget.vehicle.numberOfSeats} chỗ');
    TextEditingController _controllerLp =
        TextEditingController(text: widget.vehicle.licensePlates);
    TextEditingController _controllerDes =
        TextEditingController(text: widget.vehicle.description);
    TextEditingController _controllerPrice =
        TextEditingController(text: '${widget.vehicle.pricePerKm}');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Cập nhật',
          style: TextStyle(color: Colors.blue, fontSize: 18),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _image(widget.vehicle.imageCar),
              _textfeildInfo('Tên xe', _controllerName),
              _textfeildInfo('Chỗ ngồi', _controllerNum),
              _textfeildInfo('Biển số', _controllerLp),
              _textfeildInfo('Giá', _controllerPrice),
              _textFieldDescription('Mô tả', _controllerDes),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buttonCanCel(context),
                  SizedBox(
                    width: 8,
                  ),
                  _buttonConfirm(onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            elevation: 5,
                            title: Text('Cập nhật'),
                            content: Text('Bạn muốn cập nhật ??'),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Hủy'),
                              ),
                              FlatButton(
                                onPressed: () async{
                                  final response = await http.post(ApiHttp.urlListUpdateOpen, body: {
                                    "id": '${widget.vehicle.id}',
                                    "name_vehicle": _controllerName.text,
                                    "mode":"",
                                    "number_of_seats": _controllerNum.text,
                                    "license_plates": _controllerLp.text,
                                    "image": "",
                                    "description": _controllerDes.text,
                                    "price_perKm": _controllerPrice.text,
                                    "status": "1"
                                  });
                                },
                                child: Text('Xác nhận'),
                              )
                            ],
                          );
                        });
                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _image(String image) {
  return CachedNetworkImage(height: 200, fit: BoxFit.fill, imageUrl: image);
}

Widget _textfeildInfo(String title, TextEditingController controller) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(
            title,
            style: TextStyle(
                color: Color(0xFF737373),
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(12),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(213, 213, 213, 0.34))),
            border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(213, 213, 213, 0.34))),
          ),
        )
      ],
    ),
  );
}

Widget _textFieldDescription(String title, TextEditingController controller) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(
            title,
            style: TextStyle(
                color: Color(0xFF737373),
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          controller: controller,
          maxLines: 5,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(12),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(213, 213, 213, 0.34))),
            border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(213, 213, 213, 0.34))),
          ),
        )
      ],
    ),
  );
}

Widget _buttonConfirm({Function onPressed}) {
  return FlatButton(
    onPressed: onPressed,
    child: Text('Xác nhận', style: TextStyle(color: Colors.blue)),
  );
}

Widget _buttonCanCel(BuildContext context) {
  return FlatButton(
    onPressed: () {
      /*showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 5,
              title: Text('Cập nhật'),
              content: Text('Bạn muốn hủy cập nhật ??'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Hủy'),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Xác nhận'),
                )
              ],
            );
          });*/
      Navigator.pop(context);
    },
    child: Text('Hủy', style: TextStyle(color: Colors.blue)),
  );
}
