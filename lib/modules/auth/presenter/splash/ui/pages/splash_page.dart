import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lovely_coffee/modules/auth/presenter/splash/cubits/splash_cubit.dart';
import 'package:lovely_coffee/modules/auth/presenter/splash/cubits/splash_states.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final splashCubit = Modular.get<SplashCubit>();
    final Size size = MediaQuery.of(context).size;

    splashCubit.redirectUser();

    return Scaffold(
      body: BlocListener<SplashCubit, SplashStates>(
        bloc: splashCubit,
        listener: (context, state) {
          if (state is SplashRedirectToHomeState) {
            return;
          }

          if (state is SplashRedirectToSignInState) {
            Modular.to.navigate('/sign-in');
            return;
          }
        },
        child: Center(
          child: Lottie.asset(
            'assets/animations/splash.json',
            fit: BoxFit.contain,
            repeat: false,
            width: size.width * 0.4,
          ),
        ),
      ),
    );
  }
}
