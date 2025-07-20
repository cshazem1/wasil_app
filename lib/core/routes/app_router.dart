import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasil_task/core/injectable/get_it.dart';
import 'package:wasil_task/core/routes/app_routes.dart';
import 'package:wasil_task/features/cart/presentation/screens/cart_page.dart';

import '../../features/products/presentation/cubit/product_cubit.dart';
import '../../features/products/presentation/screens/products_screen.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.products:
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) => getIt<ProductCubit>()..fetchProducts(isRefresh: true),
              child: ProductPage(),
            ));
      case AppRoutes.cart:
        return MaterialPageRoute(builder: (_) => CartPage());

      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
