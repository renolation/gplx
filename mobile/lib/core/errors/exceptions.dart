
import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {

  const ServerException({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object> get props {
    return [message, statusCode];
  }
}

class CacheException extends Equatable implements Exception {

  const CacheException( {required this.message, this.statusCode = 500});

  final String message;
  final int statusCode;
  @override
  List<Object> get props {
    return [message, statusCode];
  }
}

class APIException extends Equatable implements Exception {

  const APIException( {required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object> get props {
    return [message, statusCode];
  }
}