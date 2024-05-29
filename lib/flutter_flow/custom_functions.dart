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

double minusPrecent(
  double number,
  double precentage,
) {
  double num = (1 - precentage / 100) * number;
  double roundedNumber =
      (num * 100).round() / 100; // Rounds to 2 decimal places
  return roundedNumber;
}

double decrementNumber(
  double number,
  int dec,
) {
  double num = number - dec;

  double roundedNumber =
      (num * 100).round() / 100; // Rounds to 2 decimal places

  return roundedNumber;
}

double getRandomNumber() {
  // Generate a random number between 100 and 1000
  math.Random random = math.Random();
  return random.nextInt(901) +
      100; // Generates a random number between 0 and 900, then adds 100
}

bool isTurn(
  String userType,
  List<String> currentBoard,
) {
  int xCount = 0;
  int oCount = 0;

  // Count the occurrences of X and O in the board
  for (String cell in currentBoard) {
    if (cell == 'X') {
      xCount++;
    } else if (cell == 'O') {
      oCount++;
    }
  }

  // Determine whose turn it is based on the count of X and O
  if (userType == 'X') {
    // If userType is X, then it's O's turn if O has fewer occurrences
    return oCount >= xCount;
  } else if (userType == 'O') {
    // If userType is O, then it's X's turn if X has fewer occurrences
    return xCount > oCount;
  } else {
    // Invalid userType
    return false;
  }
}

bool isTurnConnect4(
  List<String> currentBoard,
  String userType,
) {
  int rCount = 0;
  int bCount = 0;

  // Count the occurrences of X and O in the board
  for (String cell in currentBoard) {
    if (cell == 'R') {
      rCount++;
    } else if (cell == 'B') {
      bCount++;
    }
  }

  // Determine whose turn it is based on the count of X and O
  if (userType == 'R') {
    // If userType is X, then it's O's turn if O has fewer occurrences
    return bCount >= rCount;
  } else if (userType == 'B') {
    // If userType is O, then it's X's turn if X has fewer occurrences
    return rCount > bCount;
  } else {
    // Invalid userType
    return false;
  }
}

String getName(String userType) {
  if (userType == 'R') {
    return "Red";
  } else if (userType == 'B') {
    return "Blue";
  }
  return "Unknown type";
}
