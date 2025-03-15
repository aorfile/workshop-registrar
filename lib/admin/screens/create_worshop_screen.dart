import 'package:flutter/material.dart';
import 'package:frontend/admin/widgets/add_new_registration_field.dart';
import 'package:frontend/models/registration_field.dart';
import 'package:intl/intl.dart';

class CreateWorkshopScreen extends StatefulWidget {
  const CreateWorkshopScreen({super.key});

  @override
  State<CreateWorkshopScreen> createState() => _CreateWorkshopScreenState();
}

class _CreateWorkshopScreenState extends State<CreateWorkshopScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 2);
  final _locationTypes = ['In-Person', 'Virtual', 'Hybrid'];
  String _selectedLocationType = 'In-Person';
  bool _isLoading = false;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _capacityController = TextEditingController();
  final _minParticipantsController = TextEditingController();
  final _prerequisitesController = TextEditingController();
  final _categoryController = TextEditingController();
  final _meetingLinkController = TextEditingController();
  final List<RegistrationField> _registrationFields = [];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _capacityController.dispose();
    _minParticipantsController.dispose();
    _prerequisitesController.dispose();
    _categoryController.dispose();
    _meetingLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Workshop'),
        actions: [
          TextButton.icon(
            onPressed: _isLoading ? null : _saveWorkshop,
            icon: const Icon(Icons.check),
            label: const Text('Create'),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBasicInfo(theme),
                    const SizedBox(height: 32),
                    _buildScheduling(theme),
                    const SizedBox(height: 32),
                    _buildCapacitySection(theme),
                    const SizedBox(height: 32),
                    _buildRegistrationFields(theme),
                    const SizedBox(height: 32),
                    _buildLocationSection(theme),
                    const SizedBox(height: 32),
                    _buildPrerequisites(theme),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildBasicInfo(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basic Information',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: 'Workshop Title',
            hintText: 'Enter a descriptive title',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a title';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            labelText: 'Description',
            hintText: 'Describe what participants will learn',
          ),
          maxLines: 3,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a description';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _categoryController,
          decoration: const InputDecoration(
            labelText: 'Category',
            hintText: 'e.g., Development, Design, DevOps',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a category';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildScheduling(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Schedule',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                controller: TextEditingController(
                  text: DateFormat('MMMM d, y').format(_selectedDate),
                ),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    setState(() => _selectedDate = picked);
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Start Time',
                  suffixIcon: Icon(Icons.access_time),
                ),
                controller: TextEditingController(
                  text: _startTime.format(context),
                ),
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: _startTime,
                  );
                  if (picked != null) {
                    setState(() => _startTime = picked);
                  }
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'End Time',
                  suffixIcon: Icon(Icons.access_time),
                ),
                controller: TextEditingController(
                  text: _endTime.format(context),
                ),
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: _endTime,
                  );
                  if (picked != null) {
                    setState(() => _endTime = picked);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCapacitySection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Capacity',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _capacityController,
                decoration: const InputDecoration(
                  labelText: 'Maximum Participants',
                  hintText: 'Enter maximum capacity',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter maximum capacity';
                  }
                  final number = int.tryParse(value);
                  if (number == null || number <= 0) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _minParticipantsController,
                decoration: const InputDecoration(
                  labelText: 'Minimum Participants',
                  hintText: 'Enter minimum required',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter minimum participants';
                  }
                  final number = int.tryParse(value);
                  if (number == null || number <= 0) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: _selectedLocationType,
          decoration: const InputDecoration(
            labelText: 'Location Type',
          ),
          items: _locationTypes.map((type) {
            return DropdownMenuItem(
              value: type,
              child: Text(type),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedLocationType = value!;
            });
          },
        ),
        const SizedBox(height: 16),
        if (_selectedLocationType != 'Virtual')
          TextFormField(
            controller: _locationController,
            decoration: const InputDecoration(
              labelText: 'Location Address',
              hintText: 'Enter the physical location',
            ),
            validator: (value) {
              if (_selectedLocationType != 'Virtual' &&
                  (value == null || value.isEmpty)) {
                return 'Please enter the location';
              }
              return null;
            },
          ),
        if (_selectedLocationType != 'In-Person')
          Column(
            children: [
              const SizedBox(height: 16),
              TextFormField(
                controller: _meetingLinkController,
                decoration: const InputDecoration(
                  labelText: 'Meeting Link',
                  hintText: 'Enter virtual meeting link',
                ),
                validator: (value) {
                  if (_selectedLocationType != 'In-Person' &&
                      (value == null || value.isEmpty)) {
                    return 'Please enter the meeting link';
                  }
                  return null;
                },
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildPrerequisites(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Prerequisites',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _prerequisitesController,
          decoration: const InputDecoration(
            labelText: 'Prerequisites',
            hintText: 'List any required skills or materials',
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildRegistrationFields(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Registration Fields',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton.icon(
              onPressed: _addRegistrationField,
              icon: const Icon(Icons.add),
              label: const Text('Add Field'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _registrationFields.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final field = _registrationFields[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          field.label,
                          style: theme.textTheme.titleMedium,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _registrationFields.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                    Text(
                      'Type: ${field.type}',
                      style: theme.textTheme.bodyMedium,
                    ),
                    if (field.hint != null)
                      Text(
                        'Hint: ${field.hint}',
                        style: theme.textTheme.bodyMedium,
                      ),
                    Text(
                      'Required: ${field.required ? 'Yes' : 'No'}',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _addRegistrationField() {
    showDialog(
      context: context,
      builder: (context) => AddRegistrationFieldDialog(
        onAdd: (field) {
          setState(() {
            _registrationFields.add(field);
          });
        },
      ),
    );
  }

  Future<void> _saveWorkshop() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final workshop = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'category': _categoryController.text,
        'workshop_date': DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          _startTime.hour,
          _startTime.minute,
        ).toIso8601String(),
        'end_time': DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          _endTime.hour,
          _endTime.minute,
        ).toIso8601String(),
        'location_type': _selectedLocationType,
        'location': _locationController.text,
        'meeting_link': _meetingLinkController.text,
        'capacity': int.parse(_capacityController.text),
        'min_participants': int.parse(_minParticipantsController.text),
        'prerequisites': _prerequisitesController.text,
        'created_by': 'aorfile',
        'created_at': '2025-03-15 14:32:15',
        'registration_fields': _registrationFields.map((f) => f.toJson()).toList(),
      };

      // TODO: Call API to create workshop
      // Show success dialog
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Workshop Created'),
          content: const Text(
            'Your workshop has been created successfully. You can now manage it from the dashboard.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Return to previous screen
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to create workshop: ${e.toString()}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}

