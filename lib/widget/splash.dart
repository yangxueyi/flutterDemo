import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

import '../utils/AppInfoUtils.dart';
import '../utils/DeviceInfoUtils.dart';

import 'main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List list = new List();



  @override
  void initState() {
    super.initState();
    list.add('images/splash_1.png');
    list.add('images/splash_2.png');
    list.add('images/splash_3.png');
    list.add('images/splash_4.png');

    //初始化工具類
    DeviceInfoUtils.getInstance();
    AppInfoUtils.getInstance();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Swiper(
        //加载图片资源
        itemBuilder: (BuildContext context,int index){
          return Image.asset(list[index],fit: BoxFit.fill,);
        },
        itemCount: 4,
        //底部点
//        pagination: new SwiperPagination(),
        //是否无限轮播
        loop: false,
        //是否自动轮播
        autoplay: false,
        onTap: (index){
          if(index == list.length-1){
            //跳转并关闭先前所有页面
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => Main()),
                (route) => route ==null
            );
          }
        },
      ),
    );
  }
}
