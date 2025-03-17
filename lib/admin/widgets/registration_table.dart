import 'package:flutter/material.dart';


class RegistrationTable extends StatelessWidget {
  const RegistrationTable({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      columns: [
        DataColumn(label: Text('Student')),
        DataColumn(label: Text('Workshop')),
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('Registered')),
        DataColumn(label: Text('Actions')),
      ],
      source: _RegistrationDataSource(),
      rowsPerPage: 10,
    );
  }
}

class _RegistrationDataSource extends DataTableSource {
  final List<Map<String, dynamic>> _data = List.generate(
    50,
    (index) => {
      'student': 'Student $index',
      'workshop': 'Workshop ${index % 5}',
      'status': index % 3 == 0 ? 'registered' : 'attended',
      'registered': DateTime.now().subtract(Duration(days: index)),
    },
  );

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) return null;
    final item = _data[index];

    return DataRow(
      cells: [
        DataCell(Text(item['student'])),
        DataCell(Text(item['workshop'])),
        DataCell(_buildStatusChip(item['status'])),
        DataCell(Text(item['registered'].toString())),
        DataCell(Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {},
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    final colors = {
      'registered': Colors.blue,
      'attended': Colors.green,
      'no-show': Colors.red,
    };

    return Chip(
      label: Text(
        status,
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: colors[status],
      visualDensity: VisualDensity.compact,
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}