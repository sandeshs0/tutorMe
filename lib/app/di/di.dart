import 'package:get_it/get_it.dart';
import 'package:tutorme/core/network/hive_service.dart';
import 'package:tutorme/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:tutorme/features/auth/data/repository/local_repository/auth_local_repository.dart';
import 'package:tutorme/features/auth/domain/use_case/login_usecase.dart';
import 'package:tutorme/features/auth/domain/use_case/register_usecase.dart';
import 'package:tutorme/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:tutorme/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:tutorme/features/home/presentation/view_model/home_cubit.dart';


final getIt = GetIt.instance;

Future<void> initDependencies() async{
    // Initialize Hive Service
  _initHiveService();

  // // Initialize Auth Dependencies
  // _initAuthDependencies();

  // // Initialize Home Dependencies
  // _initHomeDependencies();
}
void _initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

void _initAuthDependencies() {
  // Auth Local Data Source
  getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSource(getIt<HiveService>()));

  // Auth Repository
  getIt.registerLazySingleton<AuthLocalRepository>(
      () => AuthLocalRepository(getIt<AuthLocalDataSource>()));

  // Use Cases
  getIt.registerLazySingleton<LoginUsecase>(
      () => LoginUsecase(getIt<AuthLocalRepository>()));
  getIt.registerLazySingleton<RegisterUsecase>(
      () => RegisterUsecase(getIt<AuthLocalRepository>()));

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
    ),
  );
}