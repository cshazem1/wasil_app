// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;
import 'package:wasil_task/core/injectable/hive_module.dart' as _i586;
import 'package:wasil_task/core/network/api_service.dart' as _i578;
import 'package:wasil_task/core/network/dio_helper.dart' as _i394;
import 'package:wasil_task/features/auth/data/data_resource/auth_data_source.dart'
    as _i563;
import 'package:wasil_task/features/auth/data/repositories/auth_repository_impl.dart'
    as _i620;
import 'package:wasil_task/features/auth/domain/repositories/auth_repository.dart'
    as _i100;
import 'package:wasil_task/features/auth/domain/use_case/login_usecase.dart'
    as _i801;
import 'package:wasil_task/features/auth/domain/use_case/register_usecase.dart'
    as _i422;
import 'package:wasil_task/features/auth/presentation/cubit/auth_cubit.dart'
    as _i677;
import 'package:wasil_task/features/cart/data/data_source/cart_local_data_source.dart'
    as _i523;
import 'package:wasil_task/features/cart/data/data_source/cart_local_data_source_impl.dart'
    as _i230;
import 'package:wasil_task/features/cart/data/models/cart_item_model.dart'
    as _i798;
import 'package:wasil_task/features/cart/data/repositories/cart_repository_impl.dart'
    as _i344;
import 'package:wasil_task/features/cart/domain/repositories/cart_repository.dart'
    as _i152;
import 'package:wasil_task/features/cart/domain/use_case/add_to_cart_usecase.dart'
    as _i40;
import 'package:wasil_task/features/cart/domain/use_case/clear_cart_usecase.dart'
    as _i35;
import 'package:wasil_task/features/cart/domain/use_case/decrease_quantity_usecase.dart'
    as _i80;
import 'package:wasil_task/features/cart/domain/use_case/get_cart_items_usecase.dart'
    as _i487;
import 'package:wasil_task/features/cart/domain/use_case/increase_quantity_usecase.dart'
    as _i276;
import 'package:wasil_task/features/cart/domain/use_case/remove_from_cart_usecase.dart'
    as _i90;
import 'package:wasil_task/features/cart/presentation/cubit/cart_cubit.dart'
    as _i729;
import 'package:wasil_task/features/products/data/data_sources/product_data_source.dart'
    as _i148;
import 'package:wasil_task/features/products/data/repositories/product_repositories_impl.dart'
    as _i323;
import 'package:wasil_task/features/products/domain/repositories/product_repository.dart'
    as _i1052;
import 'package:wasil_task/features/products/domain/use_cases/get_product_details_usecase.dart'
    as _i877;
import 'package:wasil_task/features/products/domain/use_cases/get_products_usecase.dart'
    as _i744;
import 'package:wasil_task/features/products/presentation/cubit/product_cubit/product_cubit.dart'
    as _i445;
import 'package:wasil_task/features/products/presentation/cubit/product_details_cubit/product_details_cubit.dart'
    as _i531;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final hiveModule = _$HiveModule();
    final authDataSource = _$AuthDataSource();
    gh.lazySingleton<_i979.Box<_i798.CartItemModel>>(() => hiveModule.cartBox);
    gh.lazySingleton<_i394.DioHelper>(() => _i394.DioHelper());
    gh.lazySingleton<_i59.FirebaseAuth>(() => authDataSource.firebaseAuth);
    gh.lazySingleton<_i578.ApiService>(
      () => _i578.ApiServiceImpl(gh<_i394.DioHelper>()),
    );
    gh.lazySingleton<_i523.CartLocalDataSource>(
      () => _i230.CartLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i152.CartRepository>(
      () => _i344.CartRepositoryImpl(gh<_i523.CartLocalDataSource>()),
    );
    gh.lazySingleton<_i148.ProductDataSource>(
      () => _i148.ProductDataSourceImpl(apiService: gh<_i578.ApiService>()),
    );
    gh.lazySingleton<_i100.AuthRepository>(
      () => _i620.AuthRepositoryImpl(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i801.LoginUseCase>(
      () => _i801.LoginUseCase(gh<_i100.AuthRepository>()),
    );
    gh.lazySingleton<_i422.RegisterUseCase>(
      () => _i422.RegisterUseCase(gh<_i100.AuthRepository>()),
    );
    gh.lazySingleton<_i1052.ProductRepository>(
      () => _i323.ProductRepositoriesImpl(
        dataSource: gh<_i148.ProductDataSource>(),
      ),
    );
    gh.lazySingleton<_i40.AddToCartUseCase>(
      () => _i40.AddToCartUseCase(gh<_i152.CartRepository>()),
    );
    gh.lazySingleton<_i35.ClearCartUseCase>(
      () => _i35.ClearCartUseCase(gh<_i152.CartRepository>()),
    );
    gh.lazySingleton<_i487.GetCartItemsUseCase>(
      () => _i487.GetCartItemsUseCase(gh<_i152.CartRepository>()),
    );
    gh.lazySingleton<_i90.RemoveFromCartUseCase>(
      () => _i90.RemoveFromCartUseCase(gh<_i152.CartRepository>()),
    );
    gh.lazySingleton<_i80.DecreaseQuantityUseCase>(
      () => _i80.DecreaseQuantityUseCase(gh<_i152.CartRepository>()),
    );
    gh.lazySingleton<_i276.IncreaseQuantityUseCase>(
      () => _i276.IncreaseQuantityUseCase(gh<_i152.CartRepository>()),
    );
    gh.lazySingleton<_i729.CartCubit>(
      () => _i729.CartCubit(
        gh<_i40.AddToCartUseCase>(),
        gh<_i35.ClearCartUseCase>(),
        gh<_i487.GetCartItemsUseCase>(),
        gh<_i90.RemoveFromCartUseCase>(),
        gh<_i276.IncreaseQuantityUseCase>(),
        gh<_i80.DecreaseQuantityUseCase>(),
      ),
    );
    gh.factory<_i677.AuthCubit>(
      () => _i677.AuthCubit(
        gh<_i801.LoginUseCase>(),
        gh<_i422.RegisterUseCase>(),
      ),
    );
    gh.lazySingleton<_i744.GetProductsUseCase>(
      () => _i744.GetProductsUseCase(gh<_i1052.ProductRepository>()),
    );
    gh.lazySingleton<_i877.GetProductDetailsUseCase>(
      () => _i877.GetProductDetailsUseCase(gh<_i1052.ProductRepository>()),
    );
    gh.factory<_i445.ProductCubit>(
      () => _i445.ProductCubit(gh<_i744.GetProductsUseCase>()),
    );
    gh.factory<_i531.ProductDetailsCubit>(
      () => _i531.ProductDetailsCubit(gh<_i877.GetProductDetailsUseCase>()),
    );
    return this;
  }
}

class _$HiveModule extends _i586.HiveModule {}

class _$AuthDataSource extends _i563.AuthDataSource {}
