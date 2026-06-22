import 'package:cade_meu_carro/controllers/parking.controller.dart';
import 'package:cade_meu_carro/models/history_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/strings.dart';
import '../widgets/button.dart';
import '../widgets/dropItem.dart';
import '../widgets/sign.dart';

class ParkingView extends StatefulWidget {
  const ParkingView({super.key});

  @override
  State<ParkingView> createState() => ParkingState();
}

class ParkingState extends State<ParkingView> {
  Future<void> _openDialog(
      BuildContext context, ParkingController provider) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.dialogConfirmTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.local_parking, size: 48, color: Colors.white70),
            const SizedBox(height: 16),
            Text(
              '${provider.selectedLetter}${provider.selectedNumber} no ${provider.selectedFloor}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              provider.timeTobeRecorded,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withAlpha(179),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(AppStrings.dialogCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(AppStrings.dialogSave),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final historyItem = HistoryItem(
        description:
            '${provider.selectedLetter}${provider.selectedNumber} no ${provider.selectedFloor}',
        date: provider.timeTobeRecorded,
      );
      provider.saveData(provider.selectedLetter, provider.selectedNumber,
          provider.selectedFloor, provider.timeTobeRecorded);
      provider.addHistoryItem(historyItem);
      provider.setShowSaveButton(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ParkingController>(context);
    final hasSaved = provider.code != null;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 48),
            Text(
              AppStrings.parkingTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    letterSpacing: -1,
                  ),
            ),
            const SizedBox(height: 40),
            if (!provider.isAllInfoFilled() && !hasSaved)
              Row(
                children: [
                  Expanded(
                    child: DropItem(
                      isEnabled: true,
                      dropHint: AppStrings.parkingFloorHint,
                      items: provider.dropdownFloor(),
                      selectedValue: provider.selectedFloor,
                      onChanged: provider.setFloor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropItem(
                      isEnabled: true,
                      dropHint: AppStrings.parkingSectionHint,
                      items: provider.dropdownLetter(),
                      selectedValue: provider.selectedLetter,
                      onChanged: provider.setLetter,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropItem(
                      isEnabled: true,
                      dropHint: AppStrings.parkingNumberHint,
                      items: provider.dropdownNumber(),
                      selectedValue: provider.selectedNumber,
                      onChanged: provider.setNumber,
                    ),
                  ),
                ],
              )
            else
              const SizedBox.shrink(),
            const SizedBox(height: 24),
            Sign(
              isAllInfoFilled: provider.isAllInfoFilled(),
              selectedFloor: provider.selectedFloor,
              selectedLetter: provider.selectedLetter,
              selectedNumber: provider.selectedNumber,
              code: provider.code,
              timeStamp: provider.timeStamp ?? provider.timeTobeRecorded,
            ),
            const Spacer(),
            Button(
              showButton:
                  provider.isAllInfoFilled() && provider.showSaveButton,
              onPressed: () => _openDialog(context, provider),
              text: AppStrings.buttonSave,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Button(
              showButton: true,
              onPressed: () {
                provider.reset();
                provider.removeDataFromStorage();
              },
              text: AppStrings.buttonReset,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
