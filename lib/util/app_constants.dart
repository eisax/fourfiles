import 'package:flutter/material.dart';
import 'package:fourfiles/data/model/language_model.dart';

class AppConstants {
  //app data
  static const String appName = 'fourfiles';
  static const String appVersion = '1.0';

  // Shared Key
  static const String theme = 'theme';

  //endpoints
  static const String baseUrl = 'https://0631-41-220-25-58.ngrok-free.app';
  static const String TOKEN = 'token';
  static const String loginUrl = '/api/auth/signin';
  static const String signupUrl = '/api/auth/signup';
  static const String createSurveyUrl = '/api/survey/create-survey';
  static const String getAllSurveysUrl = '/api/survey/fetch-all-surveys';
  static const String getSurveyUrl = '/api/survey/fetch-survey/';
  

  //colors
  static const Color color1 = Color(0xFF312F81);
  static const Color color2 = Color(0xFFFFFFFF);
  static const Color color3 = Color(0xFFA8A8D0);
  static const Color color4 = Color(0xFF6982FA);
  static const Color color5 = Color(0xFF0E0C14);
  static const Color color6 = Color(0xFF0E0C14);
  static const Color color7 = Color(0xFFFF3737);
  static const Color color8 = Color(0xFFF57600);
  static const Color color9 = Color(0xFF00B907);
  static const Color color10 = Color(0xFF0097EC);

  static List<LanguageModel> languages = [
    LanguageModel(
        languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(
        languageName: 'Shona', countryCode: 'ZW', languageCode: 'ar'),
  ];
}
