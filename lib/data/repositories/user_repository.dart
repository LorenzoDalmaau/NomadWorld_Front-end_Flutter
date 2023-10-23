import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:nomadworld/data/data_provider/api_provider.dart';
import 'package:nomadworld/data/models/user.dart';

class UserRepository {
  final ApiProvider apiProvider;

  UserRepository(this.apiProvider);

  Future<void> registerUser(User user) async {
    try {
      final userData = {
        'username' : user.username,
        'email' : user.email,
        'password' : user.password,
        'image' : user.image,
      };

      final response = await apiProvider.registerUser(userData);

      if (response.statusCode == 200) {
        Get.snackbar('Exito', 'Usuario registrado correctamente');
        Get.offNamed('/login');
      }
    } catch (e) {
      throw Exception('Error al registrar usuario: $e');
    }
  }
}
