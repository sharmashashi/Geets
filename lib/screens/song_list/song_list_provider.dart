import 'package:Geets/utils/colors.dart';
import 'package:flutter/material.dart';

class SongListProvider with ChangeNotifier {
  List<Widget> _songList = [Center(child: Text('Loading...',style: TextStyle(color: CustomColors.highlightedText),))];
  List<Widget> get songList => _songList;
  set setSongList(List<Widget> list) {
    this._songList = list;
    notifyListeners();
  }
}
