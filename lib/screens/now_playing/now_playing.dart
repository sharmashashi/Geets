import 'package:Geets/screens/home/home_provider.dart';
import 'package:Geets/screens/now_playing/current_song_list.dart';
import 'package:Geets/screens/now_playing/now_playing_provider.dart';
import 'package:Geets/utils/colors.dart';
import 'package:Geets/utils/custom_shadow.dart';
import 'package:Geets/utils/screen_dimension.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class NowPlaying extends StatefulWidget {
  final AudioPlayer audioPlayerRef;
  final HomeProvider homeProvider;
  NowPlaying({this.homeProvider, this.audioPlayerRef});
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  bool _listening = false;
  bool _lockUpdateSlider = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NowPlayingProvider>(
      create: (context) => NowPlayingProvider(),
      child: Builder(
        builder: (context) {
          NowPlayingProvider _nowPlayingProvider =
              Provider.of<NowPlayingProvider>(context);

          if (_listening == false) {
            _listening = true;
            if (widget.homeProvider.isPlaying == true)
              _nowPlayingProvider.setPlayPauseIconData = Icons.pause;
            widget.audioPlayerRef.onAudioPositionChanged.listen((event) async {
              _nowPlayingProvider.setSliderValue = event.inSeconds.toDouble() >=
                      widget.audioPlayerRef.duration.inSeconds.toDouble()
                  ? widget.audioPlayerRef.duration.inSeconds.toDouble()
                  : event.inSeconds.toDouble();
              _nowPlayingProvider.setSliderValue =
                  event.inSeconds.toDouble() <= 0
                      ? 0
                      : event.inSeconds.toDouble();

              //handle timer
              _nowPlayingProvider.setPresentTime = _timerParser(
                  isRemaining: false,
                  total: widget.audioPlayerRef.duration,
                  duration: event)[0];
              _nowPlayingProvider.setRemainingTime = _timerParser(
                  isRemaining: false,
                  total: widget.audioPlayerRef.duration,
                  duration: event)[1];
              if (this.mounted && _lockUpdateSlider == false) {
                _nowPlayingProvider.notify();
              }
            });
          }
          return Scaffold(
            backgroundColor: CustomColors.background,
            body: Container(
              height: ScreenDimension.height,
              width: ScreenDimension.width,
              child: Stack(children: <Widget>[
                //song list and back button
                ///reserves height: 12 percent
                Positioned(
                    top: ScreenDimension.percent(percent: 5, isHeight: true),
                    left: ScreenDimension.percent(percent: 5, isHeight: false),
                    right: ScreenDimension.percent(percent: 5, isHeight: false),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _topOptions(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            iconData: Icons.arrow_back),
                        Text(
                          'Now Playing',
                          style: TextStyle(
                              shadows: CustomShadow.textShadow,
                              color: CustomColors.background,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        _topOptions(
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Material(
                                        child: CurrentSongList(
                                      audioPlayer: widget.audioPlayerRef,
                                      homeProvider: widget.homeProvider,
                                    ));
                                  });
                              widget.audioPlayerRef.onPlayerStateChanged
                                  .listen((event) {
                                if (event == AudioPlayerState.PLAYING) {
                                  _nowPlayingProvider.setPlayPauseIconData =
                                      Icons.pause;
                                  _nowPlayingProvider.setSliderValue = 0;
                                  _nowPlayingProvider.notify();
                                }
                              });
                            },
                            iconData: Icons.list)
                      ],
                    )),

                ///reserves height :70 percent by width
                Positioned(
                  left: ScreenDimension.percent(percent: 15, isHeight: false),
                  top: ScreenDimension.percent(percent: 15, isHeight: true),
                  child: _songImage(),
                ),

                ///reserves height :5 percent
                Positioned(
                    top: ScreenDimension.percent(percent: 70, isHeight: false) +
                        ScreenDimension.percent(percent: 18, isHeight: true),
                    child: _songInfo()),

                ///reserves height :15
                ///for lyrics
                Positioned(
                  top: ScreenDimension.percent(percent: 70, isHeight: false) +
                      ScreenDimension.percent(percent: 23, isHeight: true),
                  child: Container(
                    color: Colors.transparent,
                    height:
                        ScreenDimension.percent(percent: 15, isHeight: true),
                    width: ScreenDimension.width,
                  ),
                ),

                ///reserves height: 20 percent
                Positioned(
                  top: ScreenDimension.percent(percent: 70, isHeight: false) +
                      ScreenDimension.percent(
                        percent: 40,
                        isHeight: true,
                      ),
                  left: ScreenDimension.percent(percent: 5, isHeight: false),
                  child: _slider(provider: _nowPlayingProvider),
                ),

                ///reserves height : rest of all
                Positioned(
                  top: ScreenDimension.percent(percent: 70, isHeight: false) +
                      ScreenDimension.percent(
                        percent: 50,
                        isHeight: true,
                      ),
                  child: _controllers(provider: _nowPlayingProvider),
                )
              ]),
            ),
          );
        },
      ),
    );
  }

  Widget _controllers({@required NowPlayingProvider provider}) {
    return Container(
      width: ScreenDimension.width,
      height: ScreenDimension.height -
          (ScreenDimension.percent(percent: 70, isHeight: false) +
              ScreenDimension.percent(
                percent: 50,
                isHeight: true,
              )),
      alignment: Alignment.center,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _ctrlBtn(
              onTap: () async {
                ///prev logic
                ///
                //if not first song
                if (widget.homeProvider.currentSongIndex != 0)
                //execute only if playing
                if (widget.homeProvider.isPlaying == true &&
                    widget.homeProvider.isCompleted == false &&
                    widget.homeProvider.isStopped == false) {
                  await widget.audioPlayerRef.stop();

                  widget.audioPlayerRef.play(
                      widget.homeProvider.musicFilePath[
                          widget.homeProvider.currentSongIndex - 1],
                      isLocal: true);
                  widget.homeProvider.setCurrentSongIndex =
                      widget.homeProvider.currentSongIndex - 1;

                  widget.homeProvider.notify();
                }

                ///
                ///
              },
              centerButton: false,
              iconData: Icons.skip_previous),
          Container(
            width: 15,
          ),
          _ctrlBtn(
              onTap: () {
                provider.setPlayPauseIconData =
                    provider.playPauseIconData == Icons.play_arrow
                        ? Icons.pause
                        : Icons.play_arrow;

                ///playpause logic
                ///
                if (widget.homeProvider.isPlaying == true) {
                  widget.audioPlayerRef.pause();
                } else if (widget.homeProvider.isPlaying == false) {
                  widget.audioPlayerRef.play(
                      widget.homeProvider
                          .musicFilePath[widget.homeProvider.currentSongIndex],
                      isLocal: true);
                }

                ///
                ///
                provider.notify();
              },
              centerButton: true,
              iconData: provider.playPauseIconData),
          Container(
            width: 15,
          ),
          _ctrlBtn(
              onTap: () async {
                ///
                ///next logic

                //if not last song
                if (widget.homeProvider.currentSongIndex !=
                    widget.homeProvider.musicFilePath.length - 1)
                //execute only if playing
                if (widget.homeProvider.isPlaying == true &&
                    widget.homeProvider.isCompleted == false &&
                    widget.homeProvider.isStopped == false) {
                  await widget.audioPlayerRef.stop();

                  widget.audioPlayerRef.play(
                      widget.homeProvider.musicFilePath[
                          widget.homeProvider.currentSongIndex + 1],
                      isLocal: true);
                  widget.homeProvider.setCurrentSongIndex =
                      widget.homeProvider.currentSongIndex + 1;

                  widget.homeProvider.notify();
                }

                ///
                ///
              },
              centerButton: false,
              iconData: Icons.skip_next)
        ],
      ),
    );
  }

  Widget _ctrlBtn(
      {@required Function onTap,
      @required bool centerButton,
      @required IconData iconData}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: ScreenDimension.percent(
            percent: centerButton ? 7 : 5, isHeight: true),
        width: ScreenDimension.percent(
            percent: centerButton ? 7 : 5, isHeight: true),
        decoration: BoxDecoration(
            color: CustomColors.background,
            shape: BoxShape.circle,
            boxShadow: CustomShadow.normalButtonShadow),
        alignment: Alignment.center,
        child: Icon(
          iconData,
          size: centerButton ? 40 : 25,
          color: centerButton ? Colors.white : DarkColors.playPauseButton,
        ),
      ),
    );
  }

  Widget _slider({@required NowPlayingProvider provider}) {
    return Container(
      alignment: Alignment.center,
      color: Colors.transparent,
      width: ScreenDimension.percent(percent: 90, isHeight: false),
      height: ScreenDimension.percent(percent: 10, isHeight: true),
      child: Column(
        children: <Widget>[
          Slider(
            min: 0,
            max: widget.audioPlayerRef.duration.inSeconds.toDouble(),
            value: provider.sliderValue,
            onChangeStart: (_) {
              _lockUpdateSlider = true;
            },
            onChanged: (val) {
              provider.setSliderValue = val.toInt().toDouble();
              provider.notify();
            },
            onChangeEnd: (val) {
              widget.audioPlayerRef.seek(val.toInt().toDouble());
              _lockUpdateSlider = false;
            },
            activeColor: Colors.deepOrange,
            inactiveColor: Colors.orange[100],
          ),
          //for time duration
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                provider.presentTime,
                style: TextStyle(color: CustomColors.normalText),
              ),
              Text(
                provider.remainingTime,
                style: TextStyle(color: CustomColors.normalText),
              )
            ],
          )
        ],
      ),
    );
  }

  List<String> _timerParser(
      {@required bool isRemaining,
      @required Duration total,
      @required Duration duration}) {
    List<String> _list = List();
    _list = ['', ''];
    if (isRemaining == true) {
    } else {
      int _sec = (duration.inSeconds - duration.inMinutes * 60);
      int _min = duration.inMinutes;
      _list[0] = '${_min < 10 ? '0' + _min.toString() : _min.toString()}' +
          ':${_sec < 10 ? '0' + _sec.toString() : _sec.toString()}';
      _min = (total.inSeconds - duration.inSeconds) ~/ 60;
      _sec = (total.inSeconds - duration.inSeconds) - _min * 60;
      _list[1] = '- ${_min < 10 ? '0' + _min.toString() : _min.toString()}'
          ':${(_sec < 0 ? _sec * -1 : _sec) < 10 ? '0' + _sec.toString() : _sec.toString()}';
    }
    return _list;
  }

  Widget _songInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        //
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          height: ScreenDimension.percent(percent: 2.5, isHeight: true),
          width: ScreenDimension.percent(percent: 100, isHeight: false),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              widget.homeProvider
                  .musicFileName[widget.homeProvider.currentSongIndex],
              overflow: TextOverflow.clip,
              style: TextStyle(
                  color: CustomColors.highlightedText,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: ScreenDimension.percent(percent: 2.5, isHeight: true),
          width: ScreenDimension.percent(percent: 100, isHeight: false),
          child: Text(
            widget
                .homeProvider.artistList[widget.homeProvider.currentSongIndex],
            style: TextStyle(color: CustomColors.normalText, fontSize: 14),
          ),
        )
      ],
    );
  }

  Widget _songImage() {
    return Container(
      width: ScreenDimension.percent(percent: 70, isHeight: false),
      height: ScreenDimension.percent(percent: 70, isHeight: false),
      decoration: BoxDecoration(
          color: CustomColors.background,
          shape: BoxShape.circle,
          boxShadow: CustomShadow.bigImageShadow),
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1000),
        child:
            widget.homeProvider.artWork[widget.homeProvider.currentSongIndex],
      ),
    );
  }

  Widget _topOptions({@required Function onTap, @required IconData iconData}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: ScreenDimension.percent(percent: 7, isHeight: true),
        width: ScreenDimension.percent(percent: 7, isHeight: true),
        decoration: BoxDecoration(
            color: CustomColors.background,
            shape: BoxShape.circle,
            boxShadow: CustomShadow.normalButtonShadow),
        alignment: Alignment.center,
        child: Icon(
          iconData,
          color: DarkColors.playPauseButton,
        ),
      ),
    );
  }
}
