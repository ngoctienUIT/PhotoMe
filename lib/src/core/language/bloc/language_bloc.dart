import 'dart:io' show Platform;

import 'package:flutter/material.dart' show Locale;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  int? language;

  LanguageBloc({this.language}) : super(LanguageChange(getLocal(language))) {
    on<ChangeLanguageEvent>((event, emit) => changeLanguage(event.isVN, emit));
  }

  static Locale getLocal(int? lang) {
    return lang == null
        ? Locale(Platform.localeName.split('_')[0] == "vi" ? "vi" : "en")
        : (lang == 0 ? const Locale('vi') : const Locale('en'));
  }

  void changeLanguage(bool isVN, Emitter emit) {
    if (isVN) {
      language = 0;
      emit(const LanguageChange(Locale('vi')));
    } else {
      language = 1;
      emit(const LanguageChange(Locale('en')));
    }
  }
}
