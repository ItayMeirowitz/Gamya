// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:http/http.dart' as http;

Future postToUserpage(
  String apiUrl,
  dynamic query,
  dynamic headers,
) async {
  // create post request to the apiurl using headers and query
  String urlWithParams = apiUrl + '?' + Uri(queryParameters: query).query;

  await http.get(Uri.parse(urlWithParams), headers: headers);
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
