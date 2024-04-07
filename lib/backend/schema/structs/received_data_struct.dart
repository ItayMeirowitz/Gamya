// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReceivedDataStruct extends BaseStruct {
  ReceivedDataStruct({
    String? type,
  }) : _type = type;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;
  bool hasType() => _type != null;

  static ReceivedDataStruct fromMap(Map<String, dynamic> data) =>
      ReceivedDataStruct(
        type: data['type'] as String?,
      );

  static ReceivedDataStruct? maybeFromMap(dynamic data) => data is Map
      ? ReceivedDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'type': _type,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
      }.withoutNulls;

  static ReceivedDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      ReceivedDataStruct(
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ReceivedDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ReceivedDataStruct && type == other.type;
  }

  @override
  int get hashCode => const ListEquality().hash([type]);
}

ReceivedDataStruct createReceivedDataStruct({
  String? type,
}) =>
    ReceivedDataStruct(
      type: type,
    );
