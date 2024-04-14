import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _serverIP = prefs.getString('ff_serverIP') ?? _serverIP;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  int _userId = 0;
  int get userId => _userId;
  set userId(int _value) {
    _userId = _value;
  }

  String _username = '';
  String get username => _username;
  set username(String _value) {
    _username = _value;
  }

  String _accessToken = '';
  String get accessToken => _accessToken;
  set accessToken(String _value) {
    _accessToken = _value;
  }

  String _tokenType = '';
  String get tokenType => _tokenType;
  set tokenType(String _value) {
    _tokenType = _value;
  }

  dynamic _users;
  dynamic get users => _users;
  set users(dynamic _value) {
    _users = _value;
  }

  String _serverIP = '';
  String get serverIP => _serverIP;
  set serverIP(String _value) {
    _serverIP = _value;
    prefs.setString('ff_serverIP', _value);
  }

  List<String> _usersOnline = [];
  List<String> get usersOnline => _usersOnline;
  set usersOnline(List<String> _value) {
    _usersOnline = _value;
  }

  void addToUsersOnline(String _value) {
    _usersOnline.add(_value);
  }

  void removeFromUsersOnline(String _value) {
    _usersOnline.remove(_value);
  }

  void removeAtIndexFromUsersOnline(int _index) {
    _usersOnline.removeAt(_index);
  }

  void updateUsersOnlineAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _usersOnline[_index] = updateFn(_usersOnline[_index]);
  }

  void insertAtIndexInUsersOnline(int _index, String _value) {
    _usersOnline.insert(_index, _value);
  }

  bool _hasStarted = false;
  bool get hasStarted => _hasStarted;
  set hasStarted(bool _value) {
    _hasStarted = _value;
  }

  int _notificationCounter = 0;
  int get notificationCounter => _notificationCounter;
  set notificationCounter(int _value) {
    _notificationCounter = _value;
  }

  List<dynamic> _requests = [];
  List<dynamic> get requests => _requests;
  set requests(List<dynamic> _value) {
    _requests = _value;
  }

  void addToRequests(dynamic _value) {
    _requests.add(_value);
  }

  void removeFromRequests(dynamic _value) {
    _requests.remove(_value);
  }

  void removeAtIndexFromRequests(int _index) {
    _requests.removeAt(_index);
  }

  void updateRequestsAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _requests[_index] = updateFn(_requests[_index]);
  }

  void insertAtIndexInRequests(int _index, dynamic _value) {
    _requests.insert(_index, _value);
  }

  String _leader = 'singlePlayer';
  String get leader => _leader;
  set leader(String _value) {
    _leader = _value;
  }

  int _lobbyId = 0;
  int get lobbyId => _lobbyId;
  set lobbyId(int _value) {
    _lobbyId = _value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
