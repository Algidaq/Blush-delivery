import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Pref {
  final SharedPreferences preferences;
  Pref(this.preferences);
  Locale get preferedLocale;
  ThemeMode get preferedTheme;
  Future<bool> setPreferedLocale(Locale preferedLocale);
  Future<bool> setPreferedTheme(ThemeMode themeMode);
  Future<bool> setUserToken(String token);
  Future<bool> removeUser();
  String? get token;
}

class AppPref extends Pref {
  static const kLangCodeKey = 'LangCode';
  static const kThemeModeKey = 'ThemeMode';
  static const kUserTokenKey = 'UserToken';

  AppPref(SharedPreferences preferences) : super(preferences);

  @override
  Locale get preferedLocale {
    String langCode = preferences.getString(kLangCodeKey) ?? 'en';
    return Locale(langCode);
  }

  @override
  ThemeMode get preferedTheme {
    var themeIndex = preferences.getInt(kThemeModeKey) ?? 1;
    if (themeIndex == ThemeMode.system.index) {
      return ThemeMode.light;
    } else if (themeIndex == ThemeMode.light.index) {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }

  @override
  Future<bool> setPreferedLocale(Locale preferedLocale) async {
    return preferences.setString(kLangCodeKey, preferedLocale.languageCode);
  }

  @override
  Future<bool> setPreferedTheme(ThemeMode themeMode) {
    var theme = themeMode.index;
    return preferences.setInt(kThemeModeKey, theme);
  }

  @override
  Future<bool> setUserToken(String token) {
    return preferences.setString(kUserTokenKey, token);
  }

  @override
  String? get token => preferences.getString(kUserTokenKey);

  @override
  Future<bool> removeUser() {
    return preferences.remove(kUserTokenKey);
  }
}
