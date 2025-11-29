class ServerException implements Exception {
  const ServerException([this.message = 'Server error']);

  final String message;

  @override
  String toString() => 'ServerException: $message';
}
