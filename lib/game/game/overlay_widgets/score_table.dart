import 'package:flutter/material.dart';
import 'package:scuba_sweep/data/models/score_info_model.dart';
import 'package:scuba_sweep/game/helper/colors.dart';

class ScoresTable extends StatelessWidget {
  const ScoresTable(this.scoreList, {super.key});
  final List<ScoreInfo> scoreList;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.background),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: scoreList
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.primaryLight,
                          AppColors.primary,
                          AppColors.cardColor,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.orange,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary,
                                    blurRadius: 5,
                                  )
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '${scoreList.indexOf(e) + 1}.',
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontFamily: 'LilitaOne',
                                    shadows: [
                                      Shadow(
                                        color: AppColors.primary,
                                        blurRadius: 8,
                                      )
                                    ]),
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
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
