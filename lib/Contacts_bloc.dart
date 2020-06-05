import 'dart:async';

import 'package:assignment2/ContactState.dart';
import 'package:assignment2/ContactsEvent.dart';
import 'package:assignment2/DatabaseHelperSql.dart';
import 'package:assignment2/DictionaryModel.dart';
import 'package:bloc/bloc.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() {}
  DatabaseHelperSql db = new DatabaseHelperSql();
  @override
  get initialState => ContactsLoadInProgress();

  @override
  Stream<ContactsState> mapEventToState(ContactsEvent event) async* {
    if (event is ContactLoaded) {
      yield* _mapContactsLoadedToState();
    } else if (event is ContactAdded) {
      yield* _mapContactsAddedToState(event);
    } else if (event is ContactUpdated) {
      yield* _mapContactsUpdatedToState(event);
    } else if (event is ContactDeleted) {
      yield* _mapContactsDeletedToState(event);
    }
    /*else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();*/
  }

  Stream<ContactsState> _mapContactsLoadedToState() async* {
    try {
      final todos = await _query();
      yield ContactsLoadSuccess(todos);
    } catch (_) {
      yield ContactsLoadFailure();
    }
  }

  Stream<ContactsState> _mapContactsAddedToState(ContactAdded event) async* {
    if (state is ContactsLoadSuccess) {
      final List<DictionaryModel> updatedContacts =
          List.from((state as ContactsLoadSuccess).contacts)
            ..add(event.contact);
      yield ContactsLoadSuccess(updatedContacts);
      if (updatedContacts.length != 0) _insert(updatedContacts[0]);
    }
  }

  Stream<ContactsState> _mapContactsUpdatedToState(
      ContactUpdated event) async* {
    if (state is ContactsLoadSuccess) {
      final List<DictionaryModel> updatedTodos =
          (state as ContactsLoadSuccess).contacts.map((contact) {
        return contact.name == event.contact.name ? event.contact : contact;
      }).toList();
      yield ContactsLoadSuccess(updatedTodos);
      if (updatedTodos.length != 0) _update(updatedTodos[0]);
    }
  }

  Stream<ContactsState> _mapContactsDeletedToState(
      ContactDeleted event) async* {
    if (state is ContactsLoadSuccess) {
      final updatedTodos = (state as ContactsLoadSuccess)
          .contacts
          .where((contact) => contact.name != event.contact.name)
          .toList();
      yield ContactsLoadSuccess(updatedTodos);
      if (updatedTodos.length != 0) _delete(updatedTodos[0]);
    }
  }

  void _insert(DictionaryModel model) async {
    // row to insert
    db.saveNote(model);
    print('inserted row id: ${model.id}');
    _query();
  }

  Future<List<DictionaryModel>> _query() async {
    List<DictionaryModel> items = new List();
    db.getAllNotes().then((notes) {
      notes.forEach((note) {
        items.add(DictionaryModel.fromMap(note));
      });
    });
    return items;
  }

  void _update(DictionaryModel dictionaryModel) async {
    // row to update
    db.updateNote(dictionaryModel);
    print('updated $dictionaryModel row(s)');
  }

  void _delete(DictionaryModel model) async {
    // Assuming that the number of rows is the id for the last row.
    db.deleteNote(model.id);
    print('deleted ${model.id}');
  }
}
