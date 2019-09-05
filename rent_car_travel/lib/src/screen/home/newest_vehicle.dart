import 'package:flutter/material.dart';

class NewestCar extends StatefulWidget {
  @override
  _NewestCarState createState() => _NewestCarState();
}

var listNewCar = [
  {
    "name_car": "Toyota",
    "image":
        "https://www.telegraph.co.uk/content/dam/news/2017/11/11/Lam1_trans_NvBQzQNjv4BqnAdySV0BR-4fDN_-_p756cVfcy8zLGPV4EhRkjQy7tg.jpg?imwidth=450",
  },
  {
    "name_car": "Lamborghini",
    "image":
        "https://image.iol.co.za/image/1/process/620x349?source=https://inm-baobab-prod-eu-west-1.s3.amazonaws.com/public/inm/media/image/iol/2018/11/19/18178133/IOLmot19nov18_Lamborghini_c.jpg&operation=CROP&offset=0x0&resize=1800x1010",
  },
  {
    "name_car": "BMW",
    "image":
        "https://cache.bmwusa.com/cosy.arox?BKGND=TRANSPARENT&HEIGHT=100p&WIDTH=100p&angle=60&brand=WBBI&client=byo&date=20180306&fabric=FNKFD&paint=P0C23&pov=walkaround&resp=png&sa=S027K%2CS02BQ%2CS0322%2CS04U1%2CS0508%2CS0610%2CS07Y9&vehicle=19IC",
  },
  {
    "name_car": "Tesla",
    "image":
        "https://imgix.ranker.com/node_img/26/511299/original/audi-r8-automobile-models-photo-1?w=650&q=50&fm=pjpg&fit=crop&crop=faces",
  },
  {
    "name_car": "Audi",
    "image":
        "https://imgix.ranker.com/node_img/26/511299/original/audi-r8-automobile-models-photo-1?w=650&q=50&fm=pjpg&fit=crop&crop=faces",
  },
  {
    "name_car": "Mecedes ",
    "image":
        "https://images-na.ssl-images-amazon.com/images/I/612z36b4PrL._SX425_.jpg",
  },
];

class _NewestCarState extends State<NewestCar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text('This Newest'),
                  InkWell(
                    onTap: () {},
                    child: Text('See more >'),
                  )
                ],
              )),
          Container(
              child: Column(
            children: <Widget>[
              new Image.network(listNewCar[1]['image']),
              new Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(0.0, 1.0),
                              spreadRadius: 0
                            )
                          ],
                          image: DecorationImage(
                              image: NetworkImage(listNewCar[0]['image']),
                              fit: BoxFit.fitHeight)),
                      height: 100,
                      width: MediaQuery.of(context).size.width / 2.5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                           boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(0.0, 1.0),
                              spreadRadius: 0
                            )
                          ],
                          image: DecorationImage(
                              image: NetworkImage(listNewCar[3]['image']),
                              fit: BoxFit.fitHeight)),
                      height: 100,
                      width: MediaQuery.of(context).size.width / 2.5,
                    ),
                  ],
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
