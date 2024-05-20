import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'get2_zero_widget.dart' show Get2ZeroWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

  double percentage = 5.0;

  bool started = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (getOptimal)] action in Button widget.
  ApiCallResponse? getOptimalIncResp;
  // Stores action output result for [Backend Call - API (getOptimal)] action in Button widget.
  ApiCallResponse? getOptimalPerResp;
  // Stores action output result for [Backend Call - API (getOptimal)] action in Button widget.
  ApiCallResponse? getOptimalDecResp;
  // Stores action output result for [Backend Call - API (getOptimal)] action in Button widget.
  ApiCallResponse? getOptimalResp;
  // State field(s) for Slider widget.
  double? sliderValue;
  // State field(s) for CountController widget.
  int? countControllerValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
