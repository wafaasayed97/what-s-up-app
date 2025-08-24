import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:what_s_up_app/core/app_cubit/app_cubit.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46,
      height: 46,
      child: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {},
        backgroundColor: context.read<AppCubit>().themeMode == ThemeMode.dark
            ? Colors.grey.shade900
            : Colors.white,
        child: Image.asset(
          'assets/images/meta_ai_logo.png',
          width: 32,
          height: 32,
        ),
      ),
    );
  }
}