import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasil_task/core/injectable/get_it.dart';
import 'package:wasil_task/core/routes/app_routes.dart';
import 'package:wasil_task/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:wasil_task/features/auth/presentation/page/login_screen.dart';
import 'package:wasil_task/features/cart/presentation/screens/cart_page.dart';
import 'package:wasil_task/features/products/presentation/cubit/product_details_cubit/product_details_cubit.dart';
import 'package:wasil_task/features/products/presentation/screens/product_details_screen.dart';
import 'package:wasil_task/features/splash/presentation/screens/splash_screen.dart';

import '../../features/auth/presentation/page/register_screen.dart';
import '../../features/products/presentation/cubit/product_cubit/product_cubit.dart';
import '../../features/products/presentation/screens/products_screen.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case AppRoutes.products:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ProductCubit>(),
            child: ProductPage(),
          ),
        );
      case AppRoutes.cart:
        return MaterialPageRoute(builder: (_) => CartPage());
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: LoginScreen(),
          ),
        );
      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: RegisterPage(),
          ),
        );
      case AppRoutes.productDetails:
        final int id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                getIt<ProductDetailsCubit>()..getProductDetails(id),
            child: ProductDetailsScreen(id: id),
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
