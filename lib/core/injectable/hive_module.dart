import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../features/cart/data/models/cart_item_model.dart';
import '../utils/constants.dart';

@module
abstract class HiveModule {
  @lazySingleton
  Box<CartItemModel> get cartBox => Hive.box<CartItemModel>(Constants.cartBox);
}
