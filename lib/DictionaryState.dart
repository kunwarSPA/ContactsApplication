import 'package:equatable/equatable.dart';

abstract class DictionaryState extends Equatable {
  final int duration;

  const DictionaryState(this.duration);

  @override
  List<Object> get props => [duration];
}

class Create extends DictionaryState {
  const Create(int duration) : super(duration);

  @override
  String toString() => 'Ready { duration: $duration }';
}

class Update extends DictionaryState {
  const Update(int duration) : super(duration);

  @override
  String toString() => 'Paused { duration: $duration }';
}

class Read extends DictionaryState {
  const Read(int duration) : super(duration);

  @override
  String toString() => 'Running { duration: $duration }';
}

class Delete extends DictionaryState {
  const Delete() : super(0);
}
