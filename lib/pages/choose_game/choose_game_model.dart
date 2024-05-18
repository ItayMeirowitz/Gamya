import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'choose_game_widget.dart' show ChooseGameWidget;
import 'package:flutter/material.dart';

class ChooseGameModel extends FlutterFlowModel<ChooseGameWidget> {
  ///  Local state fields for this page.

  String? errorDetail;

  int notificationCount = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - fetchData] action in ChooseGame widget.
  dynamic dataReceived;
  // Stores action output result for [Backend Call - API (postVocab)] action in ChooseGame widget.
  ApiCallResponse? dontUse;
  // Stores action output result for [Backend Call - API (postTicTacToe)] action in ChooseGame widget.
  ApiCallResponse? postTicTacToeResp;
  // Stores action output result for [Backend Call - API (postMath)] action in ChooseGame widget.
  ApiCallResponse? postMathResp;
  // Stores action output result for [Backend Call - API (postGuessWrong)] action in ChooseGame widget.
  ApiCallResponse? postCheckWrongResp;
  // Stores action output result for [Backend Call - API (postConnectF)] action in ChooseGame widget.
  ApiCallResponse? postConnectFResp;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // Stores action output result for [Backend Call - API (postVocab)] action in Container widget.
  ApiCallResponse? postVocabResp;
  // Stores action output result for [Backend Call - API (postTicTacToe)] action in Container widget.
  ApiCallResponse? postTicTacToeRespLeader;
  // Stores action output result for [Backend Call - API (postConnectF)] action in Container widget.
  ApiCallResponse? postConnect4LeaderResp;
  // Stores action output result for [Backend Call - API (postMath)] action in Container widget.
  ApiCallResponse? postMathLeaderResp;
  // Stores action output result for [Backend Call - API (postGuessWrong)] action in Container widget.
  ApiCallResponse? postGuessWrongLeaderResp;
  // Stores action output result for [Backend Call - API (postGetTZero)] action in Container widget.
  ApiCallResponse? postZeroResp;
  // Stores action output result for [Backend Call - API (getUsers)] action in IconButton widget.
  ApiCallResponse? getUsersResp;
  // Stores action output result for [Backend Call - API (InviteUser)] action in Button widget.
  ApiCallResponse? inviteUserResp;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();
  }
}
