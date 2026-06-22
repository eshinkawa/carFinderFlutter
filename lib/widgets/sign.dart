import 'package:flutter/material.dart';

import '../utils/strings.dart';

class Sign extends StatefulWidget {
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
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  bool _wasVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scale = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _fade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.6, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visible = widget.isAllInfoFilled || widget.code != null;

    if (visible && !_wasVisible) {
      _controller.forward(from: 0);
    } else if (!visible && _wasVisible) {
      _controller.reverse();
    }
    _wasVisible = visible;

    if (!visible) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Opacity(
        opacity: _fade.value,
        child: Transform.scale(
          scale: 0.8 + (0.2 * _scale.value),
          child: child,
        ),
      ),
      child: Container(
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
              widget.code ??
                  '${widget.selectedLetter}${widget.selectedNumber} no ${widget.selectedFloor}',
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(40),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${AppStrings.signTimeLabel} ${widget.timeStamp}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
