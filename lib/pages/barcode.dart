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
  String result = "";
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
            "Varescanner",
            style: TextStyle(fontSize: 30),
          ),
          Text(
            result.length != 0 ? result : "1234567890",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Column(children: [
            RawMaterialButton(
              child: Icon(
                Icons.qr_code_scanner_rounded,
                color: ScibbleColor.onlineOrange,
                size: 70,
              ),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
              fillColor: ScibbleColor.onlineBlue,
              elevation: 5.0,
              onPressed: _scanBarcode,
            ),
          ]),
        ]));
  }
}
