import 'package:assignment2/AddEditScreen.dart';
import 'package:assignment2/ArchSampleKeys.dart';
import 'package:assignment2/ContactState.dart';
import 'package:assignment2/ContactsEvent.dart';
import 'package:assignment2/Contacts_bloc.dart';
import 'package:assignment2/DictionaryModel.dart';
import 'package:assignment2/FlutterContactKeys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatelessWidget {
  final String name;

  DetailsScreen({Key key, @required this.name})
      : super(key: key ?? ArchSampleKeys.todoDetailsScreen);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) {
        final todo = (state as ContactsLoadSuccess)
            .contacts
            .firstWhere((todo) => todo.name == name, orElse: () => null);
        return Scaffold(
          appBar: AppBar(
            title: Text("Details"),
            actions: [
              IconButton(
                tooltip: "Delete Button",
                key: ArchSampleKeys.deleteTodoButton,
                icon: Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<ContactsBloc>(context)
                      .add(ContactDeleted(todo));
                  Navigator.pop(context, todo);
                },
              )
            ],
          ),
          body: todo == null
              ? Container(key: FlutterContactKeys.emptyDetailsContainer)
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: '${todo.name}__heroTag',
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 16.0,
                                    ),
                                    child: Text(
                                      todo.name,
                                      key: ArchSampleKeys.detailsTodoItemTask,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ),
                                ),
                                Text(
                                  todo.phoneNumber,
                                  key: ArchSampleKeys.detailsTodoItemNote,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            key: ArchSampleKeys.editTodoFab,
            tooltip: "Edit",
            child: Icon(Icons.edit),
            onPressed: todo == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AddEditScreen(
                            key: ArchSampleKeys.editTodoScreen,
                            onSave: (name, phoneNumber, landLine, photo,
                                favourites) {
                              DictionaryModel model = new DictionaryModel(name,
                                  phoneNumber, landLine, photo, favourites);
                              BlocProvider.of<ContactsBloc>(context)
                                  .add(ContactUpdated(model));
                            },
                            isEditing: true,
                            dictionaryModel: todo,
                          );
                        },
                      ),
                    );
                  },
          ),
        );
      },
    );
  }
}
