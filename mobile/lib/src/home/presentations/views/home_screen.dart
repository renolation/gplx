import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gplx_app/core/data/boxes.dart';
import 'package:gplx_app/core/utils/colors.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/ads/banner_ad.dart';
import '../../../../core/ads/interstitials_ad.dart';
import '../../../../core/utils/enums.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On thi GPLX'),
        actions: [
          // TextButton(
          //     onPressed: () => InterstitialAdProvider().showInterstitialAd(),
          //     child: const Text('Ads')),
          ValueListenableBuilder(
              valueListenable: SettingsBox().box.listenable(),
              builder: (context, box, _) {
                return TextButton(
                    onPressed: () {
                      showBarModalBottomSheet(
                        context: context,
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: Text('Chon loai xe'),
                            backgroundColor: Colors.black12,
                          ),
                          body: ListView.builder(
                            itemCount: TypeEnum.values.length,
                            itemBuilder: (context, index) {
                              final type = TypeEnum.values[index];
                              return ListTile(
                                title: Text(type.name),
                                subtitle: Text(type.desc),
                                onTap: () {
                                  SettingsBox().vehicleTypeQuestion = type.name;
                                  Navigator.pop(context);
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                    child: Text('Type ${SettingsBox().vehicleTypeQuestion}'));
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          children: [
            ButtonHome(
              name: 'Đề ngẫu nhiên',
              color: firstColor,
              function: () {
                context.pushNamed('randomQuiz');
              },
            ),
            ButtonHome(
              name: 'Ôn câu hỏi',
              color: secondColor,
              function: () {
                context.pushNamed('chapters');
              },
            ),
            ButtonHome(
              name: 'Đề thi',
              color: thirdColor,
              function: () {
                context.pushNamed('quizzes');
              },
            ),
            ButtonHome(
              name: 'Các câu sai',
              color: fourthColor,
              function: () {
                context.pushNamed('wrongAnswers');
              },
            ),
            ButtonHome(
              name: 'Câu điểm liệt',
              color: firstColor,
              function: () {
                context.pushNamed('importantQuestions');
              },
            ),
            ButtonHome(
              name: 'Biển báo',
              color: secondColor,
              function: () {
                context.pushNamed('signs');
              },
            ),
          ],
        ),
      ),
      // bottomSheet: Container(
      //   color: Colors.transparent,
      //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      //   child: const AnchoredAdaptiveExample(),
      // ),
    );
  }
}

class ButtonHome extends StatelessWidget {
  const ButtonHome({
    super.key,
    required this.name,
    required this.function,
    this.color = firstColor
  });

  final String name;
  final Function function;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: TextButton(
        onPressed: () => function(),
        child: Text(
          name,textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
