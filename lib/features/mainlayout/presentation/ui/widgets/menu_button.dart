import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:what_s_up_app/core/app_cubit/app_cubit.dart';
import 'package:what_s_up_app/core/app_cubit/app_state.dart';
import 'package:what_s_up_app/core/theme/light_colors.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          width: 28,
          height: 28,
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.read<AppCubit>().themeMode == ThemeMode.dark
                ? Colors.grey.shade900.withAlpha(170)
                : AppLightColors.iconBackground,
          ),
          child: Image.asset(
            'assets/images/menu_iconpng.png',
            color: context.read<AppCubit>().themeMode == ThemeMode.dark
                ? Colors.white
                : Colors.black,
          ),
        );
      },
    );
  }
}