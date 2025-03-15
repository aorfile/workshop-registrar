import 'package:flutter/material.dart';
import 'package:frontend/models/registration_field.dart';

class AddRegistrationFieldDialog extends StatefulWidget {
  final void Function(RegistrationField) onAdd;

  const AddRegistrationFieldDialog({
    super.key,
    required this.onAdd,
  });

  @override
  State<AddRegistrationFieldDialog> createState() => _AddRegistrationFieldDialogState();
}

class _AddRegistrationFieldDialogState extends State<AddRegistrationFieldDialog> {
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();
  final _hintController = TextEditingController();
  final _optionController = TextEditingController();
  final _optionsScrollController = ScrollController();
  String _selectedType = 'text';
  bool _isRequired = false;
  final List<String> _options = [];
  bool _isAddingOption = false;

  final _fieldTypes = [
    'text',
    'textarea',
    'number',
    'select',
    'checkbox',
    'date',
    'email',
    'url',
  ];

  @override
  void dispose() {
    _labelController.dispose();
    _hintController.dispose();
    _optionController.dispose();
    _optionsScrollController.dispose();
    super.dispose();
  }

  void _addOption() {
    final option = _optionController.text.trim();
    if (option.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter an option text before adding'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    
    if (_options.contains(option)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This option already exists'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _options.add(option);
      _optionController.clear();
      _isAddingOption = false;
    });

    // Scroll to bottom after adding new option
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_optionsScrollController.hasClients) {
        _optionsScrollController.animateTo(
          _optionsScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _removeOption(int index) {
    setState(() {
      _options.removeAt(index);
    });
  }

  Widget _buildOptionsList() {
    if (_options.isEmpty && !_isAddingOption) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'No options added yet',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: () {
                  setState(() {
                    _isAddingOption = true;
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('Add First Option'),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        if (_isAddingOption || _options.isNotEmpty)
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _optionController,
                  decoration: const InputDecoration(
                    labelText: 'Add Option',
                    hintText: 'Enter option text',
                    helperText: 'Press Enter or click + to add',
                    errorMaxLines: 2,
                  ),
                  onFieldSubmitted: (_) => _addOption(),
                  validator: (value) {
                    if (_selectedType == 'select' && _options.isEmpty) {
                      return 'At least one option is required for select fields';
                    }
                    return null;
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: _addOption,
              ),
            ],
          ),
        if (_options.isNotEmpty) ...[
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 200,
              minHeight: 100,
            ),
            child: Card(
              child: ListView.separated(
                controller: _optionsScrollController,
                padding: const EdgeInsets.all(8),
                itemCount: _options.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return ListTile(
                    dense: true,
                    title: Text(_options[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () => _removeOption(index),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 400,
          maxHeight: 600,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Add Registration Field',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _labelController,
                          decoration: const InputDecoration(
                            labelText: 'Field Label',
                            hintText: 'Enter field label',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a label';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedType,
                          decoration: const InputDecoration(
                            labelText: 'Field Type',
                          ),
                          items: _fieldTypes.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedType = value!;
                              if (value != 'select') {
                                _options.clear();
                                _isAddingOption = false;
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _hintController,
                          decoration: const InputDecoration(
                            labelText: 'Help Text',
                            hintText: 'Enter help text for users',
                          ),
                        ),
                        const SizedBox(height: 16),
                        CheckboxListTile(
                          title: const Text('Required Field'),
                          value: _isRequired,
                          contentPadding: EdgeInsets.zero,
                          onChanged: (value) {
                            setState(() {
                              _isRequired = value ?? false;
                            });
                          },
                        ),
                        if (_selectedType == 'select') ...[
                          const SizedBox(height: 16),
                          _buildOptionsList(),
                        ],
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_selectedType == 'select' && _options.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please add at least one option for select field'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          return;
                        }

                        final field = RegistrationField(
                          id: _labelController.text.toLowerCase().replaceAll(' ', '_'),
                          label: _labelController.text,
                          type: _selectedType,
                          required: _isRequired,
                          hint: _hintController.text.isEmpty ? null : _hintController.text,
                          options: _selectedType == 'select' ? List<String>.from(_options) : null,
                        );

                        widget.onAdd(field);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Add Field'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}