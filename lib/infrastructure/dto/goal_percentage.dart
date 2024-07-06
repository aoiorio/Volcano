import 'dart:convert';

import 'package:volcano/domain/entity/goal_percentage.dart';

class GoalPercentageDTO extends GoalPercentage{

    GoalPercentageDTO({
        super.todayGoalPercentage,
        super.monthGoalPercentage,
    });

    factory GoalPercentageDTO.fromJson(Map<String, dynamic> json) => GoalPercentageDTO(
        // ignore: avoid_dynamic_calls
        todayGoalPercentage: json['today_goal_percentage']?.toDouble(),
        // ignore: avoid_dynamic_calls
        monthGoalPercentage: json['month_goal_percentage']?.toDouble(),
    );

    factory GoalPercentageDTO.fromRawJson(String str) => GoalPercentageDTO.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    Map<String, dynamic> toJson() => {
        'today_goal_percentage': todayGoalPercentage,
        'month_goal_percentage': monthGoalPercentage,
    };
}
