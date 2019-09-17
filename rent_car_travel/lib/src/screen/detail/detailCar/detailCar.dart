import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/models/vehicle.dart';
class Detail extends StatelessWidget {
  const Detail({
    Key key,
    @required this.data,
  }) : super(key: key);

  final Vehicle data;

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black26)]);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //Seats
              Container(
                  width: 165,
                  height: 75,
                  padding: EdgeInsets.all(10),
                  decoration: decoration,
                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(Icons
                              .airline_seat_recline_extra)),
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              child: Text(
                                'Seats: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                          Container(
                              padding:
                              EdgeInsets.only(top: 5),
                              child: Text(
                                  '${data.numberOfSeats} person')),
                        ],
                      ),
                    ],
                  )),
              Container(
                  width: 165,
                  height: 75,
                  padding: EdgeInsets.all(10),
                  decoration: decoration,
                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(Icons
                              .linear_scale)),
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              child: Text(
                                'Lincense Plates: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                          Container(
                              padding:
                              EdgeInsets.only(top: 5),
                              child: Text(
                                  data.licensePlates)),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    width: 165,
                    height: 75,
                    padding: EdgeInsets.all(10),
                    decoration: decoration,
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            margin:
                            EdgeInsets.only(right: 10),
                            child: Icon(Icons
                                .directions_transit)),
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                child: Text(
                                  'Mode: ',
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.bold),
                                )),
                            Container(
                                padding:
                                EdgeInsets.only(top: 5),
                                child: Text(
                                    '${data.mode}')),
                          ],
                        ),
                      ],
                    )),
                Container(
                    width: 165,
                    height: 75,
                    padding: EdgeInsets.all(10),
                    decoration: decoration,
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            margin:
                            EdgeInsets.only(right: 10),
                            child: Icon(Icons
                                .help)),
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                child: Text(
                                  'Status: ',
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.bold),
                                )),
                            Container(
                                padding:
                                EdgeInsets.only(top: 5),
                                child: Text(
                                    data.status)),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
