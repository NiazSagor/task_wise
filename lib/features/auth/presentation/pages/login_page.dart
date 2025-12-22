import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_wise/core/common/widgets/loader.dart';
import 'package:task_wise/core/utils/show_snackbar.dart';
import 'package:task_wise/features/auth/presentation/pages/signup_page.dart';
import 'package:task_wise/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:task_wise/features/home/presentation/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginUser() {
    if (formKey.currentState!.validate()) {
      Provider.of<AuthViewModel>(context, listen: false).login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.read<AuthViewModel>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildBody(authViewModel),
      ),
    );
  }

  Widget _buildBody(AuthViewModel viewModel) {
    if (viewModel.isLoading) {
      return Loader();
    }

    if (viewModel.isAuthenticated) {
      Navigator.pushAndRemoveUntil(context, HomePage.route(), (_) => false);
    }

    if (viewModel.errorMessage != null) {
      //showSnackBar(context, viewModel.errorMessage!);
    }

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Login.",
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          TextFormField(
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "Please enter your email";
              }
              return null;
            },
            controller: emailController,
            decoration: InputDecoration(hintText: "Email"),
          ),
          const SizedBox(height: 15),
          TextFormField(
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
            controller: passwordController,
            decoration: InputDecoration(hintText: "Password"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: loginUser,
            child: Text(
              "LOGIN",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () => Navigator.push(context, SignupPage.route()),
            child: RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: Theme.of(context).textTheme.titleMedium,
                children: [
                  TextSpan(
                    text: "Sign Up",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
