import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'authenticate_widget.dart' show AuthenticateWidget;
import 'package:flutter/material.dart';

class AuthenticateModel extends FlutterFlowModel<AuthenticateWidget> {
  ///  Local state fields for this page.

  String? username;

  String? emailAdress;

  String? password;

  String? usernameCreate;

  String? emailAdressCreate;

  String? passwordCreate;

  String? passwordConfirm;

  String? signUpError;

  int? signUpErrorCode;

  String? signInError;

  int? signInErrorCode;

  String? birthday;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // State field(s) for username widget.
  FocusNode? usernameFocusNode;
  TextEditingController? usernameController;
  String? Function(BuildContext, String?)? usernameControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordControllerValidator;
  // Stores action output result for [Backend Call - API (ConnectUser)] action in Button widget.
  ApiCallResponse? signInResp;
  // State field(s) for username_Create widget.
  FocusNode? usernameCreateFocusNode;
  TextEditingController? usernameCreateController;
  String? Function(BuildContext, String?)? usernameCreateControllerValidator;
  // State field(s) for emailAddress_Create widget.
  FocusNode? emailAddressCreateFocusNode;
  TextEditingController? emailAddressCreateController;
  String? Function(BuildContext, String?)?
      emailAddressCreateControllerValidator;
  DateTime? datePicked;
  // State field(s) for password_Create widget.
  FocusNode? passwordCreateFocusNode;
  TextEditingController? passwordCreateController;
  late bool passwordCreateVisibility;
  String? Function(BuildContext, String?)? passwordCreateControllerValidator;
  // State field(s) for passwordConfirm widget.
  FocusNode? passwordConfirmFocusNode;
  TextEditingController? passwordConfirmController;
  late bool passwordConfirmVisibility;
  String? Function(BuildContext, String?)? passwordConfirmControllerValidator;
  // Stores action output result for [Backend Call - API (ConnectUser)] action in Button widget.
  ApiCallResponse? signUpResp;

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
    passwordCreateVisibility = false;
    passwordConfirmVisibility = false;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();
    usernameFocusNode?.dispose();
    usernameController?.dispose();

    passwordFocusNode?.dispose();
    passwordController?.dispose();

    usernameCreateFocusNode?.dispose();
    usernameCreateController?.dispose();

    emailAddressCreateFocusNode?.dispose();
    emailAddressCreateController?.dispose();

    passwordCreateFocusNode?.dispose();
    passwordCreateController?.dispose();

    passwordConfirmFocusNode?.dispose();
    passwordConfirmController?.dispose();
  }
}
