import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/notifications/notifications_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'choose_game_widget.dart' show ChooseGameWidget;
import 'package:badges/badges.dart' as badges;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChooseGameModel extends FlutterFlowModel<ChooseGameWidget> {
  ///  Local state fields for this page.

  String? errorDetail;

  int notificationCount = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - fetchData] action in ChooseGame widget.
  dynamic? dataReceived;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

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
