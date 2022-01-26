part of 'order_view_header.dart';

class OrderHeaderItem extends StatelessWidget {
  final IconData leadingIcon;
  final String leadingText;
  final IconData trailingIcon;
  final String trailingText;
  const OrderHeaderItem(
      {Key? key,
      required this.leadingIcon,
      required this.leadingText,
      required this.trailingIcon,
      required this.trailingText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            Icon(
              leadingIcon,
              color: kcPrimary,
            ),
            horizontalSpaceTiny,
            AppText.body(leadingText),
          ],
        ),
        verticalSpaceRegular,
        Row(
          children: [
            Icon(
              trailingIcon,
              color: kcPrimary,
            ),
            horizontalSpaceTiny,
            AppText.body(trailingText),
          ],
        ),
      ],
    );
  }
}
