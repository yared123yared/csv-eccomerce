import 'package:app/Widget/clients/client_profile/search_bar.dart';
import 'package:flutter/material.dart';

class TableHeader extends StatelessWidget {
  final int start;
  final int end;
  final int total;
  TableHeader({
    required this.start,
    required this.end,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Showing ${this.start} to ${this.end} of ${this.total} ${this.start}',
        ),
        SearchBar(),

      ],
    );
  }
}
