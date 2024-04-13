import 'dart:convert';

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
      apiUrl: 'http://$serverIP:5000/user',
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
    String? diff = 'easy',
    String? username = '',
    String? leader = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getVocab',
      apiUrl: 'http://$serverIP:5000/vocab',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {
        'username': username,
        'diff': diff,
        'leader': leader,
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
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getUsers',
      apiUrl: 'http://$serverIP:5000/users',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$tokenType $accessToken',
      },
      params: {},
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
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getScore',
      apiUrl: 'http://$serverIP:5000/getScore',
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
  }) async {
    final ffApiRequestBody = '''
{
  "sender_username": "$thisUser",
  "receiver_username": "$otherUser"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'InviteUser',
      apiUrl: 'http://$serverIP:5000/inviteUser',
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
  }) async {
    final ffApiRequestBody = '''
{
  "sender_username": "$senderUsername",
  "receiver_username": "$receiverUsername"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'declineInvite',
      apiUrl: 'http://$serverIP:5000/declineInvite',
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
  }) async {
    final ffApiRequestBody = '''
{
  "sender_username": "$senderUsername",
  "receiver_username": "$receiverUsername"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'acceptInvite',
      apiUrl: 'http://$serverIP:5000/acceptInvite',
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
  }) async {
    final ffApiRequestBody = '''
{
  "username": "$username",
  "score": $score,
  "lobby_id": $lobbyId
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'postScore',
      apiUrl: 'http://$serverIP:5000/postScore',
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

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
