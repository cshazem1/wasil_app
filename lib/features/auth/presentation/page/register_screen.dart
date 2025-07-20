import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasil_task/core/utils/extensions.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/utils/helper.dart';
import '../../domain/use_case/login_usecase.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/custom_text_field.dart';
import '../../../../core/utils/validation.dart';
import '../../../../core/routes/app_routes.dart'; // تأكد من وجود ده

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterError) {
            CustomSnackBar.show(
              context,
              state.message,
              backgroundColor: Colors.red,
            );
          } else if (state is RegisterSuccess) {
            CustomSnackBar.show(
              context,
              'Registration successful',
              backgroundColor: Colors.green,
            );
            context.pushReplacementNamed(AppRoutes.login);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  validator: validateEmail,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: _passwordController,
                  label: 'Password',
                  isPassword: true,
                  validator: validatePassword,
                ),
                const SizedBox(height: 20),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final isLoading = state is RegisterLoading;
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().register(
                                    AuthParams(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    ),
                                  );
                                }
                              },
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.white,
                                ),
                              )
                            : const Text("Register"),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text("Already have an account? Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
