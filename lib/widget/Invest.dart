import 'package:flutter/material.dart';

import '../utils/HttpUtil.dart';
import '../constans/AppConstants.dart';
import '../utils/AppInfoUtils.dart';
import '../utils/DeviceInfoUtils.dart';

class Invest extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => InvestState();
  
}

class InvestState extends State<Invest>{
  Future upData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('项目'),
        ),
        backgroundColor: Color(0xFFf1523c),

      ),
      body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                  child: Text(
                    '获取数据',
                  ),
                  onPressed: () {
                    _onClick();

                  }),
              FutureBuilder(
                  future: upData,
                  // ignore: missing_return
                  builder: (context, snap) {
                    print(snap.data);
                    switch (snap.connectionState) {
                      case ConnectionState.active:
                        return Text('active');
                      case ConnectionState.waiting:
//                        return _loading();
                      case ConnectionState.none:
                        return Text('none');
                      case ConnectionState.done:
                        if (snap.hasError) {
                          return Text(snap.error.toString()+"----========------");
                        }
//                        //若执行正常完成
//                        Map<String, dynamic> map = jsonDecode(snap.data.toString());
//                        LoadDetailEntity loanBeanEntity = LoadDetailEntity.fromJson(map);
                        return Expanded( //权重
                          flex: 1,
                          child: Text('成功'),
                        );

                      default:
                        return Text('还没有开始网络请求');

                    }
                  }),

            ],
          )),

    );
  }

  _onClick(){
    setState(() {
      upData = _UpData();
    });
  }

  Future _UpData() async {
    Map<String, String> paras = {
      "loanId": "20190723C128440000000000000001FU",
    };
    var post = HttpUtil.post(AppConstans.queryLoanDetail, data: paras,
//        success: (loadData){
//           loanBeanEntity = LoanBeanEntity.fromJson(loadData);
//          print(loanBeanEntity.loanId);
//        },
        error: (errorMsg) {
          print('------' + errorMsg);
        });
    return post;
  }

  //进度条
  _loading() {
    return  Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  
}