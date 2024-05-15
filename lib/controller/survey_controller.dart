import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fourfiles/data/api/api_client.dart';
import 'package:fourfiles/data/model/response/survey.dart';
import 'package:get/get.dart';
import 'package:fourfiles/data/repository/survey_repo.dart';
import 'package:fourfiles/view/widgets/dialog_helper.dart';
import 'package:fourfiles/view/widgets/error_widget.dart';
import 'package:fourfiles/view/widgets/loading_widget.dart';

class SurveyController extends GetxController implements GetxService {
  SurveyRepo surveyRepo;
  final ApiClient apiClient;
  SurveyController({
    required this.apiClient,
    required this.surveyRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<SurveyModel> _survey = [];
  List<SurveyModel> get survey => _survey;

  SurveyModel _mysurvey = SurveyModel();
  SurveyModel get mysurvey => _mysurvey;

  Future<void> emptySurvey() async {
    _mysurvey = SurveyModel();
    update();
  }

  int generateRandomFiveDigitId() {
    Random random = Random();
    int min = 10000;
    int max = 99999;
    return min + random.nextInt(max - min);
  }

  void addQuestion(String questionType) {
    _mysurvey.questions ??= [];

    _mysurvey.questions?.add(
      Question(
        id: generateRandomFiveDigitId(),
        question: "",
        questionType: questionType,
        description: "",
        answers: [],
      ),
    );
    update();
  }

  void updateQuestion({required String question, required int id}) {
    for (int i = 0; i < _mysurvey.questions!.length; i++) {
      if (_mysurvey.questions![i].id == id) {
        _mysurvey.questions![i].question = question;
        break;
      }
    }
    update();
  }

  void deleteQuestion({required int questionid}) {
    if (_mysurvey.questions != null) {
      for (int i = 0; i < _mysurvey.questions!.length; i++) {
        if (_mysurvey.questions![i].id == questionid) {
          _mysurvey.questions?.removeAt(i);
          break;
        }
      }
    }
    update();
  }

  bool validateSurveyForm(BuildContext context) {
    bool isAnyQuestionEmpty = false;

    if (_mysurvey.questions != null) {
      for (int i = 0; i < _mysurvey.questions!.length; i++) {
        if (_mysurvey.questions![i].question.length < 3 ||
            _mysurvey.questions![i].question.isEmpty) {
          isAnyQuestionEmpty = true;
          break;
        }
      }
    } else {
      isAnyQuestionEmpty = true;
    }

    update();

    if (_mysurvey.title == null || _mysurvey.title!.isEmpty) {
      DialogHelper.showGeneralDialog(
        context,
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ErrorWarningWidget(
                title: 'Title is Required',
                subtitle: 'Please enter form title before submitting',
                onTap: () {
                  Get.back();
                },
              )
            ],
          ),
        ),
      );

      return false;
    } else if (isAnyQuestionEmpty) {
      DialogHelper.showGeneralDialog(
        context,
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ErrorWarningWidget(
                title: 'Questions are Required',
                subtitle: 'Please add questions before you proceed',
                onTap: () {
                  Get.back();
                },
              )
            ],
          ),
        ),
      );
      return false;
    }

    return true;
  }

  Future<bool> fetchSurveyOffline(BuildContext context) async {
    _isLoading = true;

    update();

    try {
      _survey = await surveyRepo.getSurveyListOffline();

      update();
      return true;
    } catch (e) {
      update();
      return false;
    }
  }

  Future<bool> fetchSurveyByIdOffline(BuildContext context,
      {required int id}) async {
    try {
      _mysurvey = await surveyRepo.getSurveyOffline(id) ?? _mysurvey;
     
      update();
      return true;
    } catch (e) {
      update();
      return false;
    }
  }

  Future<bool> inistializeSurvey(BuildContext context) async {
    _isLoading = true;
    _survey = [];
    update();

    Response? response = await surveyRepo.getSurveyList(apiClient: apiClient);

    if (response?.statusCode == 201) {
      final responseData = response?.body;

      if (responseData != null) {
        if (responseData['data'] != null && responseData['data'] is List) {
          _survey = (responseData['data'] as List)
              .map((model) => SurveyModel.fromJson(model))
              .toList();
        }
      }

      _isLoading = false;
      update();
      return true;
    } else {
      _isLoading = false;
      update();
      return false;
    }
  }

  void saveSurvey(BuildContext context) async {
    loadingDialog(context);
    try {
      // await surveyRepo.saveSurveyOffline(survey: mysurvey).then((value) => {
      //       Navigator.of(context).pop(),
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => ShareSurveyScreen(
      //             surveyId: value,
      //           ),
      //         ),
      //       )
      //     });
    } catch (e) {}
    update();
  }

  void loadingDialog(BuildContext context) {
    DialogHelper.showGeneralDialog(
      context,
      child: GestureDetector(
        onTap: () => Get.back(),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [LoadingWidget()],
        ),
      ),
    );
  }
}
