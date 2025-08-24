
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:what_s_up_app/core/app_cubit/app_cubit.dart';
import 'package:what_s_up_app/core/app_cubit/app_state.dart';
import 'package:what_s_up_app/core/theme/light_colors.dart';

class PlusButton extends StatelessWidget {
  const PlusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Container(
          width: 28,
          height: 28,
          padding: const EdgeInsets.all(2.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppLightColors.tealColor,
          ),
          child: Image.asset(
            'assets/images/plus_icon.png',
            color: context.read<AppCubit>().themeMode == ThemeMode.dark
                ? Colors.black
                : Colors.white,
          ),
        );
      },
    );
  }
}
