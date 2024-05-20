import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'guess_wrong_widget.dart' show GuessWrongWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GuessWrongModel extends FlutterFlowModel<GuessWrongWidget> {
  ///  Local state fields for this page.

  bool isTurn = false;

  String? category;

  String? secretWord;

  String? guessCategory;

  bool waitingGuess = false;

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
  // Stores action output result for [Custom Action - fetchData] action in GuessWrong widget.
  dynamic? currentReceived;
  // Stores action output result for [Custom Action - fetchData] action in GuessWrong widget.
  dynamic? dataReceivedTurn;
  // Stores action output result for [Backend Call - API (getScore)] action in GuessWrong widget.
  ApiCallResponse? getScoreTurnResp;
  // Stores action output result for [Custom Action - fetchData] action in GuessWrong widget.
  dynamic? dataReceived;
  // Stores action output result for [Backend Call - API (getScore)] action in GuessWrong widget.
  ApiCallResponse? getScoreResp;
  // State field(s) for category widget.
  FocusNode? categoryFocusNode;
  TextEditingController? categoryTextController;
  String? Function(BuildContext, String?)? categoryTextControllerValidator;
  // State field(s) for secretWord widget.
  FocusNode? secretWordFocusNode;
  TextEditingController? secretWordTextController;
  String? Function(BuildContext, String?)? secretWordTextControllerValidator;
  // Stores action output result for [Backend Call - API (postGuessWCategory)] action in Button widget.
  ApiCallResponse? postCategoryResp;
  // State field(s) for guess widget.
  FocusNode? guessFocusNode;
  TextEditingController? guessTextController;
  String? Function(BuildContext, String?)? guessTextControllerValidator;
  // Stores action output result for [Backend Call - API (postCheckGuessW)] action in Button widget.
  ApiCallResponse? postCheckGuessResp;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    categoryFocusNode?.dispose();
    categoryTextController?.dispose();

    secretWordFocusNode?.dispose();
    secretWordTextController?.dispose();

    guessFocusNode?.dispose();
    guessTextController?.dispose();
  }
}
