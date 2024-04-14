import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';

List<dynamic> sortScores(List<dynamic> scores) {
  // Sort the list of JSON objects by score in descending order
  scores.sort((a, b) => b['score'].compareTo(a['score']));
  return scores;
}
