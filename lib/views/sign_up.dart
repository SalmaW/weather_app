import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_routes.dart';
import '../constants/app_string.dart';
import '../service/auth_controller.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Semantics(
          label: "Sign up page",
          child: Text(
            AppString.signUp,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.textTheme.bodyLarge?.color),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Semantics(
                  label: 'Email input field',
                  child: CustomTextFormField(
                    controller: emailController,
                    hintText: "Enter your email",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      return null;
                    },
                    inputTextStyle: TextStyle(
                      color: theme.bottomNavigationBarTheme.selectedItemColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(height: 20),
                Semantics(
                  label: 'Password input field',
                  child: CustomTextFormField(
                    controller: passwordController,
                    hintText: "Enter your password",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                    inputTextStyle: TextStyle(
                      color: theme.bottomNavigationBarTheme.selectedItemColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 20),
                Semantics(
                  label: 'Confirm Password input field',
                  child: CustomTextFormField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                    inputTextStyle: TextStyle(
                      color: theme.bottomNavigationBarTheme.selectedItemColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() => authController.isLoading.value
                    ? const CircularProgressIndicator()
                    : CustomElevatedButton(
                        text: AppString.signUp,
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            final email = emailController.text;
                            final password = passwordController.text;

                            authController.isLoading.value = true;

                            final result = await authController
                                .createUserWithEmailPassword(email, password);

                            authController.isLoading.value = false;

                            if (result != null) {
                              _showSnackBar(
                                  context,
                                  result,
                                  result.startsWith('Error')
                                      ? Colors.red
                                      : Colors.green);
                            }
                            Get.offNamed(Routes.loginRoute);
                          }
                        },
                        backgroundColor:
                            theme.bottomNavigationBarTheme.selectedItemColor!,
                      )),
                TextButton(
                  onPressed: () {
                    Get.offNamed(Routes.loginRoute);
                  },
                  child: const Text(AppString.haveAnAccount,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
