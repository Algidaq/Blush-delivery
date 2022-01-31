part of 'order.dart';

class Note extends Equatable {
  late final String? _id;
  late final String? _note;
  late final String? _createDate;

  Note.fromJson(Map<String, dynamic> json) {
    try {
      _id = json['id'];
      _note = json['note'];
      _createDate = json['createDate'];
    } catch (e) {
      AppLogger.e(Note, e);
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'note': note, 'createDate': createDate};
  }

  String get id => _id ?? 'N/A';
  String get note => _note ?? 'N/A';
  String get createDate => _createDate ?? DateTime.now().toString();
  String get formatedDate =>
      DateFormat('dd-MMM-YY').format(DateTime.parse(createDate));

  @override
  List<Object?> get props => [id, note, createDate];
}
