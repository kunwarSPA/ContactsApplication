import 'package:assignment2/DictionaryModel.dart';
import 'package:equatable/equatable.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();

  @override
  List<Object> get props => [];
}

class FavouritesLoadInProgress extends FavouritesState {}

class FavouritesLoadSuccess extends FavouritesState {
  final List<DictionaryModel> dictionaryListFavourites;

  const FavouritesLoadSuccess(this.dictionaryListFavourites);

  @override
  List<Object> get props => [dictionaryListFavourites];

  @override
  String toString() {
    return 'StatsLoadSuccess { numActive: $dictionaryListFavourites }';
  }
}
