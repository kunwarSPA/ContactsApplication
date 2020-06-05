import 'package:assignment2/DictionaryModel.dart';
import 'package:equatable/equatable.dart';

abstract class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object> get props => [];
}

class ContactsLoadInProgress extends ContactsState {}

class ContactsLoadSuccess extends ContactsState {
  final List<DictionaryModel> contacts;

  const ContactsLoadSuccess([this.contacts = const []]);

  @override
  List<Object> get props => [contacts];

  @override
  String toString() => 'ContactsLoadSuccess { todos: $contacts }';
}

class ContactsLoadFailure extends ContactsState {}
