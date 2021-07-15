library flipper_routing;

import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'example.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: Example, initial: true),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
  ],
  logger: StackedLogger(),
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}

//  flutter packages pub run build_runner build --delete-conflicting-outputs