import '../entities/token.dart';

abstract class AuthRepository {
  Future<Token> signUp(String name, String email, String password);
  Future<Token> login(String email, String password);
}
