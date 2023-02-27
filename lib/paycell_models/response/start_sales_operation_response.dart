class StartSalesOperationRes {
    StartSalesOperationRes({
        this.mposUniqueId,
        this.card,
        this.cash,
        this.urunListesi,
        this.header,
        this.operationResult,
        this.orderNumber,
        this.paymentTypeId,
        this.transactionType,
        this.txnId,
        this.txnStep,
    });

    String? mposUniqueId;
    Card? card;
    Cash? cash;
    List<UrunListesi>? urunListesi;
    Header? header;
    OperationResult? operationResult;
    String? orderNumber;
    int? paymentTypeId;
    String? transactionType;
    String? txnId;
    int? txnStep;

    factory StartSalesOperationRes.fromJson(Map<String, dynamic> json) => StartSalesOperationRes(
        mposUniqueId: json['MPOSUniqueId'],
        card: Card.fromJson(json['card']),
        cash: Cash.fromJson(json['cash']),
        urunListesi: List<UrunListesi>.from(json['urunListesi'].map((x) => UrunListesi.fromJson(x))),
        header: Header.fromJson(json['header']),
        operationResult: OperationResult.fromJson(json['operationResult']),
        orderNumber: json['OrderNumber'],
        paymentTypeId: json['PaymentTypeId'],
        transactionType: json['transactionType'],
        txnId: json['TxnId'],
        txnStep: json['TxnStep'],
    );

}

class Card {
    Card({
        this.bankRefNo,
        this.paymentInterface,
    });

    String? bankRefNo;
    String? paymentInterface;

    factory Card.fromJson(Map<String, dynamic> json) => Card(
        bankRefNo: json['bankRefNo'],
        paymentInterface: json['PaymentInterface'],
    );

    Map<String, dynamic> toJson() => {
        'bankRefNo': bankRefNo,
        'PaymentInterface': paymentInterface,
    };
}

class Cash {
    Cash();

    factory Cash.fromJson(Map<String, dynamic> json) => Cash(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Header {
    Header({
        this.application,
        this.requestId,
        this.transactionDate,
        this.transactionId,
    });

    String? application;
    String? requestId;
    String? transactionDate;
    String? transactionId;

    factory Header.fromJson(Map<String, dynamic> json) => Header(
        application: json['application'],
        requestId: json['requestId'],
        transactionDate: json['transactionDate'],
        transactionId: json['transactionId'],
    );

    Map<String, dynamic> toJson() => {
        'application': application,
        'requestId': requestId,
        'transactionDate': transactionDate,
        'transactionId': transactionId,
    };
}

class OperationResult {
    OperationResult({
        this.resultCode,
        this.resultDesc,
    });

    String? resultCode;
    String? resultDesc;

    factory OperationResult.fromJson(Map<String, dynamic> json) => OperationResult(
        resultCode: json['resultCode'],
        resultDesc: json['resultDesc'],
    );

    Map<String, dynamic> toJson() => {
        'resultCode': resultCode,
        'resultDesc': resultDesc,
    };
}

class UrunListesi {
    UrunListesi({
        this.birim,
        this.birimFiyat,
        this.kdvTutari,
        this.kdvOrani,
        this.malHizmet,
        this.miktar,
        this.productId,
        this.toplamKdvTutari,
    });

    String? birim;
    String? birimFiyat;
    String? kdvTutari;
    String? kdvOrani;
    String? malHizmet;
    String? miktar;
    String? productId;
    String? toplamKdvTutari;

    factory UrunListesi.fromJson(Map<String, dynamic> json) => UrunListesi(
        birim: json['Birim'],
        birimFiyat: json['BirimFiyat'],
        kdvTutari: json['KDVTutari'],
        kdvOrani: json['KdvOrani'],
        malHizmet: json['MalHizmet'],
        miktar: json['Miktar'],
        productId: json['ProductId'],
        toplamKdvTutari: json['ToplamKDVTutari'],
    );

    Map<String, dynamic> toJson() => {
        'Birim': birim,
        'BirimFiyat': birimFiyat,
        'KDVTutari': kdvTutari,
        'KdvOrani': kdvOrani,
        'MalHizmet': malHizmet,
        'Miktar': miktar,
        'ProductId': productId,
        'ToplamKDVTutari': toplamKdvTutari,
    };
}
