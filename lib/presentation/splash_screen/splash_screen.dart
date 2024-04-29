import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/splash_screen/controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final controller = Get.put(SplashController());
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 7),
    );
    _animation = Tween<double>(begin: -250, end: 50).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastEaseInToSlowEaseOut, // Add the desired curve here
      ),
    )..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        width: SizeUtils.width,
        height: SizeUtils.height,
        color: Colors.white,
        child: AnimatedCrossFade(
          crossFadeState: _animation.value > 30
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: Duration(seconds: 2),
          firstChild: Visibility(
            visible: _animation.value < 30,
            replacement: Container(
              width: SizeUtils.width,
              height: SizeUtils.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment(-0.04, 0.06),
                      end: Alignment(1.04, 0.95),
                      colors: [
                    theme.colorScheme.onPrimary.withOpacity(1),
                    appTheme.redA200
                  ])),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                    left: _animation.value == -250 ? 60 : -60,
                    curve: Curves.easeInOut,
                    duration: Duration(seconds: 3),
                    child: Material(
                        child: Image.asset(
                      'assets/images/imgmap.png',
                      height: 200.h,
                      fit: BoxFit.fitHeight,
                    ))),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.rotate(
                      angle: -51.60,
                      child: CustomImageView(
                        imagePath: 'assets/images/Line2.png',
                      ),
                    ),
                    AnimatedPositioned(
                      top: _animation.value == -250 ? 0.h : 150.h,
                      left: _animation.value == -250 ? 40.v : 118.v,
                      duration: Duration(seconds: 3),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomImageView(
                        margin: EdgeInsets.only(bottom: 120.v),
                        imagePath: 'assets/images/Line2.png'),
                    AnimatedPositioned(
                      left: _animation.value == -250 ? 0.v : 105.v,
                      bottom: _animation.value == -250 ? 120.h : 215.h,
                      duration: Duration(seconds: 3),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomImageView(
                        margin: EdgeInsets.only(top: 120.v),
                        imagePath: 'assets/images/Line2.png'),
                    AnimatedPositioned(
                      left: _animation.value == -250 ? 55.v : 160.v,
                      bottom: _animation.value == -250 ? 50.h : 150.h,
                      duration: Duration(seconds: 3),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                // AnimatedBuilder(
                //   animation: _controllerHeart,
                //   builder: (context, child) {
                //     print('heart${_animationHeart.value}');
                //     if (_animationHeart.value > 45) {
                //       //_controllerHeart.stop();
                //       _controller.stop();
                //     }
                //     return AnimatedPositioned(
                //       duration: Duration(seconds: 1),
                //       left: 90.v,
                //       bottom: 320.h,
                //       child: Icon(
                //         Icons.favorite,
                //         color: appTheme.redA200,
                //       ),
                //     );
                //   },
                // ),

                ClipPath(
                  clipper: CenterHoleClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment(-0.04, 0.06),
                            end: Alignment(1.04, 0.95),
                            colors: [
                          theme.colorScheme.onPrimary.withOpacity(1),
                          appTheme.redA200
                        ])),
                  ),
                ),
              ],
            ),
          ),
          secondChild: AnimatedCrossFade(
            crossFadeState: _animation.value > 45
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(seconds: 1),
            firstChild: Material(
              child: Container(
                height: SizeUtils.height,
                width: SizeUtils.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-0.04, 0.06),
                    end: Alignment(1.04, 0.95),
                    colors: [
                      theme.colorScheme.onPrimary.withOpacity(1),
                      appTheme.redA200
                    ],
                  ),
                ),
                child: Center(
                  child: CustomImageView(
                    imagePath: 'assets/images/Get your passport ready.png',
                  ),
                ),
              ),
            ),
            secondChild: Material(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment(-0.04, 0.06),
                        end: Alignment(1.04, 0.95),
                        colors: [
                      theme.colorScheme.onPrimary.withOpacity(1),
                      appTheme.redA200
                    ])),
                child: Center(
                  child: CustomImageView(
                    imagePath: ImageConstant.imgGroup54,
                    // height: 87.v,
                    // width: 120.h,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CenterHoleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(
          Rect.fromCircle(center: size.center(Offset.zero), radius: 100.0))
      ..fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
