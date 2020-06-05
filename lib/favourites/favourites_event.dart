import 'package:assignment2/DictionaryModel.dart';
import 'package:equatable/equatable.dart';

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();
}

class FavouritesUpdated extends FavouritesEvent {
  final List<DictionaryModel> todos;

  const FavouritesUpdated(this.todos);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'UpdateStats { todos: $todos }';
}
