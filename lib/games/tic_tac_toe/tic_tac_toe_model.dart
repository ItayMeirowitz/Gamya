import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'tic_tac_toe_widget.dart' show TicTacToeWidget;
import 'package:flutter/material.dart';

class TicTacToeModel extends FlutterFlowModel<TicTacToeWidget> {
  ///  Local state fields for this page.

  List<dynamic> currentGrid = [];
  void addToCurrentGrid(dynamic item) => currentGrid.add(item);
  void removeFromCurrentGrid(dynamic item) => currentGrid.remove(item);
  void removeAtIndexFromCurrentGrid(int index) => currentGrid.removeAt(index);
  void insertAtIndexInCurrentGrid(int index, dynamic item) =>
      currentGrid.insert(index, item);
  void updateCurrentGridAtIndex(int index, Function(dynamic) updateFn) =>
      currentGrid[index] = updateFn(currentGrid[index]);

  bool started = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (postTicTacToe)] action in TicTacToe widget.
  ApiCallResponse? postTicTacToeResp;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
