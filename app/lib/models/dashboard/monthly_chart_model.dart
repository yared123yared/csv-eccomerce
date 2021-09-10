class MonthlyChartModel {
  late String total;
  late String months;

  MonthlyChartModel({required this.months, required this.total});

  MonthlyChartModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    months = json['months'];
  }
}
