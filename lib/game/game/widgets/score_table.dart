import 'package:flutter/material.dart';
import 'package:my_flutter_app/data/models/score_info_model.dart';

class ScoresTable extends StatelessWidget {
  const ScoresTable(this.scoreList, {super.key});
  final List<ScoreInfo> scoreList;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white,
          width: 0.5,
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: scoreList
              .map(
                (e) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${e.nickname}:',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          e.score.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    if (e != scoreList.last)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          width: 200,
                          height: 0.5,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
