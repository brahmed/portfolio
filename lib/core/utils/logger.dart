import 'dart:developer' as dev;

/// Logs an informational message.
void logInfo(String message, {String name = 'portfolio'}) =>
    dev.log(message, name: name);

/// Logs an error with full context for debugging.
void logError(
  String message, {
  required Object error,
  required StackTrace stackTrace,
  String name = 'portfolio',
}) =>
    dev.log(
      message,
      name: name,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
