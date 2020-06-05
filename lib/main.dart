import 'package:assignment2/AddEditScreen.dart';
import 'package:assignment2/ArchSampleKeys.dart';
import 'package:assignment2/ArchSampleRoutes.dart';
import 'package:assignment2/ContactsEvent.dart';
import 'package:assignment2/Contacts_bloc.dart';
import 'package:assignment2/HomeScreen.dart';
import 'package:assignment2/SimpleBlocDelegate.dart';
import 'package:assignment2/complete_list/CompleteExtensionPackage.dart';
import 'package:assignment2/drawer/drawer.dart';
import 'package:assignment2/favourites/favourites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'DictionaryModel.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    BlocProvider(
      create: (context) {
        return ContactsBloc()..add(ContactLoaded());
      },
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts',
      routes: {
        ArchSampleRoutes.home: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<DrawerBloc>(
                create: (context) => DrawerBloc(),
              ),
              BlocProvider<CompleteBloc>(
                create: (context) => CompleteBloc(
                  contactBloc: BlocProvider.of<ContactsBloc>(context),
                ),
              ),
              BlocProvider<FavouritesBloc>(
                create: (context) => FavouritesBloc(
                  contactBloc: BlocProvider.of<ContactsBloc>(context),
                ),
              ),
            ],
            child: HomeScreen(),
          );
        },
        ArchSampleRoutes.addTodo: (context) {
          return AddEditScreen(
            key: ArchSampleKeys.addTodoScreen,
            onSave: (name, phoneNumber, landLine, photo, favourites) {
              BlocProvider.of<ContactsBloc>(context).add(
                ContactAdded(DictionaryModel(
                    name, phoneNumber, landLine, photo, favourites)),
              );
            },
            isEditing: false,
          );
        },
      },
    );
  }
}
