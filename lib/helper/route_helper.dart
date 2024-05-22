import 'package:fourfiles/view/screens/more/widget/category_types_screen.dart';
import 'package:fourfiles/view/screens/more/widget/create_category_screen.dart';
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

  static const String categorytypelist = '/categorytypelist';
  static const String createcategory = '/createcategory';

  static getInitialRoute() => initial;
  static getSplashRoute() => splash;
  static getAuthRoute(String name) => '$auth?name=$name';
  static getRegisterRoute(String name) => '$register?name=$name';
  static getDashboardRoute(String name) => '$dashboard?name=$name';

  static getCategoryTypeListRoute(String name) => '$dashboard?name=$name';
  static getCreateCatetoryRoute(String name) => '$createcategory?name=$name';

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
    GetPage(
      name: categorytypelist,
      page: () => const CategoryTypesListScreen(),
      transition: Transition.cupertinoDialog,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: createcategory,
      page: () => const CreateCategoryScreen(),
      transition: Transition.cupertinoDialog,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
