import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:what_s_up_app/core/app_cubit/app_cubit.dart';
import 'package:what_s_up_app/core/app_cubit/app_state.dart';
import 'package:what_s_up_app/core/constants/strings.dart';
import 'package:what_s_up_app/core/theme/light_colors.dart';
import 'package:what_s_up_app/features/chats/presentation/chats_screen.dart';
import 'package:what_s_up_app/features/chats/presentation/cubit/chat_cubit.dart';
import 'package:what_s_up_app/features/mainlayout/presentation/cubit/mainlayout_cubit.dart';
import 'package:what_s_up_app/features/mainlayout/presentation/cubit/mainlayout_state.dart';
import 'package:what_s_up_app/features/mainlayout/presentation/ui/widgets/camera_button.dart';
import 'package:what_s_up_app/features/mainlayout/presentation/ui/widgets/floating_action_button.dart';
import 'package:what_s_up_app/features/mainlayout/presentation/ui/widgets/menu_button.dart';
import 'package:what_s_up_app/features/mainlayout/presentation/ui/widgets/plus_button.dart';
import 'package:what_s_up_app/features/mainlayout/presentation/ui/widgets/pop_curve.dart';
import 'package:what_s_up_app/features/mainlayout/presentation/ui/widgets/sliver_app_bar.dart';
import 'package:what_s_up_app/features/mainlayout/presentation/ui/widgets/tab_bar_config.dart';
import 'package:what_s_up_app/features/mainlayout/presentation/ui/widgets/theme_toggle_widget.dart';
import 'package:what_s_up_app/generated/l10n.dart';

class MainlayoutScreen extends StatefulWidget {
  const MainlayoutScreen({super.key});

  @override
  State<MainlayoutScreen> createState() => _MainlayoutScreenState();
}

