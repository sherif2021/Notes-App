import 'package:clean_arch_example/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class FutureUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
