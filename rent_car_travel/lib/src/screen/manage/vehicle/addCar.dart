import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'dart:math' as Math;

import 'package:rent_car_travel/src/constants/api_http.dart';

class AddCar extends StatefulWidget {
  @override
  _AddCarState createState() => _AddCarState();
}

var _currencies = [
  "Tự động",
  "Bán tự động",
  "Cơ bản",
];

class _AddCarState extends State<AddCar> {
  String _valueDropdown = 'Tự động';
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerNum = TextEditingController();
  TextEditingController _controllerLp = TextEditingController();
  TextEditingController _controllerDes = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();

  File _imageUpload;

  Future getImageGallery() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    int rand = new Math.Random().nextInt(100000);

    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, height: 200, width: 200);

    var compressImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));

    setState(() {
      _imageUpload = compressImg;
    });
  }

  Future getImageCamera() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    int rand = new Math.Random().nextInt(100000);

    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image);

    var compressImg = new File("$path/vehicle_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));

    setState(() {
      _imageUpload = compressImg;
    });
  }

  Future upload(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(ApiHttp.urlListAddVehicle);
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile("image", stream, length,
        filename: basename(imageFile.path));
    request.fields['name_vehicle'] = _controllerName.text;
    request.fields['number_of_seats'] = _controllerNum.text;
    request.fields['license_plates'] = _controllerLp.text;
    request.fields['description'] = _controllerDes.text;
    request.fields['mode'] = _valueDropdown;
    request.fields['status'] = '1';
    request.fields['price_perKm'] = _controllerPrice.text;
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      print("Image Uploaded");
    } else {
      print("Upload Failed");
    }
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Text(
          'Thêm mới',
          style: TextStyle(color: Colors.blue, fontSize: 18),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(

            children: <Widget>[
              _buildImagePick(context, _imageUpload),
              SizedBox(
                height: 8,
              ),
              _textfeildInfo('Tên xe', _controllerName),
              _textfeildInfo('Chỗ ngồi', _controllerNum),
              _textfeildInfo('Biển số', _controllerLp),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: 8),
                child: Text(
                  'Cơ chế',
                  style: TextStyle(
                      color: Color(0xFF737373),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              _modeDropdown(),
              SizedBox(
                height: 8,
              ),
              _textfeildInfo('Giá', _controllerPrice),
              _textFieldDescription('Mô tả', _controllerDes),
              SizedBox(
                height: 12,
              ),
              _buttonConfirm(onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        elevation: 5,
                        title: Text('Thông báo'),
                        content: Text('Thêm mới xe ??'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Hủy'),
                          ),
                          FlatButton(
                            onPressed: () async {
                              upload(_imageUpload);

                            },
                            child: Text('Xác nhận'),
                          )
                        ],
                      );
                    });
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _modeDropdown() {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(12),
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
              hintText: 'Please select expense',
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide:
                      BorderSide(color: Color.fromRGBO(213, 213, 213, 0.34)))),
          isEmpty: _valueDropdown == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _valueDropdown,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  _valueDropdown = newValue;
                  state.didChange(newValue);
                });
              },
              items: _currencies.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImagePick(BuildContext context, File _image) {
    return Container(
        height: 200,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: _image != null
                ? Image.file(
                    _image,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )
                : Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        _buttonImagePick('Chụp hình', 'camera',
                            icon: Icons.camera_alt, onPressed: getImageCamera),
                        SizedBox(
                          width: 30,
                        ),
                        _buttonImagePick('Thư viện', 'gallery',
                            icon: Icons.dashboard, onPressed: getImageGallery),
                      ],
                    ),
                  )));
  }

  Widget _buttonImagePick(String title, Object hero,
      {Function onPressed, IconData icon}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FloatingActionButton(
          heroTag: hero,
          backgroundColor: Colors.grey[100],
          onPressed: onPressed,
          child: Icon(icon, color: Colors.black),
        ),
        SizedBox(height: 8),
        Text(title, style: TextStyle(color: Color(0xFF737373), fontSize: 10))
      ],
    );
  }
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

Widget _buttonConfirm({Function onPressed}) {
  return Container(
    width: 150,
    child: FlatButton(
      color: Colors.blue,
      onPressed: onPressed,
      child: Text('Xác nhận', style: TextStyle(color: Colors.white)),
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
