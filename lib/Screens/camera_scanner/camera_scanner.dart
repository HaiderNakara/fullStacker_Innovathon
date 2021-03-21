import 'dart:io';

import 'package:flutter/material.dart';

import 'package:inventory_management_system/Screens/product_detail/product_detail.dart';
import 'package:inventory_management_system/db.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

class CameraScanner extends StatefulWidget {
  static String routeName = "/productdetail";
  @override
  _CameraScannerState createState() => _CameraScannerState();
}

class _CameraScannerState extends State<CameraScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    DatabaseService _db = DatabaseService();
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? {
                      result.code != null
                          ? Future.delayed(Duration.zero, () {
                              Navigator.pushReplacementNamed(
                                  context, ProductDetail.routeName,
                                  arguments: result.code);
                            })
                          : Text("$result")
                    }
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    try {
      this.controller = controller;
      controller.scannedDataStream.listen((scanData) {
        setState(() {
          result = scanData;
        });
      });
    } catch (e) {
      return e;
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

// class CameraScanner extends StatefulWidget {
//   static String routeName = "/productdetail";
//   @override
//   _CameraScannerState createState() => _CameraScannerState();
// }

// class _CameraScannerState extends State<CameraScanner> {
//   String qrCode = "unknown";
//   Future<void> scanQRCode() async {
//     try {
//       await FlutterBarcodeScanner.scanBarcode(
//         "#ff6666",
//         "Cancel",
//         true,
//         ScanMode.QR,
//       );
//       if (!mounted) return;
//       setState(() {
//         this.qrCode = qrCode;
//       });
//     } on PlatformException {
//       qrCode = "Faileded";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: ElevatedButton(
//         onPressed: () => scanQRCode(),
//         child: Text("Start Scanning"),
//       ),
//     );
//   }
// }
