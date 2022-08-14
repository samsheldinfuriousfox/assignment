import 'package:dartz/dartz.dart';

abstract class LoginRepo {
  Future<Either<String, String?>> login(String phoneNumber);
}
