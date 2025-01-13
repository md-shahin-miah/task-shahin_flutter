import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UiPrvoderState {

  PageController pageController;

  UiPrvoderState(
      {
        required this.pageController});

  UiPrvoderState copyWith({

    PageController? pageController,
  }) =>
      UiPrvoderState(

        pageController: pageController ?? this.pageController,
      );
}

class UiProviderNotifier extends StateNotifier<UiPrvoderState> {
  UiProviderNotifier()
      : super(UiPrvoderState(pageController: PageController(initialPage: 0)));




   void setSelectedMenuOpt(int i) {
    state.pageController?.animateToPage(i,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }


}

final uiProviders =
StateNotifierProvider.autoDispose<UiProviderNotifier, UiPrvoderState>(
        (ref) {
      return UiProviderNotifier();
    });
