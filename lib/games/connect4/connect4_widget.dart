import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'connect4_model.dart';
export 'connect4_model.dart';

class Connect4Widget extends StatefulWidget {
  const Connect4Widget({super.key});

  @override
  State<Connect4Widget> createState() => _Connect4WidgetState();
}

class _Connect4WidgetState extends State<Connect4Widget> {
  late Connect4Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Connect4Model());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().hasStarted = true;
      setState(() {});
      _model.started = true;
      _model.type = functions.getName(FFAppState().userType);
      setState(() {});
      while (_model.started) {
        _model.getInitialConnectResp = await GetConnectFBoardCall.call(
          serverIP: FFAppState().serverIP,
          tokenType: FFAppState().tokenType,
          accessToken: FFAppState().accessToken,
          lobbyId: FFAppState().lobbyId,
          port: FFAppState().port,
        );
        if ((_model.getInitialConnectResp?.succeeded ?? true)) {
          _model.currentGrid = (getJsonField(
            (_model.getInitialConnectResp?.jsonBody ?? ''),
            r'''$.board''',
            true,
          ) as List)
              .map<String>((s) => s.toString())
              .toList()
              .toList()
              .cast<String>();
          setState(() {});
          _model.isTurn = functions.isTurnConnect4(
              _model.currentGrid.toList(), FFAppState().userType);
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 50));
          if (getJsonField(
                (_model.getInitialConnectResp?.jsonBody ?? ''),
                r'''$.won''',
              ) !=
              null) {
            _model.won = getJsonField(
              (_model.getInitialConnectResp?.jsonBody ?? ''),
              r'''$.won''',
            ).toString().toString();
            setState(() {});
            if (_model.won == FFAppState().userType) {
              _model.score = 100;
              setState(() {});
            } else {
              _model.score = 0;
              setState(() {});
            }

            context.goNamed(
              'GameFinished',
              queryParameters: {
                'score': serializeParam(
                  _model.score?.toDouble(),
                  ParamType.double,
                ),
              }.withoutNulls,
              extra: <String, dynamic>{
                kTransitionInfoKey: const TransitionInfo(
                  hasTransition: true,
                  transitionType: PageTransitionType.fade,
                  duration: Duration(milliseconds: 1000),
                ),
              },
            );

            return;
          }
        } else {
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return AlertDialog(
                title: const Text('Internet connection lost'),
                content: const Text('Restart game..'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext),
                    child: const Text('Ok'),
                  ),
                ],
              );
            },
          );
          await Future.delayed(const Duration(milliseconds: 50));
        }
      }
    });
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
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primary,
            automaticallyImplyLeading: false,
            title: Text(
              'Connect 4!',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                  ),
            ),
            actions: [
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
                  child: Text(
                    'Logged as: ${FFAppState().username}',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              ),
            ],
            centerTitle: false,
            elevation: 2.0,
          ),
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B0909),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0),
                    ),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).alternate,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 5.0),
                    child: Builder(
                      builder: (context) {
                        final grid = _model.currentGrid.toList();
                        return GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 1.0,
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: grid.length,
                          itemBuilder: (context, gridIndex) {
                            final gridItem = grid[gridIndex];
                            return Stack(
                              children: [
                                if (gridItem == '')
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      var shouldSetState = false;
                                      if (_model.isTurn) {
                                        _model.placeConnect4Resp =
                                            await PlaceConnectFCall.call(
                                          serverIP: FFAppState().serverIP,
                                          tokenType: FFAppState().tokenType,
                                          accessToken: FFAppState().accessToken,
                                          lobbyId: FFAppState().lobbyId,
                                          index: gridIndex.toString(),
                                          userType: FFAppState().userType,
                                          port: FFAppState().port,
                                        );
                                        shouldSetState = true;
                                        if ((_model
                                                .placeConnect4Resp?.succeeded ??
                                            true)) {
                                          _model.getConnect4Resp =
                                              await GetConnectFBoardCall.call(
                                            serverIP: FFAppState().serverIP,
                                            tokenType: FFAppState().tokenType,
                                            accessToken:
                                                FFAppState().accessToken,
                                            lobbyId: FFAppState().lobbyId,
                                            port: FFAppState().port,
                                          );
                                          shouldSetState = true;
                                          if ((_model
                                                  .getConnect4Resp?.succeeded ??
                                              true)) {
                                            _model.currentGrid = (getJsonField(
                                              (_model.getConnect4Resp
                                                      ?.jsonBody ??
                                                  ''),
                                              r'''$.board''',
                                              true,
                                            ) as List)
                                                .map<String>(
                                                    (s) => s.toString())
                                                .toList()
                                                .toList()
                                                .cast<String>();
                                            _model.isTurn =
                                                functions.isTurnConnect4(
                                                    _model.currentGrid.toList(),
                                                    FFAppState().userType);
                                            setState(() {});
                                            if (shouldSetState) {
                                              setState(() {});
                                            }
                                            return;
                                          } else {
                                            if (shouldSetState) {
                                              setState(() {});
                                            }
                                            return;
                                          }
                                        } else {
                                          if (shouldSetState) setState(() {});
                                          return;
                                        }
                                      } else {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: const Text('YOU SUCK'),
                                              content:
                                                  const Text('It is not your turn!'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext),
                                                  child: const Text(
                                                      'OK I AM VERY SORRY'),
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
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/Empty.png',
                                        width: 300.0,
                                        height: 200.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                if ('R' == gridItem)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/RedConnect.png',
                                      width: 300.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                if ('B' == gridItem)
                                  Align(
                                    alignment: const AlignmentDirectional(0.0, 0.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/BlueConnect.png',
                                        width: 300.0,
                                        height: 200.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(-1.0, 1.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: Text(
                            'Is it your turn: ${functions.isTurnConnect4(_model.currentGrid.toList(), _model.type!).toString()}',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-1.0, 1.0),
                        child: Text(
                          'You are: ${_model.type}',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 30.0,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
