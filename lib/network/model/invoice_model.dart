// To parse this JSON data, do
//
//     final invoiceModel = invoiceModelFromJson(jsonString);

import 'dart:convert';

List<InvoiceModel> invoiceModelFromJson(String str) => List<InvoiceModel>.from(json.decode(str).map((x) => InvoiceModel.fromJson(x)));

String invoiceModelToJson(List<InvoiceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InvoiceModel {
    InvoiceModel({
        this.invoice,
        this.idUser,
        this.fullname,
        this.orderAt,
        this.idOrders,
        this.status,
        this.detail,
    });

    String invoice;
    String idUser;
    String fullname;
    DateTime orderAt;
    String idOrders;
    String status;
    List<Detail> detail;

    factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        invoice: json["invoice"],
        idUser: json["id_user"],
        fullname: json["fullname"],
        orderAt: DateTime.parse(json["order_at"]),
        idOrders: json["id_orders"],
        status: json["status"],
        detail: List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "invoice": invoice,
        "id_user": idUser,
        "fullname": fullname,
        "order_at": orderAt.toIso8601String(),
        "id_orders": idOrders,
        "status": status,
        "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
    };
}

class Detail {
    Detail({
        this.idOrders,
        this.invoice,
        this.idProduct,
        this.nameProduct,
        this.quantity,
        this.price,
        this.total,
    });

    String idOrders;
    String invoice;
    String idProduct;
    String nameProduct;
    String quantity;
    String price;
    String total;

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        idOrders: json["id_orders"],
        invoice: json["invoice"],
        idProduct: json["id_product"],
        nameProduct: json["nameProduct"],
        quantity: json["quantity"],
        price: json["price"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "id_orders": idOrders,
        "invoice": invoice,
        "id_product": idProduct,
        "nameProduct": nameProduct,
        "quantity": quantity,
        "price": price,
        "total": total,
    };
}
