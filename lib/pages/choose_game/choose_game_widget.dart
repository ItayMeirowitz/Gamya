import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/notifications/notifications_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:badges/badges.dart' as badges;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'choose_game_model.dart';
export 'choose_game_model.dart';

class ChooseGameWidget extends StatefulWidget {
  const ChooseGameWidget({super.key});

  @override
  State<ChooseGameWidget> createState() => _ChooseGameWidgetState();
}

class _ChooseGameWidgetState extends State<ChooseGameWidget>
    with TickerProviderStateMixin {
  late ChooseGameModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChooseGameModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      while (!FFAppState().hasStarted) {
        _model.dataReceived = await actions.fetchData(
          'http://${FFAppState().serverIP}:5000/user/${FFAppState().username}',
          FFAppState().tokenType,
          FFAppState().accessToken,
          FFAppState().username,
        );
        if ('msg' ==
            getJsonField(
              _model.dataReceived,
              r'''$.type''',
            )) {
          // New invite
          setState(() {
            FFAppState().addToRequests(getJsonField(
              _model.dataReceived,
              r'''$.info''',
            ));
            FFAppState().notificationCounter =
                FFAppState().notificationCounter + 1;
          });
        } else if ('decline' ==
            getJsonField(
              _model.dataReceived,
              r'''$.type''',
            )) {
        } else if ('accept' ==
            getJsonField(
              _model.dataReceived,
              r'''$.type''',
            )) {
          // Invite Accepted
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return AlertDialog(
                title: const Text('Invite Accepted!'),
                content: Text(getJsonField(
                  _model.dataReceived,
                  r'''$.msg''',
                ).toString().toString()),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext),
                    child: const Text('Party up!'),
                  ),
                ],
              );
            },
          );
          setState(() {
            FFAppState().leader = FFAppState().username;
          });
        } else if ('enter_game' ==
            getJsonField(
              _model.dataReceived,
              r'''$.type''',
            )) {
          // Entering game
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return AlertDialog(
                title: const Text('Host started game'),
                content: Text(getJsonField(
                  _model.dataReceived,
                  r'''$.msg''',
                ).toString().toString()),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext),
                    child: const Text('Join In!'),
                  ),
                ],
              );
            },
          );
          setState(() {
            FFAppState().lobbyId = getJsonField(
              _model.dataReceived,
              r'''$.lobby_id''',
            );
          });
          if ('Vocab' ==
              getJsonField(
                _model.dataReceived,
                r'''$.game''',
              )) {
            _model.dontUse = await PostVocabCall.call(
              serverIP: FFAppState().serverIP,
              tokenType: FFAppState().tokenType,
              accessToken: FFAppState().accessToken,
              leader: FFAppState().leader,
              username: FFAppState().username,
            );

            context.goNamed('Vocab');
          } else if ('TicTacToe' ==
              getJsonField(
                _model.dataReceived,
                r'''$.game''',
              )) {
            _model.postTicTacToeResp = await PostTicTacToeCall.call(
              serverIP: FFAppState().serverIP,
              tokenType: FFAppState().tokenType,
              accessToken: FFAppState().accessToken,
              username: FFAppState().username,
              leader: FFAppState().leader,
            );
            if ((_model.postTicTacToeResp?.succeeded ?? true)) {
              setState(() {
                FFAppState().userType = getJsonField(
                  (_model.postTicTacToeResp?.jsonBody ?? ''),
                  r'''$.user_type''',
                ).toString().toString();
              });
            } else {
              return;
            }

            context.goNamed('TicTacToe');
          } else if ('Math test' ==
              getJsonField(
                _model.dataReceived,
                r'''$.game''',
              )) {
            _model.postMathResp = await PostMathCall.call(
              serverIP: FFAppState().serverIP,
              tokenType: FFAppState().tokenType,
              accessToken: FFAppState().accessToken,
              username: FFAppState().username,
              leader: FFAppState().leader,
            );
            if ((_model.postMathResp?.succeeded ?? true)) {
              context.goNamed('MathContest');
            } else {
              return;
            }
          } else if ('Guess Wrong' ==
              getJsonField(
                _model.dataReceived,
                r'''$.game''',
              )) {
            _model.postCheckWrongResp = await PostGuessWrongCall.call(
              serverIP: FFAppState().serverIP,
              tokenType: FFAppState().tokenType,
              accessToken: FFAppState().accessToken,
              username: FFAppState().username,
              leader: FFAppState().leader,
            );
            if ((_model.postCheckWrongResp?.succeeded ?? true)) {
              context.goNamed('GuessWrong');
            } else {
              return;
            }
          } else {
            _model.postConnectFResp = await PostConnectFCall.call(
              serverIP: FFAppState().serverIP,
              tokenType: FFAppState().tokenType,
              accessToken: FFAppState().accessToken,
              username: FFAppState().username,
              leader: FFAppState().leader,
            );
            if ((_model.postConnectFResp?.succeeded ?? true)) {
              setState(() {
                FFAppState().userType = getJsonField(
                  (_model.postConnectFResp?.jsonBody ?? ''),
                  r'''$.user_type''',
                ).toString().toString();
              });
            } else {
              return;
            }

            context.goNamed('Connect4');
          }
        }
      }
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 1,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        endDrawer: Drawer(
          elevation: 16.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: Align(
                      alignment: const AlignmentDirectional(0.0, -1.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                        child: Text(
                          'Select someone to team up with!',
                          style: FlutterFlowTheme.of(context)
                              .headlineLarge
                              .override(
                                fontFamily: 'Outfit',
                                fontSize: 20.0,
                                letterSpacing: 0.0,
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (_model.errorDetail != null && _model.errorDetail != '')
                Text(
                  valueOrDefault<String>(
                    _model.errorDetail,
                    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
                      ),
                ),
              Align(
                alignment: const AlignmentDirectional(-1.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(5.0, 40.0, 0.0, 0.0),
                  child: Text(
                    'Active users:',
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily: 'Outfit',
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    final onlineUsers = FFAppState().usersOnline.toList();
                    return GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 1.0,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: onlineUsers.length,
                      itemBuilder: (context, onlineUsersIndex) {
                        final onlineUsersItem = onlineUsers[onlineUsersIndex];
                        return Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                valueOrDefault<String>(
                                  onlineUsersItem,
                                  '???',
                                ),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                    ),
                                minFontSize: 10.0,
                              ),
                              Divider(
                                thickness: 2.0,
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                              Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Align(
                                  alignment: const AlignmentDirectional(0.0, -0.3),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      var shouldSetState = false;
                                      _model.inviteUserResp =
                                          await InviteUserCall.call(
                                        serverIP: FFAppState().serverIP,
                                        accessToken: FFAppState().accessToken,
                                        tokenType: FFAppState().tokenType,
                                        otherUser: onlineUsersItem,
                                        thisUser: FFAppState().username,
                                      );
                                      shouldSetState = true;
                                      if ((_model.inviteUserResp?.succeeded ??
                                          true)) {
                                        Navigator.pop(context);
                                        if (shouldSetState) setState(() {});
                                        return;
                                      } else {
                                        setState(() {
                                          _model.errorDetail = getJsonField(
                                            (_model.inviteUserResp?.jsonBody ??
                                                ''),
                                            r'''$.detail''',
                                          ).toString();
                                        });
                                        if (shouldSetState) setState(() {});
                                        return;
                                      }

                                      if (shouldSetState) setState(() {});
                                    },
                                    text: 'Invite!',
                                    options: FFButtonOptions(
                                      height: 40.0,
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 0.0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                          ),
                                      elevation: 3.0,
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Hello, ',
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Outfit',
                          letterSpacing: 0.0,
                        ),
                  ),
                  Text(
                    FFAppState().username,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 22.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                  Flexible(
                    child: Align(
                      alignment: const AlignmentDirectional(1.0, 0.0),
                      child: Container(
                        decoration: const BoxDecoration(),
                        child: Stack(
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 0.0, 0.0),
                                child: FlutterFlowIconButton(
                                  borderColor:
                                      FlutterFlowTheme.of(context).primary,
                                  borderRadius: 30.0,
                                  borderWidth: 1.0,
                                  buttonSize: 40.0,
                                  fillColor:
                                      FlutterFlowTheme.of(context).accent1,
                                  icon: Icon(
                                    Icons.notification_add,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                  onPressed: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      enableDrag: false,
                                      useSafeArea: true,
                                      context: context,
                                      builder: (context) {
                                        return GestureDetector(
                                          onTap: () => _model
                                                  .unfocusNode.canRequestFocus
                                              ? FocusScope.of(context)
                                                  .requestFocus(
                                                      _model.unfocusNode)
                                              : FocusScope.of(context)
                                                  .unfocus(),
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: NotificationsWidget(
                                              requests: FFAppState().requests,
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  },
                                ),
                              ),
                            ),
                            if (FFAppState().notificationCounter > 0)
                              Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      36.0, 6.0, 0.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        enableDrag: false,
                                        useSafeArea: true,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () => _model
                                                    .unfocusNode.canRequestFocus
                                                ? FocusScope.of(context)
                                                    .requestFocus(
                                                        _model.unfocusNode)
                                                : FocusScope.of(context)
                                                    .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: NotificationsWidget(
                                                requests: FFAppState().requests,
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: badges.Badge(
                                      badgeContent: Text(
                                        FFAppState()
                                            .notificationCounter
                                            .toString()
                                            .maybeHandleOverflow(
                                              maxChars: 2,
                                              replacement: '…',
                                            ),
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      showBadge: true,
                                      shape: badges.BadgeShape.circle,
                                      badgeColor: const Color(0xFFFF0004),
                                      elevation: 4.0,
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          4.0, 4.0, 4.0, 4.0),
                                      position: badges.BadgePosition.topStart(),
                                      animationType:
                                          badges.BadgeAnimationType.scale,
                                      toAnimate: true,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (FFAppState().leader != 'singlePlayer')
                Text(
                  'Party lead by ${FFAppState().leader}',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
                      ),
                ),
            ],
          ),
          actions: [
            Align(
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                child: FlutterFlowIconButton(
                  borderColor: FlutterFlowTheme.of(context).primary,
                  borderRadius: 25.0,
                  borderWidth: 1.0,
                  buttonSize: 50.0,
                  fillColor: FlutterFlowTheme.of(context).accent1,
                  icon: Icon(
                    Icons.connect_without_contact,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    var shouldSetState = false;
                    scaffoldKey.currentState!.openEndDrawer();
                    _model.getUsersResp = await GetUsersCall.call(
                      serverIP: FFAppState().serverIP,
                      tokenType: FFAppState().tokenType,
                      accessToken: FFAppState().accessToken,
                      username: FFAppState().username,
                    );
                    shouldSetState = true;
                    if ((_model.getUsersResp?.succeeded ?? true)) {
                      setState(() {
                        FFAppState().usersOnline = (getJsonField(
                          (_model.getUsersResp?.jsonBody ?? ''),
                          r'''$.users''',
                          true,
                        ) as List)
                            .map<String>((s) => s.toString())
                            .toList()
                            .toList()
                            .cast<String>();
                      });
                      if (shouldSetState) setState(() {});
                      return;
                    } else {
                      if (shouldSetState) setState(() {});
                      return;
                    }

                    if (shouldSetState) setState(() {});
                  },
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: const Alignment(-1.0, 0),
                    child: FlutterFlowButtonTabBar(
                      useToggleButtonStyle: false,
                      isScrollable: true,
                      labelStyle:
                          FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Readex Pro',
                                letterSpacing: 0.0,
                              ),
                      unselectedLabelStyle: const TextStyle(),
                      labelColor: FlutterFlowTheme.of(context).primary,
                      unselectedLabelColor:
                          FlutterFlowTheme.of(context).secondaryText,
                      backgroundColor: FlutterFlowTheme.of(context).accent1,
                      borderColor: FlutterFlowTheme.of(context).primary,
                      borderWidth: 2.0,
                      borderRadius: 12.0,
                      elevation: 0.0,
                      labelPadding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      buttonMargin:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 16.0, 0.0),
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      tabs: const [
                        Tab(
                          text: 'All',
                        ),
                      ],
                      controller: _model.tabBarController,
                      onTap: (i) async {
                        [() async {}][i]();
                      },
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _model.tabBarController,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 16.0, 0.0, 0.0),
                                child: Text(
                                  'Games',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        fontFamily: 'Outfit',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 8.0, 16.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    var shouldSetState = false;
                                    _model.postVocabResp =
                                        await PostVocabCall.call(
                                      serverIP: FFAppState().serverIP,
                                      tokenType: FFAppState().tokenType,
                                      accessToken: FFAppState().accessToken,
                                      leader: FFAppState().leader,
                                      username: FFAppState().username,
                                    );
                                    shouldSetState = true;
                                    if ((_model.postVocabResp?.succeeded ??
                                        true)) {
                                      setState(() {
                                        FFAppState().lobbyId = getJsonField(
                                          (_model.postVocabResp?.jsonBody ??
                                              ''),
                                          r'''$.lobby_id''',
                                        );
                                      });

                                      context.goNamed('Vocab');

                                      if (shouldSetState) setState(() {});
                                      return;
                                    } else {
                                      if (shouldSetState) setState(() {});
                                      return;
                                    }

                                    if (shouldSetState) setState(() {});
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          8.0, 8.0, 12.0, 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/vocabT.png',
                                              width: 114.0,
                                              height: 70.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Vocabulary Test',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 12.0, 16.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    var shouldSetState = false;
                                    _model.postTicTacToeRespLeader =
                                        await PostTicTacToeCall.call(
                                      serverIP: FFAppState().serverIP,
                                      tokenType: FFAppState().tokenType,
                                      accessToken: FFAppState().accessToken,
                                      username: FFAppState().username,
                                      leader: FFAppState().leader,
                                    );
                                    shouldSetState = true;
                                    if ((_model.postTicTacToeRespLeader
                                            ?.succeeded ??
                                        true)) {
                                      setState(() {
                                        FFAppState().lobbyId = getJsonField(
                                          (_model.postTicTacToeRespLeader
                                                  ?.jsonBody ??
                                              ''),
                                          r'''$.lobby_id''',
                                        );
                                        FFAppState().userType = getJsonField(
                                          (_model.postTicTacToeRespLeader
                                                  ?.jsonBody ??
                                              ''),
                                          r'''$.user_type''',
                                        ).toString();
                                        FFAppState().hasStarted = true;
                                      });

                                      context.goNamed('TicTacToe');

                                      if (shouldSetState) setState(() {});
                                      return;
                                    } else {
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: const Text('error accoured'),
                                            content: Text(getJsonField(
                                              (_model.postTicTacToeRespLeader
                                                      ?.jsonBody ??
                                                  ''),
                                              r'''$.detail''',
                                            ).toString()),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                                child: const Text('Ok'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      if (shouldSetState) setState(() {});
                                      return;
                                    }

                                    if (shouldSetState) setState(() {});
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          8.0, 8.0, 12.0, 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/TicTacToe.png',
                                              width: 90.0,
                                              height: 70.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'TicTacToe',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 8.0, 16.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    var shouldSetState = false;
                                    _model.postConnect4LeaderResp =
                                        await PostConnectFCall.call(
                                      serverIP: FFAppState().serverIP,
                                      tokenType: FFAppState().tokenType,
                                      accessToken: FFAppState().accessToken,
                                      username: FFAppState().username,
                                      leader: FFAppState().leader,
                                    );
                                    shouldSetState = true;
                                    if ((_model.postConnect4LeaderResp
                                            ?.succeeded ??
                                        true)) {
                                      setState(() {
                                        FFAppState().lobbyId = getJsonField(
                                          (_model.postConnect4LeaderResp
                                                  ?.jsonBody ??
                                              ''),
                                          r'''$.lobby_id''',
                                        );
                                        FFAppState().userType = getJsonField(
                                          (_model.postConnect4LeaderResp
                                                  ?.jsonBody ??
                                              ''),
                                          r'''$.user_type''',
                                        ).toString();
                                        FFAppState().hasStarted = true;
                                      });

                                      context.goNamed('Connect4');

                                      if (shouldSetState) setState(() {});
                                      return;
                                    } else {
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: const Text('error accoured'),
                                            content: Text(getJsonField(
                                              (_model.postConnect4LeaderResp
                                                      ?.jsonBody ??
                                                  ''),
                                              r'''$.detail''',
                                            ).toString()),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                                child: const Text('Ok'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      if (shouldSetState) setState(() {});
                                      return;
                                    }

                                    if (shouldSetState) setState(() {});
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          8.0, 8.0, 12.0, 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/Connect4.png',
                                              width: 90.0,
                                              height: 70.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Connect 4',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 8.0, 16.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    var shouldSetState = false;
                                    _model.postMathLeaderResp =
                                        await PostMathCall.call(
                                      serverIP: FFAppState().serverIP,
                                      tokenType: FFAppState().tokenType,
                                      accessToken: FFAppState().accessToken,
                                      username: FFAppState().username,
                                      leader: FFAppState().leader,
                                    );
                                    shouldSetState = true;
                                    if ((_model.postMathLeaderResp?.succeeded ??
                                        true)) {
                                      setState(() {
                                        FFAppState().lobbyId = getJsonField(
                                          (_model.postMathLeaderResp
                                                  ?.jsonBody ??
                                              ''),
                                          r'''$.lobby_id''',
                                        );
                                      });

                                      context.goNamed('MathContest');

                                      if (shouldSetState) setState(() {});
                                      return;
                                    } else {
                                      if (shouldSetState) setState(() {});
                                      return;
                                    }

                                    if (shouldSetState) setState(() {});
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          8.0, 8.0, 12.0, 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/mathTest.jpeg',
                                              width: 90.0,
                                              height: 70.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Math Test',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 8.0, 16.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    var shouldSetState = false;
                                    _model.postGuessWrongLeaderResp =
                                        await PostGuessWrongCall.call(
                                      serverIP: FFAppState().serverIP,
                                      tokenType: FFAppState().tokenType,
                                      accessToken: FFAppState().accessToken,
                                      username: FFAppState().username,
                                      leader: FFAppState().leader,
                                    );
                                    shouldSetState = true;
                                    if ((_model.postGuessWrongLeaderResp
                                            ?.succeeded ??
                                        true)) {
                                      setState(() {
                                        FFAppState().lobbyId = getJsonField(
                                          (_model.postGuessWrongLeaderResp
                                                  ?.jsonBody ??
                                              ''),
                                          r'''$.lobby_id''',
                                        );
                                      });

                                      context.goNamed('GuessWrong');

                                      if (shouldSetState) setState(() {});
                                      return;
                                    } else {
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: const Text('error accoured'),
                                            content: Text(getJsonField(
                                              (_model.postTicTacToeRespLeader
                                                      ?.jsonBody ??
                                                  ''),
                                              r'''$.detail''',
                                            ).toString()),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                                child: const Text('Ok'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      if (shouldSetState) setState(() {});
                                      return;
                                    }

                                    if (shouldSetState) setState(() {});
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          8.0, 8.0, 12.0, 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/GuessWrong.png',
                                              width: 90.0,
                                              height: 70.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Guess Wrong',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 8.0, 16.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    var shouldSetState = false;
                                    _model.postZeroResp =
                                        await PostGetTZeroCall.call(
                                      serverIP: FFAppState().serverIP,
                                      tokenType: FFAppState().tokenType,
                                      accessToken: FFAppState().accessToken,
                                      username: FFAppState().username,
                                    );
                                    shouldSetState = true;
                                    if ((_model.postZeroResp?.succeeded ??
                                        true)) {
                                      setState(() {
                                        FFAppState().lobbyId = getJsonField(
                                          (_model.postZeroResp?.jsonBody ?? ''),
                                          r'''$.lobby_id''',
                                        );
                                      });

                                      context.goNamed('Get2Zero');

                                      if (shouldSetState) setState(() {});
                                      return;
                                    } else {
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: const Text('Cannot enter game'),
                                            content: const Text(
                                                'This game is for a single player'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                                child: const Text('Got it!'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      if (shouldSetState) setState(() {});
                                      return;
                                    }

                                    if (shouldSetState) setState(() {});
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          8.0, 8.0, 12.0, 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/Get2ZeroIcon.png',
                                              width: 90.0,
                                              height: 70.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Get 2 Zero!',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
