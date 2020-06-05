import 'package:assignment2/drawer/drawerTab.dart';
import 'package:equatable/equatable.dart';

abstract class DrawerEvent extends Equatable {
  const DrawerEvent();
}

class DrawerUpdated extends DrawerEvent {
  final DrawerTab tab;

  const DrawerUpdated(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'TabUpdated { tab: $tab }';
}
