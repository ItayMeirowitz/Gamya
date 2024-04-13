import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'game_finished_widget.dart' show GameFinishedWidget;
import 'package:flutter/material.dart';

class GameFinishedModel extends FlutterFlowModel<GameFinishedWidget> {
  ///  Local state fields for this page.

  List<dynamic> scores = [];
  void addToScores(dynamic item) => scores.add(item);
  void removeFromScores(dynamic item) => scores.remove(item);
  void removeAtIndexFromScores(int index) => scores.removeAt(index);
  void insertAtIndexInScores(int index, dynamic item) =>
      scores.insert(index, item);
  void updateScoresAtIndex(int index, Function(dynamic) updateFn) =>
      scores[index] = updateFn(scores[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (postScore)] action in GameFinished widget.
  ApiCallResponse? postScoreResp;
  // Stores action output result for [Backend Call - API (getScore)] action in GameFinished widget.
  ApiCallResponse? initialGetScoreResp;
  // Stores action output result for [Backend Call - API (getScore)] action in Button widget.
  ApiCallResponse? getScoreResp;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
