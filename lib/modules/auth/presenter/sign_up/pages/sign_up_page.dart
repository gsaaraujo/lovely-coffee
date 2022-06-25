import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:email_validator/email_validator.dart';
import 'package:lovely_coffee/application/styles/color_styles.dart';
import 'package:lovely_coffee/application/styles/heading_styles.dart';
import 'package:lovely_coffee/application/widgets/elevated_button_widget.dart';
import 'package:lovely_coffee/application/widgets/snack_bar_widget.dart';
import 'package:lovely_coffee/application/widgets/text_input_field_widget.dart';
import 'package:lovely_coffee/application/constants/exception_messages_const.dart';
import 'package:lovely_coffee/modules/auth/presenter/sign_up/cubits/sign_up_cubit.dart';
import 'package:lovely_coffee/modules/auth/presenter/sign_up/cubits/sign_up_states.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _signUpCubit = Modular.get<SignUpCubit>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpStates>(
      bloc: _signUpCubit,
      listener: (context, state) {
        if (state is SignUpSucceedState) {
          Modular.to.pop();

          ScaffoldMessenger.of(context).showSnackBar(
            snackBarWidget(
              title: 'Your account has been successfully created.',
              icon: const Icon(Icons.coffee_rounded, color: Colors.white),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Sign up',
                            style: HeadingStyles.heading32Bold),
                        const SizedBox(height: 70),
                        TextInputFieldWidget(
                          hint: 'Your name',
                          controller: _nameController,
                        ),
                        const SizedBox(height: 30),
                        TextInputFieldWidget(
                          hint: 'Your email',
                          controller: _emailController,
                          validator: (String email) {
                            final bool isEmailNotValid =
                                !EmailValidator.validate(email);

                            if (isEmailNotValid) {
                              return ExceptionMessagesConst.invalidEmail;
                            }
                          },
                        ),
                        const SizedBox(height: 30),
                        TextInputFieldWidget(
                          hint: 'Your password',
                          controller: _passwordController,
                          isPassword: true,
                          validator: (String password) {
                            if (password.length < 8) {
                              return ExceptionMessagesConst.weakPassword;
                            }
                          },
                        ),
                        const SizedBox(height: 30),
                        BlocBuilder<SignUpCubit, SignUpStates>(
                          bloc: _signUpCubit,
                          builder: (context, state) {
                            if (state is SignUpFailedState) {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  state.message,
                                  textAlign: TextAlign.start,
                                  style: HeadingStyles.errorMessage,
                                ),
                              );
                            }

                            return const SizedBox();
                          },
                        ),
                        const SizedBox(height: 50),
                        BlocBuilder<SignUpCubit, SignUpStates>(
                          bloc: _signUpCubit,
                          builder: (context, state) {
                            return ElevatedButtonWidget(
                              title: 'Sign up',
                              isLoading: state is SignUpLoadingState,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _signUpCubit.signUp(
                                    _nameController.text,
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 70),
                        TextButton(
                          onPressed: () => Modular.to.pop(),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Already have an account ? ',
                              style: HeadingStyles.heading16Normal,
                              children: [
                                TextSpan(
                                  text: 'Sign in now.',
                                  style: HeadingStyles.heading16Bold.copyWith(
                                    color: ColorStyles.highlight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
