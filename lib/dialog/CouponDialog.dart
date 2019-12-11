import 'package:flutter/material.dart';

class CouponDialog{

  static Widget getDialog(BuildContext context,String title,String content,String buttomStr) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Colors.transparent,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 15),
                      width: MediaQuery.of(context).size.width*0.7,
                      height: 160,
                      decoration: BoxDecoration(
                          border:
                          Border.all(color: Colors.white),
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                          color: Colors.white
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 53,bottom: 14),
                            child: Text(
                              title,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666)
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 12,right: 12,bottom: 14),
                            child: Text(
                              content,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF666666)
                              ),
                            ),
                          ),
                          Text(
                            buttomStr,
                            style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFFf1523c)
                            ),
                          )
                        ],
                      ),

                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'images/icon_month_rate.png',
                      width: 50,
                      height: 50,
                    ),
                  ),

                ],
              ),

            ],
          );
        });

  }
}