
import 'package:another_flushbar/flushbar.dart';
import 'package:buts_conductor_app/Controller/provider.dart';
import 'package:buts_conductor_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late QRViewController _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
      _controller.scannedDataStream.listen((scanData) async {
        _controller.pauseCamera();
        print('Scanned data: ${scanData.code}');
        List<String>? QRdata = scanData.code?.split(" ");
        Provider.of<AppProvider>(context, listen: false).updateTicketData(QRdata![1], QRdata[0], QRdata[2]);
        try {
          bool scanned = await Provider.of<AppProvider>(context, listen: false).scanQR();
          if(scanned){
            Navigator.pop(context);
            Flushbar(
              message: "Scanned Successfully",
              icon: const Icon(
                Icons.info_outline,
                size: 28.0,
                color: kYellow,
              ),
              duration: const Duration(seconds: 3),
              leftBarIndicatorColor: kYellow,
              flushbarPosition: FlushbarPosition.TOP,
            ).show(context);
          }
        } catch(e) {
          Navigator.pop(context);
          Flushbar(
            message: e.toString(),
            icon: const Icon(
              Icons.info_outline,
              size: 28.0,
              color: kYellow,
            ),
            duration: const Duration(seconds: 3),
            leftBarIndicatorColor: kYellow,
            flushbarPosition: FlushbarPosition.TOP,
          ).show(context);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: QRView(
                key: _qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(borderRadius: 10, borderColor: kBlue, borderLength: 80, borderWidth: 5),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'Scan QR Code',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
