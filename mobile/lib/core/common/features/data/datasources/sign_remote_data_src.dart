

import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../errors/exceptions.dart';
import '../models/sign_model.dart';

abstract class SignRemoteDataSrc {
  const SignRemoteDataSrc();

  Future<List<SignModel>> getSigns();

}

class SignRemoteDataSrcImpl implements SignRemoteDataSrc {
  const SignRemoteDataSrcImpl({
    required SupabaseClient client,
}) : _client = client;

  final SupabaseClient _client;

  @override
  Future<List<SignModel>> getSigns() async {
    try {
      final data = await _client
          .from('sign')
          .select('*');


      String jsonString = jsonEncode(data);
      final fetchedSigns = signModelFromJson(jsonString);
      return fetchedSigns;
    } on ServerException {
      rethrow;
    } on CacheException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

}