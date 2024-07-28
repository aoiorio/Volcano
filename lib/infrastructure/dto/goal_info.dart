import 'dart:convert';

import 'package:volcano/infrastructure/dto/todo.dart';

// NOTE this file doesn't extend entity, because I need to convert json to Map

class GoalInfo {
  GoalInfo({
    this.todayGoal,
    this.monthGoal,
  });

  factory GoalInfo.fromJson(Map<String, dynamic> json) => GoalInfo(
        todayGoal: json['today_goal'] == null
            ? null
            : TodayGoal.fromJson(json['today_goal']),
        monthGoal: json['month_goal'] == null
            ? null
            : MonthGoal.fromJson(json['month_goal']),
      );

  factory GoalInfo.fromRawJson(String str) =>
      GoalInfo.fromJson(json.decode(str));
  final TodayGoal? todayGoal;
  final MonthGoal? monthGoal;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'today_goal': todayGoal?.toJson(),
        'month_goal': monthGoal?.toJson(),
      };
}

class MonthGoal {
  MonthGoal({
    this.monthGoalPercentage,
    this.monthTodo,
  });

  factory MonthGoal.fromRawJson(String str) =>
      MonthGoal.fromJson(json.decode(str));

  factory MonthGoal.fromJson(Map<String, dynamic> json) => MonthGoal(
        // ignore: avoid_dynamic_calls
        monthGoalPercentage: json['month_goal_percentage']?.toDouble(),
        monthTodo: json['month_todo'] == null
            ? []
            : List<TodoDTO>.from(
                // ignore: inference_failure_on_untyped_parameter, avoid_dynamic_calls, lines_longer_than_80_chars, unnecessary_lambdas
                json['month_todo']!.map((x) => TodoDTO.fromJson(x)),
              ),
      );
  final double? monthGoalPercentage;
  final List<TodoDTO>? monthTodo;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'month_goal_percentage': monthGoalPercentage,
        'month_todo': monthTodo == null
            ? <dynamic>[]
            : List<dynamic>.from(monthTodo!.map((x) => x.toJson())),
      };
}

class TodayGoal {
  TodayGoal({
    this.todayGoalPercentage,
    this.todayTodo,
  });

  factory TodayGoal.fromJson(Map<String, dynamic> json) => TodayGoal(
        todayGoalPercentage: json['today_goal_percentage'],
        todayTodo: json['today_todo'] == null
            ? []
            : List<TodoDTO>.from(
                // ignore: inference_failure_on_untyped_parameter, avoid_dynamic_calls, lines_longer_than_80_chars, unnecessary_lambdas
                json['today_todo']!.map((x) => TodoDTO.fromJson(x)),
              ),
      );

  factory TodayGoal.fromRawJson(String str) =>
      TodayGoal.fromJson(json.decode(str));
  final double? todayGoalPercentage;
  final List<TodoDTO>? todayTodo;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'today_goal_percentage': todayGoalPercentage,
        'today_todo': todayTodo == null
            ? <dynamic>[]
            : List<dynamic>.from(todayTodo!.map((x) => x.toJson())),
      };
}
