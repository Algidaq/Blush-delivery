// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "ar": MessageLookupByLibrary.simpleMessage("Arabic"),
        "call": MessageLookupByLibrary.simpleMessage("Call"),
        "cash": MessageLookupByLibrary.simpleMessage("Cash"),
        "cashAndMbok": MessageLookupByLibrary.simpleMessage("Cash & Mbok"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "en": MessageLookupByLibrary.simpleMessage("English"),
        "invalidCashAndMbok": MessageLookupByLibrary.simpleMessage(
            "Cash + Mbok not equal order total"),
        "invalidUser": MessageLookupByLibrary.simpleMessage(
            "Invalid phone number or password"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "mbok": MessageLookupByLibrary.simpleMessage("Mbok"),
        "networkError": MessageLookupByLibrary.simpleMessage(
            "Check Your Network Connection"),
        "noOrders": MessageLookupByLibrary.simpleMessage("No Orders"),
        "notes": MessageLookupByLibrary.simpleMessage("Notes"),
        "notify": MessageLookupByLibrary.simpleMessage("Notifiy"),
        "orders": MessageLookupByLibrary.simpleMessage("Orders"),
        "pass": MessageLookupByLibrary.simpleMessage("Password"),
        "passHint": MessageLookupByLibrary.simpleMessage("Enter your password"),
        "paymentMethod": MessageLookupByLibrary.simpleMessage("Payment Method"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone Number"),
        "primaryPhone": MessageLookupByLibrary.simpleMessage("Primary Phone"),
        "receipt": MessageLookupByLibrary.simpleMessage("Recepit"),
        "reload": MessageLookupByLibrary.simpleMessage("Reload"),
        "reports": MessageLookupByLibrary.simpleMessage("Reports"),
        "requestCancelled": MessageLookupByLibrary.simpleMessage(
            "Your request to server got cancelled"),
        "secondaryPhone": MessageLookupByLibrary.simpleMessage("Second Phone"),
        "select": MessageLookupByLibrary.simpleMessage("Select"),
        "selectImagePath": MessageLookupByLibrary.simpleMessage(
            "Select receipt from gallery or capture a photo"),
        "total": MessageLookupByLibrary.simpleMessage("Total"),
        "unavailableService": MessageLookupByLibrary.simpleMessage(
            "Wer sorry service is currentlly unavailable"),
        "unpaid": MessageLookupByLibrary.simpleMessage("Unpaid"),
        "update": MessageLookupByLibrary.simpleMessage("update")
      };
}
