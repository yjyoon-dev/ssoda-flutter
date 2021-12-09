import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:hashchecker_web/models/reward.dart';

class Roulette extends StatelessWidget {
  final rouletteValue;
  final List<Reward> rewardList;
  const Roulette(
      {Key? key, required this.rouletteValue, required this.rewardList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<int, List<Color>> rouletteColorMap = {
      2: [Color(0xFFF15A5A), Color(0xFF2D95BF)],
      3: [Color(0xFFF15A5A), Color(0xFF4EBA6F), Color(0xFF2D95BF)],
      4: [
        Color(0xFFF15A5A),
        Color(0xFFF0C419),
        Color(0xFF4EBA6F),
        Color(0xFF2D95BF)
      ],
      5: [
        Color(0xFFF15A5A),
        Color(0xFFF0C419),
        Color(0xFF4EBA6F),
        Color(0xFF2D95BF),
        Color(0xFF955BA5)
      ]
    };

    return Container(
        padding: const EdgeInsets.all(20),
        child: FortuneWheel(
            indicators: [
              FortuneIndicator(
                  alignment: Alignment.topCenter,
                  child: TriangleIndicator(
                    color: Colors.white.withOpacity(0.7),
                  )),
            ],
            physics: NoPanPhysics(),
            selected: Stream.value(rewardList
                .indexWhere((element) => element.id == rouletteValue)),
            items: List.generate(
                rewardList.length,
                (index) => FortuneItem(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: AutoSizeText(
                        '   ${rewardList[index].name}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        maxLines: 1,
                        minFontSize: 5,
                      ),
                    ),
                    style: FortuneItemStyle(
                        color: rouletteColorMap[rewardList.length]![index],
                        borderWidth: 3,
                        borderColor: Colors.white)))));
  }
}
