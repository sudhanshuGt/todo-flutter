import '../../core/error/exceptions.dart';
import '../../domain/entities/token.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_datesource.dart';

/// Implementation of [AuthRepository] that handles user authentication.
///
/// Uses a remote data source ([AuthRemoteDatasource]) to perform actual API calls
/// and maps data models to domain entities ([Token]).
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remote;

  /// Constructor injecting the remote datasource.
  AuthRepositoryImpl(this.remote);

  /// Registers a new user with [name], [email], and [password].
  ///
  /// Returns a [Token] on successful signup.
  /// Throws a [ServerException] if any error occurs during the remote call.
  @override
  Future<Token> signUp(String name, String email, String password) async {
    try {
      final model = await remote.signUp(
        name: name,
        email: email,
        password: password,
      );
      // Map remote model to domain entity
      return Token(model.token);
    } on Exception catch (e) {
      // Wrap and rethrow as a domain-specific exception
      throw ServerException(e.toString());
    }
  }

  /// Logs in a user with [email] and [password].
  ///
  /// Returns a [Token] on successful login.
  /// Throws a [ServerException] if any error occurs during the remote call.
  @override
  Future<Token> login(String email, String password) async {
    try {
      final model = await remote.login(
        email: email,
        password: password,
      );
      // Map remote model to domain entity
      return Token(model.token);
    } on Exception catch (e) {
      // Wrap and rethrow as a domain-specific exception
      throw ServerException(e.toString());
    }
  }
}
