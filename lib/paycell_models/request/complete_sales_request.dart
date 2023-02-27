import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class PaycellCompleteSalesRequest {
    PaycellCompleteSalesRequest({
        required this.header, 
        required this.transactionResult,
    });

    /// Slip basılıp basılmayacağı bilgisi bu alana set edilecek. “1”: slip basılacak , “2” :slip basılmayacak
    String printSlip='1';
    /// Body'de gönderilecek header modeli
    HeaderForCompleteSalesReq header;
    /// Milisaniye cinsinden slipler arası bekleme süresinin ne kadar olacağı belirlenecek.
    int slipEstimatedTime=1000;
    /// İşlem sonlandırmak istenden durumudur. “1”: İşlem başarılı “2”: İşlem başarısız
    int transactionResult;


    Map<String, dynamic> toJson() => {
        'PrintSlip': printSlip,
        'header': header.toJson(),
        'slipEstimatedTime': slipEstimatedTime,
        'transactionResult': transactionResult,
    };
}

class HeaderForCompleteSalesReq {
    HeaderForCompleteSalesReq({
        required this.clientKey,
        required this.application,
    });
    /// Servis kullanımı için önceden paylaşılacak, servis güvenlik parametresi
    String application;
    /// "PaycellMPOS" olarak verilecek.
    String clientKey;
    /// Satış tamamlama isteğinin request ID'si
    String requestId='2';
    /// İşlem tarihi aşağıda verilen formatta
    String transactionDate=DateFormat('yyyymmddHHMMSS').format(DateTime.now());
    /// İşleme verilen uniq id (numara, guid formatında)
    String transactionId=const Uuid().v4();

    Map<String, dynamic> toJson() => {
        'application': application,
        'ClientKey': clientKey,
        'requestId': requestId,
        'transactionDate': transactionDate,
        'transactionId': transactionId,
    };
}










