import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_car_travel/src/constants/api_http.dart';
import 'package:rent_car_travel/src/models/place_item.dart';
import 'package:rent_car_travel/src/screen/manage/route/route.dart';
import 'package:rent_car_travel/src/screen/map/place_picker_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:math' as Math;

class AddRoute extends StatefulWidget {
  @override
  _AddRouteState createState() => _AddRouteState();
}

class _AddRouteState extends State<AddRoute> {
  ProgressDialog prLogin;
  PlaceItemRes fromAddress;

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerDes = TextEditingController();
  TextEditingController _controllerPrice4s = TextEditingController();
  TextEditingController _controllerPrice7s = TextEditingController();
  TextEditingController _controllerPrice16s = TextEditingController();

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

  Future upload(File imageFile, BuildContext context) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(ApiHttp.urlListAddRoute);

    var request = new http.MultipartRequest("POST", uri);

    var multipartFile = new http.MultipartFile("image", stream, length,
        filename: basename(imageFile.path));
    request.fields['name_route'] = _controllerName.text;
    request.fields['description'] = _controllerDes.text;
    request.fields['lat'] = fromAddress == null ? '0' : '${fromAddress.lat}';
    request.fields['lng'] = fromAddress == null ? '0' : '${fromAddress.lng}';
    request.fields['price_of_4_seats'] = '${_controllerPrice4s.text}';
    request.fields['price_of_7_seats'] = '${_controllerPrice7s.text}';
    request.fields['price_of_16_seats'] = '${_controllerPrice16s.text}';
    request.fields['rating'] = '4.9';

    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Thông báo"),
            content: Text('Đặt xe thành công. Về trang chủ.'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.popUntil(
                      context,
                      (Route<dynamic> route) => false);
                },
                child: Text('Xác nhận'),
              )
            ],
          );
        },
      );
    } else {
      print("Upload Failed");
    }
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    prLogin = new ProgressDialog(context);
    prLogin.style(
      message: 'Please wait...',
    );
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
              _buildImagePick(context),
              _line(),
              _buildInfo(context),
              SizedBox(
                height: 8,
              ),
              _buttonConfirm(onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        elevation: 5,
                        title: Text('Thông báo'),
                        content: Text('Thêm mới tuyến đường ??'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Hủy'),
                          ),
                          FlatButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              prLogin.show();
                              upload(_imageUpload, context);
                              Future.delayed(Duration(seconds: 5))
                                  .then((value) {
                                prLogin.hide().whenComplete(() {
                                });
                              });
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

  Widget _buildImagePick(BuildContext context) {
    return Container(
      height: 200,
      child: _imageUpload == null
          ? Center(
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
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.file(
                _imageUpload,
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Column(
      children: <Widget>[
        _textfeildInfo('Tên tuyến đường', _controllerName),
        _selectedPickUp(fromAddress == null ? '' : fromAddress.name, () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  PlacePickerPage(fromAddress == null ? "" : fromAddress.name,
                      (place, isFrom) {
                    fromAddress = place;
                    setState(() {});
                  }, true)));
        }),
        _textfeildInfo('Giá xe 4 chỗ', _controllerPrice4s),
        _textfeildInfo('Giá xe 7 chỗ', _controllerPrice7s),
        _textfeildInfo('Giá xe 16 chỗ', _controllerPrice16s),
        _textFieldDescription('Mô tả ', _controllerDes)
      ],
    );
  }

  Widget _selectedPickUp(
    String title,
    Function onPressed,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              'Vị trí',
              style: TextStyle(
                  color: Color(0xFF737373),
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 8),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(213, 213, 213, 0.34)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: _textRoute(title, onPressed: onPressed),
          )
        ],
      ),
    );
  }
}

Widget _textRoute(String title, {Function onPressed}) {
  final TextStyle hintStyle = TextStyle(color: Color(0xFFadadad), fontSize: 12);
  final TextStyle textStyle = TextStyle(color: Colors.black, fontSize: 14);
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: 30,
      alignment: Alignment.centerLeft,
      width: double.maxFinite,
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: title == 'Chọn vị trí' ? hintStyle : textStyle,
      ),
    ),
  );
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

Widget _line() {
  return Container(
    height: 1,
    margin: EdgeInsets.symmetric(vertical: 16),
    color: Color.fromRGBO(213, 213, 213, 0.34),
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
