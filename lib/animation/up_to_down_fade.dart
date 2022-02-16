import 'package:flutter/material.dart';

class UpToDownFade extends StatefulWidget {
  final double delay;
  final Widget child;
  const UpToDownFade({Key? key, required this.child, required this.delay}) : super(key: key);

  @override
  _UpToDownFadeState createState() => _UpToDownFadeState();
}

class _UpToDownFadeState extends State<UpToDownFade>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;
  late Animation<double> traslateY;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    opacity = Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(parent: controller, curve: Curves.ease));
    traslateY = Tween(begin: -20.0,end: 0.0).animate(CurvedAnimation(parent: controller, curve: Curves.ease));
    startAnimation();
    super.initState();
  }

  startAnimation() async{
    await Future.delayed(Duration(milliseconds: (widget.delay * 1000).round()));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Opacity(
          opacity: opacity.value,
          child: Transform.translate(
            offset: Offset(0,traslateY.value),
            child: widget.child,
          ),
        );
      },
    );
  }
}
