import 'package:flutter/material.dart';

/// RoleSelectionScreen
/// Path: frontend/doctor_app/lib/common/role_selection_screen.dart
///
/// Notes:
/// - Saves you from missing imports by using internal placeholder pages for Doctor/Patient login.
/// - Replace DoctorLoginPlaceholder / PatientLoginPlaceholder with your real screens later,
///   or change the Navigator.push(...) to navigate to your actual screen widgets.

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  // Colors chosen to match your design
  static const Color bg = Color(0xFFBEEFF3); // light aqua background (tweak if you want)
  static const Color headingColor = Color(0xFF032859); // deep navy for text
  static const Color cardColor = Color(0xFF7FA3FF); // bluish-purple card
  static const Color buttonFill = Color(0xFFE6E6E6); // light grey pill buttons
  static const Color accent = Color(0xFF004E89); // darker accent (if needed)

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final double cardWidth = media.size.width * 0.92;
    final double cardHeight = media.size.height * 0.30;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: media.size.height - media.padding.top - media.padding.bottom,
            child: Column(
              children: [
                const SizedBox(height: 18),

                // Logo
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.asset(
                    'assets/logo.png',
                    height: 120,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const SizedBox(
                      height: 120,
                      child: Center(child: Text('LOGO', style: TextStyle(color: Colors.black45))),
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                // Tagline
                const Text(
                  'Health meets Technology..',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF032859),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 28),

                // Heading with shadow like the design
                Text(
                  'SELECT YOUR ROLE',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: headingColor,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        offset: Offset(2, 3),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // Big rounded card container
                Center(
                  child: Container(
                    width: cardWidth,
                    height: cardHeight,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Patient button
                        _RoleButton(
                          label: 'PATIENT',
                          onTap: () {
                            // Placeholder navigation -> replace with real screen later
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const PatientLoginPlaceholder()),
                            );
                          },
                          fillColor: buttonFill,
                          textColor: Colors.black87,
                        ),

                        const SizedBox(height: 22),

                        // Doctor button
                        _RoleButton(
                          label: 'DOCTOR',
                          onTap: () {
                            // Placeholder navigation -> replace with real screen later
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const DoctorLoginPlaceholder()),
                            );
                          },
                          fillColor: buttonFill,
                          textColor: Colors.black87,
                        ),
                      ],
                    ),
                  ),
                ),

                // Add some breathing space at bottom
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Simple reusable role button used in the card
class _RoleButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final Color fillColor;
  final Color textColor;

  const _RoleButton({
    required this.label,
    required this.onTap,
    required this.fillColor,
    required this.textColor,
  });

  @override
  State<_RoleButton> createState() => _RoleButtonState();
}

class _RoleButtonState extends State<_RoleButton> with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  late AnimationController _anim;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(vsync: this, duration: const Duration(milliseconds: 120));
    _anim.addListener(() {
      setState(() {
        _scale = 1.0 - (_anim.value * 0.05);
      });
    });
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails d) => _anim.forward();
  void _onTapUp(TapUpDetails d) {
    _anim.reverse();
    widget.onTap();
  }

  void _onTapCancel() => _anim.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: Transform.scale(
        scale: _scale,
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            color: widget.fillColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            widget.label,
            style: TextStyle(
              color: widget.textColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}

/// Placeholder doctor login page — replace with your real screen later.
/// Saved here to keep the role-selection screen self-contained and runnable.
class DoctorLoginPlaceholder extends StatelessWidget {
  const DoctorLoginPlaceholder({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Login'),
        backgroundColor: const Color(0xFF004E89),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Text('Doctor login screen placeholder\nReplace this widget with your real login screen.',
            textAlign: TextAlign.center),
      ),
    );
  }
}

/// Placeholder patient login page — replace with your real screen later.
class PatientLoginPlaceholder extends StatelessWidget {
  const PatientLoginPlaceholder({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Login'),
        backgroundColor: const Color(0xFF004E89),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Text('Patient login screen placeholder\nReplace this widget with your real patient login screen.',
            textAlign: TextAlign.center),
      ),
    );
  }
}
