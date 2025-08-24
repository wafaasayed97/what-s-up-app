import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:what_s_up_app/core/constants/strings.dart';
import 'package:what_s_up_app/features/mainlayout/presentation/cubit/mainlayout_state.dart';

class MainLayoutCubit extends Cubit<MainLayoutState> {
  MainLayoutCubit() : super(MainLayoutInitial());

  static MainLayoutCubit get(BuildContext context) =>
      BlocProvider.of<MainLayoutCubit>(context);
  void changeBottomNavBarIndex(int index) {
    mainLayoutIntitalScreenIndex = index;
    emit(AppBottomNavState(mainLayoutIntitalScreenIndex));
  }
}