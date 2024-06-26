class OrderHistory{
  String orderId;
  String paymentId;

  OrderHistory({
    required this.orderId,
    required this.paymentId,
  });

  factory OrderHistory.fromMap(Map<String, dynamic> json) => OrderHistory(
    orderId: json["orderId"],
    paymentId: json["paymentId"],
  );

  Map<String, dynamic> toMap() => {
    "orderId": orderId,
    "paymentId": paymentId,
  };

}