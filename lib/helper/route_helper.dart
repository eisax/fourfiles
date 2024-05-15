import 'package:get/get.dart';
import 'package:fourfiles/view/screens/mainnavigation/navigation_bar_screen.dart';
import 'package:fourfiles/view/screens/auth/widgets/signinscreen.dart';
import 'package:fourfiles/view/screens/auth/widgets/signupscreen.dart';
import 'package:fourfiles/view/screens/splash/splashscreen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String auth = '/auth';
  static const String register = '/register';
  static const String dashboard = '/dashboard';
  static const String surveyslist = '/surveyslist';
  static const String addsurveyquestion = '/addsurveyquestion';
  static const String createsurvey = '/createsurvey';
  static const String profile = '/profile';
  static const String createsurveydashboard = '/createsurveydashboard';
  static const String conductsurvey = '/conductsurvey';

  static const String sharesurvey = '/sharesurvey';
  static const String viewsurveyform = '/viewsurveyform';
  static const String viewsurveyresponses = '/viewsurveyresponses';
  static const String collectsurveyresponses = '/collectsurveyresponses';

  static getInitialRoute() => initial;
  static getSplashRoute() => splash;
  static getAuthRoute(String name) => '$auth?name=$name';
  static getRegisterRoute(String name) => '$register?name=$name';
  static getDashboardRoute(String name) => '$dashboard?name=$name';
  static getsurveyslistRoute(String name) => '$surveyslist?name=$name';
  static getAddsurveyquestionRoute(String name) =>
      '$addsurveyquestion?name=$name';
  static getCreatesurveyRoute(String name) => '$createsurvey?name=$name';
  static getProfileRoute(String name) => '$profile?name=$name';
  static getCreateSurveyDashboardRoute(String name) =>
      '$createsurveydashboard?name=$name';
  static getConductSurveyRoute(String name) => '$conductsurvey?name=$name';

  static getCollectSurveyResponsesRoute(String name) =>
      '$collectsurveyresponses?name=$name';
  static getShareSurveyResponsesRoute(String name) =>
      '$viewsurveyresponses?name=$name';
  static getViewSurveyFormRoute(String name) => '$viewsurveyform?name=$name';
  static getShareSurveyFormRoute(String name) => '$sharesurvey?name=$name';

  static List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: auth,
      page: () => const SignInScreen(),
      transition: Transition.cupertinoDialog,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: register,
      page: () => const SignUpScreen(),
      transition: Transition.cupertinoDialog,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: dashboard,
      page: () => const MainNavigationBar(),
      transition: Transition.cupertinoDialog,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