class _MainlayoutScreenState extends State<MainlayoutScreen>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _scaleAnimations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  @override
  void dispose() {
    _disposeAnimations();
    super.dispose();
  }

  void _initializeAnimations() {
    _controllers = List.generate(
      5,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ),
    );

    _scaleAnimations = _controllers.map((controller) {
      return Tween<double>(
        begin: 1.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controller, curve: const PopCurve()));
    }).toList();
  }

  void _disposeAnimations() {
    for (final controller in _controllers) {
      controller.dispose();
    }
  }

  void _animateIcon(int index) {
    try {
      if (_controllers[index].isAnimating) {
        _controllers[index].stop();
      }
      _controllers[index].reset();
      _controllers[index].forward();
    } catch (e) {
      debugPrint('Animation error: $e');
    }
  }

  // App bar configurations for each tab
  Map<int, TabAppBarConfig> get _tabConfigurations => const {
    0: TabAppBarConfig(leftWidget: MenuButton()),
    1: TabAppBarConfig(leftWidget: MenuButton(), rightWidgets: [PlusButton()]),
    2: TabAppBarConfig(rightWidgets: [PlusButton()]),
    3: TabAppBarConfig(
      leftWidget: MenuButton(),
      rightWidgets: [CameraButton(), SizedBox(width: 16), PlusButton()],
    ),
    4: TabAppBarConfig(),
  };

  // Method to build selected icons that responds to theme changes
  List<Widget> _buildSelectedIcons(bool isDark) {
    return [
      Image.asset(
        'assets/images/status_filled.png',
        width: 32,
        height: 32,
        color: isDark ? Colors.white : Colors.black,
      ),
      Image.asset(
        'assets/images/calls_filled.png',
        width: 32,
        height: 32,
        color: isDark ? Colors.white : Colors.black,
      ),
      Image.asset(
        'assets/images/communities_filled.png',
        width: 32,
        height: 32,
        color: isDark ? Colors.white : Colors.black,
      ),
      Image.asset(
        'assets/images/chats_filled.png',
        width: 32,
        height: 32,
        color: isDark ? Colors.white : Colors.black,
      ),
      Image.asset(
        'assets/images/settings_filled.png',
        width: 32,
        height: 32,
        color: isDark ? Colors.white : Colors.black,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      Text(S().update),
      Text(S().calls),
      Text(S().communities),
      Text('WhatsApp'),
      Text(S().settings),
    ];

    final unselectedIcons = [
      Image.asset('assets/images/status.png', width: 32, height: 32),
      Image.asset('assets/images/calls.png', width: 32, height: 32),
      Image.asset('assets/images/communities.png', width: 32, height: 32),
      Image.asset('assets/images/chats.png', width: 32, height: 32),
      Image.asset('assets/images/settings.png', width: 32, height: 32),
    ];

    return BlocProvider(
      create: (context) => MainLayoutCubit(),
      child: BlocConsumer<MainLayoutCubit, MainLayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = MainLayoutCubit.get(context);

          return Scaffold(
            extendBody: true,
            floatingActionButton: (mainLayoutIntitalScreenIndex == 3)
                ? const FloatingActionButtonWidget()
                : null,
            body: PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                SystemNavigator.pop();
              },
              child: IndexedStack(
                index: mainLayoutIntitalScreenIndex,
                children: [
                  _buildScaffoldPage(0, titles, context, Colors.black),
                  _buildScaffoldPage(1, titles, context, Colors.black),
                  _buildScaffoldPage(2, titles, context, Colors.black),
                  _buildScaffoldPage(
                    3,
                    titles,
                    context,
                    AppLightColors.primary,
                  ),
                  _buildScaffoldPage(4, titles, context, Colors.black),
                ],
              ),
            ),
            bottomNavigationBar: BlocBuilder<AppCubit, AppState>(
              builder: (context, themeState) {
                // Get current theme state
                final isDark =
                    context.watch<AppCubit>().themeMode == ThemeMode.dark;
                final selectedIcons = _buildSelectedIcons(isDark);

                return _buildBottomNavigationBar(
                  titles,
                  unselectedIcons,
                  selectedIcons,
                  cubit,
                  context,
                  isDark,
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildScaffoldPage(
    int index,
    List<Text> titles,
    BuildContext context,
    Color titleColor,
  ) {
    final currentConfig = _tabConfigurations[index] ?? const TabAppBarConfig();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            HomeSliverAppBar(
              isCollapsed: innerBoxIsScrolled,
              config: currentConfig,
              titles: titles,
              currentIndex: index,
              titleColor: titleColor,
            ),
          ];
        },
        body: _buildTabContent(index, titles, context, currentConfig),
      ),
    );
  }

  Widget _buildBottomNavigationBar(
    List<Text> appBarTitles,
    List<Widget> unselectedIcons,
    List<Widget> selectedIcons,
    MainLayoutCubit cubit,
    BuildContext context,
    bool isDark, // Add isDark parameter
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.transparent : AppLightColors.navBarBorder,
            width: 0.2,
          ),
        ),
      ),
      child: BottomNavigationBar(
        selectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        currentIndex: mainLayoutIntitalScreenIndex,
        backgroundColor: isDark
            ? Colors.black.withAlpha(240)
            : Colors.white.withAlpha(240),
        elevation: 0,
        selectedLabelStyle: const TextStyle(
          fontFamily: "SFPro",
          fontWeight: FontWeight.w300,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: "SFPro",
          fontWeight: FontWeight.w300,
        ),
        selectedItemColor: isDark ? Colors.white : Colors.black,
        unselectedItemColor: AppLightColors.textSecondary,
        onTap: (index) {
          _animateIcon(index);
          cubit.changeBottomNavBarIndex(index);
        },
        items: List.generate(5, (index) {
          return BottomNavigationBarItem(
            icon: AnimatedBuilder(
              animation: _scaleAnimations[index],
              builder: (context, child) {
                final progress = _controllers[index].value;
                double scale;
                if (progress <= 0.5) {
                  scale = 1.0 + (progress * 2 * 0.1);
                } else {
                  scale = 1.1 - ((progress - 0.5) * 2 * 0.2);
                }
                scale = scale.clamp(1.0, 1.1);
                return Transform.scale(
                  scale: scale,
                  child: mainLayoutIntitalScreenIndex == index
                      ? selectedIcons[index]
                      : unselectedIcons[index],
                );
              },
            ),
            label: appBarTitles[index].data == 'WhatsApp'
                ? 'Chats'
                : appBarTitles[index].data,
          );
        }),
      ),
    );
  }

  Widget _buildTabContent(
    int index,
    List<Text> appBarTitles,
    BuildContext context,
    TabAppBarConfig config,
  ) {
    switch (index) {
      case 0: // Updates
      //TODO: Implement Updates Page
      // return BlocProvider(
      //   create: (context) => StatusCubit(),
      //   child: const UpdatesPage(),
      // );
      case 1: // Calls
        return Column(
          children: [
            Center(
              child: Text(
                appBarTitles[1].data!,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontFamily: "SFPro",
                
                ),
              ),
            ),
          ],
        );
      case 2: // Communities
        return Column(
          children: [
            Center(
              child: Text(
                appBarTitles[2].data!,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(fontFamily: "SFPro"),
              ),
            ),
          ],
        );
      case 3: // Chats
        return BlocProvider(
          create: (context) => ChatsCubit(),
          child: const ChatsScreen(),
        );
      case 4: // Settings
        return BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 70,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Change theme",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(fontFamily: "SFPro"),
                  ),
                  Spacer(),
                  ThemeToggleWidget(),
                ],
              ),
            );
          },
        );
      default:
        return const Center(child: Text('Unknown tab'));
    }
  }
}
