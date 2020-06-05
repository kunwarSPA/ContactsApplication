import 'package:assignment2/ArchSampleKeys.dart';
import 'package:assignment2/ContactItem.dart';
import 'package:assignment2/FlutterContactKeys.dart';
import 'package:assignment2/LoadingIndicator.dart';
import 'package:assignment2/complete_list/CompleteExtensionPackage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'DetailsScreen.dart';

class ContactListPage extends StatelessWidget {
  ContactListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteBloc, CompleteState>(
      builder: (context, state) {
        if (state is CompleteListLoadInProgress) {
          return LoadingIndicator(key: ArchSampleKeys.todosLoading);
        } else if (state is CompleteListLoadSuccess) {
          final contactList = state.filteredTodos;
          print(contactList);
          return ListView.builder(
            key: ArchSampleKeys.todoList,
            itemCount: contactList.length,
            itemBuilder: (BuildContext context, int index) {
              final todo = contactList[index];
              return ContactItem(
                item: todo,
                onTap: () async {
                  final removedTodo = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return DetailsScreen(name: todo.name);
                    }),
                  );
                  if (removedTodo != null) {
                    print(removedTodo);
                  }
                },
                onCheckboxChanged: (_) {
//
                },
              );
            },
          );
        } else {
          return Container(key: FlutterContactKeys.filteredTodosEmptyContainer);
        }
      },
    );
  }
}
