import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'connect4_widget.dart' show Connect4Widget;
import 'package:flutter/material.dart';

class Connect4Model extends FlutterFlowModel<Connect4Widget> {
  ///  Local state fields for this page.

  List<String> currentGrid = [];
  void addToCurrentGrid(String item) => currentGrid.add(item);
  void removeFromCurrentGrid(String item) => currentGrid.remove(item);
  void removeAtIndexFromCurrentGrid(int index) => currentGrid.removeAt(index);
  void insertAtIndexInCurrentGrid(int index, String item) =>
      currentGrid.insert(index, item);
  void updateCurrentGridAtIndex(int index, Function(String) updateFn) =>
      currentGrid[index] = updateFn(currentGrid[index]);

  bool isTurn = false;

  bool started = false;

  String? won;

  int? score;

  String? type;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (getConnectFBoard)] action in Connect4 widget.
  ApiCallResponse? getInitialConnectResp;
  // Stores action output result for [Backend Call - API (placeConnectF)] action in Image widget.
  ApiCallResponse? placeConnect4Resp;
  // Stores action output result for [Backend Call - API (getConnectFBoard)] action in Image widget.
  ApiCallResponse? getConnect4Resp;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
