import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class ConnectUserCall {
  static Future<ApiCallResponse> call({
    String? username = '',
    String? email = '',
    String? password = '',
    String? serverIP = '',
    String? birthday = '',
    String? port = '5000',
  }) async {
    final ffApiRequestBody = '''
{
  "username": "$username",
  "email": "$email",
  "birthday": "$birthday",
  "password": "$password",
  "online": 1
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ConnectUser',
      apiUrl: 'http://$serverIP:$port/user',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic id(dynamic response) => getJsonField(
        response,
        r'''$.id''',
      );
  static dynamic isNew(dynamic response) => getJsonField(
        response,
        r'''$.isNew''',
      );
}

class GetVocabCall {
  static Future<ApiCallResponse> call({
    String? accessToken = '',
    String? tokenType = '',
    String? serverIP = '',
    String? diff = '',
    String? port = '5000',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getVocab',
      apiUrl: 'http://$serverIP:$port/getVocab',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {
        'diff': diff,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic vocabList(dynamic response) => getJsonField(
        response,
        r'''$.vocab''',
      );
  static dynamic status(dynamic response) => getJsonField(
        response,
        r'''$.status''',
      );
  static dynamic length(dynamic response) => getJsonField(
        response,
        r'''$.length''',
      );
}

class GetUsersCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    String? username = '',
    String? port = '5000',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getUsers',
      apiUrl: 'http://$serverIP:$port/users',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {
        'username': username,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic users(dynamic response) => getJsonField(
        response,
        r'''$.users''',
      );
}

class GetScoreCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    int? lobbyId,
    String? port = '5000',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getScore',
      apiUrl: 'http://$serverIP:$port/getScore',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {
        'lobby_id': lobbyId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class InviteUserCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    String? otherUser = '',
    String? thisUser = '',
    String? port = '5000',
  }) async {
    final ffApiRequestBody = '''
{
  "sender_username": "$thisUser",
  "receiver_username": "$otherUser"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'InviteUser',
      apiUrl: 'http://$serverIP:$port/inviteUser',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class DeclineInviteCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    String? senderUsername = '',
    String? receiverUsername = '',
    String? port = '5000',
  }) async {
    final ffApiRequestBody = '''
{
  "sender_username": "$senderUsername",
  "receiver_username": "$receiverUsername"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'declineInvite',
      apiUrl: 'http://$serverIP:$port/declineInvite',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class AcceptInviteCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    String? senderUsername = '',
    String? receiverUsername = '',
    String? port = '5000',
  }) async {
    final ffApiRequestBody = '''
{
  "sender_username": "$senderUsername",
  "receiver_username": "$receiverUsername"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'acceptInvite',
      apiUrl: 'http://$serverIP:$port/acceptInvite',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class PostScoreCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    String? username = '',
    double? score,
    int? lobbyId,
    String? port = '5000',
  }) async {
    final ffApiRequestBody = '''
{
  "username": "$username",
  "score": $score,
  "lobby_id": $lobbyId
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'postScore',
      apiUrl: 'http://$serverIP:$port/postScore',
      callType: ApiCallType.POST,
      headers: {
        'Content-type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetOptimalCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    double? number,
    double? percent,
    int? dec,
    String? port = '5000',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getOptimal',
      apiUrl: 'http://$serverIP:$port/zero/optimal',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {
        'number': number,
        'percent': percent,
        'dec': dec,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class PostGetTZeroCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    String? username = '',
    String? port = '5000',
  }) async {
    final ffApiRequestBody = '''
{
  "username": "$username"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'postGetTZero',
      apiUrl: 'http://$serverIP:$port/zero',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class PostVocabCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    String? leader = '',
    String? username = '',
    String? port = '5000',
  }) async {
    final ffApiRequestBody = '''
{
  "leader": "$leader",
  "username": "$username"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'postVocab',
      apiUrl: 'http://$serverIP:$port/vocab',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class PostTicTacToeCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    String? username = '',
    String? leader = '',
    String? port = '5000',
  }) async {
    final ffApiRequestBody = '''
{
  "username": "$username",
  "leader": "$leader"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'postTicTacToe',
      apiUrl: 'http://$serverIP:$port/tictactoe',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class PlaceTicTacToeCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    int? lobbyId,
    int? index,
    String? userType = '',
    String? port = '5000',
  }) async {
    final ffApiRequestBody = '''
{
  "lobby_id": $lobbyId,
  "index": $index,
  "user_type": "$userType"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'placeTicTacToe',
      apiUrl: 'http://$serverIP:$port/tictactoe/place',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetTicTacToeBoardCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    int? lobbyId,
    String? port = '5000',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getTicTacToeBoard',
      apiUrl: 'http://$serverIP:$port/tictactoe/board',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {
        'lobby_id': lobbyId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class PostConnectFCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    String? username = '',
    String? leader = '',
    String? port = '5000',
  }) async {
    final ffApiRequestBody = '''
{
  "leader": "$leader",
  "username": "$username"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'postConnectF',
      apiUrl: 'http://$serverIP:$port/connect4',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class PlaceConnectFCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    int? lobbyId,
    String? index = '',
    String? userType = '',
    String? port = '5000',
  }) async {
    final ffApiRequestBody = '''
{
  "lobby_id": $lobbyId,
  "index": $index,
  "user_type": "$userType"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'placeConnectF',
      apiUrl: 'http://$serverIP:$port/connect4/place',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetConnectFBoardCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    int? lobbyId,
    String? port = '5000',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getConnectFBoard',
      apiUrl: 'http://$serverIP:$port/connect4/board',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {
        'lobby_id': lobbyId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetMathTestCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    int? lobbyId,
    String? port = '5000',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getMathTest',
      apiUrl: 'http://$serverIP:$port/getMath',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {
        'lobby_id': lobbyId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class PostMathCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    String? username = '',
    String? leader = '',
    String? port = '5000',
  }) async {
    final ffApiRequestBody = '''
{
  "username": "$username",
  "leader": "$leader"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'postMath',
      apiUrl: 'http://$serverIP:$port/mathTest',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class PostVocabAnswerCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    String? diff = '',
    int? index,
    String? answer = '',
    String? port = '5000',
  }) async {
    final ffApiRequestBody = '''
{
  "diff": "$diff",
  "index": $index,
  "answer": "$answer"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'postVocabAnswer',
      apiUrl: 'http://$serverIP:$port/vocab/answer',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class PostMathAnswerCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    int? lobbyId,
    int? index,
    String? answer = '',
    String? port = '5000',
  }) async {
    final ffApiRequestBody = '''
{
  "lobby_id": $lobbyId,
  "index": $index,
  "answer": "$answer"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'postMathAnswer',
      apiUrl: 'http://$serverIP:$port/math/answer',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class PostGuessWCategoryCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    int? lobbyId,
    String? username = '',
    String? category = '',
    String? secretWord = '',
    String? port = '5000',
  }) async {
    final ffApiRequestBody = '''
{
  "lobby_id": $lobbyId,
  "username": "$username",
  "category": "$category",
  "secret_word": "$secretWord"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'postGuessWCategory',
      apiUrl: 'http://$serverIP:$port/guessWrong/category',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class PostCheckGuessWCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    String? lobbyId = '',
    String? username = '',
    String? guess = '',
    String? port = '5000',
  }) async {
    final ffApiRequestBody = '''
{
  "lobby_id": "$lobbyId",
  "username": "$username",
  "guess": "$guess"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'postCheckGuessW',
      apiUrl: 'http://$serverIP:$port/guessWrong/guess',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class PostGuessWrongCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? tokenType = '',
    String? accessToken = '',
    String? username = '',
    String? leader = '',
    String? port = '5000',
  }) async {
    final ffApiRequestBody = '''
{
  "username": "$username",
  "leader": "$leader"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'postGuessWrong',
      apiUrl: 'http://$serverIP:$port/guessWrong',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class LogOutCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? accessToken = '',
    String? tokenType = '',
    String? username = '',
    String? port = '5000',
  }) async {
    final ffApiRequestBody = '''
{
  "username": "$username"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'logOut',
      apiUrl: 'http://$serverIP:$port/LogOut',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class LeavePartyCall {
  static Future<ApiCallResponse> call({
    String? serverIP = '',
    String? port = '5000',
    String? accessToken = '',
    String? tokenType = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'leaveParty',
      apiUrl: 'http://$serverIP:$port/leaveParty',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
