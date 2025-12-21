import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_wise/core/common/widgets/loader.dart';
import 'package:task_wise/core/utils/show_snackbar.dart';
import 'package:task_wise/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task_wise/features/auth/presentation/pages/login_page.dart';

class SignupPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignupPage());

  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  void signUpUser() {
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthSignUp(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          phoneNumber: phoneNumberController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBar(context, state.message);
          } else if (state is AuthSuccess) {
            showSnackBar(context, "Signup successful, please login");
            Navigator.pushAndRemoveUntil(
              context,
              LoginPage.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign Up.",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please enter your first name";
                        }
                        return null;
                      },
                      controller: firstNameController,
                      decoration: InputDecoration(hintText: "First Name"),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please enter your last name";
                        }
                        return null;
                      },
                      controller: lastNameController,
                      decoration: InputDecoration(hintText: "Last Name"),
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
                          return "Please enter your phone number";
                        }
                        return null;
                      },
                      controller: phoneNumberController,
                      decoration: InputDecoration(hintText: "Phone Number"),
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
                      onPressed: signUpUser,
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () => Navigator.pushAndRemoveUntil(
                        context,
                        LoginPage.route(),
                        (route) => false,
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: "Sign In",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
