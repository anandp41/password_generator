// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;
import '../model/data_model.dart';

ValueNotifier<List<PasswordModel>> passwordLogNotifier = ValueNotifier([]);
late Database _db;

Future<void> initializeDataBase() async {
  io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, 'passwordlogs.db');
  _db = await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE passwordlogs (key TEXT PRIMARY KEY,password TEXT)');
    },
  );
  getAllPasswords();
}

Future<void> addPassword(PasswordModel value) async {
  _db.rawInsert('INSERT INTO passwordlogs (key,password) VALUES (?,?)', [
    value.key,
    value.password,
  ]);

  await getAllPasswords();
}

Future<void> getAllPasswords() async {
  final values = await _db.rawQuery('SELECT * FROM passwordlogs');

  passwordLogNotifier.value.clear();
  passwordLogNotifier.notifyListeners();
  for (var map in values) {
    final password = PasswordModel.fromMap(map);
    passwordLogNotifier.value.add(password);
  }
  passwordLogNotifier.value = passwordLogNotifier.value.reversed.toList();
  passwordLogNotifier.notifyListeners();
}

Future<PasswordModel> getThisPassword(String key) async {
  PasswordModel? password;
  final result =
      await _db.rawQuery('SELECT * FROM passwordlogs WHERE key=?', [key]);
  for (var map in result) {
    password = PasswordModel.fromMap(map);
  }
  return password!;
}

Future<void> deleteRow(BuildContext catx, String key) async {
  return showDialog(
      context: catx,
      builder: (ctx1) {
        return AlertDialog(
            title: const Text('Delete'),
            content: const Text("Are you sure to delete?"),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      Navigator.pop(catx);
                      await _db.rawDelete(
                          'DELETE from passwordlogs where key=?', [key]);
                      getAllPasswords();
                    },
                    icon: const Icon(
                      Icons.check,
                    ),
                    label: const Text('Yes'),
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(catx);
                      },
                      icon: const Icon(Icons.cancel),
                      label: const Text('No'))
                ],
              ),
            ]);
      });
}

Future<void> updateKey({
  required String oldKey,
  required String newKey,
}) async {
  await _db
      .rawUpdate('UPDATE passwordlogs SET key=? WHERE key=$oldKey', [newKey]);
  await getAllPasswords();
}
