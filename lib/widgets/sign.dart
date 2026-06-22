import 'package:flutter/material.dart';

import '../utils/strings.dart';

class Sign extends StatelessWidget {
  const Sign({
    super.key,
    required this.isAllInfoFilled,
    required this.selectedLetter,
    required this.selectedNumber,
    required this.selectedFloor,
    required this.code,
    required this.timeStamp,
  });

  final bool isAllInfoFilled;
  final String? selectedLetter;
  final String? selectedNumber;
  final String? selectedFloor;
  final String? code;
  final String? timeStamp;

  @override
  Widget build(BuildContext context) {
    if (!isAllInfoFilled && code == null) {
      return const SizedBox.shrink();
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.secondary.withAlpha(179),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary.withAlpha(51),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.local_parking,
            size: 32,
            color: Colors.white.withAlpha(200),
          ),
          const SizedBox(height: 16),
          Text(
            code ??
                '$selectedLetter$selectedNumber no $selectedFloor',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 52,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(40),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${AppStrings.signTimeLabel} $timeStamp',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
