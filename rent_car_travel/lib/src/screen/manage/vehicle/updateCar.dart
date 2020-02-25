import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rent_car_travel/src/constants/api_http.dart';
import 'package:rent_car_travel/src/models/vehicle.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;

import 'dart:math' as Math;

class UpdateCar extends StatefulWidget {
  final Vehicle vehicle;

  const UpdateCar({Key key, this.vehicle}) : super(key: key);

  @override
  _UpdateCarState createState() => _UpdateCarState();
}

class _UpdateCarState extends State<UpdateCar> {
  File _imageUpload;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerNum = TextEditingController();
  TextEditingController _controllerLp = TextEditingController();
  TextEditingController _controllerDes = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _controllerName.value = TextEditingValue(text: widget.vehicle.nameCar);
    _controllerNum.value =
        TextEditingValue(text: '${widget.vehicle.numberOfSeats} chỗ');
    _controllerLp.value = TextEditingValue(text: widget.vehicle.licensePlates);
    _controllerDes.value = TextEditingValue(text: widget.vehicle.description);
    _controllerPrice.value =
        TextEditingValue(text: '${widget.vehicle.pricePerKm}');
    super.initState();
  }

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
    var uri = Uri.parse(ApiHttp.urlListUpdateVehicle);

    var request = new http.MultipartRequest("POST", uri);

    var multipartFile = new http.MultipartFile("image", stream, length,
        filename: basename(imageFile.path));
    request.fields['id'] = '${widget.vehicle.id}';
    request.fields['name_vehicle'] = _controllerName.text;
    request.fields['number_of_seats'] = _controllerNum.text;
    request.fields['license_plates'] = _controllerLp.text;
    request.fields['description'] = _controllerDes.text;
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
              Center(
                child: _imageUpload == null
                    ? InkWell(
                        onTap: () {
                          getImageGallery();
                        },
                        child: _image(
                            ApiHttp.urlImageVehicle + widget.vehicle.imageCar))
                    : new Image.file(_imageUpload),
              ),
              SizedBox(height: 12,),
              _textfeildInfo('Tên xe', _controllerName),
              _textfeildInfo('Chỗ ngồi', _controllerNum),
              _textfeildInfo('Biển số', _controllerLp),

              _textfeildInfo('Giá', _controllerPrice),
              _textFieldDescription('Mô tả', _controllerDes),
              SizedBox(height: 12,),
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
  return Container(
    width: 120,
    child: FlatButton(
      color: Colors.blue,
      onPressed: onPressed,
      child: Text('Xác nhận', style: TextStyle(color: Colors.white)),
    ),
  );
}

Widget _buttonCanCel(BuildContext context) {
  return Container(
    width: 120,
    child: FlatButton(
      color: Colors.red,
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
      child: Text('Hủy', style: TextStyle(color: Colors.white)),
    ),
  );
}
