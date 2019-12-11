import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class Account extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountState();
}

class AccountState extends State<Account> {
  var tabs = <Tab>[];

  @override
  void initState() {
    super.initState();
    tabs = [Tab(text: '密码登录'), Tab(text: '验证码登录')];
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color(0xFFF45A42));
    //获取状态栏高度
    var padding = MediaQuery.of(context).padding;
    var max = math.max(padding.top, EdgeInsets.zero.top);
    print(max);

    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(top: max),
      child: Column(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    'images/top_page_pg.png',
                    height: 343.0,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15, left: 15),
                    child: Image.asset(
                      'images/icon_out.png',
                      width: 15,
                      height: 15,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 235,
                    ),
//                    width: MediaQuery.of(context).size.width,
                    height: 287,
                    child: Stack(
                      children: <Widget>[
                        Card(
                          margin: EdgeInsets.only(left: 16, right: 16),
                          color: Colors.white,
                          elevation: 0,
                          child: Container(
                              height: 267,
//                              width: MediaQuery.of(context).size.width,
                              child: DefaultTabController(
                                  length: tabs.length,
                                  initialIndex: 0,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        color: Colors.white,
                                        height: 44,
                                        child: TabBar(
                                          tabs: tabs,
                                          isScrollable: true,
                                          //是否可以滚动
                                          //下划线的设置
                                          indicatorWeight: 2.0,
                                          indicatorColor: Color(0xFFf1523c),
                                          //设置下划线与文字等宽
                                          indicatorSize:
                                              TabBarIndicatorSize.label,

                                          //tab的设置
                                          labelColor: Color(0xFF000000),
                                          labelPadding: EdgeInsets.only(
                                              left: 40.0, right: 40.0),
                                          unselectedLabelColor:
                                              Color(0xFF666666),
                                          labelStyle: TextStyle(fontSize: 14.0),
                                          unselectedLabelStyle:
                                              TextStyle(fontSize: 14.0),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: TabBarView(children: [
                                            password(),
                                            Text('2222222')
                                          ]))
                                    ],
                                  ))),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin:
                              EdgeInsets.only(top: 247, left: 66, right: 66),
                          child: FlatButton(
                            onPressed: () {},
                            child: Container(
                              height: 42,
                              child: Center(
                                child: Text(
                                  '登录',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            color: Color(0xFFf1523c),
                            shape: StadiumBorder(
                                side: new BorderSide(
                              style: BorderStyle.solid,
                              color: Color(0xFFf1523c),
                            )),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
          Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 18, right: 27),
                    color: Color(0xFFd1cfca),
                    height: 0.5,
                  )),
              Image.asset(
                'images/icon_wx.png',
                width: 25,
                height: 20,
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 27, right: 18),
                    color: Color(0xFFd1cfca),
                    height: 0.5,
                  )),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '我已阅读并同意',
                  style: TextStyle(fontSize: 10.0, color: Color(0xFF999999)),
                ),
                GestureDetector(
                  child: Text(
                    '《家家盈用户服务协议》',
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF71B2FD)),
                  ),
                  onTap: () {},
                ),
                GestureDetector(
                  child: Text(
                    '《家家盈隐私政策》',
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF71B2FD)),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget password() {
    return Column(
      children: <Widget>[
        Theme(
            data: ThemeData(
                primaryColor: Color(0xFFEFEFEF), //设置下划线颜色
                cursorColor: Colors.red, //设置光标颜色
                indicatorColor: Colors.red),
            child: TextField(
              style: TextStyle(fontSize: 16.0),
              decoration: InputDecoration(
                  hintText: '请输入手机号码',
                  hintStyle: TextStyle(color: Color(0xFFDBDBDB)),
                  prefixIcon: Image.asset(
                    'images/icon_number.png',
                    width: 5,
                    height: 3,
                  ),
                  border: UnderlineInputBorder(
                      //设置输入框风格
                      borderRadius: BorderRadius.circular(1.0) //设置下划线宽度
                      )),
            )),
        Row(
          children: <Widget>[
            Image.asset('images/icon_number.png', width: 15, height: 18),
            Expanded(
                flex: 1,
                child: TextField(
                  style: TextStyle(fontSize: 15.0),
                  decoration: InputDecoration(
                      hintText: '请输入密码',
                      hintStyle: TextStyle(color: Color(0xFFDBDBDB)),
                      border: InputBorder.none),
                )
            )
          ],
        ),
        Divider(
          color: Colors.red,
        )
      ],
    );
  }
//    return Theme(
//      data: new ThemeData(primaryColor: Colors.red, hintColor: Colors.blue),
//      child: TextField(
//        decoration: InputDecoration(
//          hintText: '请输入手机号码',
//        )
//      ),
//    );
}
