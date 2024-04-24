import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'guess_wrong_widget.dart' show GuessWrongWidget;
import 'package:flutter/material.dart';

class GuessWrongModel extends FlutterFlowModel<GuessWrongWidget> {
  ///  Local state fields for this page.

  bool isTurn = false;

  String? category;

  String? secretWord;

  String? guessCategory;

  bool waitingGuess = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - fetchData] action in GuessWrong widget.
  dynamic currentReceived;
  // Stores action output result for [Custom Action - fetchData] action in GuessWrong widget.
  dynamic dataReceived;
  // Stores action output result for [Custom Action - fetchData] action in GuessWrong widget.
  dynamic dataReceivedTurn;
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
