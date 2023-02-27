import 'dart:convert';
import 'package:flutter/services.dart';

import '../enum/type_enum.dart';
import '../paycell_models/request/complete_sales_request.dart';
import '../paycell_models/request/start_sales_operation_request.dart';
import '../paycell_models/response/start_sales_operation_response.dart';


class PaycellService {
  /// 3002 - QR ÖDEME BAŞARILI KODU
  /// 3006 - BANKA KREDİ BAŞARILI
  /// 3008 - İSTANBUL KART ÖDEME BAŞARILI
  /// 3016 - MKE satış banka başarılı
  /// 3034 - Taksitli Savaş
  final List<String> successfullPaymentCodes = [
    '3006',
    '3002',
    '3010',
    '3008',
    '1'
  ];

  static const platformForPaycellAppToAppIntegration =
      MethodChannel("example_integration/mposgatewaylib");

  Future<String?> startSalesOperation(
      PaycellStartSalesOperationRequest startSalesOperationReq) async {
    try {
      String? response =
          await platformForPaycellAppToAppIntegration.invokeMethod(
        'startSalesOperation',
        jsonEncode(startSalesOperationReq),
      );
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  completeSalesOperation(
      PaycellCompleteSalesRequest completeSalesOperationRequest) {
    platformForPaycellAppToAppIntegration.invokeMethod('completeSalesOperation',
        jsonEncode(completeSalesOperationRequest.toJson()));
  }

  PaycellDeviceStatusesEnum checkIfPosAvailable(String deviceResponse) {
    if (deviceResponse == 'Mpos is busy.') {
      return PaycellDeviceStatusesEnum.BUSY;
    }
    if (deviceResponse == 'Mpos isn\'t installed.') {
      return PaycellDeviceStatusesEnum.NOT_INSTALLED;
    }
    return PaycellDeviceStatusesEnum.FREE;
  }

  Future<void> startAndCompleteSalesOperation({
    required PaycellStartSalesOperationRequest startSalesOperationReq,
    VoidCallback? onDeviceBusy,
    VoidCallback? onMposNotInstalled,
    Function(String)? onPaymentSuccesfull,
    Function(String?)? onPaymentNotSuccesfull,
    VoidCallback? onPaymentResponseNull,
    VoidCallback? onError,
  }) async {
    final completeSalesReqHeader = HeaderForCompleteSalesReq(
        clientKey: startSalesOperationReq.header.clientKey,
        application: startSalesOperationReq.header.application
        );
    try {
      final salesResponse = await startSalesOperation(startSalesOperationReq);
      if (salesResponse != null) {
        final deviceStatus = checkIfPosAvailable(salesResponse);
        if (deviceStatus == PaycellDeviceStatusesEnum.BUSY) {
          completeSalesOperation(PaycellCompleteSalesRequest(
              header: completeSalesReqHeader, transactionResult: 2));
          onDeviceBusy?.call();
        } else if (deviceStatus == PaycellDeviceStatusesEnum.NOT_INSTALLED) {
          completeSalesOperation(PaycellCompleteSalesRequest(
              header: completeSalesReqHeader, transactionResult: 2));
          onMposNotInstalled?.call();
        } else {
          try {
            final mPosSalesResultJson = jsonDecode(salesResponse);
            StartSalesOperationRes mPosSalesResultAsModel =
                StartSalesOperationRes.fromJson(mPosSalesResultJson);
            if (successfullPaymentCodes
                .contains(mPosSalesResultAsModel.operationResult!.resultCode)) {
              completeSalesOperation(PaycellCompleteSalesRequest(
                  header: completeSalesReqHeader, transactionResult: 1));
              onPaymentSuccesfull
                  ?.call(startSalesOperationReq.header.transactionId);
            } else {
              completeSalesOperation(PaycellCompleteSalesRequest(
                  header: completeSalesReqHeader, transactionResult: 2));
              onPaymentNotSuccesfull
                  ?.call(mPosSalesResultAsModel.operationResult!.resultCode);
            }
          } catch (e) {
            completeSalesOperation(PaycellCompleteSalesRequest(
                header: completeSalesReqHeader, transactionResult: 2));
            onPaymentResponseNull?.call();
          }
        }
      } else {
        completeSalesOperation(PaycellCompleteSalesRequest(
            header: completeSalesReqHeader, transactionResult: 2));
        onPaymentResponseNull?.call();
      }
    } catch (e) {
      completeSalesOperation(PaycellCompleteSalesRequest(
          header: completeSalesReqHeader, transactionResult: 2));
      onError?.call();
    }
  }
}
