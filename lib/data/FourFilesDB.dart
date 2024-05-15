// ignore_for_file: unused_import

import 'dart:async';
import 'package:floor/floor.dart';
import 'package:fourfiles/data/dao/SurveyDao.dart';
import 'package:fourfiles/data/model/response/survey.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'FourFilesDB.g.dart';

// @TypeConverters([])
@Database(version: 2, entities: [SurveyModel])
abstract class AppDatabase extends FloorDatabase {
  SurveyModelDao get surveyModelDao;

  static Future<AppDatabase> init() async {
    AppDatabase instance =
        await $FloorAppDatabase.databaseBuilder("fourfilesdb").build();
    return instance;
  }
}
