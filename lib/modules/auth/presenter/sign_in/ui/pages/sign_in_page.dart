import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lovely_coffee/application/styles/color_styles.dart';
import 'package:lovely_coffee/application/styles/heading_styles.dart';
import 'package:lovely_coffee/application/widgets/elevated_button_widget.dart';
import 'package:lovely_coffee/application/widgets/text_input_field_widget.dart';
import 'package:lovely_coffee/modules/auth/presenter/sign_in/cubits/sign_in_cubit.dart';
import 'package:lovely_coffee/modules/auth/presenter/sign_in/cubits/sign_in_states.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _signInCubit = Modular.get<SignInCubit>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInStates>(
      bloc: _signInCubit,
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Scaffold(
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
                        const Text('Sign in',
                            style: HeadingStyles.heading32Bold),
                        const SizedBox(height: 70),
                        TextInputFieldWidget(
                          controller: _emailController,
                          hint: 'Your email',
                        ),
                        const SizedBox(height: 30),
                        TextInputFieldWidget(
                          controller: _passwordController,
                          hint: 'Your password',
                          isPassword: true,
                        ),
                        const SizedBox(height: 70),
                        BlocBuilder<SignInCubit, SignInStates>(
                          bloc: _signInCubit,
                          builder: (context, state) {
                            return ElevatedButtonWidget(
                              title: 'Sign in',
                              isLoading: state is SignInLoadingState,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _signInCubit.signInWithCredentials(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 15),
                        BlocBuilder<SignInCubit, SignInStates>(
                          bloc: _signInCubit,
                          builder: (context, state) {
                            return ElevatedButton.icon(
                              label: const Text(
                                'Connect with Google',
                                style: HeadingStyles.heading16Bold,
                              ),
                              icon: SvgPicture.asset(
                                'assets/icons/google.svg',
                                width: 24,
                                height: 24,
                              ),
                              onPressed: state is SignInLoadingState
                                  ? null
                                  : () => _signInCubit.signInWithGoogle(),
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0XFFE4E4E4),
                                minimumSize: const Size(double.infinity, 48),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 70),
                        TextButton(
                          onPressed: () {},
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Don’t you have an account? ',
                              style: HeadingStyles.heading16Normal,
                              children: [
                                TextSpan(
                                  text: 'Sign up now !',
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
