import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorme/app/shared_prefs/token_shared_prefs.dart';
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
import 'package:tutorme/features/student/data/data_source/repository/remote_repository/student_remote_repository.dart';
import 'package:tutorme/features/student/data/data_source/student_remote_data_source.dart/student_remote_data_source.dart';
import 'package:tutorme/features/student/domain/repository/student_repository.dart';
import 'package:tutorme/features/student/domain/usecase/get_student_profile_usecase.dart';
import 'package:tutorme/features/student/domain/usecase/update_student_profile_usecase.dart';
import 'package:tutorme/features/student/presentation/view_model/bloc/student_profile_bloc.dart';
import 'package:tutorme/features/tutors/data/data_source/remote_data_source/tutor_remote_data_source.dart';
import 'package:tutorme/features/tutors/data/repository/remote_repository/tutor_remote_repository.dart';
import 'package:tutorme/features/tutors/domain/repository/tutor_repository.dart';
import 'package:tutorme/features/tutors/domain/usecase/get_all_tutors_usecase.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initHiveService();
  _initApiService();
  _initSharedPreferences();

  _initAuthDependencies();
  _initTutorDependencies(); // ✅ Add this before HomeCubit
  _initStudentProfileDependencies();
  _initHomeDependencies();
}

void _initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

void _initTutorDependencies() {
  // Register Remote Data Source
  getIt.registerLazySingleton<TutorRemoteDataSource>(
      () => TutorRemoteDataSource(dio: getIt<Dio>()));

  // Register Repository
  getIt.registerLazySingleton<ITutorRepository>(
      () => TutorRemoteRepository(getIt<TutorRemoteDataSource>()));

  // Register Use Case
  getIt.registerLazySingleton<GetAllTutorsUsecase>(
      () => GetAllTutorsUsecase(tutorRepository: getIt<ITutorRepository>()));
}

void _initStudentProfileDependencies() {
  // ✅ Register Remote Data Source
  getIt.registerLazySingleton<StudentRemoteDataSource>(() =>
      StudentRemoteDataSource(
          dio: getIt<Dio>(), tokenSharedPrefs: getIt<TokenSharedPrefs>()));

  // ✅ Register Repository
  getIt.registerLazySingleton<IStudentRepository>(
      () => StudentRemoteRepository(getIt<StudentRemoteDataSource>()));

  // ✅ Register Use Case
  getIt.registerLazySingleton<GetStudentProfileUsecase>(
      () => GetStudentProfileUsecase(repository: getIt<IStudentRepository>()));

  getIt.registerLazySingleton<UpdateStudentProfileUsecase>(() =>
      UpdateStudentProfileUsecase(
          studentRepository: getIt<IStudentRepository>()));

  getIt.registerFactory(() => StudentProfileBloc(
        getStudentProfileUsecase: getIt<GetStudentProfileUsecase>(),
        updateStudentProfileUsecase: getIt<UpdateStudentProfileUsecase>(),
      ));
}

_initApiService() {
  // Remote Data Source
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

void _initAuthDependencies() {
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

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
  getIt.registerLazySingleton<LoginUsecase>(() => LoginUsecase(
        getIt<AuthRemoteRepository>(),
        getIt<TokenSharedPrefs>(),
      ));
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
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(getAllTutorsUsecase: getIt<GetAllTutorsUsecase>()),
  );
}
