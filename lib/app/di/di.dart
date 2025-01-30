import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tutorme/core/network/api_service.dart';
import 'package:tutorme/core/network/hive_service.dart';
import 'package:tutorme/features/auth/data/data_source/remote_data_source.dart/auth_remote_datasource.dart';
import 'package:tutorme/features/auth/data/repository/remote_repository/auth_remote_repository.dart';
import 'package:tutorme/features/auth/domain/use_case/login_usecase.dart';
import 'package:tutorme/features/auth/domain/use_case/register_usecase.dart';
import 'package:tutorme/features/auth/domain/use_case/verify_usecase.dart';
import 'package:tutorme/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:tutorme/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:tutorme/features/home/presentation/view_model/home_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initHiveService();
  _initApiService();

  _initAuthDependencies();

  _initHomeDependencies();
}

void _initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService() {
  // Remote Data Source
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

void _initAuthDependencies() {
  // Auth Local Data Source
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(getIt<Dio>()));
  // getIt.registerLazySingleton<AuthLocalDataSource>(
  //     () => AuthLocalDataSource(getIt<HiveService>()));
  getIt.registerLazySingleton<VerifyEmailUsecase>(
      () => VerifyEmailUsecase(getIt<AuthRemoteRepository>()));

  // Auth Repository
  // getIt.registerLazySingleton<AuthLocalRepository>(
  //     () => AuthLocalRepository(getIt<AuthLocalDataSource>()));
  getIt.registerLazySingleton<AuthRemoteRepository>(
      () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()));

  // Use Cases
  getIt.registerLazySingleton<LoginUsecase>(
      () => LoginUsecase(getIt<AuthRemoteRepository>()));
  getIt.registerLazySingleton<RegisterUsecase>(
      () => RegisterUsecase(getIt<AuthRemoteRepository>()));

  // Login Bloc
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      loginUseCase: getIt<LoginUsecase>(),
      homeCubit: getIt<HomeCubit>(),
    ),
  );

  // Register Bloc
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt<RegisterUsecase>(),
      verifyEmailUsecase: getIt<VerifyEmailUsecase>(),
    ),
  );
}

void _initHomeDependencies() {
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
}
