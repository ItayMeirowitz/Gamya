import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'vocab_model.dart';
export 'vocab_model.dart';

class VocabWidget extends StatefulWidget {
  const VocabWidget({super.key});

  @override
  State<VocabWidget> createState() => _VocabWidgetState();
}

class _VocabWidgetState extends State<VocabWidget> {
  late VocabModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VocabModel());

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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          actions: const [],
          flexibleSpace: FlexibleSpaceBar(
            title: Align(
              alignment: const AlignmentDirectional(0.0, 1.0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                child: Text(
                  'Vocabulary Contest!',
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
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                        child: Text(
                          _model.wordToGuess!,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 30.0,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 150.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, -1.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    if (_model.op1 == _model.correct) {
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

                                      if (_model.diff == 'easy') {
                                        setState(() {
                                          _model.clientScore =
                                              _model.clientScore! + 20;
                                        });
                                      } else if (_model.diff == 'medium') {
                                        setState(() {
                                          _model.clientScore =
                                              _model.clientScore! + 40;
                                        });
                                      } else if (_model.diff == 'hard') {
                                        setState(() {
                                          _model.clientScore =
                                              _model.clientScore! + 100;
                                        });
                                      }
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
                                      context.pushNamed(
                                        'GameFinished',
                                        queryParameters: {
                                          'score': serializeParam(
                                            _model.clientScore?.toDouble(),
                                            ParamType.double,
                                          ),
                                        }.withoutNulls,
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: const TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.scale,
                                            alignment: Alignment.bottomCenter,
                                            duration:
                                                Duration(milliseconds: 2000),
                                          ),
                                        },
                                      );

                                      return;
                                    } else {
                                      setState(() {
                                        _model.wordToGuess = getJsonField(
                                          _model
                                              .vocabList[_model.currentIndex!],
                                          r'''$.word''',
                                        ).toString();
                                        _model.op1 = getJsonField(
                                          _model
                                              .vocabList[_model.currentIndex!],
                                          r'''$.op1''',
                                        ).toString();
                                        _model.op2 = getJsonField(
                                          _model
                                              .vocabList[_model.currentIndex!],
                                          r'''$.op2''',
                                        ).toString();
                                        _model.op3 = getJsonField(
                                          _model
                                              .vocabList[_model.currentIndex!],
                                          r'''$.op3''',
                                        ).toString();
                                        _model.op4 = getJsonField(
                                          _model
                                              .vocabList[_model.currentIndex!],
                                          r'''$.op4''',
                                        ).toString();
                                        _model.correct = getJsonField(
                                          _model
                                              .vocabList[_model.currentIndex!],
                                          r'''$.correct''',
                                        ).toString();
                                      });
                                      return;
                                    }
                                  },
                                  text: _model.op1!,
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 24.0, 0.0),
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
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
                                    borderSide: const BorderSide(
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
                                alignment: const AlignmentDirectional(0.0, -1.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    if (_model.op2 == _model.correct) {
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

                                      if (_model.diff == 'easy') {
                                        setState(() {
                                          _model.clientScore =
                                              _model.clientScore! + 20;
                                        });
                                      } else if (_model.diff == 'medium') {
                                        setState(() {
                                          _model.clientScore =
                                              _model.clientScore! + 40;
                                        });
                                      } else if (_model.diff == 'hard') {
                                        setState(() {
                                          _model.clientScore =
                                              _model.clientScore! + 100;
                                        });
                                      }
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
                                      context.pushNamed(
                                        'GameFinished',
                                        queryParameters: {
                                          'score': serializeParam(
                                            _model.clientScore?.toDouble(),
                                            ParamType.double,
                                          ),
                                        }.withoutNulls,
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: const TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.scale,
                                            alignment: Alignment.bottomCenter,
                                            duration:
                                                Duration(milliseconds: 2000),
                                          ),
                                        },
                                      );

                                      return;
                                    } else {
                                      setState(() {
                                        _model.wordToGuess = getJsonField(
                                          _model
                                              .vocabList[_model.currentIndex!],
                                          r'''$.word''',
                                        ).toString();
                                        _model.op1 = getJsonField(
                                          _model
                                              .vocabList[_model.currentIndex!],
                                          r'''$.op1''',
                                        ).toString();
                                        _model.op2 = getJsonField(
                                          _model
                                              .vocabList[_model.currentIndex!],
                                          r'''$.op2''',
                                        ).toString();
                                        _model.op3 = getJsonField(
                                          _model
                                              .vocabList[_model.currentIndex!],
                                          r'''$.op3''',
                                        ).toString();
                                        _model.op4 = getJsonField(
                                          _model
                                              .vocabList[_model.currentIndex!],
                                          r'''$.op4''',
                                        ).toString();
                                        _model.correct = getJsonField(
                                          _model
                                              .vocabList[_model.currentIndex!],
                                          r'''$.correct''',
                                        ).toString();
                                      });
                                      return;
                                    }
                                  },
                                  text: _model.op2!,
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 24.0, 0.0),
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
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
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 100.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            child: Align(
                              alignment: const AlignmentDirectional(0.0, -1.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  if (_model.op3 == _model.correct) {
                                    _model.soundPlayer5 ??= AudioPlayer();
                                    if (_model.soundPlayer5!.playing) {
                                      await _model.soundPlayer5!.stop();
                                    }
                                    _model.soundPlayer5!.setVolume(1.0);
                                    _model.soundPlayer5!
                                        .setAsset(
                                            'assets/audios/cute-level-up-3-189853.mp3')
                                        .then(
                                            (_) => _model.soundPlayer5!.play());

                                    if (_model.diff == 'easy') {
                                      setState(() {
                                        _model.clientScore =
                                            _model.clientScore! + 20;
                                      });
                                    } else if (_model.diff == 'medium') {
                                      setState(() {
                                        _model.clientScore =
                                            _model.clientScore! + 40;
                                      });
                                    } else if (_model.diff == 'hard') {
                                      setState(() {
                                        _model.clientScore =
                                            _model.clientScore! + 100;
                                      });
                                    }
                                  } else {
                                    _model.soundPlayer6 ??= AudioPlayer();
                                    if (_model.soundPlayer6!.playing) {
                                      await _model.soundPlayer6!.stop();
                                    }
                                    _model.soundPlayer6!.setVolume(1.0);
                                    _model.soundPlayer6!
                                        .setAsset(
                                            'assets/audios/buzzer-or-wrong-answer-20582.mp3')
                                        .then(
                                            (_) => _model.soundPlayer6!.play());
                                  }

                                  setState(() {
                                    _model.currentIndex =
                                        _model.currentIndex! + 1;
                                  });
                                  if (_model.currentIndex! >=
                                      _model.quizLength) {
                                    context.pushNamed(
                                      'GameFinished',
                                      queryParameters: {
                                        'score': serializeParam(
                                          _model.clientScore?.toDouble(),
                                          ParamType.double,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: const TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.scale,
                                          alignment: Alignment.bottomCenter,
                                          duration:
                                              Duration(milliseconds: 2000),
                                        ),
                                      },
                                    );

                                    return;
                                  } else {
                                    setState(() {
                                      _model.wordToGuess = getJsonField(
                                        _model.vocabList[_model.currentIndex!],
                                        r'''$.word''',
                                      ).toString();
                                      _model.op1 = getJsonField(
                                        _model.vocabList[_model.currentIndex!],
                                        r'''$.op1''',
                                      ).toString();
                                      _model.op2 = getJsonField(
                                        _model.vocabList[_model.currentIndex!],
                                        r'''$.op2''',
                                      ).toString();
                                      _model.op3 = getJsonField(
                                        _model.vocabList[_model.currentIndex!],
                                        r'''$.op3''',
                                      ).toString();
                                      _model.op4 = getJsonField(
                                        _model.vocabList[_model.currentIndex!],
                                        r'''$.op4''',
                                      ).toString();
                                      _model.correct = getJsonField(
                                        _model.vocabList[_model.currentIndex!],
                                        r'''$.correct''',
                                      ).toString();
                                    });
                                    return;
                                  }
                                },
                                text: _model.op3!,
                                options: FFButtonOptions(
                                  height: 40.0,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(
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
                                  borderSide: const BorderSide(
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
                              alignment: const AlignmentDirectional(0.0, -1.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  if (_model.op4 == _model.correct) {
                                    _model.soundPlayer7 ??= AudioPlayer();
                                    if (_model.soundPlayer7!.playing) {
                                      await _model.soundPlayer7!.stop();
                                    }
                                    _model.soundPlayer7!.setVolume(1.0);
                                    _model.soundPlayer7!
                                        .setAsset(
                                            'assets/audios/cute-level-up-3-189853.mp3')
                                        .then(
                                            (_) => _model.soundPlayer7!.play());

                                    if (_model.diff == 'easy') {
                                      setState(() {
                                        _model.clientScore =
                                            _model.clientScore! + 20;
                                      });
                                    } else if (_model.diff == 'medium') {
                                      setState(() {
                                        _model.clientScore =
                                            _model.clientScore! + 40;
                                      });
                                    } else if (_model.diff == 'hard') {
                                      setState(() {
                                        _model.clientScore =
                                            _model.clientScore! + 100;
                                      });
                                    }
                                  } else {
                                    _model.soundPlayer8 ??= AudioPlayer();
                                    if (_model.soundPlayer8!.playing) {
                                      await _model.soundPlayer8!.stop();
                                    }
                                    _model.soundPlayer8!.setVolume(1.0);
                                    _model.soundPlayer8!
                                        .setAsset(
                                            'assets/audios/buzzer-or-wrong-answer-20582.mp3')
                                        .then(
                                            (_) => _model.soundPlayer8!.play());
                                  }

                                  setState(() {
                                    _model.currentIndex =
                                        _model.currentIndex! + 1;
                                  });
                                  if (_model.currentIndex! >=
                                      _model.quizLength) {
                                    context.pushNamed(
                                      'GameFinished',
                                      queryParameters: {
                                        'score': serializeParam(
                                          _model.clientScore?.toDouble(),
                                          ParamType.double,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: const TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.scale,
                                          alignment: Alignment.bottomCenter,
                                          duration:
                                              Duration(milliseconds: 2000),
                                        ),
                                      },
                                    );

                                    return;
                                  } else {
                                    setState(() {
                                      _model.wordToGuess = getJsonField(
                                        _model.vocabList[_model.currentIndex!],
                                        r'''$.word''',
                                      ).toString();
                                      _model.op1 = getJsonField(
                                        _model.vocabList[_model.currentIndex!],
                                        r'''$.op1''',
                                      ).toString();
                                      _model.op2 = getJsonField(
                                        _model.vocabList[_model.currentIndex!],
                                        r'''$.op2''',
                                      ).toString();
                                      _model.op3 = getJsonField(
                                        _model.vocabList[_model.currentIndex!],
                                        r'''$.op3''',
                                      ).toString();
                                      _model.op4 = getJsonField(
                                        _model.vocabList[_model.currentIndex!],
                                        r'''$.op4''',
                                      ).toString();
                                      _model.correct = getJsonField(
                                        _model.vocabList[_model.currentIndex!],
                                        r'''$.correct''',
                                      ).toString();
                                    });
                                    return;
                                  }
                                },
                                text: _model.op4!,
                                options: FFButtonOptions(
                                  height: 40.0,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(
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
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 100.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              40.0, 0.0, 0.0, 0.0),
                          child: Text(
                            valueOrDefault<String>(
                              _model.clientScore?.toString(),
                              '0',
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyLarge.override(
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
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0.0, -1.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 30.0, 0.0, 0.0),
                                child: Text(
                                  'Choose Difficulty:',
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
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Flexible(
                                      child: Align(
                                        alignment:
                                            const AlignmentDirectional(0.0, 0.0),
                                        child: Text(
                                          'x1 score',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Align(
                                        alignment:
                                            const AlignmentDirectional(0.0, 0.0),
                                        child: Text(
                                          'x2 score',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Align(
                                        alignment:
                                            const AlignmentDirectional(0.0, 0.0),
                                        child: Text(
                                          'x5 score',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Flexible(
                                      child: Align(
                                        alignment:
                                            const AlignmentDirectional(0.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            setState(() {
                                              _model.diff = 'easy';
                                            });
                                          },
                                          text: 'Easy',
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
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
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Align(
                                        alignment:
                                            const AlignmentDirectional(0.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            setState(() {
                                              _model.diff = 'medium';
                                            });
                                          },
                                          text: 'Medium',
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .warning,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
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
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Align(
                                        alignment:
                                            const AlignmentDirectional(0.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            setState(() {
                                              _model.diff = 'hard';
                                            });
                                          },
                                          text: 'Hard',
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
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
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                'Difficulty selected: ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                _model.diff,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            70.0, 80.0, 70.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            var shouldSetState = false;
                            _model.vocabJSON = await GetVocabCall.call(
                              accessToken: FFAppState().accessToken,
                              tokenType: FFAppState().tokenType,
                              serverIP: FFAppState().serverIP,
                              diff: _model.diff,
                            );
                            shouldSetState = true;
                            if ((_model.vocabJSON?.succeeded ?? true)) {
                              setState(() {
                                _model.vocabList = getJsonField(
                                  (_model.vocabJSON?.jsonBody ?? ''),
                                  r'''$.vocab''',
                                  true,
                                )!
                                    .toList()
                                    .cast<dynamic>();
                                _model.quizLength = getJsonField(
                                  (_model.vocabJSON?.jsonBody ?? ''),
                                  r'''$.length''',
                                );
                              });
                            } else {
                              if (shouldSetState) setState(() {});
                              return;
                            }

                            setState(() {
                              _model.wordToGuess = getJsonField(
                                _model.vocabList[_model.currentIndex!],
                                r'''$.word''',
                              ).toString();
                              _model.op1 = getJsonField(
                                _model.vocabList[_model.currentIndex!],
                                r'''$.op1''',
                              ).toString();
                              _model.op2 = getJsonField(
                                _model.vocabList[_model.currentIndex!],
                                r'''$.op2''',
                              ).toString();
                              _model.op3 = getJsonField(
                                _model.vocabList[_model.currentIndex!],
                                r'''$.op3''',
                              ).toString();
                              _model.op4 = getJsonField(
                                _model.vocabList[_model.currentIndex!],
                                r'''$.op4''',
                              ).toString();
                              _model.correct = getJsonField(
                                _model.vocabList[_model.currentIndex!],
                                r'''$.correct''',
                              ).toString();
                              _model.hasStarted = true;
                            });
                            if (shouldSetState) setState(() {});
                          },
                          text: 'Press to START!',
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
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
                            borderSide: const BorderSide(
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
    );
  }
}
