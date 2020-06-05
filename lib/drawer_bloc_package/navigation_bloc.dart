import 'dart:async';

import 'package:assignment2/drawer_bloc_package/navigation_provider.dart';

class NavigationDrawerBloc {
  final navigationController = StreamController();
  NavigationProvider navigationProvider = new NavigationProvider();

  Stream get getNavigation => navigationController.stream;

  void updateNavigation(String navigation) {
    navigationProvider.updateNavigation(navigation);
    navigationController.sink.add(navigationProvider.currentNavigation);
  }

  void dispose() {
    navigationController.close();
  }
}

final bloc = NavigationDrawerBloc();
