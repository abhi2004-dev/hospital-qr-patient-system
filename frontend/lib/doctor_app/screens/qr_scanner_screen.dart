import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  bool flashOn = false;
  bool isProcessing = false;

  void _handleScan(String code) {
    if (isProcessing) return;

    setState(() => isProcessing = true);
    // return scanned code to previous screen
    Navigator.pop(context, code);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() => isProcessing = false);
    });
  }

  // Gallery QR Scan (robust fallback)
  Future<void> pickQrFromGallery() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    try {
      // Try controller.analyzeImage if available (works with many mobile_scanner versions)
      if (_controller != null) {
        // some versions return a list or a single Barcode; handle both cases safely
        dynamic result;
        try {
          // prefer controller.analyzeImage (may return List<Barcode> or Barcode)
          result = await _controller.analyzeImage(picked.path);
        } catch (_) {
          // ignore and try platform-level API usage below
          result = null;
        }

        if (result != null) {
          // result might be a Barcode, or List<Barcode>
          String? raw;
          if (result is List && result.isNotEmpty) {
            raw = (result.first as Barcode).rawValue;
          } else if (result is Barcode) {
            raw = (result as Barcode).rawValue;
          } else if (result is String) {
            raw = result;
          }

          if (raw != null && raw.isNotEmpty) {
            _handleScan(raw);
            return;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No QR code detected in the selected image.")));
            return;
          }
        }
      }

      // If controller.analyzeImage not available or returned null -> fallback
      // NOTE: If your `mobile_scanner` doesn't support analyzeImage, you can add another package
      // such as `qr_code_tools` or `zxing2` for offline image analysis. For now show message:
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Gallery QR scan not supported on this version. Try camera scan.")));

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("QR scan failed: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double frameSize = 280;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A77B8), Color(0xFF0AA2CE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              MobileScanner(
                controller: _controller,
                onDetect: (capture) {
                  if (capture.barcodes.isEmpty) return;
                  final barcode = capture.barcodes.first;
                  final raw = barcode.rawValue ?? "";
                  if (raw.isNotEmpty) _handleScan(raw);
                },
              ),

              Positioned(
                top: MediaQuery.of(context).size.height * 0.22,
                child: Container(
                  width: frameSize,
                  height: frameSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black, width: 3),
                  ),
                ),
              ),

              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              Positioned(
                bottom: 180,
                child: ElevatedButton.icon(
                  onPressed: pickQrFromGallery,
                  icon: const Icon(Icons.upload),
                  label: const Text("Upload QR"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 130,
                child: IconButton(
                  icon: Icon(
                    flashOn ? Icons.flash_on : Icons.flash_off,
                    size: 34,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _controller.toggleTorch();
                    setState(() => flashOn = !flashOn);
                  },
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 110,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE6E6E6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Scan a QR Code",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
