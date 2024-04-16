import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'tic_tac_toe_model.dart';
export 'tic_tac_toe_model.dart';

class TicTacToeWidget extends StatefulWidget {
  const TicTacToeWidget({super.key});

  @override
  State<TicTacToeWidget> createState() => _TicTacToeWidgetState();
}

class _TicTacToeWidgetState extends State<TicTacToeWidget> {
  late TicTacToeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TicTacToeModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        FFAppState().hasStarted = true;
      });
      setState(() {
        _model.started = true;
      });
      while (_model.started) {
        _model.getInitialTicTacToeResp = await GetTicTacToeBoardCall.call(
          serverIP: FFAppState().serverIP,
          tokenType: FFAppState().tokenType,
          accessToken: FFAppState().accessToken,
          lobbyId: FFAppState().lobbyId,
        );
        if ((_model.getInitialTicTacToeResp?.succeeded ?? true)) {
          setState(() {
            _model.currentGrid = (getJsonField(
              (_model.getInitialTicTacToeResp?.jsonBody ?? ''),
              r'''$.board''',
              true,
            ) as List)
                .map<String>((s) => s.toString())
                .toList()
                .toList()
                .cast<String>();
          });
          setState(() {
            _model.isTurn = functions.isTurn(
                FFAppState().userType, _model.currentGrid.toList());
          });
        } else {
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return AlertDialog(
                title: const Text('aaaaaaaaaaaaaaaaaaaaaaaaa'),
                content: const Text('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext),
                    child: const Text('Oaaaaaak'),
                  ),
                ],
              );
            },
          );
          return;
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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Tic Tac Toe',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontSize: 22.0,
                      letterSpacing: 0.0,
                    ),
              ),
            ],
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (_model.started)
                Builder(
                  builder: (context) {
                    final grid = _model.currentGrid.toList();
                    return GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 1.0,
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: grid.length,
                      itemBuilder: (context, gridIndex) {
                        final gridItem = grid[gridIndex];
                        return Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Stack(
                            children: [
                              if (' ' == gridItem)
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    var shouldSetState = false;
                                    if (_model.isTurn) {
                                      _model.placeTicTacToeResp =
                                          await PlaceTicTacToeCall.call(
                                        serverIP: FFAppState().serverIP,
                                        tokenType: FFAppState().tokenType,
                                        accessToken: FFAppState().accessToken,
                                        lobbyId: FFAppState().lobbyId,
                                        index: gridIndex,
                                        userType: FFAppState().userType,
                                      );
                                      shouldSetState = true;
                                      if ((_model
                                              .placeTicTacToeResp?.succeeded ??
                                          true)) {
                                        _model.getTicTacToeResp =
                                            await GetTicTacToeBoardCall.call(
                                          serverIP: FFAppState().serverIP,
                                          tokenType: FFAppState().tokenType,
                                          accessToken: FFAppState().accessToken,
                                          lobbyId: FFAppState().lobbyId,
                                        );
                                        shouldSetState = true;
                                        if ((_model
                                                .getTicTacToeResp?.succeeded ??
                                            true)) {
                                          setState(() {
                                            _model.currentGrid = (getJsonField(
                                              (_model.getTicTacToeResp
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
                                          });
                                          if (shouldSetState) setState(() {});
                                          return;
                                        } else {
                                          if (shouldSetState) setState(() {});
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
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                                child:
                                                    const Text('OK I AM VERY SORRY'),
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
                              if ('O' == gridItem)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/O_pic.png',
                                    width: 300.0,
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              if ('X' == gridItem)
                                Align(
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/X_pic.png',
                                      width: 300.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
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
              Align(
                alignment: const AlignmentDirectional(-1.0, 1.0),
                child: Text(
                  'You are: ${FFAppState().userType}',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        fontSize: 30.0,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
