import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_wise/core/common/widgets/loader.dart';
import 'package:task_wise/features/auth/domain/repository/auth_repository.dart';
import 'package:task_wise/features/auth/presentation/pages/login_page.dart';
import 'package:task_wise/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:task_wise/features/home/domain/repository/get_task_repository.dart';
import 'package:task_wise/features/home/presentation/pages/home_page.dart';
import 'package:task_wise/features/home/presentation/viewmodel/task_viewmodel.dart';
import 'package:task_wise/features/task/domain/repository/task_repository.dart';
import 'package:task_wise/features/task/presentation/viewmodel/add_task_viewmodel.dart';
import 'package:task_wise/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (context) =>
              TaskViewModel(repository: serviceLocator<GetTaskRepository>()),
        ),

        ChangeNotifierProvider(
          lazy: false,
          create: (context) =>
              AuthViewModel(repository: serviceLocator<AuthRepository>()),
        ),

        ChangeNotifierProvider(
          create: (context) =>
              AddTaskViewModel(repository: serviceLocator<TaskRepository>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AuthViewModel>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskWise',
      theme: ThemeData(
        fontFamily: "Cera Pro",
        inputDecorationTheme: InputDecorationTheme(
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.red),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.all(27),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 3),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 3),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 60),
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: _buildBody(viewModel),
    );
  }

  Widget _buildBody(AuthViewModel viewModel) {
    if (viewModel.isLoading) {
      return Loader();
    }
    if (viewModel.errorMessage != null) {}
    return viewModel.isAuthenticated ? HomePage() : LoginPage();
  }
}
