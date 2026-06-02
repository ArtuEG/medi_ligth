/// Entidad de dominio: usuario del personal de enfermería.
///
/// Struct puro, sin dependencias de framework ni de serialización.
class User {
  const User({
    required this.id,
    required this.fullName,
    required this.email,
  });

  final String id;
  final String fullName;
  final String email;
}
