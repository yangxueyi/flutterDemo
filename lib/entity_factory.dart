import 'package:jjyflutter/bean/home_bean_entity.dart';
import 'package:jjyflutter/bean/invest_detail_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "HomeBeanEntity") {
      return HomeBeanEntity.fromJson(json) as T;
    } else if (T.toString() == "InvestDetailEntity") {
      return InvestDetailEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}