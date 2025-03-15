class RegistrationField {
  final String id;
  final String label;
  final String type;
  final bool required;
  final dynamic defaultValue;
  final List<String>? options;
  final String? hint;
  final String? validationRegex;

  const RegistrationField({
    required this.id,
    required this.label,
    required this.type,
    this.required = false,
    this.defaultValue,
    this.options,
    this.hint,
    this.validationRegex,
  });

  factory RegistrationField.fromJson(Map<String, dynamic> json) => RegistrationField(
    id: json['id'],
    label: json['label'],
    type: json['type'],
    required: json['required'] ?? false,
    defaultValue: json['default_value'],
    options: (json['options'] as List<dynamic>?)?.cast<String>(),
    hint: json['hint'],
    validationRegex: json['validation_regex'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'type': type,
    'required': required,
    'default_value': defaultValue,
    'options': options,
    'hint': hint,
    'validation_regex': validationRegex,
  };
}