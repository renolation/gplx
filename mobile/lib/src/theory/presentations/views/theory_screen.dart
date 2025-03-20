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
                            itemBuilder: (context, index) {
                              final type = TypeEnum.values[index];
                              return ListTile(
                                title: Text(type.name),
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
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        children: [
          Container(
            color: Colors.green,
            child: TextButton(
              child: Text('De ngau nhien'),
              onPressed: () {},
            ),
          ),

          Container(
            color: Colors.green,
            child: TextButton(
              child: Text('On cau hoi'),
              onPressed: () {
                context.pushNamed('chapters');
              },
            ),
          ),
          Container(
            color: Colors.green,
            child: TextButton(
              child: Text('De thi'),
              onPressed: () {
                context.pushNamed('quizzes');
              },
            ),
          ),
          Container(
            color: Colors.green,
            child: TextButton(
              child: Text('Cac cau bi sai'),
              onPressed: () {},
            ),
          ),

          Container(
            color: Colors.green,
            child: TextButton(
              child: Text('Cau diem liet'),
              onPressed: () {

              },
            ),
          ),
          Container(
            color: Colors.green,
            child: TextButton(
              child: Text('Bien bao'),
              onPressed: () {

              },
            ),
          )
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
