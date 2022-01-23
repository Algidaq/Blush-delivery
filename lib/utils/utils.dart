import 'package:intl/intl.dart';

String formatCurrency(double value) {
  return NumberFormat('#,###.#').format(value);
}
