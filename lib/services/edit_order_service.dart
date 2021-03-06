import 'dart:typed_data';

import 'package:blush_delivery/enums/payment_method.dart';
import 'package:blush_delivery/interfaces/i_edit_order_service.dart';
import 'package:blush_delivery/interfaces/i_permission_handler_service.dart';
import 'package:blush_delivery/interfaces/i_image_picker_service.dart';
import 'package:blush_delivery/models/order_update_model.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/services/base_service.dart';
import 'package:blush_delivery/services/image_picker_service.dart';
import 'package:blush_delivery/services/permission_handler_service.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:dio/dio.dart';

import 'package:http_parser/http_parser.dart';

class EditOrderService extends BaseService implements IEditOrderService {
  @override
  IImagePickerService imagePickerService = ImagePickerService();
  @override
  IPermissionHandlerService permissionService = PermissionHandlerService();
  late String? _path;
  @override
  String get path => _path ?? '';
  set path(String value) {
    _path = value;
  }

  @override
  Future<Order?> updateOrder(OrderUpdateModel model, {Uint8List? bytes}) async {
    try {
      Map<String, dynamic> data;
      if (model.paymentMethod != PaymentMethod.cash) {
        var receipt = await uploadReceipt(bytes!);
        data = model.toJson(extendedData: receipt.toJson());
      } else {
        data = model.toJson();
      }
      var res = await put(path: '/woo-orders/${model.id}', data: data);
      return Order.fromJson(res.data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Receipt> uploadReceipt(Uint8List bytes) async {
    try {
      path = '/images';
      var res = await uploadImage(formData: getFormData(bytes));
      return Receipt.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  FormData getFormData(Uint8List bytes) {
    return FormData.fromMap(
      {
        'receipt': MultipartFile.fromBytes(bytes,
            filename: 'receipt', contentType: MediaType('image', 'png')),
      },
    );
  }

  @override
  Future<Order> addOrderNotes(
      {required String id, required List<Map<String, dynamic>> data}) async {
    try {
      var res = await put(path: '/woo-orders/$id', data: {'notes': data});
      return Order.fromJson(res.data);
    } catch (e) {
      AppLogger.e(e);
      rethrow;
    }
  }
}
