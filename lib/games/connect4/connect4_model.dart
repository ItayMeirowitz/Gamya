import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'connect4_widget.dart' show Connect4Widget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
