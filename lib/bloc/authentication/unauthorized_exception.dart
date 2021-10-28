class UnauthorizedException implements Exception {
  final String cause;
  const UnauthorizedException(this.cause);
}