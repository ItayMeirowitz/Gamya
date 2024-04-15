import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'get2_zero_widget.dart' show Get2ZeroWidget;
import 'package:flutter/material.dart';

class Get2ZeroModel extends FlutterFlowModel<Get2ZeroWidget> {
  ///  Local state fields for this page.

  String initialOptimal = '?';

  int clicks = 0;

  int initialDecrementer = 1;

  double? initialNumber;

  String currentOptimal = '?';

  bool reveal = false;

  double? currentNumber;

  int currentDecrementer = 1;

  double percentage = 10.0;

  bool started = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (getOptimal)] action in Button widget.
  ApiCallResponse? getOptimalResp;
  // State field(s) for Slider widget.
  double? sliderValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
