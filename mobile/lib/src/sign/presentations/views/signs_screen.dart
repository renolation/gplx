import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gplx_app/core/common/features/data/models/sign_model.dart';
import 'package:gplx_app/src/sign/presentations/bloc/sign_bloc.dart';

class SignsScreen extends StatelessWidget {
  const SignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biển báo giao thông'),
      ),
      body: BlocBuilder<SignBloc, SignState>(builder: (context, state) {
        if (state is SignLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SignLoaded) {
          Map<String, List<SignModel>> signs = {};
          for (var sign in state.signs) {
            if (signs.containsKey(sign.type)) {
              signs[sign.type]?.add(sign);
            } else {
              signs[sign.type] = [sign];
            }
          }

          return ListView.builder(
            itemCount: signs.length,
            itemBuilder: (context, index) {
              final sign = signs.values.elementAt(index);
              return ExpansionTile(
                title: Text(signs.keys.elementAt(index)),
                initiallyExpanded: true,
                children: sign
                    .map(
                      (e) => ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: 'https://taplaixe.vn${e.image}',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text('${e.bold} ${e.name}'),
                        subtitle: Text(e.desc),
                      ),
                    )
                    .toList(),
              );
            },
          );
        } else if (state is SignError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      }),
    );
  }
}
