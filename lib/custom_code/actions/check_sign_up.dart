// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

String? checkSignUp(
    String username, String email, String password, String confirmPassword) {
  // Check username
  RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9 ]+$');
  if (!usernameRegex.hasMatch(username)) {
    return "Username must contain only English letters,\nnumbers, and spaces.";
  }

  // Check email
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(email)) {
    return "Invalid email format.\nPlease enter a valid email address.";
  }

  // Check password
  RegExp passwordRegex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>])[A-Za-z0-9!@#$%^&*(),.?":{}|<>]{8,}$');
  if (!passwordRegex.hasMatch(password)) {
    return "Password must be at least 8 characters long\nand contain at least one uppercase letter,\none digit, and one special character.";
  }

  // Check confirmPassword
  if (password != confirmPassword) {
    return "Passwords do not match.\nPlease make sure the passwords match.";
  }

  return null;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
