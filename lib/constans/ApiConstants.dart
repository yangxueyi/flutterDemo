

class ApiConstans{

  /*
   * 借款类型
   * ALL, 全部
   * HOUSINGLOAN, 房抵经营借款,
   * CONSUME, 消费借款,
   * FOLLOW, 跟投借款
   */
  static const String ALL = "ALL";
  static const String HOUSINGLOAN = "HOUSINGLOAN";
  static const String CONSUME = "CONSUME";
  static const String FOLLOW = "FOLLOW";


  //OPEN=开标状态但未到投资时间
  static const String LOAN_STATUS_OPEN = "OPEN";
  //OPENED=开标状态可以投资
  static const String LOAN_STATUS_OPENED = "OPENED";
  // FULL=满标
  static const String LOAN_STATUS_FULL = "FULL";
  // DISBURSE=还款中
  static const String LOAN_STATUS_DISBURSE = "DISBURSE";
  //COMPLETED=已完成
  static const String LOAN_STATUS_COMPLETED = "COMPLETED";
  // KILLED=已流标
  static const String LOAN_STATUS_KILLED = "KILLED";
  //STOP=停止募集
  static const String LOAN_STATUS_STOP = "STOP";

  // COMMON=普通理财
  static const String LOAN_TYPE_COMMON = "COMMON";
  // ADDINTEREST=内部加息
  static const String LOAN_TYPE_ADDINTEREST = "ADDINTEREST";
  // NOVICE=新手
  static const String LOAN_TYPE_NOVICE = "NOVICE";
  // VIP=投资加密  标的类型
  static const String LOAN_TYPE_VIP = "VIP";

  static const String REDMONEY_USE_SHI = '是';
  static const String REDMONEY_USE_NO ='否';
  static const String SWITCH_ON = 'ON';
  static const String SWITCH_OFF ='OFF';


}