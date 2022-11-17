import 'package:dartz/dartz.dart';

import '../error/failures.dart';

abstract class UseCase<Type> {
  Future<Either<Failure, Type>> call();
}