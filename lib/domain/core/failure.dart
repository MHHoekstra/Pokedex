sealed class Failure {}

class NotFoundFailure extends Failure {}

class ServerFailure extends Failure {}

class ConnectionFailure extends Failure {}
