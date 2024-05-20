import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'tic_tac_toe_widget.dart' show TicTacToeWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TicTacToeModel extends FlutterFlowModel<TicTacToeWidget> {
  ///  Local state fields for this page.

  List<String> currentGrid = [];
  void addToCurrentGrid(String item) => currentGrid.add(item);
  void removeFromCurrentGrid(String item) => currentGrid.remove(item);
  void removeAtIndexFromCurrentGrid(int index) => currentGrid.removeAt(index);
  void insertAtIndexInCurrentGrid(int index, String item) =>
      currentGrid.insert(index, item);
  void updateCurrentGridAtIndex(int index, Function(String) updateFn) =>
      currentGrid[index] = updateFn(currentGrid[index]);

  bool started = false;

  bool isTurn = false;

  String? won;

  int? score;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (getTicTacToeBoard)] action in TicTacToe widget.
  ApiCallResponse? getInitialTicTacToeResp;
  // Stores action output result for [Backend Call - API (placeTicTacToe)] action in Image widget.
  ApiCallResponse? placeTicTacToeResp;
  // Stores action output result for [Backend Call - API (getTicTacToeBoard)] action in Image widget.
  ApiCallResponse? getTicTacToeResp;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
