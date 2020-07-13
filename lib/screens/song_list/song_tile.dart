import 'package:Geets/screens/song_list/tile_provider.dart';
import 'package:Geets/utils/colors.dart';
import 'package:Geets/utils/saved_preference.dart';
import 'package:Geets/utils/screen_dimension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongTile extends StatefulWidget {
  final int count;
  final String title;
  final String artist;
  SongTile({this.count, this.title, this.artist});
  @override
  _SongTileState createState() => _SongTileState();
}

class _SongTileState extends State<SongTile> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TileProvider>(
      create: (context) => TileProvider(),
      child: Builder(builder: (context) {
        TileProvider _tileProvider = Provider.of<TileProvider>(context);
        SavedPreferences.fetch(initSongTile: true).then((value) {
          if (value == false) {
            SavedPreferences.update(initSongTile: true).then((_) {
              _tileProvider.updateSongStatus(play: false);
            });
          }
        });
        return Container(
          width: ScreenDimension.width,
          height: ScreenDimension.percent(percent: 8, isHeight: true),
          color: CustomColors.background,
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ///divide into three portion horizontally
              Container(
                alignment: Alignment.center,
                width: ScreenDimension.percent(percent: 20, isHeight: false),
                child: _countBuilder(),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width:
                    ScreenDimension.percent(percent: 60, isHeight: false) - 20,
                child: _songInfo(),
              ),
              Container(
                width: ScreenDimension.percent(percent: 20, isHeight: false),
                alignment: Alignment.center,
                child: _playerButton(_tileProvider),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _countBuilder() {
    return Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: CustomColors.background, width: 2),
            gradient: LinearGradient(
                colors: [CustomColors.upperLeftShadow, CustomColors.background],
                stops: [0.3, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            boxShadow: [
              BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 2,
                  offset: Offset(1, 1),
                  color: CustomColors.lowerRightShadow),
              BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 2,
                  offset: Offset(-1, -1),
                  color: CustomColors.upperLeftShadow),
            ]),
        child: Text(
          widget.count.toString(),
          style: TextStyle(color: CustomColors.normalText),
        ));
  }

  Widget _songInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //
        Text(
          widget.title,
          style: TextStyle(
              color: CustomColors.highlightedText,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        Text(
          widget.artist,
          style: TextStyle(color: CustomColors.normalText),
        )
      ],
    );
  }

  Widget _playerButton(TileProvider provider) {
    return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: CustomColors.background, width: 2),
            gradient: LinearGradient(
                colors: [CustomColors.upperLeftShadow, CustomColors.background],
                stops: [0.3, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            boxShadow: [
              BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 2,
                  offset: Offset(1, 1),
                  color: CustomColors.lowerRightShadow),
              BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 2,
                  offset: Offset(-1, -1),
                  color: CustomColors.upperLeftShadow),
            ]),
        child: provider.playPauseIcon);
  }
}
