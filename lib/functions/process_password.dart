import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:password_generator/db/functions/db_functions.dart';
import 'package:password_generator/db/model/data_model.dart';

String processPassword(
    {required int length,
    required bool oneSmallCaseLetter,
    required bool oneUpperCaseLetter,
    required bool oneNumber,
    required bool oneSpecialCharacter,
    required String key}) {
  length = length < 6
      ? 6
      : length > 20
          ? 20
          : length;
  final random = Random();
  const upperCaseCharacters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const lowerCaseCharacters = 'abcdefghijklmnopqrstuvwxyz';
  const numbers = '0123456789';
  const specialCharacters = '!@#\$%^&*()_+';
  var characters = oneSmallCaseLetter ? lowerCaseCharacters : '';
  characters += oneUpperCaseLetter ? upperCaseCharacters : '';
  characters += oneNumber ? numbers : '';
  characters += oneSpecialCharacter ? specialCharacters : '';
  String password = '';
  for (int i = 0; i < length; i++) {
    password += characters[
        // Generate a random password
        random.nextInt(characters.length)];
  }
  //Check if all conditions are met
  if (oneSmallCaseLetter) {
    bool presentOnce = false;
    for (int i = 0; i < lowerCaseCharacters.length; i++) {
      if (password.contains(lowerCaseCharacters[i])) {
        presentOnce = true;
        break;
      }
    }
    if (!presentOnce) {
      return processPassword(
          key: key,
          length: length,
          oneSmallCaseLetter: oneSmallCaseLetter,
          oneUpperCaseLetter: oneUpperCaseLetter,
          oneNumber: oneNumber,
          oneSpecialCharacter: oneSpecialCharacter);
    }
  }
  if (oneUpperCaseLetter) {
    bool presentOnce = false;
    for (int i = 0; i < upperCaseCharacters.length; i++) {
      if (password.contains(upperCaseCharacters[i])) {
        presentOnce = true;
        break;
      }
    }
    if (!presentOnce) {
      return processPassword(
          key: key,
          length: length,
          oneSmallCaseLetter: oneSmallCaseLetter,
          oneUpperCaseLetter: oneUpperCaseLetter,
          oneNumber: oneNumber,
          oneSpecialCharacter: oneSpecialCharacter);
    }
  }
  if (oneNumber) {
    bool presentOnce = false;
    for (int i = 0; i < numbers.length; i++) {
      if (password.contains(numbers[i])) {
        presentOnce = true;
        break;
      }
    }
    if (!presentOnce) {
      return processPassword(
          key: key,
          length: length,
          oneSmallCaseLetter: oneSmallCaseLetter,
          oneUpperCaseLetter: oneUpperCaseLetter,
          oneNumber: oneNumber,
          oneSpecialCharacter: oneSpecialCharacter);
    }
  }
  if (oneSpecialCharacter) {
    bool presentOnce = false;
    for (int i = 0; i < specialCharacters.length; i++) {
      if (password.contains(specialCharacters[i])) {
        presentOnce = true;
        break;
      }
    }
    if (!presentOnce) {
      return processPassword(
          key: key,
          length: length,
          oneSmallCaseLetter: oneSmallCaseLetter,
          oneUpperCaseLetter: oneUpperCaseLetter,
          oneNumber: oneNumber,
          oneSpecialCharacter: oneSpecialCharacter);
    }
  }

  String dateTime = DateTime.now().toString();
  var keyToSave = key.trim().isNotEmpty ? key : dateTime;

  var passwordToLog = PasswordModel(key: keyToSave, password: password);

  addPassword(passwordToLog);
  if (kDebugMode) {
    print(password);
  }
  return password;
}
