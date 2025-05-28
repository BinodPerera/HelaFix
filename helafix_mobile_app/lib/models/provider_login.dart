class ProviderLogin {
  final String email;
  final String hashedPassword;

  ProviderLogin({
    required this.email,
    required this.hashedPassword,
  });

  factory ProviderLogin.fromMap(Map<String, dynamic> provider) {
    return ProviderLogin(
      email: provider['email'],
      hashedPassword: provider['password'],
    );
  }
}
