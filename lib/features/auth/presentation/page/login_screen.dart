import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasil_task/core/routes/app_routes.dart';
import 'package:wasil_task/core/utils/extensions.dart';
import 'package:wasil_task/features/auth/domain/use_case/login_usecase.dart';
import 'package:wasil_task/features/auth/presentation/cubit/auth_cubit.dart';

import '../../../../core/utils/helper.dart';
import '../../../../core/utils/validation.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginError) {
            CustomSnackBar.show(
              context,
              state.message,
              backgroundColor: Colors.red,
              duration: Duration(milliseconds: 2000),
            );
          } else if (state is LoginSuccess) {
            CustomSnackBar.show(
              context,
              'Login successful!',
              backgroundColor: Colors.green,
            );
            context.pushReplacementNamed(AppRoutes.products);
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
                const SizedBox(height: 24),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final isLoading = state is LoginLoading;
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().login(
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
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Login'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () =>
                      context.pushReplacementNamed(AppRoutes.products),
                  child: const Text('Continue as Guest'),
                ),
                TextButton(
                  onPressed: () => context.pushNamed(AppRoutes.register),
                  child: const Text("Don't have an account? Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
