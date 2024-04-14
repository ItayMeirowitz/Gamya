import '/flutter_flow/flutter_flow_util.dart';
import 'i_pregisteration_widget.dart' show IPregisterationWidget;
import 'package:flutter/material.dart';

class IPregisterationModel extends FlutterFlowModel<IPregisterationWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
