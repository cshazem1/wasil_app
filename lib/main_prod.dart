import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/adapters.dart';

import 'core/bloc_observer.dart';
import 'core/injectable/get_it.dart';
import 'core/services/local_notification/local_notification_service.dart';
import 'core/services/push_notification/push_notification_service.dart';
import 'core/utils/constants.dart';
import 'features/cart/data/models/cart_item_model.dart';
import 'firebase_options.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemModelAdapter());
  await Hive.openBox<CartItemModel>(Constants.cartBox);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  Future.wait([
    PushNotificationService.init(),
    LocalNotificationService.init(),
  ]);
  runApp(const WasilTaskApp());
}