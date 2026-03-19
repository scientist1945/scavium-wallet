class SendValidationResult {
  final bool isValid;
  final String? error;

  const SendValidationResult({required this.isValid, this.error});

  const SendValidationResult.valid() : isValid = true, error = null;

  const SendValidationResult.invalid(this.error) : isValid = false;
}
