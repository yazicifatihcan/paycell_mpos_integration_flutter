import 'package:flutter/material.dart';
import 'package:paycell_mpos_integration_flutter/enum/type_enum.dart';
import 'package:paycell_mpos_integration_flutter/paycell_models/request/start_sales_operation_request.dart';
import 'package:paycell_mpos_integration_flutter/paycell_service/paycell_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paycell Entegrasyon Örneği',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paycell Entegrasyon Örneği"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => startSalesOperation(PaymentTypeEnum.CASH,context),
              child: const Text("Nakit ile Ödeme"),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () => startSalesOperation(PaymentTypeEnum.CASH,context),
              child: const Text("Kart ile Ödeme"),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> startSalesOperation(PaymentTypeEnum paymentType, BuildContext context) async {
  await PaycellService().startAndCompleteSalesOperation(
    startSalesOperationReq: paycellStartSalesOperationRequest(paymentType),
    onDeviceBusy: () => debugPrint("Device is Busy"),
    onError: () => debugPrint("Unexpected error occured."),
    onMposNotInstalled: () => debugPrint("Mpos Application not installed on device."),
    onPaymentNotSuccesfull: (resultCode) => debugPrint(resultCode),
    onPaymentResponseNull: () => debugPrint("Unexpected error occured."),
    onPaymentSuccesfull: (transactionId) => debugPrint("Payment succesfully taken. Transaction ID->$transactionId"),
  );
}

PaycellStartSalesOperationRequest paycellStartSalesOperationRequest(PaymentTypeEnum paymentType) => PaycellStartSalesOperationRequest(
    header: HeaderForStartSales(
        clientKey: "your-client-key-here", application: "PaycellMPOS", packageName: "com.procenne.mpos.turkcellmenu.test2", sequentialNo: "PB123456789", dateTime: DateTime.now()),
    invoiceStatus: "1",
    methodType: paymentType == PaymentTypeEnum.CASH ? "1" : "2",
    printSlip: "1",
    products: List.generate(5, (index) => ProductForSalesReq(productAmount: 20, productCount: 1, productKdvAmount: 18, productKdvRate: 8, productName: "Hamsi Tava")),
    subMerchantId: "123456789",
    totalAmount: 100,
    totalKdvAmount: 18,
    dgpNo: "DGP123456789");

