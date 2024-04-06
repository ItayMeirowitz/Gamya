import '/flutter_flow/flutter_flow_util.dart';
import 'error_page_widget.dart' show ErrorPageWidget;
import 'package:flutter/material.dart';

class ErrorPageModel extends FlutterFlowModel<ErrorPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
