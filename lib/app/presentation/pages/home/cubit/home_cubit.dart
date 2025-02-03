import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/router/retip_router.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit([PageController? controller])
      : super(HomeState(controller ?? PageController()));

  void goToPage(int value) {
    final shellContext = RetipRouter.shellNavKey.currentContext;

    bool jump = false;
    while (shellContext != null && Navigator.canPop(shellContext)) {
      Navigator.pop(shellContext);
      jump = true;
    }

    if (jump) {
      state.controller.jumpToPage(
        value,
      );
    } else {
      state.controller.animateToPage(
        value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    emit(HomeState(state.controller, value));
  }

  @override
  Future<void> close() {
    state.controller.dispose();
    return super.close();
  }
}
