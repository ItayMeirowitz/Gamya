import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'guess_wrong_model.dart';
export 'guess_wrong_model.dart';

class GuessWrongWidget extends StatefulWidget {
  const GuessWrongWidget({super.key});

  @override
  State<GuessWrongWidget> createState() => _GuessWrongWidgetState();
}

class _GuessWrongWidgetState extends State<GuessWrongWidget> {
  late GuessWrongModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GuessWrongModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().update(() {
        FFAppState().hasStarted = true;
      });
      _model.currentReceived = await actions.fetchData(
        'http://${FFAppState().serverIP}:5000/guessWrong/${FFAppState().username}',
        FFAppState().tokenType,
        FFAppState().accessToken,
        FFAppState().username,
      );
      if ('true' ==
          getJsonField(
            _model.currentReceived,
            r'''$.current''',
          )) {
        setState(() {
          _model.isTurn = true;
        });
        await Future.delayed(const Duration(milliseconds: 500));
      } else {
        setState(() {
          _model.isTurn = false;
        });
        await Future.delayed(const Duration(milliseconds: 500));
      }

      while (FFAppState().hasStarted) {
        if (_model.isTurn) {
          while (_model.isTurn) {
            _model.dataReceivedTurn = await actions.fetchData(
              'http://${FFAppState().serverIP}:5000/guessWrong/${FFAppState().username}',
              FFAppState().tokenType,
              FFAppState().accessToken,
              FFAppState().username,
            );
            if (getJsonField(
                  _model.dataReceivedTurn,
                  r'''$.current''',
                ) !=
                null) {
              setState(() {
                _model.isTurn = false;
              });
              setState(() {
                _model.category = null;
                _model.secretWord = null;
                _model.waitingGuess = false;
              });
              break;
            } else if (getJsonField(
                  _model.dataReceivedTurn,
                  r'''$.gameOver''',
                ) !=
                null) {
              context.goNamed(
                'GameFinished',
                queryParameters: {
                  'score': serializeParam(
                    -1.0,
                    ParamType.double,
                  ),
                }.withoutNulls,
                extra: <String, dynamic>{
                  kTransitionInfoKey: TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.fade,
                    duration: Duration(milliseconds: 1000),
                  ),
                },
              );

              return;
            } else if (getJsonField(
                  _model.dataReceivedTurn,
                  r'''$.getScore''',
                ) !=
                null) {
              _model.getScoreTurnResp = await GetScoreCall.call(
                serverIP: FFAppState().serverIP,
                tokenType: FFAppState().tokenType,
                accessToken: FFAppState().accessToken,
                lobbyId: FFAppState().lobbyId,
              );
              if ((_model.getScoreTurnResp?.succeeded ?? true)) {
                setState(() {
                  _model.scores = (_model.getScoreTurnResp?.jsonBody ?? '')
                      .toList()
                      .cast<dynamic>();
                });
              }
            } else {
              await showDialog(
                context: context,
                builder: (alertDialogContext) {
                  return AlertDialog(
                    title: Text('yhgokn '),
                    content: Text('ghytvnu'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(alertDialogContext),
                        child: Text('Ok'),
                      ),
                    ],
                  );
                },
              );
            }
          }
        } else {
          while (!_model.isTurn) {
            _model.dataReceived = await actions.fetchData(
              'http://${FFAppState().serverIP}:5000/guessWrong/${FFAppState().username}',
              FFAppState().tokenType,
              FFAppState().accessToken,
              FFAppState().username,
            );
            if (getJsonField(
                  _model.dataReceived,
                  r'''$.category''',
                ) !=
                null) {
              setState(() {
                _model.guessCategory = getJsonField(
                  _model.dataReceived,
                  r'''$.category''',
                ).toString().toString();
              });
            } else if (getJsonField(
                  _model.dataReceived,
                  r'''$.getScore''',
                ) !=
                null) {
              _model.getScoreResp = await GetScoreCall.call(
                serverIP: FFAppState().serverIP,
                tokenType: FFAppState().tokenType,
                accessToken: FFAppState().accessToken,
                lobbyId: FFAppState().lobbyId,
              );
              if ((_model.getScoreResp?.succeeded ?? true)) {
                setState(() {
                  _model.scores = (_model.getScoreResp?.jsonBody ?? '')
                      .toList()
                      .cast<dynamic>();
                });
              }
            } else if (getJsonField(
                  _model.dataReceived,
                  r'''$.current''',
                ) !=
                null) {
              if ('true' ==
                  getJsonField(
                    _model.dataReceived,
                    r'''$.current''',
                  )) {
                setState(() {
                  _model.isTurn = true;
                  _model.guessCategory = null;
                });
                break;
              }
              setState(() {
                _model.guessCategory = null;
              });
            } else if (getJsonField(
                  _model.dataReceived,
                  r'''$.gameOver''',
                ) !=
                null) {
              context.goNamed(
                'GameFinished',
                queryParameters: {
                  'score': serializeParam(
                    -1.0,
                    ParamType.double,
                  ),
                }.withoutNulls,
                extra: <String, dynamic>{
                  kTransitionInfoKey: TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.fade,
                    duration: Duration(milliseconds: 1000),
                  ),
                },
              );

              return;
            } else {
              await showDialog(
                context: context,
                builder: (alertDialogContext) {
                  return AlertDialog(
                    title: Text('SUS'),
                    content: Text('couldnt get state'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(alertDialogContext),
                        child: Text('Ok'),
                      ),
                    ],
                  );
                },
              );
              break;
            }
          }
        }

        await Future.delayed(const Duration(milliseconds: 250));
      }
    });

    _model.categoryTextController ??= TextEditingController();
    _model.categoryFocusNode ??= FocusNode();

    _model.secretWordTextController ??= TextEditingController();
    _model.secretWordFocusNode ??= FocusNode();

    _model.guessTextController ??= TextEditingController();
    _model.guessFocusNode ??= FocusNode();
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
              'Guess Wrong!',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                  ),
            ),
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
            centerTitle: false,
            elevation: 2.0,
          ),
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    if (_model.isTurn)
                      Stack(
                        children: [
                          if (!_model.waitingGuess)
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 0.0),
                                    child: Text(
                                      'Choose a category:',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 18.0,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 20.0, 24.0, 16.0),
                                    child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller:
                                            _model.categoryTextController,
                                        focusNode: _model.categoryFocusNode,
                                        autofocus: true,
                                        autofillHints: [AutofillHints.username],
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Enter catergory here',
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    letterSpacing: 0.0,
                                                  ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                          ),
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          contentPadding: EdgeInsets.all(24.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              letterSpacing: 0.0,
                                            ),
                                        cursorColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        validator: _model
                                            .categoryTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 5.0, 0.0, 0.0),
                                    child: Text(
                                      'Enter the word you think they would guess:',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 20.0, 24.0, 16.0),
                                    child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller:
                                            _model.secretWordTextController,
                                        focusNode: _model.secretWordFocusNode,
                                        autofocus: true,
                                        autofillHints: [AutofillHints.username],
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Secret word here',
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    letterSpacing: 0.0,
                                                  ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                          ),
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          contentPadding: EdgeInsets.all(24.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              letterSpacing: 0.0,
                                            ),
                                        cursorColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        validator: _model
                                            .secretWordTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                  FFButtonWidget(
                                    onPressed: () async {
                                      var _shouldSetState = false;
                                      setState(() {
                                        _model.category =
                                            _model.categoryTextController.text;
                                        _model.secretWord = _model
                                            .secretWordTextController.text;
                                      });
                                      if ((_model.category != null &&
                                              _model.category != '') &&
                                          (_model.secretWord != null &&
                                              _model.secretWord != '')) {
                                        _model.postCategoryResp =
                                            await PostGuessWCategoryCall.call(
                                          serverIP: FFAppState().serverIP,
                                          tokenType: FFAppState().tokenType,
                                          accessToken: FFAppState().accessToken,
                                          lobbyId: FFAppState().lobbyId,
                                          username: FFAppState().username,
                                          category: _model.category,
                                          secretWord: _model.secretWord,
                                        );
                                        _shouldSetState = true;
                                        if ((_model
                                                .postCategoryResp?.succeeded ??
                                            true)) {
                                          setState(() {
                                            _model.waitingGuess = true;
                                          });
                                        } else {
                                          await showDialog(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return AlertDialog(
                                                title: Text('API error'),
                                                content: Text((_model
                                                            .postCategoryResp
                                                            ?.jsonBody ??
                                                        '')
                                                    .toString()),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext),
                                                    child: Text('Ok'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                          if (_shouldSetState) setState(() {});
                                          return;
                                        }
                                      } else {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: Text('Invalid Input'),
                                              content: Text(
                                                  'Both fields need to be filled'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext),
                                                  child: Text('Ok, mb'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        if (_shouldSetState) setState(() {});
                                        return;
                                      }

                                      if (_shouldSetState) setState(() {});
                                    },
                                    text: 'Submit',
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
                                ],
                              ),
                            ),
                          if (_model.waitingGuess)
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.0, -1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 20.0, 10.0, 0.0),
                                    child: Text(
                                      'Waiting for users to guess the word',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 28.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, 1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 80.0, 0.0, 0.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/loading-ezgif.com-optimize.gif',
                                        width: 300.0,
                                        height: 357.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    if (!_model.isTurn)
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Stack(
                            children: [
                              if (_model.guessCategory == null ||
                                  _model.guessCategory == '')
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(0.0, -1.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 20.0, 10.0, 0.0),
                                        child: Text(
                                          'Waiting for others',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 28.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 1.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 80.0, 0.0, 0.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/loading-ezgif.com-optimize.gif',
                                            width: 300.0,
                                            height: 357.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (_model.guessCategory != null &&
                                  _model.guessCategory != '')
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(0.0, -1.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 20.0, 0.0, 0.0),
                                        child: AutoSizeText(
                                          'Category: ${_model.guessCategory}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 30.0,
                                                letterSpacing: 0.0,
                                              ),
                                          minFontSize: 10.0,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(0.0, -1.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 0.0),
                                        child: Text(
                                          'Guess the unanticipated',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 20.0, 24.0, 16.0),
                                      child: Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller:
                                              _model.guessTextController,
                                          focusNode: _model.guessFocusNode,
                                          autofocus: true,
                                          autofillHints: [
                                            AutofillHints.username
                                          ],
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Unanticipated word',
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      letterSpacing: 0.0,
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40.0),
                                            ),
                                            filled: true,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            contentPadding:
                                                EdgeInsets.all(24.0),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                letterSpacing: 0.0,
                                              ),
                                          cursorColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          validator: _model
                                              .guessTextControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 20.0, 0.0, 0.0),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          var _shouldSetState = false;
                                          _model.postCheckGuessResp =
                                              await PostCheckGuessWCall.call(
                                            serverIP: FFAppState().serverIP,
                                            tokenType: FFAppState().tokenType,
                                            accessToken:
                                                FFAppState().accessToken,
                                            lobbyId:
                                                FFAppState().lobbyId.toString(),
                                            username: FFAppState().username,
                                            guess:
                                                _model.guessTextController.text,
                                          );
                                          _shouldSetState = true;
                                          if ((_model.postCheckGuessResp
                                                  ?.succeeded ??
                                              true)) {
                                            setState(() {
                                              _model.guessCategory = null;
                                            });
                                            if (_shouldSetState)
                                              setState(() {});
                                            return;
                                          } else {
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text('aaaa'),
                                                  content: Text('checkguesded'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: Text('Ok'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                            if (_shouldSetState)
                                              setState(() {});
                                            return;
                                          }

                                          if (_shouldSetState) setState(() {});
                                        },
                                        text: 'Send it!',
                                        options: FFButtonOptions(
                                          height: 40.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
                Flexible(
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Builder(
                      builder: (context) {
                        final scoresList = _model.scores.toList();
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: scoresList.length,
                          itemBuilder: (context, scoresListIndex) {
                            final scoresListItem = scoresList[scoresListIndex];
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
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
                                  padding: EdgeInsets.all(12.0),
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
