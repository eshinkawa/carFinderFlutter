import 'package:flutter/material.dart';

class DropItem extends StatelessWidget {
  const DropItem({
    super.key,
    required this.isEnabled,
    required this.onChanged,
    required this.items,
    required this.selectedValue,
    required this.dropHint,
  });

  final bool isEnabled;
  final ValueChanged<String?>? onChanged;
  final List<DropdownMenuItem<String>> items;
  final String? selectedValue;
  final String dropHint;

  @override
  Widget build(BuildContext context) {
    if (!isEnabled) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary.withAlpha(179),
        borderRadius: BorderRadius.circular(14),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          items: items,
          value: selectedValue,
          dropdownColor: Theme.of(context).colorScheme.tertiary,
          isExpanded: true,
          icon: const Icon(Icons.expand_more, color: Colors.white70),
          hint: Text(
            dropHint,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'IBMPlexSans',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white.withAlpha(179),
            ),
          ),
          style: const TextStyle(
            fontFamily: 'IBMPlexSans',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
