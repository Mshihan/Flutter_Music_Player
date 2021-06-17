import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:neumorphic/neumorphic.dart';

class NeumorphicApp extends StatefulWidget {
  @override
  _NeumorphicAppState createState() => _NeumorphicAppState();
}

class _NeumorphicAppState extends State<NeumorphicApp>
    with TickerProviderStateMixin {
  var item = CurveType.convex;

  AnimationController _controller;
  AnimationController _animationControllerBackButton;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animationControllerBackButton = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }



  double value = 0.00;
  String label = '';
  String startTime = '0.00';
  String endTime = '4.35';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 40),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Color(0xFF1F1E24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  usualButton(
                    controller: _animationControllerBackButton,
                    iconData: AnimatedIcons.arrow_menu,
                  ),
                  Text(
                    'PLAYING NOW',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white30,
                        fontWeight: FontWeight.w600),
                  ),
                  usualButton(
                    controller: _animationControllerBackButton,
                    iconData: AnimatedIcons.menu_close,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 300,
              width: 300,
//                color: Colors.white,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/jaySean.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            NeuText('Ride It', parentColor: Color(0xFF1F1E24), emboss: false, style: TextStyle(fontSize: 50),),
            SizedBox(
              height: 20,
            ),
            NeuText('Jay Sean ft. Tupac', parentColor: Color(0x251F1E24), emboss: false, style: TextStyle(fontSize: 20, color: Colors.white30),),
            SizedBox(height: 50,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                Text(startTime, style: TextStyle(fontSize: 12, color: Colors.white30),),
                Text(endTime, style: TextStyle(fontSize: 12, color: Colors.white30),),
              ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Slider(
                onChanged: (double){
                  setState(() {
                    value = double;
                    print(value);
                    startTime = value.toStringAsFixed(2);
                    endTime = (4.35 - value).toStringAsFixed(2);
                  });
                },
                value: value,
                max: 4.35,
                min: 0.00,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
//                        setState(() {
//                          item == CurveType.concave
//                              ? item = CurveType.convex
//                              : item = CurveType.concave;
//                          _controller.value == 1.0
//                              ? _controller.reverse()
//                              : _controller.forward();
//                        });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: NeuCardx(
                        isTop: false,
                        curveType: CurveType.flat,
                        bevel: 10,
                        padding: EdgeInsets.all(4),
                        midColor: Color(0xff18191D),
                        decoration: NeumorphicDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF1F1E24),
                        ),
                        child: NeuCardx(
                          isTop: true,
                          curveType: item,
                          bevel: 80,
                          midColor: Colors.blue,
                          padding: EdgeInsets.all(25),
                          decoration: NeumorphicDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff18191D),
                          ),
                          child: Icon(
                            Icons.fast_rewind,
                            color: Colors.white,
                          )
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        item == CurveType.concave
                            ? item = CurveType.convex
                            : item = CurveType.concave;
                        _controller.value == 1.0
                            ? _controller.reverse()
                            : _controller.forward();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: NeuCardx(
                        isTop: false,
                        curveType: CurveType.flat,
                        bevel: 10,
                        padding: EdgeInsets.all(4),
                        midColor: Color(0xff18191D),
                        decoration: NeumorphicDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF1F1E24),
                        ),
                        child: NeuCardx(
                          isTop: true,
                          curveType: item,
                          bevel: 80,
                          midColor: Color(0xFFF13900),
                          padding: EdgeInsets.all(25),
                          decoration: NeumorphicDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff18191D),
                          ),
                          child: AnimatedIcon(
                            icon: AnimatedIcons.play_pause,
                            progress: _controller,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
//                        setState(() {
//                          item == CurveType.concave
//                              ? item = CurveType.convex
//                              : item = CurveType.concave;
//                          _controller.value == 1.0
//                              ? _controller.reverse()
//                              : _controller.forward();
//                        });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: NeuCardx(
                        isTop: false,
                        curveType: CurveType.flat,
                        bevel: 10,
                        padding: EdgeInsets.all(4),
                        midColor: Color(0xff18191D),
                        decoration: NeumorphicDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF1F1E24),
                        ),
                        child: NeuCardx(
                          isTop: true,
                          curveType: item,
                          bevel: 80,
                          midColor: Colors.blue,
                          padding: EdgeInsets.all(25),
                          decoration: NeumorphicDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff18191D),
                          ),
                          child:Icon(
                            Icons.fast_forward,
                            color: Colors.white,
                          )
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class usualButton extends StatefulWidget {
  const usualButton({
    Key key,
    @required AnimationController controller,
    AnimatedIconData iconData,
    Color TopColor,
  })
      : _controller = controller,
        _iconData = iconData,
        TopColor = TopColor,
        super(key: key);

  final AnimationController _controller;
  final AnimatedIconData _iconData;
  final Color TopColor;

  @override
  _usualButtonState createState() => _usualButtonState();
}

class _usualButtonState extends State<usualButton> {
  CurveType type = CurveType.convex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          type == CurveType.concave
              ? type = CurveType.convex
              : type = CurveType.concave;
          widget._controller.value == 1.0
              ? widget._controller.reverse()
              : widget._controller.forward();
        });
      },
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
          midColor: widget.TopColor ?? Colors.blue,
          padding: EdgeInsets.all(13),
          decoration: NeumorphicDecoration(
            shape: BoxShape.circle,
            color: Color(0xff18191D),
          ),
          child: Center(
            child: AnimatedIcon(
              icon: widget._iconData,
              progress: widget._controller,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),
      ),
    );
  }
}

