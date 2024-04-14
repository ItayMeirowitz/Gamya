// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';

import 'dart:async';

import 'package:http/http.dart';

import 'package:http/http.dart' as http;

import 'package:gamya/custom_code/actions/post_to_userpage.dart';

dynamic fetchData(String apiUrl, String tokenType, String accessToken,
    String username) async {
  while (true) {
    Map<String, String> headers = {
      'Authorization': "$tokenType $accessToken",
      'Content-Type': 'application/json', // Specify the content type as JSON
    };

    Map<String, dynamic> getQueryParams = {
      'get': 'true',
      'change': jsonEncode({})
    };
    String urlWithParams =
        apiUrl + '?' + Uri(queryParameters: getQueryParams).query;

    http.Response response =
        await http.get(Uri.parse(urlWithParams), headers: headers);

    sleep(Duration(milliseconds: 50));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      if (data['isUpdate'] == 'true') {
        Map<String, dynamic> updateQueryParams = {
          'get': 'false',
          'change': jsonEncode({'isUpdate': 'false'})
        };

        postToUserpage(apiUrl, updateQueryParams, headers);

        return data['data'];
      }
    } else {
      return {"msg": "failed to load data: ${response.statusCode}"};
    }
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
