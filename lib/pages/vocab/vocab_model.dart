import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'vocab_widget.dart' show VocabWidget;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class VocabModel extends FlutterFlowModel<VocabWidget> {
  ///  Local state fields for this page.

  List<dynamic> vocabList = [];
  void addToVocabList(dynamic item) => vocabList.add(item);
  void removeFromVocabList(dynamic item) => vocabList.remove(item);
  void removeAtIndexFromVocabList(int index) => vocabList.removeAt(index);
  void insertAtIndexInVocabList(int index, dynamic item) =>
      vocabList.insert(index, item);
  void updateVocabListAtIndex(int index, Function(dynamic) updateFn) =>
      vocabList[index] = updateFn(vocabList[index]);

  String? wordToGuess = 'SUS';

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
  AudioPlayer? soundPlayer1;
  AudioPlayer? soundPlayer2;
  AudioPlayer? soundPlayer3;
  AudioPlayer? soundPlayer4;
  AudioPlayer? soundPlayer5;
  AudioPlayer? soundPlayer6;
  AudioPlayer? soundPlayer7;
  AudioPlayer? soundPlayer8;
  // Stores action output result for [Backend Call - API (getVocab)] action in Button widget.
  ApiCallResponse? vocabJSON;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
