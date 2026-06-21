sealed class SignException implements Exception {}

class UnauthorizedTokenException extends SignException {}

class AgeLimitException extends SignException {}

class TypeMisMatchException extends SignException {}
