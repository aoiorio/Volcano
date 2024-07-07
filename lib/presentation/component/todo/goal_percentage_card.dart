import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:volcano/presentation/component/global/bounced_button.dart';

class GoalPercentageCard extends ConsumerWidget {
  const GoalPercentageCard({
    super.key,
    required this.goalString,
    required this.goalPercentage,
    required this.onPress,
  });

  final String goalString;
  final double goalPercentage;
  final void Function() onPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(30),
      margin: const EdgeInsets.only(top: 50),
      width: 340,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xffAEADB9),
      ),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          BouncedButton(
            // TODO go to today's todo page!
            onPress: HapticFeedback.lightImpact,
            child: Container(
              width: 80,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xffE3E3E3),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '"',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff4D3769),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_outlined,
                    color: Color(0xff4D3769),
                  ),
                  Text(
                    '"',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff4D3769),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '"$goalString"',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.black),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    '$goalPercentage',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 48,
                        ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      '%',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 36,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              LinearPercentIndicator(
                width: 230,
                lineHeight: 28,
                // animation: true,
                padding: EdgeInsets.zero,
                // animationDuration: 1500,
                percent: goalPercentage / 100,
                barRadius: const Radius.circular(10),
                backgroundColor: const Color(0xffffffff),
                progressColor: const Color(0xff4C4C4C),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
