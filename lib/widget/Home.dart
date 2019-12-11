import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_swiper/flutter_swiper.dart';

import '../utils/HttpUtil.dart';
import '../utils/MoneyUtils.dart';
import '../constans/AppConstants.dart';
import '../bean/home_bean_entity.dart';
import 'InvestDetails.dart';
import 'myWebview.dart';

import '../constans/ApiConstants.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  Future future;

  HomeBeanEntity homeBeanEntity;

  Color borrowColor;
  Color rateColor = Color(0xFFf1523c);
  String addRate = ''; //内部加息
  String borrow;
  Color btnBgColor ;//按钮背景颜色
  Color btnBorderColor;//按钮边框颜色
  Color btnTextColor;//按钮文字颜色
  double btnHeight;//按钮高度
  //按钮下的文字是否显示
  bool visible;

  HomeBeanBusinessobjectLoanlist loanList;

  @override
  void initState() {
    super.initState();

    setState(() {
      future = _getHomeData();
    });
  }

  Future _getHomeData() async {
    var homeData = HttpUtil.post(AppConstans.getIndexInfo, error: (errorMsg) {
      print('---***---' + errorMsg);
    });
    print('----------' + homeData.toString());
    return homeData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          title: Center(
//            child: Text('主页'),
//          ),
//          backgroundColor: Color(0xFFf1523c),
//        ),
        body: FutureBuilder(
            future: future,
            builder: (context, snap) {
              print(snap.data);

              switch (snap.connectionState) {
                case ConnectionState.active:
                  return Text('active');
                case ConnectionState.waiting:
                  return _loading();
                case ConnectionState.none:
                  return Text('none');
                case ConnectionState.done:
                  if (snap.hasError) {
                    return Text(snap.error.toString() + "----========------");
                  }
//                 //若执行正常完成
                  Map<String, dynamic> map = jsonDecode(snap.data.toString());
                  homeBeanEntity = HomeBeanEntity.fromJson(map);
                  return RefreshIndicator(
                      child: CustomScrollView(
                        slivers: <Widget>[
                          _banner(),
                          SliverToBoxAdapter(
                            child: GestureDetector(
                              child: Image.asset('images/infodisclosurebg.png'),
                              onTap: () {
                                _goWeb('信息披露',AppConstans.H5_BaseUrl + AppConstans.infoMenu);
                              },
                            ),
                          ),
                          _homeList()
                          // Next, create a SliverList
                        ],
                      ),
                      onRefresh: _doRefresh);

                default:
                  return Text('还没有开始网络请求');
              }
            }));
  }

  //轮播
  Widget _banner() {
    return SliverToBoxAdapter(

      child: Container(
        height: 200,
        color: Colors.green,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              AppConstans.imageUrl +
                  homeBeanEntity.businessObject.bannerList[index].imageUrl,
              fit: BoxFit.fill,
            );
          },
          itemCount: homeBeanEntity.businessObject.bannerList.length,
          pagination: new SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                  activeColor: Color(0xFFf1523c) //选择的颜色
                  )),
          loop: false,
          autoplay: true,
          onTap: (index) {
            print('$index');
            _goWeb(homeBeanEntity.businessObject.bannerList[index].wxTitle, homeBeanEntity.businessObject.bannerList[index].linkUrl);
          },
        ),
      ),
    );
  }

  //首页列表
  Widget _homeList() {
    // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == homeBeanEntity.businessObject.loanList.length) {
            return Container(
              height: 100,
//              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: ImageIcon(
                          AssetImage('images/icon_notice.png'),
                          color: Color(0xFF999999),
                        ),
                      ),
                      Text(
                        '市场有风险，出借需谨慎',
                        style:
                            TextStyle(color: Color(0xFF999999), fontSize: 12),
                      )
                    ],
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(top: 7.0),
                      child: Text(
                        '《风险提示书》',
                        style: TextStyle(color: Color(0xFF71B2FD), fontSize: 14),
                      ),
                    ),
                    onTap: (){
                      _goWeb('风险提示书', AppConstans.H5_BaseUrl+AppConstans.riskhints);
                    },
                  ),
                ],
              ),
            );
          }
          loanList = homeBeanEntity.businessObject.loanList[index];
          _selectRate();

          return _homeItem(index);
        },
        childCount: homeBeanEntity.businessObject.loanList.length + 1,
      ),
    );
  }

  _homeItem(int index) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Container(
            height: 137,
            child: Column(
              children: <Widget>[
                Container(
                  height: 40,
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 5.0),
                        child: Text(
                          loanList.loanName,
                          style: TextStyle(
                              fontSize: 14.0, color: Color(0xff393a3e)),
                        ),
                      ),
                      Container(
//                            margin: EdgeInsets.only(left: 6.0),
                        padding: EdgeInsets.only(left: 6.0, right: 6.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.0)),
                            border: Border.all(color: borrowColor, width: 0.5)),
                        child: Text(
                          loanList.repayType,
                          style: TextStyle(fontSize: 12.0, color: borrowColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Color(0xffE0E0E0),
                ),
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  //富文本
                                  RichText(
                                    text: TextSpan(
                                        text: loanList.yearRate.split('.')[0] +
                                            '.',
                                        style: TextStyle(
                                            fontFamily: 'Alternate',
                                            fontSize: 30.0,
                                            color: rateColor),
                                        children: [
                                          TextSpan(
                                            text: loanList.yearRate
                                                    .split('.')[1] +
                                                '%',
                                            style: TextStyle(
                                                fontFamily: 'Alternate',
                                                fontSize: 18.0,
                                                color: rateColor),
                                          ),
                                          TextSpan(
                                            text: addRate,
                                            style: TextStyle(
                                                fontFamily: 'Alternate',
                                                fontSize: 18.0,
                                                color: rateColor),
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                              Text(
                                borrow,
                                style: TextStyle(
                                    color: borrowColor, fontSize: 12.0),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              /*Text(
                                loanList.termCount + loanList.termUnit,
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: 18.0,
                                    fontFamily: 'Alternate'),
                              )*/
                              RichText(
                                  text: TextSpan(
                                      text: loanList.termCount,
                                      style: TextStyle(
                                          color: Color(0xff666666),
                                          fontSize: 18.0,
                                          fontFamily: 'Alternate'),
                                      children: [
                                    TextSpan(
                                      text: loanList.termUnit,
                                      style: TextStyle(
                                          color: Color(0xff666666),
                                          fontSize: 11.0,
                                          fontFamily: 'Alternate'),
                                    )
                                  ])),
                              Text(
                                '出借周期',
                                style: TextStyle(
                                    color: Color(0xff666666), fontSize: 12.0),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  GestureDetector(
                                    child: Container(
                                      width: 70.0,
                                      height: btnHeight,
                                      margin: EdgeInsets.only(bottom: 5.0),
                                      decoration: BoxDecoration(
                                          color: btnBgColor,
                                          border: Border.all(color: btnBorderColor, width: 1.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)
                                          ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          loanList.loanStatusDesc,
                                          style: TextStyle(
                                              color: btnTextColor,
                                              fontSize: 12.0),
                                        ),
                                      )
                                    ),
                                    onTap: () {
                                      _onClick(index);
                                    },
                                  ),
                                  Offstage(//控制控件的显示隐藏的控件
                                    offstage: visible,
                                    child: Text(
                                      '剩余${MoneyUtils.exceedunit(loanList.surplusAmount)}',
                                      style: TextStyle(
                                          color: Color(0xff666666),
                                          fontSize: 12.0),
                                    ),
                                  )
                                ])),
                      ],
                    ))
              ],
            ),
          ),

          /*Center(
                  child: Text(
                      homeBeanEntity.businessObject.loanList[index].loanName),
                )*/
          onTap: () {
            _onClick(index);
            print(index);
          },
        ),
        Container(
          height: 10.0,
          color: Color(0xFFF5F5F5),
        ),
      ],
    );
  }

  //根据返回状态，修改item
  _selectRate() {
    var borrowType = loanList.borrowType;
    var loanStatus = loanList.loanStatus;
    var loanType = loanList.loanType;

    if (borrowType == ApiConstans.CONSUME) {
      borrow = '名义利率(年化)';
      borrowColor = Color(0xFFf1523c);
    } else {
      borrow = '利率(年化)';
      borrowColor = Color(0xff888888);
    }

    //开标状态但未到投资时间
    if (loanStatus == ApiConstans.LOAN_STATUS_OPEN) {

      visible = false;

      btnBgColor = Colors.transparent;
      btnBorderColor = Color(0xFFf1523c);
      btnTextColor = Color(0xFFf1523c);
      btnHeight = 20.0;


      //开标状态可以投资 立即投资
    } else if (loanStatus == ApiConstans.LOAN_STATUS_OPENED) {
      visible = false;
      btnBgColor = Color(0xFFf1523c);
      btnBorderColor = Color(0xFFf1523c);
      btnTextColor = Colors.white;
      btnHeight = 20.0;

      //还款中
    } else if (loanStatus == ApiConstans.LOAN_STATUS_DISBURSE) {
      visible = true;
      btnBgColor = Colors.transparent;
      btnBorderColor = Color(0xFFf1523c);
      btnTextColor = Color(0xFFf1523c);
      btnHeight = 25.0;

    } else {
      visible = true;
      borrowColor = Color(0xff888888);
      rateColor = Color(0xFF666666);
      btnBgColor = Colors.transparent;
      btnBorderColor = Color(0xFF666666);
      btnTextColor = Color(0xFF666666);
      btnHeight = 25.0;
    }

    //判断新手，加息，vip
    if (loanType == ApiConstans.LOAN_TYPE_NOVICE) {
    } else if (loanType == ApiConstans.LOAN_TYPE_VIP) {
    } else if (loanType == ApiConstans.LOAN_TYPE_ADDINTEREST) {
      addRate = "+" + loanList.addRate + "%";
    } else {}
  }

  //下拉刷新
  Future<void> _doRefresh() async {
    await Future<Null>.delayed(Duration(seconds: 2), () {
      /**
       *
       * mounted
       * 判断当前页面是否存在于构件树中，防止内存泄露
       * true 表示当前页面挂在到构件树中
       *false 时未挂载当前页面
       */
      if (mounted) {
        setState(() {
          future = _getHomeData();
          return null;
        });
      }
    });
  }

  //进度条
  _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
//          backgroundColor: Color(0xFFf1523c),
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFf1523c)),
        ),
      ),
    );
  }

  //跳转到详情页
  _onClick(int index){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => InvestDetails(homeBeanEntity.businessObject.loanList[index].loanId)));
  }
  //跳转web'
  _goWeb(String title, String url){
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyWebView(title, url)));
  }
}
