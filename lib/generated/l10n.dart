// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get ar {
    return Intl.message(
      'Arabic',
      name: 'ar',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get en {
    return Intl.message(
      'English',
      name: 'en',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get pass {
    return Intl.message(
      'Password',
      name: 'pass',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get passHint {
    return Intl.message(
      'Enter your password',
      name: 'passHint',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number or password`
  String get invalidUser {
    return Intl.message(
      'Invalid phone number or password',
      name: 'invalidUser',
      desc: '',
      args: [],
    );
  }

  /// `Wer sorry service is currentlly unavailable`
  String get unavailableService {
    return Intl.message(
      'Wer sorry service is currentlly unavailable',
      name: 'unavailableService',
      desc: '',
      args: [],
    );
  }

  /// `Your request to server got cancelled`
  String get requestCancelled {
    return Intl.message(
      'Your request to server got cancelled',
      name: 'requestCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Check Your Network Connection`
  String get networkError {
    return Intl.message(
      'Check Your Network Connection',
      name: 'networkError',
      desc: '',
      args: [],
    );
  }

  /// `Reload`
  String get reload {
    return Intl.message(
      'Reload',
      name: 'reload',
      desc: '',
      args: [],
    );
  }

  /// `Reports`
  String get reports {
    return Intl.message(
      'Reports',
      name: 'reports',
      desc: '',
      args: [],
    );
  }

  /// `Cash`
  String get cash {
    return Intl.message(
      'Cash',
      name: 'cash',
      desc: '',
      args: [],
    );
  }

  /// `Mbok`
  String get mbok {
    return Intl.message(
      'Mbok',
      name: 'mbok',
      desc: '',
      args: [],
    );
  }

  /// `Cash & Mbok`
  String get cashAndMbok {
    return Intl.message(
      'Cash & Mbok',
      name: 'cashAndMbok',
      desc: '',
      args: [],
    );
  }

  /// `Unpaid`
  String get unpaid {
    return Intl.message(
      'Unpaid',
      name: 'unpaid',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `No Orders`
  String get noOrders {
    return Intl.message(
      'No Orders',
      name: 'noOrders',
      desc: '',
      args: [],
    );
  }

  /// `Call`
  String get call {
    return Intl.message(
      'Call',
      name: 'call',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Primary Phone`
  String get primaryPhone {
    return Intl.message(
      'Primary Phone',
      name: 'primaryPhone',
      desc: '',
      args: [],
    );
  }

  /// `Second Phone`
  String get secondaryPhone {
    return Intl.message(
      'Second Phone',
      name: 'secondaryPhone',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Notifiy`
  String get notify {
    return Intl.message(
      'Notifiy',
      name: 'notify',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Cash + Mbok not equal order total`
  String get invalidCashAndMbok {
    return Intl.message(
      'Cash + Mbok not equal order total',
      name: 'invalidCashAndMbok',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Recepit`
  String get receipt {
    return Intl.message(
      'Recepit',
      name: 'receipt',
      desc: '',
      args: [],
    );
  }

  /// `Select receipt from gallery or capture a photo`
  String get selectImagePath {
    return Intl.message(
      'Select receipt from gallery or capture a photo',
      name: 'selectImagePath',
      desc: '',
      args: [],
    );
  }

  /// `update`
  String get update {
    return Intl.message(
      'update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Shipping details`
  String get shippingDetails {
    return Intl.message(
      'Shipping details',
      name: 'shippingDetails',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Add note`
  String get addNote {
    return Intl.message(
      'Add note',
      name: 'addNote',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get note {
    return Intl.message(
      'Note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `SEE ALL`
  String get seeAll {
    return Intl.message(
      'SEE ALL',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Proudcts total`
  String get productTotal {
    return Intl.message(
      'Proudcts total',
      name: 'productTotal',
      desc: '',
      args: [],
    );
  }

  /// ` SDG`
  String get sdg {
    return Intl.message(
      ' SDG',
      name: 'sdg',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Fees`
  String get shipping {
    return Intl.message(
      'Delivery Fees',
      name: 'shipping',
      desc: '',
      args: [],
    );
  }

  /// `Order total`
  String get orderTotal {
    return Intl.message(
      'Order total',
      name: 'orderTotal',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get eng {
    return Intl.message(
      'English',
      name: 'eng',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arb {
    return Intl.message(
      'Arabic',
      name: 'arb',
      desc: '',
      args: [],
    );
  }

  /// `Switch to {name}`
  String switchTo(Object name) {
    return Intl.message(
      'Switch to $name',
      name: 'switchTo',
      desc: '',
      args: [name],
    );
  }

  /// `Switch to light`
  String get switchToLight {
    return Intl.message(
      'Switch to light',
      name: 'switchToLight',
      desc: '',
      args: [],
    );
  }

  /// `Switch to dark`
  String get switchToDark {
    return Intl.message(
      'Switch to dark',
      name: 'switchToDark',
      desc: '',
      args: [],
    );
  }

  /// `Switch to Arabic`
  String get switchToArb {
    return Intl.message(
      'Switch to Arabic',
      name: 'switchToArb',
      desc: '',
      args: [],
    );
  }

  /// `Switch to English`
  String get switchToEng {
    return Intl.message(
      'Switch to English',
      name: 'switchToEng',
      desc: '',
      args: [],
    );
  }

  /// `logout`
  String get logout {
    return Intl.message(
      'logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Genreal Settings`
  String get generalSettings {
    return Intl.message(
      'Genreal Settings',
      name: 'generalSettings',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
