import 'dart:convert';
import 'dart:io';

import 'package:assignment2/ArchSampleKeys.dart';
import 'package:assignment2/DictionaryModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef OnSaveCallback = Function(String name, String phoneNumber,
    String landLine, String photo, bool favourites);

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final DictionaryModel dictionaryModel;

  AddEditScreen({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.dictionaryModel,
  }) : super(key: key ?? ArchSampleKeys.addTodoScreen);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File _image;
  final picker = ImagePicker();
  String _name;
  String _phoneNumber;
  String _landLine;
  String _photo = ArchSampleKeys.defaultImageBase64;
  bool get isEditing => widget.isEditing;
  bool switchControl = false;
  var textHolder = 'Switch is OFF';

  void toggleSwitch(bool value) {
    if (switchControl == false) {
      setState(() {
        switchControl = true;
        textHolder = 'Switch is ON';
      });
      print('Switch is ON');
      // Put your code here which you want to execute on Switch ON event.

    } else {
      setState(() {
        switchControl = false;
        textHolder = 'Switch is OFF';
      });
      print('Switch is OFF');
      // Put your code here which you want to execute on Switch OFF event.
    }
  }

  Future getImage() async {
    print("getImage called");
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    print("Image picked is $pickedFile");
    setState(() {
      _image = File(pickedFile.path);

      _photo = base64Encode(_image.readAsBytesSync());
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? "Edit" : "Add Contact",
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Switch(
                onChanged: toggleSwitch,
                value: widget.dictionaryModel != null
                    ? widget.dictionaryModel.favourites
                    : switchControl,
                activeColor: Colors.blue,
                activeTrackColor: Colors.green,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey,
              ),
            ),
            // if (_image != null || widget.dictionaryModel != null)
            GestureDetector(
              child: CircleAvatar(
                child: _image != null
                    ? Image.file(_image)
                    : ((widget.dictionaryModel == null ||
                            widget.dictionaryModel.image == null)
                        ? Image.memory(
                            base64Decode(ArchSampleKeys.defaultImageBase64))
                        : Image.memory(
                            base64Decode(widget.dictionaryModel.image))),
                backgroundColor: Colors.transparent,
                radius: 50,
              ),
              onTap: getImage,
            ),
            /*else
              Text(
                "Click on Pick Image to select an Image",
                style: TextStyle(fontSize: 18.0),
              ),*/
            /*RaisedButton(
              onPressed: () {
                getImage();
              },
              child: Text("Pick Image From Gallery"),
            ),*/
            TextFormField(
              initialValue: isEditing ? widget.dictionaryModel.name : '',
              key: ArchSampleKeys.taskField,
              autofocus: !isEditing,
              decoration: InputDecoration(
                hintText: "Name",
              ),
              validator: (val) {
                return val.trim().isEmpty ? "New error" : null;
              },
              onSaved: (value) => _name = value,
            ),
            TextFormField(
              initialValue: isEditing ? widget.dictionaryModel.phoneNumber : '',
              style: textTheme.subtitle1,
              decoration: InputDecoration(
                hintText: "Phone Number",
              ),
              onSaved: (value) => _phoneNumber = value,
            ),
            TextFormField(
              initialValue: isEditing ? widget.dictionaryModel.landLine : '',
              style: textTheme.subtitle1,
              decoration: InputDecoration(
                hintText: "LandLine",
              ),
              onSaved: (value) => _landLine = value,
            ),
            /* TextFormField(
              initialValue: isEditing ? widget.dictionaryModel.image : '',
              style: textTheme.subtitle1,
              decoration: InputDecoration(
                hintText: "Photo",
              ),
              onSaved: (value) => _photo = value,
            ),*/
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key:
            isEditing ? ArchSampleKeys.saveTodoFab : ArchSampleKeys.saveNewTodo,
        tooltip: isEditing ? "Saved" : "Add data",
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(
                _name, _phoneNumber, _landLine, _photo, switchControl);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
