import '../repositories/auth_repository.dart';
import '../entities/token.dart';

class SignupUsecase {
  final AuthRepository repo;
  SignupUsecase(this.repo);
  Future<Token> call(String name, String email, String password) =>
      repo.signUp(name, email, password);
}
