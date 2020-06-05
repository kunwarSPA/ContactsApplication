import 'package:equatable/equatable.dart';

class DictionaryModel extends Equatable {
  int _id;
  String _name;
  String _phoneNumber;
  String _landLine;
  String _image;
  bool _favourites;

  DictionaryModel(this._name, this._phoneNumber, this._landLine, this._image,this._favourites);

  @override
  // TODO: implement props
  List<Object> get props => [_name, _phoneNumber, _landLine, _image,_favourites];

  DictionaryModel.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._phoneNumber = obj['phoneNumber'];
    this._landLine = obj['landLine'];
    this._image = obj['image'];
    this._favourites = obj['favourites'];

  }

  int get id => _id;
  String get name => _name;
  String get phoneNumber => _phoneNumber;
  String get landLine => _landLine;
  String get image => _image;
  bool get favourites => _favourites;


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['phoneNumber'] = _phoneNumber;
    map['landLine'] = _landLine;
    map['image'] = _image;
    map['favourites'] = _favourites;
    return map;
  }

  DictionaryModel.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._phoneNumber = map['phoneNumber'];
    this._landLine = map['landLine'];
    this._image = map['image'];
    this._favourites = map['favourites'];
  }
}
