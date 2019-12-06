import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/screen/profile/profile.dart';
class TabbarSideMenu extends StatelessWidget {
  final String name;

  TabbarSideMenu(this.name, this.avatar);

  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.blueAccent,
                Colors.white,
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp)),
      padding: EdgeInsets.only(left: 10),
      height: 150,
      child: Row(
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    avatar == '' ? 'https://t4.ftcdn.net/jpg/02/68/29/79/500_F_268297980_bleTmBMJomIyWLanB4HrLpnDoEh4vboM.jpg': avatar),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[Text(name != '' ? 'Hi, ${name.toString()}' : 'Hi, user', style: TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold),)],
              ),
            ),
          ),
          Container(
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder) => Profile()));
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
