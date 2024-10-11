import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:microbook_library/model/live_model.dart';
import 'package:microbook_library/model/micro_model.dart';

class MicroListBloc extends Cubit<Map<String, dynamic>> {
  MicroListBloc(super.initialState);

  /// 点击展示微册页面
  void showMicroDetail(MicroModel model) {
    emit(model.toJson());
  }

  /// 显示直播页面
  void showLiveStream(LiveModel model) {
    emit(model.toJson());
  }
}
