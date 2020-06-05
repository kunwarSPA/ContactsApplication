import 'package:assignment2/DictionaryModel.dart';
import 'package:assignment2/complete_list/VisibilityFilter.dart';
import 'package:equatable/equatable.dart';

abstract class CompleteEvent extends Equatable {
  const CompleteEvent();
}

class CompleteListUpdated extends CompleteEvent {
  final VisibilityFilter filter;

  const CompleteListUpdated(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'FilterUpdated { filter: $filter }';
}

class BlocUpdated extends CompleteEvent {
  final List<DictionaryModel> todos;

  const BlocUpdated(this.todos);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'BlocUpdated { todos: $todos }';
}
