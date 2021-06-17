import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/rendering.dart';
import 'neumorphic_design_example.dart';

int isSelectedIndex;

enum PlayerState { stopped, playing, paused }


class AudioApp extends StatefulWidget {
  @override
  _AudioAppState createState() => _AudioAppState();
}

class _AudioAppState extends State<AudioApp> with TickerProviderStateMixin {
  List<Song> _songs;
  AnimationController _controller;
  String imagePath;
  MusicFinder audioPlayer;
  PlayerState playerState = PlayerState.stopped;

  @override
  void initState() {
    super.initState();
    fetchSongs();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    audioPlayer = MusicFinder();
  }

  void fetchSongs() async {
    MusicFinder audioPlayer = new MusicFinder();
    List<Song> songs = await MusicFinder.allSongs();

    var sortSongs = [];
    List<Song> finalSongs = List();
    for (int i = 0; i < songs.length; i++) {
      sortSongs.add(songs[i].title);
    }
    sortSongs.sort();
    for (int i = 0; i < sortSongs.length; i++) {
      for (int j = 0; j < sortSongs.length; j++) {
        if (sortSongs[i] == songs[j].title) {
          finalSongs.add(songs[j]);
          print(sortSongs[i]);
          print(songs[j].title);
        }
      }
    }

    setState(() {
      _songs = finalSongs;
    });
  }

  String AlbumImage() {
    if (imagePath == null) {
      return "assets/jaySean.jpg";
    } else {
      try {
        return imagePath;
      } catch (e) {
        return 'assets/jaySean.jpg';
      }
    }
  }


  Future stop() async {
    final result = await audioPlayer.stop();
  }

  checkPlayer(String path, int index) async{
    await stop();
    if(isSelectedIndex == index) {
      await audioPlayer.play(path);
    }else{
      await audioPlayer.pause();
    }
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 40),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Color(0xFF1F1E24),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              'PLAYING NOW',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white30,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: usualButton(
                    controller: _controller,
                    iconData: AnimatedIcons.add_event,
                  ),
                ),
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        AlbumImage(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  child: usualButton(
                    controller: _controller,
                    iconData: AnimatedIcons.add_event,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Stack(
              children: <Widget>[
                Container(
                  height: 501,
                  child: ListView.builder(
                    itemCount: _songs.length,
                    itemBuilder: (context, index) {
                      return MenuListTile(
                        index: index,
                        width: width,
                        songs: _songs,
                        player: audioPlayer,
                        function: () async{
                          if (isSelectedIndex != index) {
                            setState(() {
                              isSelectedIndex = index;
                              imagePath = _songs[index].albumArt;
                            });
//                            await audioPlayer.play(_songs[index].uri, isLocal: true);
                          } else {
                            setState(() {
                              isSelectedIndex = null;
                            });
//                            await audioPlayer.stop();
                          }
                          checkPlayer(_songs[index].uri, index);
                        },
                      );
                    },
                  ),
                ),
                Container(
                  width: width,
                  height: 30,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF1F1E24),
                          Color(0xFF1F1E24).withOpacity(0.9),
                          Color(0xFF1F1E24).withOpacity(0.5),
                          Color(0xFF1F1E24).withOpacity(0.0)
                        ]),
                  ),
                ),
                Positioned(
                  bottom: -1,
                  child: Container(
                    width: width,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xFF1F1E24),
                            Color(0xFF1F1E24),
                            Color(0xFF1F1E24).withOpacity(0.7),
                            Color(0xFF1F1E24).withOpacity(0.0)
                          ]),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MenuListTile extends StatefulWidget {
  const MenuListTile({
    Key key,
    @required this.width,
    @required List<Song> songs,
    @required this.index,
    @required this.function,
    @required this.player,
  })  : _songs = songs,
        super(key: key);

  final double width;
  final List<Song> _songs;
  final int index;
  final Function function;
  final MusicFinder player;

  @override
  _MenuListTileState createState() => _MenuListTileState();
}

class _MenuListTileState extends State<MenuListTile> {
  double bevel = 0.0;
  CurveType type = CurveType.convex;
  IconData icon;

  @override
  void initState() {
    super.initState();
    icon = Icons.play_arrow;
  }

  @override
  Widget build(BuildContext context) {
    if (isSelectedIndex != widget.index) {
      type = CurveType.convex;
      icon = Icons.play_arrow;
    } else {
      type = CurveType.concave;
      icon = Icons.pause;
    }
    return GestureDetector(
      onTap: () {
        widget.function();
        setState(() {
          if (isSelectedIndex == widget.index) {
            icon = Icons.pause;
            type = CurveType.concave;
          } else {
            icon = Icons.play_arrow;
            type = CurveType.convex;
          }
        });
      },
      child: NeuCardx(
        curveType: CurveType.emboss,
        color: Color(0xFF1F1E24),
        midColor: Color(0xFF1F1E24),
        bevel: isSelectedIndex == widget.index ? 20 : 0.0,
        decoration: NeumorphicDecoration(
          color: Color(0xFF1F1E24),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.only(
            top: 10.0, left: 10.0, right: 10.0, bottom: 15),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: widget.width * 0.7,
                  child: Text(
                    widget._songs[widget.index].title,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: widget.width * 0.7,
                  child: Text(
                    widget._songs[widget.index].artist,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
              child: NeuCardx(
                isTop: false,
                curveType: CurveType.flat,
                bevel: 5,
                padding: EdgeInsets.all(4),
                midColor: Color(0xFF1F1E24),
                decoration: NeumorphicDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF1F1E24),
                ),
                child: NeuCardx(
                  isTop: true,
                  curveType: type,
                  bevel: 80,
                  midColor: Color(0xFFF13900),
                  padding: EdgeInsets.all(13),
                  decoration: NeumorphicDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff18191D),
                  ),
                  child: Center(
                      child: Icon(
                    icon,
                    color: Colors.white,
                    size: 15,
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
