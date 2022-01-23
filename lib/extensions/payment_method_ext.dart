import 'package:blush_delivery/enums/payment_method.dart';
import 'package:blush_delivery/generated/l10n.dart';

extension PaymentMethodExt on PaymentMethod {
  String title(S s) {
    switch (this) {
      case PaymentMethod.cash:
        return s.cash;
      case PaymentMethod.mbok:
        return s.mbok;
      case PaymentMethod.cashAndMobk:
        return s.cashAndMbok;
      case PaymentMethod.unpaid:
        return s.unpaid;
    }
  }
}
