import 'package:assignment2/DictionaryModel.dart';
import 'package:equatable/equatable.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class ContactLoaded extends ContactsEvent {}

class ContactAdded extends ContactsEvent {
  final DictionaryModel contact;

  const ContactAdded(this.contact);

  @override
  List<Object> get props => [contact];

  @override
  String toString() => 'ContactAdded { Contact: $contact }';
}

class ContactUpdated extends ContactsEvent {
  final DictionaryModel contact;

  const ContactUpdated(this.contact);

  @override
  List<Object> get props => [contact];

  @override
  String toString() => 'ContactUpdated { Contact: $contact }';
}

class ContactDeleted extends ContactsEvent {
  final DictionaryModel contact;

  const ContactDeleted(this.contact);

  @override
  List<Object> get props => [contact];

  @override
  String toString() => 'ContactDeleted { Contact: $contact }';
}

class ClearCompleted extends ContactsEvent {}

class ToggleAll extends ContactsEvent {}
