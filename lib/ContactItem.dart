import 'package:assignment2/ArchSampleKeys.dart';
import 'package:assignment2/DictionaryModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final DictionaryModel item;

  ContactItem({
    Key key,
    this.onDismissed,
    @required this.onTap,
    @required this.onCheckboxChanged,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ArchSampleKeys.todoItem(item.id),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        /* leading: Checkbox(
          key: ArchSampleKeys.todoItemCheckbox(todo.id),
          value: todo.complete,
          onChanged: onCheckboxChanged,
        ),*/
        title: Hero(
          tag: '${item.name}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              item.name,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        subtitle: item.phoneNumber.isNotEmpty
            ? Text(
                item.phoneNumber,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
              )
            : null,
      ),
    );
  }
}
