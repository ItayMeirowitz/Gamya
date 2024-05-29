import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'game_finished_model.dart';
export 'game_finished_model.dart';

class GameFinishedWidget extends StatefulWidget {
  const GameFinishedWidget({
    super.key,
    required this.score,
  });

  final double? score;

  @override
  State<GameFinishedWidget> createState() => _GameFinishedWidgetState();
}

class _GameFinishedWidgetState extends State<GameFinishedWidget> {
  late GameFinishedModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameFinishedModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      while (widget.score != null) {
        if (widget.score != -1.0) {
          _model.postScoreResp = await PostScoreCall.call(
            serverIP: FFAppState().serverIP,
            tokenType: FFAppState().tokenType,
            accessToken: FFAppState().accessToken,
            username: FFAppState().username,
            score: widget.score,
            lobbyId: FFAppState().lobbyId,
            port: FFAppState().port,
          );
        }
        _model.getScoreResp = await GetScoreCall.call(
          serverIP: FFAppState().serverIP,
          tokenType: FFAppState().tokenType,
          accessToken: FFAppState().accessToken,
          lobbyId: FFAppState().lobbyId,
          port: FFAppState().port,
        );
        if ((_model.getScoreResp?.succeeded ?? true)) {
          setState(() {
            _model.scores =
                (_model.getScoreResp?.jsonBody ?? '').toList().cast<dynamic>();
          });
          return;
        } else {
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
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primary,
            automaticallyImplyLeading: false,
            title: Text(
              'Good Game!',
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    fontFamily: 'Outfit',
                    letterSpacing: 0.0,
                  ),
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
                Align(
                  alignment: const AlignmentDirectional(0.0, -1.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 60.0, 0.0, 0.0),
                        child: Text(
                          'Game Concluded',
                          style:
                              FlutterFlowTheme.of(context).bodyLarge.override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 40.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 20.0),
                              child: Text(
                                'Scores from the match:',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          final scoresList = _model.scores.toList();
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: scoresList.length,
                            itemBuilder: (context, scoresListIndex) {
                              final scoresListItem =
                                  scoresList[scoresListIndex];
                              return Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 10.0, 0.0),
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  elevation: 4.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      '${getJsonField(
                                        scoresListItem,
                                        r'''$.username''',
                                      ).toString()}: ${getJsonField(
                                        scoresListItem,
                                        r'''$.score''',
                                      ).toString()}',
                                      textAlign: TextAlign.center,
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
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(5.0, 15.0, 0.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        var shouldSetState = false;
                        _model.getScoreResponse = await GetScoreCall.call(
                          serverIP: FFAppState().serverIP,
                          tokenType: FFAppState().tokenType,
                          accessToken: FFAppState().accessToken,
                          lobbyId: FFAppState().lobbyId,
                          port: FFAppState().port,
                        );
                        shouldSetState = true;
                        if ((_model.getScoreResponse?.succeeded ?? true)) {
                          setState(() {
                            _model.scores =
                                (_model.getScoreResponse?.jsonBody ?? '')
                                    .toList()
                                    .cast<dynamic>();
                          });
                          if (shouldSetState) setState(() {});
                          return;
                        } else {
                          if (shouldSetState) setState(() {});
                          return;
                        }

                        if (shouldSetState) setState(() {});
                      },
                      text: 'Refresh results',
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
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
          ),
        ),
      ),
    );
  }
}
