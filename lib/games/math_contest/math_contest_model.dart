import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'math_contest_widget.dart' show MathContestWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class MathContestModel extends FlutterFlowModel<MathContestWidget> {
  ///  Local state fields for this page.

  List<dynamic> mathList = [];
  void addToMathList(dynamic item) => mathList.add(item);
  void removeFromMathList(dynamic item) => mathList.remove(item);
  void removeAtIndexFromMathList(int index) => mathList.removeAt(index);
  void insertAtIndexInMathList(int index, dynamic item) =>
      mathList.insert(index, item);
  void updateMathListAtIndex(int index, Function(dynamic) updateFn) =>
      mathList[index] = updateFn(mathList[index]);

  String? eqToSolve = 'SUS';

  String? op1;

  String? op2;

  String? op3;

  String? op4;

  int? clientScore = 0;

  bool? hasStarted = false;

  int? currentIndex = 0;

  String? correct;

  int quizLength = 0;

  String diff = 'easy';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (postMathAnswer)] action in Button widget.
  ApiCallResponse? postMathAnswer1Resp;
  AudioPlayer? soundPlayer1;
  AudioPlayer? soundPlayer2;
  // Stores action output result for [Backend Call - API (postMathAnswer)] action in Button widget.
  ApiCallResponse? postMathAnswer2Resp;
  AudioPlayer? soundPlayer3;
  AudioPlayer? soundPlayer4;
  // Stores action output result for [Backend Call - API (postMathAnswer)] action in Button widget.
  ApiCallResponse? postMathAnswer3Resp;
  AudioPlayer? soundPlayer5;
  AudioPlayer? soundPlayer6;
  // Stores action output result for [Backend Call - API (postMathAnswer)] action in Button widget.
  ApiCallResponse? postMathAnswer4Resp;
  AudioPlayer? soundPlayer7;
  AudioPlayer? soundPlayer8;
  // Stores action output result for [Backend Call - API (getMathTest)] action in Button widget.
  ApiCallResponse? mathJSON;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
