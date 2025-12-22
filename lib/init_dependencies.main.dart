part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initTask();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  final dio = Dio(
    BaseOptions(
      baseUrl: AppSecrets.taskBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AuthInterceptor(sharedPreferences: serviceLocator()),
  );

  dio.interceptors.add(serviceLocator<AuthInterceptor>());
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
      requestHeader: false,
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
  serviceLocator.registerLazySingleton(
    () => Hive.box(name: "tasks"),
    instanceName: "allTasks",
  );
  serviceLocator.registerLazySingleton(
    () => Hive.box(name: "offline_tasks"),
    instanceName: "offlineTasks",
  );
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: serviceLocator()),
  );

  serviceLocator.registerFactory<AuthLocalDatSource>(
    () => AuthLocalDataSourceImpl(),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: serviceLocator(),
      authLocalDatSource: serviceLocator(),
      sharedPreferences: serviceLocator(),
      connectionChecker: serviceLocator(),
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
  serviceLocator.registerFactory<GetTaskRemoteDataSource>(
    () => GetTaskDataSourceImpl(client: serviceLocator()),
  );
  serviceLocator.registerFactory<GetTasksLocalDataSource>(
    () => GetTasksLocalDataSourceImpl(
      allTaskBox: serviceLocator.get<Box>(instanceName: 'allTasks'),
      offlineTaskBox: serviceLocator.get<Box>(instanceName: 'offlineTasks'),
    ),
  );
  serviceLocator.registerFactory<GetTaskRepository>(
    () => GetTaskRepositoryImpl(
      remoteDataSource: serviceLocator(),
      tasksLocalDataSource: serviceLocator(),
      connectionChecker: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<TaskLocalDataSource>(
    () => TaskLocalDataSourceImpl(
      allTaskBox: serviceLocator.get<Box>(instanceName: 'allTasks'),
      offlineTaskBox: serviceLocator.get<Box>(instanceName: 'offlineTasks'),
    ),
  );

  serviceLocator.registerFactory<TaskRepository>(
    () => TaskRepositoryImpl(
      remoteDataSource: serviceLocator(),
      localDataSource: serviceLocator(),
      connectionChecker: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => SyncTasksUseCase(taskRepository: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => AddTaskUseCase(taskRepository: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => DeleteTaskUseCase(taskRepository: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => GetTasksUseCase(taskRepository: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => UpdateTaskUseCase(taskRepository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => TaskBloc(
      addTaskUseCase: serviceLocator(),
      getTasksUseCase: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => HomeBloc(
      getTasksUseCase: serviceLocator(),
      syncTaskUseCase: serviceLocator(),
    ),
  );
}
