import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:scibble/theme/scibble_color.dart';

class Barcode extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Barcode> {
  String result = "Varescanner";
  Future _scanBarcode() async {
    try {
      ScanResult barcodeResult = await BarcodeScanner.scan();
      setState(() {
        result = barcodeResult.rawContent;
      });
    } on PlatformException catch (pe) {
      if (pe.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result = "Kameratillatelse ble nektet";
        });
      } else {
        setState(() {
          result = "Noe gikk galt $pe";
        });
      }
    } on FormatException {
      setState(() {
        result = "Ingenting ble scannet";
      });
    } catch (ex) {
      setState(() {
        result = "Noe gikk galt $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          Text(
            result,
            style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: IconButton(
              iconSize: 70,
              color: ScibbleColor.onlineBlue,
              icon: Icon(
                Icons.qr_code_scanner_rounded,
              ),
              onPressed: _scanBarcode,
            ),
          ),
        ]));
  }
}
