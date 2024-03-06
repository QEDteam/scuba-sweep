import 'package:flutter/material.dart';
import 'package:scuba_sweep/data/models/score_info_model.dart';
import 'package:scuba_sweep/game/helper/colors.dart';

class ScoresTable extends StatelessWidget {
  const ScoresTable(this.scoreList, {super.key});
  final List<ScoreInfo> scoreList;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.white,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: scoreList
            .map(
              (e) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: getRankColor(scoreList.indexOf(e) + 1),
                              border: Border.all(
                                color: AppColors.white,
                                width: 2,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.primary,
                                  blurRadius: 5,
                                )
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '${scoreList.indexOf(e) + 1}',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: 'LilitaOne',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${e.nickname == '' ? 'player' : e.nickname}:',
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'LilitaOne'),
                        ),
                        Expanded(child: Container()),
                        Text(
                          e.score.toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'LilitaOne'),
                        ),
                      ],
                    ),
                  ),
                  if (scoreList.indexOf(e) != scoreList.length - 1)
                    const Divider(
                      color: AppColors.white,
                      thickness: 2,
                    ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

Color getRankColor(int rank) {
  switch (rank) {
    case 1:
      return AppColors.buttonBottom;
    case 2:
      return AppColors.green;
    case 3:
      return AppColors.primaryLight;
    default:
      return Colors.transparent;
  }
}
