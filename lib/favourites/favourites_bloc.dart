import 'dart:async';

import 'package:assignment2/ContactState.dart';
import 'package:assignment2/Contacts_bloc.dart';
import 'package:assignment2/DictionaryModel.dart';
import 'package:assignment2/favourites/favourites.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final ContactsBloc contactBloc;
  StreamSubscription todosSubscription;

  FavouritesBloc({@required this.contactBloc}) {
    todosSubscription = contactBloc.listen((state) {
      if (state is ContactsLoadSuccess) {
        add(FavouritesUpdated(state.contacts));
      }
    });
  }

  @override
  FavouritesState get initialState => FavouritesLoadInProgress();

  @override
  Stream<FavouritesState> mapEventToState(FavouritesEvent event) async* {
    if (event is FavouritesUpdated) {
      List<DictionaryModel> dictionaryModel =
          event.todos.where((todo) => todo.favourites).toList();

      yield FavouritesLoadSuccess(dictionaryModel);
    }
  }

  @override
  Future<void> close() {
    todosSubscription.cancel();
    return super.close();
  }
}
