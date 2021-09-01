class NumbersDashBoardModel {
  late int clientsCount;
  late int clientsThisMonth;
  late String month;
  late int totalDebt;
  late int totalPayment;

  NumbersDashBoardModel.fromJson(Map<String, dynamic> json) {
    clientsCount = json['clientsCount'];
    clientsThisMonth = json['clientsThisMonth'];
    month = json['month'];
    totalDebt = json['totalDebt'];
    totalPayment = json['totalPayment'];
  }
}
