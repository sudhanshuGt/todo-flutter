import '../repositories/auth_repository.dart';
import '../entities/token.dart';

class LoginUsecase {
  final AuthRepository repo;
  LoginUsecase(this.repo);
  Future<Token> call(String email, String password) => repo.login(email, password);
}
