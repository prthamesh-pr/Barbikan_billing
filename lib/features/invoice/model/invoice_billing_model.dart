class InvoiceBillingModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  InvoiceBillingModel({this.statusCode, this.data, this.message, this.success});

  InvoiceBillingModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  List<Bills>? bills;

  Data({this.bills});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['bills'] != null) {
      bills = <Bills>[];
      json['bills'].forEach((v) {
        bills!.add(new Bills.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bills != null) {
      data['bills'] = this.bills!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bills {
  String? id;
  String? invoiceNumber;
  String? invoiceDate;
  String? dueDate;
  String? partyId;
  String? totalAmount;
  String? createdAt;
  String? updatedAt;
  List<InvoiceItems>? invoiceItems;
  PurchaseParty? purchaseParty;

  Bills(
      {this.id,
        this.invoiceNumber,
        this.invoiceDate,
        this.dueDate,
        this.partyId,
        this.totalAmount,
        this.createdAt,
        this.updatedAt,
        this.invoiceItems,
        this.purchaseParty});

  Bills.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNumber = json['invoice_number'];
    invoiceDate = json['invoice_date'];
    dueDate = json['due_date'];
    partyId = json['party_id'];
    totalAmount = json['total_amount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['InvoiceItems'] != null) {
      invoiceItems = <InvoiceItems>[];
      json['InvoiceItems'].forEach((v) {
        invoiceItems!.add(new InvoiceItems.fromJson(v));
      });
    }
    purchaseParty = json['PurchaseParty'] != null
        ? new PurchaseParty.fromJson(json['PurchaseParty'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_number'] = this.invoiceNumber;
    data['invoice_date'] = this.invoiceDate;
    data['due_date'] = this.dueDate;
    data['party_id'] = this.partyId;
    data['total_amount'] = this.totalAmount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.invoiceItems != null) {
      data['InvoiceItems'] = this.invoiceItems!.map((v) => v.toJson()).toList();
    }
    if (this.purchaseParty != null) {
      data['PurchaseParty'] = this.purchaseParty!.toJson();
    }
    return data;
  }
}

class InvoiceItems {
  String? id;
  String? salesBillId;
  String? productName;
  String? price;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  InvoiceItems(
      {this.id,
        this.salesBillId,
        this.productName,
        this.price,
        this.quantity,
        this.createdAt,
        this.updatedAt});

  InvoiceItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesBillId = json['sales_bill_id'];
    productName = json['product_name'];
    price = json['price'];
    quantity = json['quantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sales_bill_id'] = this.salesBillId;
    data['product_name'] = this.productName;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class PurchaseParty {
  String? partyName;
  String? id;

  PurchaseParty({this.partyName, this.id});

  PurchaseParty.fromJson(Map<String, dynamic> json) {
    partyName = json['party_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['party_name'] = this.partyName;
    data['id'] = this.id;
    return data;
  }
}
