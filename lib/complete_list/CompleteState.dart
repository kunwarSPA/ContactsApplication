import 'package:assignment2/DictionaryModel.dart';
import 'package:assignment2/complete_list/VisibilityFilter.dart';
import 'package:equatable/equatable.dart';

abstract class CompleteState extends Equatable {
  const CompleteState();

  @override
  List<Object> get props => [];
}

class CompleteListLoadInProgress extends CompleteState {}

class CompleteListLoadSuccess extends CompleteState {
  final List<DictionaryModel> filteredTodos;
  final VisibilityFilter activeFilter;

  const CompleteListLoadSuccess(
    this.filteredTodos,
    this.activeFilter,
  );

  @override
  List<Object> get props => [filteredTodos, activeFilter];

  @override
  String toString() {
    return 'FilteredTodosLoadSuccess { filteredTodos: $filteredTodos, activeFilter: $activeFilter }';
  }
}
