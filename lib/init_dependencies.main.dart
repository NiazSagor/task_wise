part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initTask();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  final dio = Dio(
    BaseOptions(
      baseUrl: AppSecrets.taskBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  serviceLocator.registerLazySingleton(() => dio);

  serviceLocator.registerLazySingleton(() => supabase.client);

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory(() => InternetConnection());

  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(internetConnection: serviceLocator()),
  );

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(() => Hive.box(name: "tasks"));
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(supabaseClient: serviceLocator()),
  );

  serviceLocator.registerFactory<AuthLocalDatSource>(
    () => AuthLocalDataSourceImpl(),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(() => UserSignUpUseCase(serviceLocator()));
  serviceLocator.registerFactory(() => GetCurrentUserUseCase(serviceLocator()));

  serviceLocator.registerFactory(
    () => UserLoginUseCase(authRepository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      signUpUseCase: serviceLocator(),
      loginUseCase: serviceLocator(),
      getCurrentUserUseCase: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}

void _initTask() {
  serviceLocator.registerFactory<TaskRemoteDataSource>(
    () => TaskRemoteDatSourceImpl(client: serviceLocator()),
  );
  serviceLocator.registerFactory<TaskRepository>(
    () => TaskRepositoryImpl(remoteDataSource: serviceLocator()),
  );
}
