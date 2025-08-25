import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:what_s_up_app/core/app_cubit/app_cubit.dart';
import 'package:what_s_up_app/core/app_cubit/app_state.dart';
// ignore: must_be_immutable
class ThemeToggleWidget extends StatelessWidget {
  ThemeToggleWidget({super.key});

  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<AppCubit>().toggleTheme();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 50,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: AssetImage(
                  context.read<AppCubit>().themeMode == ThemeMode.dark
                      ? 'assets/images/dark.png'
                      : 'assets/images/light.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  alignment: context.read<AppCubit>().themeMode == ThemeMode.dark
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withAlpha(51),
                          blurRadius: 10,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}