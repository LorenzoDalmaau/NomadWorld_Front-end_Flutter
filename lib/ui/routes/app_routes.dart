
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:nomadworld/ui/screens/HomeScreen/home_screen.dart';
import 'package:nomadworld/ui/screens/LoginScreen/login_screen.dart';
import 'package:nomadworld/ui/screens/RegisterScreen/register_screen.dart';

class AppRoutes {
  static final List<GetPage> routes = [
    GetPage(name: '/login', page: () => const LoginScreen()),
    GetPage(name: '/register', page: () => RegisterScreen()),
    GetPage(name: '/home', page: () => const HomeScreen()),
  ];
}