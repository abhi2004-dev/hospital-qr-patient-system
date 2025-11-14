import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../utils/api_service.dart';
import 'patient_basic_info_screen.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({Key? key}) : super(key: key);

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool processing = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) controller?.pauseCamera();
    controller?.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onCreated(QRViewController ctrl) {
    controller = ctrl;

    ctrl.scannedDataStream.listen((scan) async {
      if (processing) return;
      processing = true;

      final raw = scan.code;
      if (raw == null) {
        _msg("Invalid QR");
        processing = false;
        return;
      }

      try {
        Map payload =
            raw.startsWith("{") ? jsonDecode(raw) : {"type": "patient", "id": raw};

        if (payload["type"] != "patient") {
          _msg("Invalid patient QR");
          processing = false;
          return;
        }

        final id = payload["id"];

        final res = await ApiService.getPatientSummary(id);
        if (res["success"] == true) {
          final data = res["body"]["patient"] ?? res["body"];

          await controller?.pauseCamera();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PatientBasicInfoScreen(
                data: data,
                doctorId: '',
              ),
            ),
          ).then((_) {
            controller?.resumeCamera();
          });
        } else {
          _msg("Patient not found");
        }
      } catch (e) {
        _msg("QR error");
      }

      processing = false;
    });
  }

  void _msg(String s) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan Patient QR")),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onCreated,
            ),
          ),
          const Expanded(
            flex: 1,
            child: Center(child: Text("Align QR inside the box")),
          ),
        ],
      ),
    );
  }
}
