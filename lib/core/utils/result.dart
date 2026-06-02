import '../error/failure.dart';

/// Resultado de una operación que puede fallar, sin lanzar excepciones.
///
/// Permite a la capa de presentación manejar éxito/error de forma exhaustiva:
/// ```dart
/// switch (result) {
///   case Ok(:final value): // ...
///   case Err(:final failure): // ...
/// }
/// ```
sealed class Result<T> {
  const Result();
}

class Ok<T> extends Result<T> {
  const Ok(this.value);
  final T value;
}

class Err<T> extends Result<T> {
  const Err(this.failure);
  final Failure failure;
}
