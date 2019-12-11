

class MoneyUtils {
  /*大于10000，以X万来显示,如果为10000的非整数倍，取两位小数，并不四舍五入*/
  static String exceedunit(String money){
    if(money == null){
      return "0.00";
    }
    money = money.split(".")[0];
    if(money.length > 4){
      String moneyW = money.substring(money.length - 4 , money.length - 2);
      if(int.parse(moneyW) > 0){
        money = money.substring(0,money.length - 4) + '.' + moneyW + '万';
      }else{
        money = money.substring(0,money.length - 4) + '.00万';
      }

    }else{
      money = money+".00";
    }

    return money;
  }

  static String exceedunit2(String money){
    if(money == null){
      return "0.00";
    }
    money = money.split(".")[0];
    if(money.length > 4){
      String moneyW = money.substring(money.length - 4 , money.length - 2);
      if(int.parse(moneyW) > 0){
        money = money.substring(0,money.length - 4) + '.' + moneyW ;
      }else{
        money = money.substring(0,money.length - 4);
      }

    }else{
      money = money+".00";
    }

    return money;
  }



}