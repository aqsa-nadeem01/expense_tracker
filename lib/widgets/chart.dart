import 'package:expense_tracker_app/controller/expense_controller.dart';
import 'package:expense_tracker_app/model/chart.dart';
import 'package:expense_tracker_app/model/expense.dart';
import 'package:expense_tracker_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    // Function to aggregate the data
    List<ChartData> getAggregatedData(List<Expense> expenses) {
      Map<String, double> categoryTotals = {};

      for (var expense in expenses) {
        String category = expense.category.title;
        double amount = expense.amount;

        if (categoryTotals.containsKey(category)) {
          categoryTotals[category] = categoryTotals[category]! + amount;
        } else {
          categoryTotals[category] = amount;
        }
      }

      return categoryTotals.entries.map((entry) {
        var expense =
            expenses.firstWhere((exp) => exp.category.title == entry.key);
        return ChartData(entry.key, entry.value, expense.category.color);
      }).toList();
    }

    return SizedBox(
      height: SizeConfig.screenHeight * 0.4,
      child: Obx(() {
        // Fetching expenses reactively from ExpenseController
        final expenses =
            Get.find<ExpenseController>().registratedExpense.toList();

        // Aggregate data based on current expense list
        final chartData = getAggregatedData(expenses);

        return SfCircularChart(
          series: [
            PieSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.category,
              yValueMapper: (ChartData data, _) => data.amount,
              pointColorMapper: (ChartData data, _) => data.color,
              dataLabelMapper: (ChartData data, _) =>
                  '\$${data.amount.toStringAsFixed(1)}',
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelPosition: ChartDataLabelPosition.outside,
              ),
            ),
          ],
          legend: const Legend(
            isVisible: true,
            position:
                LegendPosition.bottom,
            overflowMode: LegendItemOverflowMode
                .wrap,
            textStyle: TextStyle(fontSize: 12),
          ),
          tooltipBehavior: TooltipBehavior(enable: true),
        );
      }),
    );
  }
}
