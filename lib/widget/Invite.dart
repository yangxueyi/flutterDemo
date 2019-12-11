import 'package:flutter/material.dart';

class Invite extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => InviteState();
  
}

class InviteState extends State<Invite>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('邀请'),
        ),
        backgroundColor: Color(0xFFf1523c),

      ),
    );
  }
  
}