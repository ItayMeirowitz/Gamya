import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'math_contest_model.dart';
export 'math_contest_model.dart';

class MathContestWidget extends StatefulWidget {
  const MathContestWidget({super.key});

  @override
  State<MathContestWidget> createState() => _MathContestWidgetState();
}

class _MathContestWidgetState extends State<MathContestWidget> {
  late MathContestModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MathContestModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        FFAppState().hasStarted = true;
      });
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
            actions: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
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
            flexibleSpace: FlexibleSpaceBar(
              title: Align(
                alignment: AlignmentDirectional(-1.0, 1.0),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 10.0),
                  child: Text(
                    'Math Contest!',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                          fontSize: 22.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              ),
              centerTitle: true,
              expandedTitleScale: 1.0,
            ),
            elevation: 1.0,
          ),
          body: SafeArea(
            top: true,
            child: Stack(
              children: [
                if (_model.hasStarted ?? true)
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 50.0, 0.0, 0.0),
                          child: Text(
                            _model.eqToSolve!,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 30.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 150.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Align(
                                  alignment: AlignmentDirectional(0.0, -1.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      var _shouldSetState = false;
                                      _model.postMathAnswer1Resp =
                                          await PostMathAnswerCall.call(
                                        serverIP: FFAppState().serverIP,
                                        tokenType: FFAppState().tokenType,
                                        accessToken: FFAppState().accessToken,
                                        lobbyId: FFAppState().lobbyId,
                                        index: _model.currentIndex,
                                        answer: _model.op1,
                                      );
                                      _shouldSetState = true;
                                      if ((_model
                                              .postMathAnswer1Resp?.succeeded ??
                                          true)) {
                                        if (getJsonField(
                                          (_model.postMathAnswer1Resp
                                                  ?.jsonBody ??
                                              ''),
                                          r'''$.correct''',
                                        )) {
                                          _model.soundPlayer1 ??= AudioPlayer();
                                          if (_model.soundPlayer1!.playing) {
                                            await _model.soundPlayer1!.stop();
                                          }
                                          _model.soundPlayer1!.setVolume(1.0);
                                          _model.soundPlayer1!
                                              .setAsset(
                                                  'assets/audios/cute-level-up-3-189853.mp3')
                                              .then((_) =>
                                                  _model.soundPlayer1!.play());

                                          setState(() {
                                            _model.clientScore =
                                                _model.clientScore! + 50;
                                          });
                                        } else {
                                          _model.soundPlayer2 ??= AudioPlayer();
                                          if (_model.soundPlayer2!.playing) {
                                            await _model.soundPlayer2!.stop();
                                          }
                                          _model.soundPlayer2!.setVolume(1.0);
                                          _model.soundPlayer2!
                                              .setAsset(
                                                  'assets/audios/buzzer-or-wrong-answer-20582.mp3')
                                              .then((_) =>
                                                  _model.soundPlayer2!.play());
                                        }

                                        setState(() {
                                          _model.currentIndex =
                                              _model.currentIndex! + 1;
                                        });
                                        if (_model.currentIndex! >=
                                            _model.quizLength) {
                                          context.goNamed(
                                            'GameFinished',
                                            queryParameters: {
                                              'score': serializeParam(
                                                _model.clientScore?.toDouble(),
                                                ParamType.double,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.scale,
                                                alignment:
                                                    Alignment.bottomCenter,
                                                duration: Duration(
                                                    milliseconds: 2000),
                                              ),
                                            },
                                          );

                                          if (_shouldSetState) setState(() {});
                                          return;
                                        } else {
                                          setState(() {
                                            _model.eqToSolve = getJsonField(
                                              _model.mathList[
                                                  _model.currentIndex!],
                                              r'''$.equation''',
                                            ).toString();
                                            _model.op1 = getJsonField(
                                              _model.mathList[
                                                  _model.currentIndex!],
                                              r'''$.op1''',
                                            ).toString();
                                            _model.op2 = getJsonField(
                                              _model.mathList[
                                                  _model.currentIndex!],
                                              r'''$.op2''',
                                            ).toString();
                                            _model.op3 = getJsonField(
                                              _model.mathList[
                                                  _model.currentIndex!],
                                              r'''$.op3''',
                                            ).toString();
                                            _model.op4 = getJsonField(
                                              _model.mathList[
                                                  _model.currentIndex!],
                                              r'''$.op4''',
                                            ).toString();
                                            _model.correct = getJsonField(
                                              _model.mathList[
                                                  _model.currentIndex!],
                                              r'''$.correct''',
                                            ).toString();
                                          });
                                          if (_shouldSetState) setState(() {});
                                          return;
                                        }
                                      } else {
                                        if (_shouldSetState) setState(() {});
                                        return;
                                      }

                                      if (_shouldSetState) setState(() {});
                                    },
                                    text: _model.op1!,
                                    options: FFButtonOptions(
                                      height: 40.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
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
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Align(
                                  alignment: AlignmentDirectional(0.0, -1.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      var _shouldSetState = false;
                                      _model.postMathAnswer2Resp =
                                          await PostMathAnswerCall.call(
                                        serverIP: FFAppState().serverIP,
                                        tokenType: FFAppState().tokenType,
                                        accessToken: FFAppState().accessToken,
                                        lobbyId: FFAppState().lobbyId,
                                        index: _model.currentIndex,
                                        answer: _model.op2,
                                      );
                                      _shouldSetState = true;
                                      if ((_model
                                              .postMathAnswer2Resp?.succeeded ??
                                          true)) {
                                        if (getJsonField(
                                          (_model.postMathAnswer2Resp
                                                  ?.jsonBody ??
                                              ''),
                                          r'''$.correct''',
                                        )) {
                                          _model.soundPlayer3 ??= AudioPlayer();
                                          if (_model.soundPlayer3!.playing) {
                                            await _model.soundPlayer3!.stop();
                                          }
                                          _model.soundPlayer3!.setVolume(1.0);
                                          _model.soundPlayer3!
                                              .setAsset(
                                                  'assets/audios/cute-level-up-3-189853.mp3')
                                              .then((_) =>
                                                  _model.soundPlayer3!.play());

                                          setState(() {
                                            _model.clientScore =
                                                _model.clientScore! + 50;
                                          });
                                        } else {
                                          _model.soundPlayer4 ??= AudioPlayer();
                                          if (_model.soundPlayer4!.playing) {
                                            await _model.soundPlayer4!.stop();
                                          }
                                          _model.soundPlayer4!.setVolume(1.0);
                                          _model.soundPlayer4!
                                              .setAsset(
                                                  'assets/audios/buzzer-or-wrong-answer-20582.mp3')
                                              .then((_) =>
                                                  _model.soundPlayer4!.play());
                                        }

                                        setState(() {
                                          _model.currentIndex =
                                              _model.currentIndex! + 1;
                                        });
                                        if (_model.currentIndex! >=
                                            _model.quizLength) {
                                          context.goNamed(
                                            'GameFinished',
                                            queryParameters: {
                                              'score': serializeParam(
                                                _model.clientScore?.toDouble(),
                                                ParamType.double,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.scale,
                                                alignment:
                                                    Alignment.bottomCenter,
                                                duration: Duration(
                                                    milliseconds: 2000),
                                              ),
                                            },
                                          );

                                          if (_shouldSetState) setState(() {});
                                          return;
                                        } else {
                                          setState(() {
                                            _model.eqToSolve = getJsonField(
                                              _model.mathList[
                                                  _model.currentIndex!],
                                              r'''$.equation''',
                                            ).toString();
                                            _model.op1 = getJsonField(
                                              _model.mathList[
                                                  _model.currentIndex!],
                                              r'''$.op1''',
                                            ).toString();
                                            _model.op2 = getJsonField(
                                              _model.mathList[
                                                  _model.currentIndex!],
                                              r'''$.op2''',
                                            ).toString();
                                            _model.op3 = getJsonField(
                                              _model.mathList[
                                                  _model.currentIndex!],
                                              r'''$.op3''',
                                            ).toString();
                                            _model.op4 = getJsonField(
                                              _model.mathList[
                                                  _model.currentIndex!],
                                              r'''$.op4''',
                                            ).toString();
                                            _model.correct = getJsonField(
                                              _model.mathList[
                                                  _model.currentIndex!],
                                              r'''$.correct''',
                                            ).toString();
                                          });
                                          if (_shouldSetState) setState(() {});
                                          return;
                                        }
                                      } else {
                                        if (_shouldSetState) setState(() {});
                                        return;
                                      }

                                      if (_shouldSetState) setState(() {});
                                    },
                                    text: _model.op2!,
                                    options: FFButtonOptions(
                                      height: 40.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
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
                                      borderSide: BorderSide(
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 100.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    var _shouldSetState = false;
                                    _model.postMathAnswer3Resp =
                                        await PostMathAnswerCall.call(
                                      serverIP: FFAppState().serverIP,
                                      tokenType: FFAppState().tokenType,
                                      accessToken: FFAppState().accessToken,
                                      lobbyId: FFAppState().lobbyId,
                                      index: _model.currentIndex,
                                      answer: _model.op3,
                                    );
                                    _shouldSetState = true;
                                    if ((_model
                                            .postMathAnswer3Resp?.succeeded ??
                                        true)) {
                                      if (getJsonField(
                                        (_model.postMathAnswer3Resp?.jsonBody ??
                                            ''),
                                        r'''$.correct''',
                                      )) {
                                        _model.soundPlayer5 ??= AudioPlayer();
                                        if (_model.soundPlayer5!.playing) {
                                          await _model.soundPlayer5!.stop();
                                        }
                                        _model.soundPlayer5!.setVolume(1.0);
                                        _model.soundPlayer5!
                                            .setAsset(
                                                'assets/audios/cute-level-up-3-189853.mp3')
                                            .then((_) =>
                                                _model.soundPlayer5!.play());

                                        setState(() {
                                          _model.clientScore =
                                              _model.clientScore! + 50;
                                        });
                                      } else {
                                        _model.soundPlayer6 ??= AudioPlayer();
                                        if (_model.soundPlayer6!.playing) {
                                          await _model.soundPlayer6!.stop();
                                        }
                                        _model.soundPlayer6!.setVolume(1.0);
                                        _model.soundPlayer6!
                                            .setAsset(
                                                'assets/audios/buzzer-or-wrong-answer-20582.mp3')
                                            .then((_) =>
                                                _model.soundPlayer6!.play());
                                      }

                                      setState(() {
                                        _model.currentIndex =
                                            _model.currentIndex! + 1;
                                      });
                                      if (_model.currentIndex! >=
                                          _model.quizLength) {
                                        context.goNamed(
                                          'GameFinished',
                                          queryParameters: {
                                            'score': serializeParam(
                                              _model.clientScore?.toDouble(),
                                              ParamType.double,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.scale,
                                              alignment: Alignment.bottomCenter,
                                              duration:
                                                  Duration(milliseconds: 2000),
                                            ),
                                          },
                                        );

                                        if (_shouldSetState) setState(() {});
                                        return;
                                      } else {
                                        setState(() {
                                          _model.eqToSolve = getJsonField(
                                            _model
                                                .mathList[_model.currentIndex!],
                                            r'''$.equation''',
                                          ).toString();
                                          _model.op1 = getJsonField(
                                            _model
                                                .mathList[_model.currentIndex!],
                                            r'''$.op1''',
                                          ).toString();
                                          _model.op2 = getJsonField(
                                            _model
                                                .mathList[_model.currentIndex!],
                                            r'''$.op2''',
                                          ).toString();
                                          _model.op3 = getJsonField(
                                            _model
                                                .mathList[_model.currentIndex!],
                                            r'''$.op3''',
                                          ).toString();
                                          _model.op4 = getJsonField(
                                            _model
                                                .mathList[_model.currentIndex!],
                                            r'''$.op4''',
                                          ).toString();
                                          _model.correct = getJsonField(
                                            _model
                                                .mathList[_model.currentIndex!],
                                            r'''$.correct''',
                                          ).toString();
                                        });
                                        if (_shouldSetState) setState(() {});
                                        return;
                                      }
                                    } else {
                                      if (_shouldSetState) setState(() {});
                                      return;
                                    }

                                    if (_shouldSetState) setState(() {});
                                  },
                                  text: _model.op3!,
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 24.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 3.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    var _shouldSetState = false;
                                    _model.postMathAnswer4Resp =
                                        await PostMathAnswerCall.call(
                                      serverIP: FFAppState().serverIP,
                                      tokenType: FFAppState().tokenType,
                                      accessToken: FFAppState().accessToken,
                                      lobbyId: FFAppState().lobbyId,
                                      index: _model.currentIndex,
                                      answer: _model.op4,
                                    );
                                    _shouldSetState = true;
                                    if ((_model
                                            .postMathAnswer4Resp?.succeeded ??
                                        true)) {
                                      if (getJsonField(
                                        (_model.postMathAnswer4Resp?.jsonBody ??
                                            ''),
                                        r'''$.correct''',
                                      )) {
                                        _model.soundPlayer7 ??= AudioPlayer();
                                        if (_model.soundPlayer7!.playing) {
                                          await _model.soundPlayer7!.stop();
                                        }
                                        _model.soundPlayer7!.setVolume(1.0);
                                        _model.soundPlayer7!
                                            .setAsset(
                                                'assets/audios/cute-level-up-3-189853.mp3')
                                            .then((_) =>
                                                _model.soundPlayer7!.play());

                                        setState(() {
                                          _model.clientScore =
                                              _model.clientScore! + 50;
                                        });
                                      } else {
                                        _model.soundPlayer8 ??= AudioPlayer();
                                        if (_model.soundPlayer8!.playing) {
                                          await _model.soundPlayer8!.stop();
                                        }
                                        _model.soundPlayer8!.setVolume(1.0);
                                        _model.soundPlayer8!
                                            .setAsset(
                                                'assets/audios/buzzer-or-wrong-answer-20582.mp3')
                                            .then((_) =>
                                                _model.soundPlayer8!.play());
                                      }

                                      setState(() {
                                        _model.currentIndex =
                                            _model.currentIndex! + 1;
                                      });
                                      if (_model.currentIndex! >=
                                          _model.quizLength) {
                                        context.goNamed(
                                          'GameFinished',
                                          queryParameters: {
                                            'score': serializeParam(
                                              _model.clientScore?.toDouble(),
                                              ParamType.double,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.scale,
                                              alignment: Alignment.bottomCenter,
                                              duration:
                                                  Duration(milliseconds: 2000),
                                            ),
                                          },
                                        );

                                        if (_shouldSetState) setState(() {});
                                        return;
                                      } else {
                                        setState(() {
                                          _model.eqToSolve = getJsonField(
                                            _model
                                                .mathList[_model.currentIndex!],
                                            r'''$.equation''',
                                          ).toString();
                                          _model.op1 = getJsonField(
                                            _model
                                                .mathList[_model.currentIndex!],
                                            r'''$.op1''',
                                          ).toString();
                                          _model.op2 = getJsonField(
                                            _model
                                                .mathList[_model.currentIndex!],
                                            r'''$.op2''',
                                          ).toString();
                                          _model.op3 = getJsonField(
                                            _model
                                                .mathList[_model.currentIndex!],
                                            r'''$.op3''',
                                          ).toString();
                                          _model.op4 = getJsonField(
                                            _model
                                                .mathList[_model.currentIndex!],
                                            r'''$.op4''',
                                          ).toString();
                                          _model.correct = getJsonField(
                                            _model
                                                .mathList[_model.currentIndex!],
                                            r'''$.correct''',
                                          ).toString();
                                        });
                                        if (_shouldSetState) setState(() {});
                                        return;
                                      }
                                    } else {
                                      if (_shouldSetState) setState(() {});
                                      return;
                                    }

                                    if (_shouldSetState) setState(() {});
                                  },
                                  text: _model.op4!,
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 24.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 3.0,
                                    borderSide: BorderSide(
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 100.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  25.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Your score: ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                      decoration: TextDecoration.underline,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                40.0, 0.0, 0.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                _model.clientScore?.toString(),
                                '0',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                if (!_model.hasStarted!)
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                5.0, 30.0, 5.0, 0.0),
                            child: Text(
                              'Are you ready to begin?',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 30.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              70.0, 50.0, 70.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              var _shouldSetState = false;
                              _model.mathJSON = await GetMathTestCall.call(
                                serverIP: FFAppState().serverIP,
                                tokenType: FFAppState().tokenType,
                                accessToken: FFAppState().accessToken,
                                lobbyId: FFAppState().lobbyId,
                              );
                              _shouldSetState = true;
                              if ((_model.mathJSON?.succeeded ?? true)) {
                                setState(() {
                                  _model.mathList = getJsonField(
                                    (_model.mathJSON?.jsonBody ?? ''),
                                    r'''$.equations''',
                                    true,
                                  )!
                                      .toList()
                                      .cast<dynamic>();
                                  _model.quizLength = getJsonField(
                                    (_model.mathJSON?.jsonBody ?? ''),
                                    r'''$.length''',
                                  );
                                });
                              } else {
                                if (_shouldSetState) setState(() {});
                                return;
                              }

                              setState(() {
                                _model.eqToSolve = getJsonField(
                                  _model.mathList[_model.currentIndex!],
                                  r'''$.equation''',
                                ).toString();
                                _model.op1 = getJsonField(
                                  _model.mathList[_model.currentIndex!],
                                  r'''$.op1''',
                                ).toString();
                                _model.op2 = getJsonField(
                                  _model.mathList[_model.currentIndex!],
                                  r'''$.op2''',
                                ).toString();
                                _model.op3 = getJsonField(
                                  _model.mathList[_model.currentIndex!],
                                  r'''$.op3''',
                                ).toString();
                                _model.op4 = getJsonField(
                                  _model.mathList[_model.currentIndex!],
                                  r'''$.op4''',
                                ).toString();
                                _model.correct = getJsonField(
                                  _model.mathList[_model.currentIndex!],
                                  r'''$.correct''',
                                ).toString();
                                _model.hasStarted = true;
                              });
                              if (_shouldSetState) setState(() {});
                            },
                            text: 'Press to START!',
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 3.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
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
