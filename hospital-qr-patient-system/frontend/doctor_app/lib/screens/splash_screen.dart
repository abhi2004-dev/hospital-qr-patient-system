import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../screens/role_selection_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotation;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2200));
    _rotation = Tween<double>(begin: pi / 4, end: 0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _scale = Tween<double>(begin: 0.6, end: 3.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _opacity = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();
    Timer(const Duration(milliseconds: 2600), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RoleSelectionScreen()));
    });
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (ctx, child) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFFE0F7FA), Color(0xFF2EB5E0)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            child: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Transform.rotate(
                  angle: _rotation.value,
                  child: Transform.scale(
                    scale: _scale.value,
                    child: Opacity(
                      opacity: _opacity.value.clamp(0.0, 1.0),
                      child: Image.asset('assets/logo.png', width: 120, height: 120),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                const Text('HEALTH_QR', style: TextStyle(color: Color(0xFF032859), fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 2)),
                const SizedBox(height: 8),
                const Text('Smart Health. Simplified.', style: TextStyle(color: Color(0xFF032859), fontSize: 14)),
              ]),
            ),
          );
        },
      ),
    );
  }
}
