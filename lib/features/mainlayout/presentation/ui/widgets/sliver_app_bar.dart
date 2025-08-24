import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:what_s_up_app/core/app_cubit/app_cubit.dart';
import 'package:what_s_up_app/core/app_cubit/app_state.dart';
import 'package:what_s_up_app/core/constants/strings.dart';
import 'package:what_s_up_app/core/theme/light_colors.dart';
import 'package:what_s_up_app/generated/l10n.dart';

class HomeSliverAppBar extends StatelessWidget {
  final bool isCollapsed;
  final TabAppBarConfig config;
  final List<Text> titles;
  final int currentIndex;

  const HomeSliverAppBar({
    super.key,
    required this.isCollapsed,
    required this.config,
    required this.titles,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return SliverAppBar(
          pinned: true,
          expandedHeight: mainLayoutIntitalScreenIndex == 0 ? 120 : 153.0,
          automaticallyImplyLeading: false,
          backgroundColor: context.read<AppCubit>().themeMode == ThemeMode.dark
              ? Colors.black.withAlpha(240)
              : Colors.white,
          bottom: isCollapsed ? _buildBorder(context) : null,
          title: _buildTitle(context),
          flexibleSpace: _buildFlexibleSpace(context),
        );
      },
    );
  }

  PreferredSize _buildBorder(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: context.read<AppCubit>().themeMode == ThemeMode.dark
                  ? Colors.transparent
                  : AppLightColors.navBarBorder,
              width: 0.2,
            ),
          ),
        ),
        child: const SizedBox(width: double.infinity, height: 0.2),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: Stack(
        children: [
          // Left widget
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Align(child: config.leftWidget ?? const SizedBox(width: 0)),
          ),
          // Right widgets
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: config.rightWidgets ?? [],
            ),
          ),
          // Title
          if (isCollapsed)
            Positioned(
              left: 45,
              right: 60,
              top: 0,
              bottom: 0,
              child: Transform.translate(
                offset: const Offset(10, 0),
                child: Center(
                  child: Text(
                    titles[currentIndex].data ?? '',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 16.8,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFlexibleSpace(BuildContext context) {
    return FlexibleSpaceBar(
      titlePadding: EdgeInsets.zero,
      background: ColoredBox(
        color: context.read<AppCubit>().themeMode == ThemeMode.dark
            ? Colors.black
            : Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: kToolbarHeight - 10,
              bottom: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isCollapsed)
                  Text(
                    titles[currentIndex].data ?? '',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 33.3,
                      color: context.read<AppCubit>().themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                if (!isCollapsed) const SizedBox(height: 10),
                if (!isCollapsed && mainLayoutIntitalScreenIndex != 0)
                  SearchWidget(
                    hintText: currentIndex == 3
                        ? S().askMetaAIOrSearch
                        : S().search,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}