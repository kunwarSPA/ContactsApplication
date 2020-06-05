import 'package:assignment2/AddEditScreen.dart';
import 'package:assignment2/ArchSampleKeys.dart';
import 'package:assignment2/ArchSampleRoutes.dart';
import 'package:assignment2/ContactListPage.dart';
import 'package:assignment2/ContactsEvent.dart';
import 'package:assignment2/Contacts_bloc.dart';
import 'package:assignment2/DictionaryModel.dart';
import 'package:assignment2/FavouritesListingPage.dart';
import 'package:assignment2/complete_list/CompleteExtensionPackage.dart';
import 'package:assignment2/drawer_bloc_package/navigation_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteBloc, CompleteState>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Contacts"),
          ),
          body: StreamBuilder(
            stream: bloc.getNavigation,
            initialData: bloc.navigationProvider.currentNavigation,
            // ignore: missing_return
            builder: (context, snapshot) {
              if (bloc.navigationProvider.currentNavigation == "Home") {
                return ContactListPage();
              }
              if (bloc.navigationProvider.currentNavigation == "Add") {
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
              }
              if (bloc.navigationProvider.currentNavigation == "Favourites") {
                return FavouritesListingPage();
              }
            }, // access the data in our Stream here
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, ArchSampleRoutes.addTodo);
            },
            child: Icon(Icons.add),
          ),
          drawer: Drawer(
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                    accountName: Text("Admin"),
                    currentAccountPicture:
                        CircleAvatar(child: Icon(Icons.person)),
                    accountEmail: Text("12345@gmail.com")),
                ListTile(
                  title: Text("Home"),
                  onTap: () {
                    Navigator.of(context).pop();
                    bloc.updateNavigation("Home");
                  },
                ),
                ListTile(
                  title: Text("Add Contacts"),
                  onTap: () {
                    Navigator.of(context).pop();
                    bloc.updateNavigation("Add");
                  },
                ),
                ListTile(
                  title: Text("Favourites"),
                  onTap: () {
                    Navigator.of(context).pop();
                    bloc.updateNavigation("Favourites");
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
