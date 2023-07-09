import 'package:clean_arch_example/core/error/failure.dart';

String getFailureMessage(Failure failure) {
  if (failure is CustomFailure) {
    return failure.message;
  } else if (failure is LocalStorageFailure) {
    return 'Local Storage Error';
  } else {
    return '';
  }
}
