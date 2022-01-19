import 'package:blush_delivery/app_bloc.dart';
import 'package:blush_delivery/repo/app_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('AppBloc Test-', () {
    group('Consturction Test-', () {
      test('When Constructed with empty Pref', () async {
        //Arrange
        SharedPreferences.setMockInitialValues({});
        var pref = await SharedPreferences.getInstance();
        var appPref = AppPref(pref);
        //Act
        var bloc = AppBloc(appPref);
        //Assert
        expect(bloc.state.locale.languageCode,
            appPref.preferedLocale.languageCode);
        expect(bloc.state.themeMode, appPref.preferedTheme);
      });

      test(
          'When Constucted with prefered lang ar theme is dark, app initial state should be locale ar and themeMode dark',
          () async {
        //Arrange
        SharedPreferences.setMockInitialValues({
          AppPref.kLangCodeKey: 'ar',
          AppPref.kThemeModeKey: ThemeMode.dark.index
        });
        var pref = await SharedPreferences.getInstance();
        //Act
        var appBloc = AppBloc(AppPref(pref));
        //Assert
        expect(appBloc.state.locale.languageCode, 'ar');
        expect(appBloc.state.themeMode, ThemeMode.dark);
      });
    });

    group('Properties Test-', () {
      setUp(() async {
        SharedPreferences.setMockInitialValues({
          AppPref.kLangCodeKey: 'ar',
          AppPref.kThemeModeKey: ThemeMode.dark.index
        });
      });
      test('isDarkMode if appinitial state is dark', () async {
        //Arrange
        var pref = await SharedPreferences.getInstance();
        //Act
        var appBloc = AppBloc(AppPref(pref));
        //Assert
        expect(appBloc.isDarkMode, true);
      });
    });

    group('AppState changes', () {
      test('onChange Lang, when String is null, App State lang should be en',
          () async {
        //Arrange
        SharedPreferences.setMockInitialValues({AppPref.kLangCodeKey: 'ar'});
        var appBloc = AppBloc(AppPref(await SharedPreferences.getInstance()));
        //Act
        appBloc.onLangChange(null);
        //Assert
        await Future.delayed(const Duration(seconds: 1));
        expect(appBloc.state.locale.languageCode, 'en');
        expect(appBloc.appPref.preferedLocale.languageCode, 'en');
      });

      test('onChange Lang, when String is ar, App State lang should be ar',
          () async {
        //Arrange
        SharedPreferences.setMockInitialValues({AppPref.kLangCodeKey: 'ar'});
        var appBloc = AppBloc(AppPref(await SharedPreferences.getInstance()));
        //Act
        appBloc.onLangChange('ar');
        //Assert
        await Future.delayed(const Duration(seconds: 1));
        expect(appBloc.state.locale.languageCode, 'ar');
        expect(appBloc.appPref.preferedLocale.languageCode, 'ar');
      });

      test(
          'When onChangeTheme is Called with a null value, themeMode should light',
          () async {
        //Arrange
        SharedPreferences.setMockInitialValues(
            {AppPref.kThemeModeKey: ThemeMode.system.index});
        var appBloc = AppBloc(AppPref(await SharedPreferences.getInstance()));
        //Act
        appBloc.onThemeChange(null);
        //Assert
        await Future.delayed(const Duration(seconds: 1));
        expect(appBloc.state.themeMode, ThemeMode.light);
        expect(appBloc.appPref.preferedTheme, ThemeMode.light);
      });

      test(
          'When onChangeTheme is Called with a true value, themeMode should dark',
          () async {
        //Arrange
        SharedPreferences.setMockInitialValues(
            {AppPref.kThemeModeKey: ThemeMode.system.index});
        var appBloc = AppBloc(AppPref(await SharedPreferences.getInstance()));
        //Act
        appBloc.onThemeChange(true);
        //Assert
        await Future.delayed(const Duration(seconds: 1));
        expect(appBloc.state.themeMode, ThemeMode.dark);
        expect(appBloc.appPref.preferedTheme, ThemeMode.dark);
      });
    });
  });
}
