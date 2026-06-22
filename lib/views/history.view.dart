import 'package:cade_meu_carro/controllers/parking.controller.dart';
import 'package:cade_meu_carro/models/history_item.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../utils/strings.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView>
    with TickerProviderStateMixin {
  final Map<int, AnimationController> _itemControllers = {};
  final Map<int, Animation<double>> _itemAnimations = {};

  @override
  void dispose() {
    for (final c in _itemControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _animateItem(int index) {
    final controller = _itemControllers.putIfAbsent(
      index,
      () => AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ),
    );
    _itemAnimations.putIfAbsent(
      index,
      () => CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutCubic,
      ),
    );
    Future.delayed(Duration(milliseconds: 50 * index), () {
      if (mounted) controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ParkingController>(context);
    return ValueListenableBuilder(
      valueListenable: provider.historyListenable,
      builder: (context, Box<HistoryItem> box, _) {
        if (box.values.isEmpty) {
          return SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: child,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 64,
                        color: Colors.white.withAlpha(77),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppStrings.historyEmpty,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your saved parking spots will appear here',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.white.withAlpha(100)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Text(
                  '${box.values.length} saved',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white54),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: box.values.length,
                  itemBuilder: (context, index) {
                    final item = box.getAt(index);
                    if (item == null) return const SizedBox.shrink();

                    _animateItem(index);

                    final animation = _itemAnimations[index];
                    if (animation == null) return const SizedBox.shrink();

                    return AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) => SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.3, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      ),
                      child: Dismissible(
                        key: ValueKey(item.date),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 24),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.error,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child:
                              const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) =>
                            provider.deleteHistoryItem(index),
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withAlpha(51),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.local_parking,
                                    color: Colors.white70,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.description,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item.date,
                                        style: TextStyle(
                                          color: Colors.white.withAlpha(153),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
