import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gplx_app/core/data/boxes.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/ads/banner_ad.dart';
import '../../../../core/ads/interstitials_ad.dart';
import '../../../../core/utils/enums.dart';

class TheoryScreen extends StatelessWidget {
  const TheoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          TextButton(
              onPressed: () => InterstitialAdProvider().showInterstitialAd(),
              child: const Text('Ads')),
          ValueListenableBuilder(
              valueListenable: SettingsBox().box.listenable(),
              builder: (context, box, _) {
                return TextButton(
                    onPressed: () {
                      showMaterialModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          child: ListView.builder(
                            itemCount: TypeEnum.values.length,
                            itemBuilder: (context, index){
                              final type = TypeEnum.values[index];
                              return ListTile(
                                title: Text(type.name),
                                onTap: (){
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
      body: ListView(
        children: [
          ValueListenableBuilder(
              valueListenable: SettingsBox().box.listenable(),
              builder: (context, box, _) {
                return TextButton(
                    onPressed: () {
                      SettingsBox().hasFinishedOnboarding =
                          !SettingsBox().hasFinishedOnboarding;
                    },
                    child: Text(
                        'Settings ${SettingsBox().hasFinishedOnboarding}'));
              }),
          ValueListenableBuilder(
              valueListenable: QuestionsBox().box.listenable(),
              builder: (context, box, _) {
                return TextButton(
                    onPressed: () {},
                    child: Text(
                        'Question ${QuestionsBox().wrongQuestions.length}'));
              }),
          TextButton(
            child: Text('chapter'),
            onPressed: () {
              context.pushNamed('chapters');
            },
          ),
          TextButton(
            child: Text('wrong answers'),
            onPressed: () {
              context.pushNamed('wrongAnswers');
            },
          ),
          TextButton(
            child: Text('quizzes'),
            onPressed: () {
              context.pushNamed('quizzes');
            },
          ),
        ],
      ),
      // bottomSheet: Container(
      //   color: Colors.transparent,
      //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      //   child: const AnchoredAdaptiveExample(),
      // ),
    );
  }
}
