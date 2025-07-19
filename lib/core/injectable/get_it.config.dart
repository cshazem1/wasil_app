// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;
import 'package:wasil_task/core/injectable/hive_module.dart' as _i586;
import 'package:wasil_task/core/network/api_service.dart' as _i578;
import 'package:wasil_task/core/network/dio_helper.dart' as _i394;
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
import 'package:wasil_task/features/products/data/data_sources/product_data_source.dart'
    as _i148;
import 'package:wasil_task/features/products/data/repositories/product_repositories_impl.dart'
    as _i323;
import 'package:wasil_task/features/products/domain/repositories/product_repository.dart'
    as _i1052;
import 'package:wasil_task/features/products/domain/use_cases/get_products_usecase.dart'
    as _i744;
import 'package:wasil_task/features/products/presentation/cubit/product_cubit.dart'
    as _i398;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final hiveModule = _$HiveModule();
    gh.lazySingleton<_i394.DioHelper>(() => _i394.DioHelper());
    gh.lazySingleton<_i979.Box<_i798.CartItemModel>>(() => hiveModule.cartBox);
    gh.lazySingleton<_i578.ApiService>(
        () => _i578.ApiServiceImpl(gh<_i394.DioHelper>()));
    gh.lazySingleton<_i230.CartLocalDataSourceImpl>(() =>
        _i230.CartLocalDataSourceImpl(gh<_i979.Box<_i798.CartItemModel>>()));
    gh.lazySingleton<_i152.CartRepository>(
        () => _i344.CartRepositoryImpl(gh<_i523.CartLocalDataSource>()));
    gh.lazySingleton<_i148.ProductDataSource>(
        () => _i148.ProductDataSourceImpl(apiService: gh<_i578.ApiService>()));
    gh.lazySingleton<_i1052.ProductRepository>(() =>
        _i323.ProductRepositoriesImpl(
            dataSource: gh<_i148.ProductDataSource>()));
    gh.lazySingleton<_i40.AddToCartUseCase>(
        () => _i40.AddToCartUseCase(gh<_i152.CartRepository>()));
    gh.lazySingleton<_i744.GetProductsUseCase>(
        () => _i744.GetProductsUseCase(gh<_i1052.ProductRepository>()));
    gh.lazySingleton<_i398.ProductCubit>(
        () => _i398.ProductCubit(gh<_i744.GetProductsUseCase>()));
    return this;
  }
}

class _$HiveModule extends _i586.HiveModule {}
