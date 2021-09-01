class DailyChartModel {
  late String date;
  late String total;

  DailyChartModel(this.date, this.total);
  DailyChartModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    total = json['total'];
  }
}
