import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blush_delivery/repo/app_pref.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AppEvents {}

class AppLangChange extends AppEvents {
  final Locale locale;
  AppLangChange(this.locale);
}

class AppThemeChange extends AppEvents {
  final ThemeMode themeMode;
  AppThemeChange(this.themeMode);
}

class AppState extends Equatable {
  final Locale locale;
  final ThemeMode themeMode;
  const AppState(this.locale, this.themeMode);

  AppState copyWith({Locale? locale, ThemeMode? themeMode}) =>
      AppState(locale ?? this.locale, themeMode ?? this.themeMode);
  @override
  List<Object?> get props => [locale, themeMode];
}

class AppBloc extends Bloc<AppEvents, AppState> {
  final AppPref appPref;
  AppBloc(this.appPref)
      : super(
          AppState(
            appPref.preferedLocale,
            appPref.preferedTheme,
          ),
        ) {
    on<AppLangChange>(handleLangChange);
    on<AppThemeChange>(handleThemeChange);
  }

  FutureOr<void> handleLangChange(
      AppLangChange event, Emitter<AppState> emit) async {
    await appPref.setPreferedLocale(event.locale);
    emit(state.copyWith(locale: event.locale));
  }

  FutureOr<void> handleThemeChange(
      AppThemeChange event, Emitter<AppState> emit) async {
    await appPref.setPreferedTheme(event.themeMode);
    emit(state.copyWith(themeMode: event.themeMode));
  }

  bool get isDarkMode => state.themeMode == ThemeMode.dark;
  void onThemeChange(bool? value) {
    if (value != null && value) {
      add(AppThemeChange(ThemeMode.dark));
    } else {
      add(AppThemeChange(ThemeMode.light));
    }
  }

  void onLangChange(String? value) {
    add(AppLangChange(Locale(value ?? 'en')));
  }
}
