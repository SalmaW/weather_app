import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/views/widgets/custom_button.dart';
import 'package:weather_app/views/widgets/custom_text_field.dart';
import '../../constants/app_routes.dart';
import '../constants/app_string.dart';
import '../service/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
        title: Text(
          AppString.login,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.bodyLarge?.color ?? Colors.black,
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
                const SizedBox(height: 100),
                Semantics(
                  label: 'Email input field',
                  hint: 'Please enter your email address',
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
                      color: theme.bottomNavigationBarTheme.selectedItemColor ??
                          Colors.blue,
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
                  hint: 'Please enter your password',
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
                      color: theme.bottomNavigationBarTheme.selectedItemColor ??
                          Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() => authController.isLoading.value
                    ? const CircularProgressIndicator()
                    : CustomElevatedButton(
                        text: AppString.login,
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            final email = emailController.text;
                            final password = passwordController.text;

                            authController.isLoading.value = true;

                            final result = await authController
                                .signInWithEmailAndPassword(email, password);
                            authController.isLoading.value = false;

                            if (result != null) {
                              if (context.mounted) {
                                _showSnackBar(
                                    context,
                                    result,
                                    result.startsWith('Error')
                                        ? Colors.red
                                        : Colors.green);
                              }
                            }
                            if (result != null &&
                                result.startsWith('invalid-credential')) {
                              return;
                            }
                            Get.offNamed(Routes.homeRoute);
                          }
                        },
                        backgroundColor:
                            theme.bottomNavigationBarTheme.selectedItemColor!,
                      )),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.offNamed(Routes.signUpRoute);
                  },
                  child: const Text(
                    AppString.noAccount,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
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
