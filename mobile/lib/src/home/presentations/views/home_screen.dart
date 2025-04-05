import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gplx_app/core/data/boxes.dart';
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
              name: 'De ngau nhien',
              function: () {
                context.pushNamed('randomQuiz');
              },
            ),
            ButtonHome(
              name: 'On cau hoi',
              function: () {
                context.pushNamed('chapters');
              },
            ),
            ButtonHome(
              name: 'De thi',
              function: () {
                context.pushNamed('quizzes');
              },
            ),
            ButtonHome(
              name: 'Cac cau bi sai',
              function: () {
                context.pushNamed('wrongAnswers');
              },
            ),
            ButtonHome(
              name: 'Cau diem liet',
              function: () {
                context.pushNamed('importantQuestions');
              },
            ),
            ButtonHome(
              name: 'Bien bao',
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
  });

  final String name;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: TextButton(
        onPressed: () => function(),
        child: Text(
          name,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
