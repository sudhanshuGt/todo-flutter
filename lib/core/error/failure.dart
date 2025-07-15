abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  final int? code;
  const ServerFailure(String msg, {this.code}) : super(msg);
}

class CacheFailure extends Failure {
  const CacheFailure(String msg) : super(msg);
}
