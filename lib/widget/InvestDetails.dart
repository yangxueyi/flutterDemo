import 'package:flutter/material.dart';

import 'dart:convert';

import '../utils/HttpUtil.dart';
import '../constans/AppConstants.dart';
import '../bean/invest_detail_entity.dart';
import '../constans/ApiConstants.dart';
import '../constans/StrConstants.dart';
import '../utils/MoneyUtils.dart';
import '../dialog/CouponDialog.dart';

import 'myWebview.dart';

class InvestDetails extends StatefulWidget {
  String loanId;

  InvestDetails(this.loanId, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InvestDetailsState(loanId);
}

class InvestDetailsState extends State<InvestDetails> {
  Future investData;
  final String loanId;

  String borrow;
  InvestDetailBusinessobject investDetailBean;

  String addRate = '';
  String yuan;
  String estimateRate;
  String getMonDate;
  String endInterest;
  Color loanStatusColor;
  String dialogTilte = '优惠券';
  String dialogContent;
  String dialogButtom = '';
  String dialogTilte1;
  String dialogContent1;
  String dialogButtom1 = '';

  InvestDetailsState(this.loanId);

  @override
  void initState() {
    super.initState();
    setState(() {
      investData = _getInvestDetail();
    });
  }

  Future _getInvestDetail() {
    Map<String, String> paras = {
      "loanId": loanId,
    };
    var investDetail = HttpUtil.post(
        AppConstans.BaseUrl + AppConstans.queryLoanDetail,
        data: paras, error: (errorMsg) {
//      print(errorMsg);
    });
    return investDetail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('项目详情'),
        ),
        backgroundColor: Color(0xFFf1523c),
        elevation: 0,
        actions: <Widget>[
          Center(
            child: Container(
                margin: EdgeInsets.only(right: 15.0),
                child: GestureDetector(
                  child: Text(
                    '协议',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  onTap: () {
                    print('?tempId=' + investDetailBean.protocolTempId);
                    _goWeb(
                        '借款协议(范本)',
                        AppConstans.H5_BaseUrl +
                            AppConstans.H5_PROTOCOL +
                            "?tempId=" +
                            investDetailBean.protocolTempId);
                  },
                )),
          )
        ],
      ),
      body: FutureBuilder(
        future: investData,
        builder: (context, snap) {
          print(snap.data);
          switch (snap.connectionState) {
            case ConnectionState.active:
              return Text('active');
            case ConnectionState.waiting:
              return _loading();
//              return Text("loading");
            case ConnectionState.none:
              return Text('none');
            case ConnectionState.done:
              if (snap.hasError) {
                return Text(snap.error.toString() + "----========------");
              }
//                 //若执行正常完成
              Map map = jsonDecode(snap.data.toString());
              investDetailBean =
                  InvestDetailEntity.fromJson(map).businessObject;
              _selectRate();
              return _detailsPage();

            default:
              return Text('还没有开始网络请求');
          }
        },
      ),
    );
  }

  Widget _detailsPage() {
    return Column(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Container(
                child: Stack(children: <Widget>[
              Image.asset(
                'images/top_page_pg.png',
                height: 277.0,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
              Container(
                margin: EdgeInsets.only(top: 22, left: 33),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      investDetailBean.loanTitle,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 14),
                            child: RichText(
                              text: TextSpan(
                                  text: investDetailBean.yearRate + '%',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50,
                                      fontFamily: 'Alternate'),
                                  children: [
                                    TextSpan(
                                      text: addRate,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontFamily: 'Alternate'),
                                    ),
                                  ]),
                            )),
                        Padding(
                          padding: EdgeInsets.only(right: 40, bottom: 5),
                          child: RichText(
                              text: TextSpan(
                                  text: investDetailBean.termCount,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontFamily: 'Alternate'),
                                  children: [
                                TextSpan(
                                  text: investDetailBean.termUnit,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                )
                              ])),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 11, bottom: 5),
                      child: Text(
                        borrow,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '红包',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        Container(
                          width: 1,
                          height: 14,
                          margin: EdgeInsets.only(left: 5, right: 5),
                          color: Colors.white,
                        ),
                        Text(
                          '加息券',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        Container(
                          width: 1,
                          height: 14,
                          margin: EdgeInsets.only(left: 5, right: 5),
                          color: Colors.white,
                        ),
                        Text(
                          '现金券',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: GestureDetector(
                            child: Image.asset(
                              'images/icon_mark.png',
                              width: 15,
                              height: 15,
                            ),
                            onTap: () {
                              print('********');
                              CouponDialog.getDialog(context, dialogTilte,
                                  dialogContent, dialogButtom);
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                  color: Colors.white,
                  margin: EdgeInsets.only(
                      top: 200, bottom: 20, left: 20, right: 20),
                  elevation: 3, //阴影
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 24, left: 16, right: 16),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '剩余',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              '项目进度',
                              style: TextStyle(fontSize: 14),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 27),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                    text: MoneyUtils.exceedunit2(
                                        investDetailBean.surplusMoney.amount
                                            .toString()),
                                    style: TextStyle(
                                        fontSize: 36,
                                        color: Colors.black,
                                        fontFamily: 'Alternate'),
                                    children: [
                                      TextSpan(
                                          text: yuan,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                          ))
                                    ]),
                              ),
                              Text(
                                investDetailBean.progressRate + '%',
                                style: TextStyle(
                                    fontSize: 36,
                                    color: Colors.black,
                                    fontFamily: 'Alternate'),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 9, right: 9),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                estimateRate,
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                getMonDate,
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                '回款到账',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: 9, left: 9, top: 5, bottom: 5),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  width: 7,
                                  height: 7,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xFFf1523c)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  )),
                              Expanded(
                                  flex: 8,
                                  child: Container(
                                    height: 1,
                                    color: Colors.red,
                                  )),
                              Container(
                                  width: 7,
                                  height: 7,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xFFf1523c)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  )),
                              Expanded(
                                  flex: 9,
                                  child: Container(
                                    height: 1,
                                    color: Colors.red,
                                  )),
                              Container(
                                  width: 7,
                                  height: 7,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xFFf1523c)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 9, right: 9),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                investDetailBean.startInterest,
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                endInterest,
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                '到期后1-3个工作日',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: 40, bottom: 5, left: 5, right: 13),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '项目名称',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF333333)),
                                    ),
                                    Text(
                                      investDetailBean.loanTitle,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF666666)),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 0.5,
                                  color: Color(0xFFDDDDDD),
                                  margin: EdgeInsets.only(top: 5, bottom: 21),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '项目状态',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF666666)),
                                    ),
                                    Text(
                                      investDetailBean.loanStatusDesc,
                                      style: TextStyle(
                                          fontSize: 12, color: loanStatusColor),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 25, bottom: 25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '还款方式',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFFf1523c)),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            investDetailBean.profitType,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFFf1523c)),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: GestureDetector(
                                              child: Image.asset(
                                                'images/icon_mark_red.png',
                                                width: 13,
                                                height: 13,
                                              ),
                                              onTap: () {
                                                CouponDialog.getDialog(
                                                    context,
                                                    dialogTilte1,
                                                    dialogContent1,
                                                    dialogButtom1);
                                              },
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '项目总额',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF666666)),
                                    ),
                                    Text(
                                      MoneyUtils.exceedunit(investDetailBean
                                              .loanAmount.amount
                                              .toString()) +
                                          '元',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF666666)),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 25, bottom: 25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '项目开始时间',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF666666)),
                                      ),
                                      Text(
                                        investDetailBean.openDate,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF666666)),
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '项目详情',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF666666)),
                                      ),
                                      Image.asset(
                                        'images/icon_right.png',
                                        width: 7,
                                        height: 13,
                                      )
                                    ],
                                  ),
                                  onTap: () {
//                                    _goWeb('项目详情',
//                                      AppConstans.b
//                                    )
                                  },
                                ),
                                Container(
                                  height: 0.5,
                                  color: Color(0xFFDDDDDD),
                                  margin: EdgeInsets.only(top: 5, bottom: 25),
                                ),
                                GestureDetector(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '还款详情',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF666666)),
                                      ),
                                      Image.asset(
                                        'images/icon_right.png',
                                        width: 7,
                                        height: 13,
                                      )
                                    ],
                                  ),
                                  onTap: () {},
                                ),
                                Container(
                                  height: 0.5,
                                  color: Color(0xFFDDDDDD),
                                  margin: EdgeInsets.only(top: 5, bottom: 25),
                                ),
                                GestureDetector(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '出借用户',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF666666)),
                                      ),
                                      Image.asset(
                                        'images/icon_right.png',
                                        width: 7,
                                        height: 13,
                                      )
                                    ],
                                  ),
                                  onTap: () {},
                                ),
                                Container(
                                  height: 0.5,
                                  color: Color(0xFFDDDDDD),
                                  margin: EdgeInsets.only(top: 5),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 38, left: 16, right: 16),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        '募集时间须知：本项目自' +
                                            investDetailBean.openDate +
                                            '起,募集期不得超过' +
                                            investDetailBean.failureTime +
                                            '。若超过' +
                                            investDetailBean.failureTime +
                                            '，则借款协议不生效，出借人的出借资金将解冻。',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Color(0xFF999999)),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          '提前还款须知：提前还款将影响项目的出借周期和收益，出借本金将提前返还给出借人，收益将以实际出借时间计算。',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFF999999)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 30, bottom: 33),
                                  child: Row(
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
                                        style: TextStyle(
                                            color: Color(0xFF999999),
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  )),
            ]))),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(bottom: 16, left: 66, right: 66),
          child: FlatButton(
            onPressed: () {},
            child: Container(
              height: 42,
              child: Center(
                child: Text(
                  '立即出借',
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
    );
  }

  //根据返回状态，修改item
  _selectRate() {
    var loanType = investDetailBean.loanType;
    var borrowType = investDetailBean.borrowType;
    var loanStatus = investDetailBean.loanStatus;
    var profitType = investDetailBean.profitType;
    var redMoneyUse = investDetailBean.redMoneyUse;
    var cashCouponFlag = investDetailBean.cashCouponFlag;
    var increaseInterest = investDetailBean.increaseInterestCouponFlag;
    var amount = investDetailBean.profitPer.amount;

    var money =
        MoneyUtils.exceedunit(investDetailBean.surplusMoney.amount.toString());
    //判断是不是内部加息
    if (loanType == ApiConstans.LOAN_TYPE_ADDINTEREST) {
      addRate = "+" + investDetailBean.addRate + "%";
    }

    if (borrowType == ApiConstans.CONSUME) {
      borrow = '名义利率(年化)';
    } else {
      borrow = '利率(年化)';
    }

    if (money.contains('万')) {
      yuan = '万元';
    } else {
      yuan = '元';
    }

    if (loanStatus == ApiConstans.LOAN_STATUS_COMPLETED ||
        loanStatus == ApiConstans.LOAN_STATUS_DISBURSE) {
      estimateRate = '计息日';
    } else {
      estimateRate = '预计计息日';
    }
    if (investDetailBean.endTime != null) {
      getMonDate = '回款日';
      endInterest = investDetailBean.endTime;
    } else {
      getMonDate = '预计回款日';
      endInterest = investDetailBean.endInterest;
    }

    if (loanStatus == ApiConstans.LOAN_STATUS_DISBURSE) {
      loanStatusColor = Color(0xFF666666);
    } else {
      loanStatusColor = Color(0xFFF25848);
    }

    if (redMoneyUse == ApiConstans.REDMONEY_USE_NO &&
        cashCouponFlag == ApiConstans.SWITCH_OFF &&
        increaseInterest == ApiConstans.SWITCH_OFF) {
      dialogContent = '出借项目不能使用优惠券';
    } else {
      dialogContent = '出借项目可以使用，红包，加息券，现金券（获取）提升收益';
    }

    if (profitType == StrConstants.month_rate) {
      dialogTilte1 = StrConstants.month_rate;
      dialogContent1 = StrConstants.month_content;
      dialogButtom1 = StrConstants.profit_per + amount.toString();
    } else if (profitType == StrConstants.one_reta) {
      dialogTilte1 = StrConstants.one_reta;
      dialogContent1 = StrConstants.one_reta_content;
      dialogButtom1 = StrConstants.profit_per + amount.toString();
    } else if (profitType == StrConstants.equivalent_principal) {
      dialogTilte1 = StrConstants.equivalent_principal;
      dialogContent1 = StrConstants.equivalent_principal_context;
      dialogButtom1 = StrConstants.profit_per + amount.toString();
    }

    if (borrowType == ApiConstans.CONSUME) {}
    if (borrowType == ApiConstans.FOLLOW) {
    } else {}
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

  //跳转web页面
  _goWeb(String title, String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MyWebView(title, url)));
  }
}
