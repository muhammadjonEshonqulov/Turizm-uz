class PasswordValidationResult {
  final bool isFilled;
  final bool hasUppercase;
  final bool hasLowercase;
  final bool hasSpecialCharacter;
  final bool isValid;

  PasswordValidationResult({
    required this.isFilled,
    required this.hasUppercase,
    required this.hasLowercase,
    required this.hasSpecialCharacter,
    required this.isValid,
  });
}

PasswordValidationResult validatePassword(String? value) {
  bool isFilled = value != null && value.isNotEmpty;
  bool hasUppercase = value != null && RegExp(r'(?=.*[A-Z])').hasMatch(value);
  bool hasLowercase = value != null && RegExp(r'(?=.*[a-z])').hasMatch(value);
  bool hasSpecialCharacter = value != null && RegExp(r'(?=.*[\W_])').hasMatch(value);

  bool isValid = isFilled && hasUppercase && hasLowercase && hasSpecialCharacter;

  return PasswordValidationResult(
    isFilled: isFilled,
    hasUppercase: hasUppercase,
    hasLowercase: hasLowercase,
    hasSpecialCharacter: hasSpecialCharacter,
    isValid: isValid,
  );
}
