import 'package:Geets/screens/song_list/song_tile.dart';
import 'package:Geets/utils/colors.dart';
import 'package:Geets/utils/screen_dimension.dart';
import 'package:flutter/material.dart';

class SongList extends StatefulWidget {
  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenDimension.percent(percent: 60, isHeight: true),
      width: ScreenDimension.width,
      color: CustomColors.background,
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        children: <Widget>[
          SongTile(
            count: 1,
            title: 'Dance Monkey',
            artist: 'Tones and I',
          ),
          SongTile(
            count: 2,
            title: 'Yummy',
            artist: 'Justin Bieber',
          ),
          SongTile(
            count: 3,
            title: 'Master of Puppets',
            artist: 'Metallica',
          ),
          SongTile(
            count: 4,
            title: 'Shadow of the day',
            artist: 'Linkin Park',
          ),
          SongTile(
            count: 5,
            title: 'Turn the page',
            artist: 'Metallica',
          ),
          SongTile(
            count: 6,
            title: 'Numb',
            artist: 'Linkin Park',
          ),
          SongTile(
            count: 7,
            title: 'Wake me up',
            artist: 'Unknown',
          ),
          SongTile(
            count: 8,
            title: 'Stand still',
            artist: 'Zayn',
          ),
          SongTile(count: 9, title: 'Cloud number nine', artist: 'Bryan Adams'),
        ],
      ),
    );
  }
}
