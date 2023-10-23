import 'package:nomadworld/data/models/user.dart';
import 'package:nomadworld/data/repositories/user_repository.dart';

class RegisterUserUseCase {
  final UserRepository userRepository;

  RegisterUserUseCase(this.userRepository);

  Future<void> execute({
    required String username,
    required String email,
    required String password,
    required String repeatPassword,
  }) async {
    // Here, we validate the data that the user entered
    if (password != repeatPassword) {
      throw Exception('Las contraseñas no coinciden');
    }

    // Here, we create the user object
    final user = User(username: username, email: email, password: password, image: '');
    await userRepository.registerUser(user);

    // Registro exitoso
  }
}
