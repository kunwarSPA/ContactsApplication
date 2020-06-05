import 'dart:async';

import 'package:assignment2/ContactState.dart';
import 'package:assignment2/Contacts_bloc.dart';
import 'package:assignment2/DictionaryModel.dart';
import 'package:assignment2/complete_list/CompleteExtensionPackage.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'VisibilityFilter.dart';

class CompleteBloc extends Bloc<CompleteEvent, CompleteState> {
  final ContactsBloc contactBloc;
  StreamSubscription ContactsSubscription;

  CompleteBloc({@required this.contactBloc}) {
    ContactsSubscription = contactBloc.listen((state) {
      if (state is ContactsLoadSuccess) {
        add(BlocUpdated((contactBloc.state as ContactsLoadSuccess).contacts));
      }
    });
  }

  @override
  CompleteState get initialState {
    return contactBloc.state is ContactsLoadSuccess
        ? CompleteListLoadSuccess(
            (contactBloc.state as ContactsLoadSuccess).contacts,
            VisibilityFilter.all,
          )
        : CompleteListLoadInProgress();
  }

  @override
  Stream<CompleteState> mapEventToState(CompleteEvent event) async* {
    if (event is CompleteListUpdated) {
      yield* _mapFilterUpdatedToState(event);
    } else if (event is BlocUpdated) {
      yield* _mapContactUpdatedToState(event);
    }
  }

  Stream<CompleteState> _mapFilterUpdatedToState(
      CompleteListUpdated event) async* {
    if (contactBloc.state is ContactsLoadSuccess) {
      yield CompleteListLoadSuccess(
        _mapContactsToCompleteTodos(
          (contactBloc.state as ContactsLoadSuccess).contacts,
          event.filter,
        ),
        event.filter,
      );
    }
  }

  Stream<CompleteState> _mapContactUpdatedToState(
    BlocUpdated event,
  ) async* {
    final visibilityFilter = state is CompleteListLoadSuccess
        ? (state as CompleteListLoadSuccess).activeFilter
        : VisibilityFilter.all;
    yield CompleteListLoadSuccess(
      _mapContactsToCompleteTodos(
        (contactBloc.state as ContactsLoadSuccess).contacts,
        visibilityFilter,
      ),
      visibilityFilter,
    );
  }

  List<DictionaryModel> _mapContactsToCompleteTodos(
      List<DictionaryModel> list, VisibilityFilter filter) {
    return list;
  }

  @override
  Future<void> close() {
    ContactsSubscription.cancel();
    return super.close();
  }
}
