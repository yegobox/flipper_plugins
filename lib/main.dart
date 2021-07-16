import 'package:flipper_routing/routes.router.dart';
import 'package:flipper_services/locator.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stacked_services/stacked_services.dart';
// import 'package:flutter_gen/gen_l10n/flipper_localizations.dart'; // Add this line.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  setupLocator();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // home: RootApp(),
    navigatorKey: StackedService.navigatorKey,
    onGenerateRoute: StackedRouter().onGenerateRoute,
  ));
}
