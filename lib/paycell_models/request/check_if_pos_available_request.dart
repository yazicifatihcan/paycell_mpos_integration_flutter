import 'package:uuid/uuid.dart';

class PaycellCheckIfPosAvailableRequest {
    PaycellCheckIfPosAvailableRequest({
      required this.header,
    });
    
    /// Body'de gönderilecek header modeli
    HeaderForIfPosAvailable header;
    /// "1" olarak gönderilecek.
    String methodType='1';

    Map<String, dynamic> toJson() => {
        'header': header.toJson(),
        'methodType': methodType,
    };
}

class HeaderForIfPosAvailable {
   HeaderForIfPosAvailable(
    {
    required this.clientKey,
    required this.application,
    }
   );
    /// "PaycellMPOS" olarak verilecek.
    String application;
    /// Servis kullanımı için önceden paylaşılacak, servis güvenlik parametresi
    String clientKey;
    /// Pos Müsaitliği kontrol isteğinin request ID'si
    String requestId='5';
    /// İşleme verilen uniq id (numara, guid formatında)
    String transactionId=const Uuid().v4();

    Map<String, dynamic> toJson() => {
        'application': application,
        'ClientKey': clientKey,
        'requestId': requestId,
        'transactionId': transactionId,
    };
}

