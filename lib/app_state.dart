import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  set userId(int value) {
    _userId = value;
  }

  String _username = '';
  String get username => _username;
  set username(String value) {
    _username = value;
  }

  String _accessToken = '';
  String get accessToken => _accessToken;
  set accessToken(String value) {
    _accessToken = value;
  }

  String _tokenType = '';
  String get tokenType => _tokenType;
  set tokenType(String value) {
    _tokenType = value;
  }

  dynamic _users;
  dynamic get users => _users;
  set users(dynamic value) {
    _users = value;
  }

  String _serverIP = '';
  String get serverIP => _serverIP;
  set serverIP(String value) {
    _serverIP = value;
    prefs.setString('ff_serverIP', value);
  }

  List<String> _usersOnline = [];
  List<String> get usersOnline => _usersOnline;
  set usersOnline(List<String> value) {
    _usersOnline = value;
  }

  void addToUsersOnline(String value) {
    _usersOnline.add(value);
  }

  void removeFromUsersOnline(String value) {
    _usersOnline.remove(value);
  }

  void removeAtIndexFromUsersOnline(int index) {
    _usersOnline.removeAt(index);
  }

  void updateUsersOnlineAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    _usersOnline[index] = updateFn(_usersOnline[index]);
  }

  void insertAtIndexInUsersOnline(int index, String value) {
    _usersOnline.insert(index, value);
  }

  bool _hasStarted = false;
  bool get hasStarted => _hasStarted;
  set hasStarted(bool value) {
    _hasStarted = value;
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
