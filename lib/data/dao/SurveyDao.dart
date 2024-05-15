import 'package:floor/floor.dart';
import 'package:fourfiles/data/model/response/survey.dart';

@dao
abstract class SurveyModelDao {
  @Query('SELECT * FROM ${SurveyModel.tableName} WHERE id = :id')
  Future<SurveyModel?> findById(int id);

  @Query('SELECT COUNT(id) FROM ${SurveyModel.tableName}')
  Future<int?> getCount();

  @Query('SELECT * FROM ${SurveyModel.tableName} WHERE name = :search')
  Future<List<SurveyModel>?> searchPattern(String search);

  // @Query('UPDATE ${SurveyModel.tableName} SET isCurrentlyActive = 0')
  // Future<int?> setAllToInactive();

  @Query('SELECT * FROM ${SurveyModel.tableName}')
  Future<List<SurveyModel>> findAll();

  @Query('SELECT * FROM ${SurveyModel.tableName}')
  Stream<List<SurveyModel>> findAllStream();

  @Query('DELETE FROM ${SurveyModel.tableName}')
  Future<void> deleteAll();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertTransaction(SurveyModel transaction);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertTransactions(List<SurveyModel> transactions);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updateTransaction(SurveyModel transaction);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updateTransactions(List<SurveyModel> transactions);

  @delete
  Future<void> deleteTransaction(SurveyModel transaction);

  @delete
  Future<int> deleteTransactions(List<SurveyModel> transactions);
}
