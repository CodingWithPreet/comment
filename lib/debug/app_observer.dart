import 'package:logger/logger.dart';
import 'package:bloc/bloc.dart';

final logger=Logger();

class AppObserver extends BlocObserver{
  @override
  void onCreate(BlocBase bloc) {
    logger.d('onCreate -- ${bloc.runtimeType}');
    super.onCreate(bloc);
  }
  @override
  void onChange(BlocBase bloc, Change change) {
    logger.d('onChange -- ${bloc.runtimeType},$change');
    super.onChange(bloc, change);
  }
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.e('onError -- ${bloc.runtimeType},$error');
    super.onError(bloc, error, stackTrace);
  }
  @override
  void onClose(BlocBase bloc) {
    logger.d('onClose -- ${bloc.runtimeType}');
    super.onClose(bloc);
  }
}