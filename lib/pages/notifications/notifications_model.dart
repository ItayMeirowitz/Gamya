import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'notifications_widget.dart' show NotificationsWidget;
import 'package:flutter/material.dart';

class NotificationsModel extends FlutterFlowModel<NotificationsWidget> {
  ///  Local state fields for this component.

  List<dynamic> requestList = [];
  void addToRequestList(dynamic item) => requestList.add(item);
  void removeFromRequestList(dynamic item) => requestList.remove(item);
  void removeAtIndexFromRequestList(int index) => requestList.removeAt(index);
  void insertAtIndexInRequestList(int index, dynamic item) =>
      requestList.insert(index, item);
  void updateRequestListAtIndex(int index, Function(dynamic) updateFn) =>
      requestList[index] = updateFn(requestList[index]);

  ///  State fields for stateful widgets in this component.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // Stores action output result for [Backend Call - API (declineInvite)] action in DeclineInvite widget.
  ApiCallResponse? declineInviteResp;
  // Stores action output result for [Backend Call - API (acceptInvite)] action in AcceptInvite widget.
  ApiCallResponse? acceptInviteResp;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
