
import '../../core/error/exceptions.dart';
import '../../domain/entities/token.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_datesource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remote;
  AuthRepositoryImpl(this.remote);

  @override
  Future<Token> signUp(String name, String email, String password) async {
    try {
      final model =
      await remote.signUp(name: name, email: email, password: password);
      return Token(model.token);
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Token> login(String email, String password) async {
    try {
      final model =
      await remote.login(email: email, password: password);
      return Token(model.token);
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }
}
