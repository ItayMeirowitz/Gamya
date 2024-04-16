import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'tic_tac_toe_widget.dart' show TicTacToeWidget;
import 'package:flutter/material.dart';

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
