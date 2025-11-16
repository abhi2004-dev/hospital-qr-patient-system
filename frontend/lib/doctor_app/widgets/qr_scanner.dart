import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart' as ms;
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart'
    as mlkit;

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final ms.MobileScannerController _controller = ms.MobileScannerController(
    detectionSpeed: ms.DetectionSpeed.noDuplicates,
  );

  bool flashOn = false;
  bool isProcessing = false;

  void _handleScan(String code) {
    if (isProcessing) return;

    setState(() => isProcessing = true);
    Navigator.pop(context, code);

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() => isProcessing = false);
    });
  }

  Future<void> pickQrFromGallery() async {
    try {
      final XFile? file =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (file == null) return;

      final mlkit.InputImage inputImage =
          mlkit.InputImage.fromFilePath(file.path);

      final barcodeScanner = mlkit.BarcodeScanner(
        formats: [mlkit.BarcodeFormat.qrCode],
      );

      final List<mlkit.Barcode> barcodes =
          await barcodeScanner.processImage(inputImage);

      if (barcodes.isEmpty || barcodes.first.rawValue == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No QR code detected")),
        );
        return;
      }

      _handleScan(barcodes.first.rawValue!);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error scanning QR: $e")),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              ms.MobileScanner(
                controller: _controller,
                onDetect: (capture) {
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
                    border: Border.all(
                      color: Colors.white.withOpacity(0.9),
                      width: 3,
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back,
                      size: 32, color: Colors.white),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                    color: Colors.white,
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
