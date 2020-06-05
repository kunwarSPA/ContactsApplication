import 'dart:async';

import 'package:assignment2/drawer/drawer.dart';
import 'package:assignment2/drawer/drawerTab.dart';
import 'package:bloc/bloc.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerTab> {
  @override
  DrawerTab get initialState => DrawerTab.todos;

  @override
  Stream<DrawerTab> mapEventToState(DrawerEvent event) async* {
    if (event is DrawerUpdated) {
      yield event.tab;
    }
  }
}
