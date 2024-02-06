import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:nomadworld/ui/screens/HomeScreen/home_screen.dart';
import 'package:nomadworld/ui/screens/LocationDetailScreen/LocationDetail.dart';
import 'package:nomadworld/ui/screens/LoginScreen/login_screen.dart';
import 'package:nomadworld/ui/screens/RegisterScreen/register_screen.dart';
import 'package:nomadworld/ui/screens/countri_screen/contri_screen.dart';
import 'package:nomadworld/ui/widgets/navigation/bottom_nav.dart';
import '../screens/CreateIL/create_il.dart';
import '../screens/RouteScreen/RouteScreen.dart';
import '../screens/create_location/create_location.dart';
import '../screens/create_route/create_route.dart';
import '../screens/searchbar_screen/searchbar_screen.dart';

class AppRoutes {
  static final List<GetPage> routes = [
    GetPage(name: '/navigation', page: () => const BottomNav()),
    GetPage(name: '/login', page: () => const LoginScreen()),
    GetPage(name: '/register', page: () => const RegisterScreen()),
    GetPage(name: '/home', page: () => HomeScreen()),
    GetPage(name: '/create-il', page: () => const CreateIL()),
    GetPage(name: '/create_route', page: () => const CreateRoute()),
    GetPage(name: '/create_location', page: () => const CreateLocation()),
    GetPage(name: '/route', page: () => RouteScreen()),
    GetPage(name: '/location', page: () => LocationDetail()),
    GetPage(name: '/country', page: () => CountriScreen()),
    GetPage(name: '/searchbar', page: () => const SearchBarScreen()),
  ];
}