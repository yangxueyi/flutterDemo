import 'package:flutter/material.dart';

import 'Home.dart';
import 'Invest.dart';
import 'Invite.dart';
import 'Account.dart';

class Main extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MainState();

}

class MainState extends State<Main>{

  var list = [Home(),Invest(),Invite(),Account()];
  int bottomIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[bottomIndex],
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: ImageIcon(AssetImage('images/icon_home.png')),title: Text('主页')),
            BottomNavigationBarItem(icon: ImageIcon(AssetImage('images/icon_invest_gray.png')),title: Text('项目')),
            BottomNavigationBarItem(icon: ImageIcon(AssetImage('images/icon_my_gray.png')),title: Text('邀请')),
            BottomNavigationBarItem(icon: ImageIcon(AssetImage('images/icon_invite_gray.png')),title: Text('账户')),
          ],
        currentIndex: bottomIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFFf1523c),
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          setState(() {
            bottomIndex = index;
          });
        },
      ),
    );
  }

}
