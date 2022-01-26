import 'dart:typed_data';

import 'package:blush_delivery/interfaces/i_image_picker_service.dart';
import 'package:blush_delivery/interfaces/i_permission_handler_service.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/models/order_update_model.dart';
import 'package:dio/dio.dart';

abstract class IEditOrderService {
  late final IImagePickerService imagePickerService;
  late final IPermissionHandlerService permissionService;
  Future<Order?> updateOrder(OrderUpdateModel model, {Uint8List? bytes});
  Future<Receipt> uploadReceipt(Uint8List bytes);
  FormData getFormData(Uint8List bytes);
}
