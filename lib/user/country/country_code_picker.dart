import 'package:flutter/material.dart';
import 'country_model.dart';
import 'country_data.dart';

class CountryCodePicker extends StatefulWidget {
  final Function(Country) onChanged;
  final Country initialCountry;

  const CountryCodePicker({
    Key? key,
    required this.onChanged,
    required this.initialCountry,
  }) : super(key: key);

  @override
  _CountryCodePickerState createState() => _CountryCodePickerState();
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.initialCountry;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Country>(
          value: _selectedCountry,
          items:
              countries.map((Country country) {
                return DropdownMenuItem<Country>(
                  value: country,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(country.flag, style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 4),
                      Text(
                        country.dialCode,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              }).toList(),
          onChanged: (Country? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedCountry = newValue;
              });
              widget.onChanged(newValue);
            }
          },
        ),
      ),
    );
  }
}
