import 'package:intl/intl.dart';

String formatCurrency(double value) {
  return NumberFormat('#,###.#').format(value);
}

const String kImagePlaceHolder =
    'https://via.placeholder.com/300/a9357c/f9fbfd?text=Blush';

const String kAppUrl = 'http://192.168.43.13:3001/api';