enum LightSource { topLeft, topRight, bottomLeft, bottomRight }

/// The [CurveType] of [Neumorphic] material.
/// Can be [concave], [convex], [emboss] or [flat]
enum CurveType {
  concave,
  convex,
  emboss,
  flat,
}

/// It is container like a `Material` merged with `Container`, but implements Neumorphism.
class NeuCardx extends StatelessWidget {
  /// Creates a Neumorphic design card
  ///
  NeuCardx({
    this.midColor = Colors.white,
    this.isTop = false,
    this.child,
    this.bevel = 12.0,
    this.curveType = CurveType.convex,
    Color color,
    NeumorphicDecoration decoration,
    this.alignment,
    this.width,
    this.height,
    BoxConstraints constraints,
    this.margin,
    this.padding,
    this.transform,
    Key key,
  })
      : decoration = decoration ?? NeumorphicDecoration(color: color),
        constraints = (width != null || height != null)
            ? constraints?.tighten(width: width, height: height) ??
            BoxConstraints.tightFor(width: width, height: height)
            : constraints,
        super(key: key);

  final Widget child;
  Color midColor;
  bool isTop;

  /// Elevation relative to parent. Main constituent of Neumorphism.
  final double bevel;
  final CurveType curveType;

  /// The decoration to paint behind the [child].
  ///
  /// A shorthand for specifying just a solid color is available in the
  /// constructor: set the `color` argument instead of the `decoration`
  /// argument.
  final NeumorphicDecoration decoration;

  //color inside the container

  final AlignmentGeometry alignment;
  final double width;
  final double height;
  final BoxConstraints constraints;
  final EdgeInsetsGeometry margin;
  final EdgeInsets padding;
  final Matrix4 transform;

  @override
  Widget build(BuildContext context) {
    final color = decoration?.color ??
        NeuTheme
            .of(context)
            .backgroundColor ??
        Theme
            .of(context)
            .backgroundColor;
    final emboss = curveType == CurveType.emboss;

    Color colorValue = midColor;

    List<BoxShadow> shadowList;

    !isTop
        ? shadowList = [
      BoxShadow(
        color: _getAdjustColor(color, emboss ? 0 - bevel : bevel),
        offset: Offset(0 - bevel, 0 - bevel),
        blurRadius: bevel,
      ),
      BoxShadow(
        color: _getAdjustColor(color, emboss ? bevel : 0 - bevel),
        offset: Offset(bevel, bevel),
        blurRadius: bevel,
      )
    ]
        : shadowList = [];

    if (emboss) {
      shadowList = [
        BoxShadow(
          color: _getAdjustColor(color, bevel),
          offset: Offset(bevel / 4, bevel / 4),
          blurRadius: bevel / 4,
        ),
        BoxShadow(
          color: _getAdjustColor(color, 0 - bevel),
          offset: Offset(0 - bevel / 6, 0 - bevel / 6),
          blurRadius: bevel / 6,
        ),
      ];

      colorValue = _getAdjustColor(colorValue, 0 - bevel / 2);
    }

    Gradient gradient;
    switch (curveType) {
      case CurveType.concave:
        gradient = _getConcaveGradients(colorValue, bevel);
        break;
      case CurveType.convex:
        gradient = _getConvexGradients(colorValue, bevel);
        break;
      case CurveType.emboss:
      case CurveType.flat:
        gradient = _getFlatGradients(colorValue, bevel);
        break;
    }

    Widget content = child;

    if (decoration.borderRadius != null ||
        decoration.clipBehavior != Clip.antiAlias) {
      content = ClipRRect(
        borderRadius: decoration.borderRadius,
        clipBehavior: decoration.clipBehavior,
        child: content,
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      alignment: alignment,
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      padding: padding,
      transform: transform,
      decoration: BoxDecoration(
        borderRadius: decoration.borderRadius,
        gradient: gradient,
        boxShadow: shadowList,
        shape: decoration.shape,
        border: decoration.border,
      ),
      child: content,
    );
  }

  Color _getAdjustColor(Color baseColor, double amount) {
    Map<String, int> colors = {
      'r': baseColor.red,
      'g': baseColor.green,
      'b': baseColor.blue
    };

    colors = colors.map((key, value) {
      if (value + amount < 0) {
        return MapEntry(key, 0);
      }
      if (value + amount > 255) {
        return MapEntry(key, 255);
      }
      return MapEntry(key, (value + amount).floor());
    });
    return Color.fromRGBO(colors['r'], colors['g'], colors['b'], 1);
  }

  Gradient _getFlatGradients(Color baseColor, double depth) =>
      LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          baseColor,
          baseColor,
        ],
      );

  Gradient _getConcaveGradients(Color baseColor, double depth) =>
      LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          _getAdjustColor(baseColor, 0 - depth),
          _getAdjustColor(baseColor, depth),
        ],
      );

  Gradient _getConvexGradients(Color baseColor, double depth) =>
      LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          _getAdjustColor(baseColor, depth),
          _getAdjustColor(baseColor, 0 - depth),
        ],
      );
}

class NeumorphicDecoration {
  const NeumorphicDecoration({
    this.color,
    this.borderRadius,
    this.clipBehavior = Clip.antiAlias,
    this.shape = BoxShape.rectangle,
    this.border,
  });

  final Color color;
  final BorderRadiusGeometry borderRadius;
  final BoxShape shape;
  final BoxBorder border;
  final Clip clipBehavior;
}
