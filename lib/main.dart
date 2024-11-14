import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(callbackDispatcher);
  await Workmanager().registerPeriodicTask(
    "countdown_updater",
    "updateCountdown",
    frequency: const Duration(hours: 1),
  );
  runApp(const MaterialApp(home: SizedBox()));
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await updateWidget();
    return Future.value(true);
  });
}

Future<void> updateWidget() async {
  final targetDate = DateTime(2025, 1, 1); // Change this to your target date
  final now = DateTime.now();
  final daysRemaining = targetDate.difference(now).inDays;
  
  await HomeWidget.saveWidgetData('days_remaining', daysRemaining);
  await HomeWidget.updateWidget(
    name: 'CountdownWidgetProvider',
    androidName: 'CountdownWidgetProvider',
    iOSName: 'CountdownWidget',
  );
}