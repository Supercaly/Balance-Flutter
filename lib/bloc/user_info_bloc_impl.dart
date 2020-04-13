
import 'package:balance_app/bloc/events/user_info_events.dart';
import 'package:balance_app/bloc/states/user_info_state.dart';
import 'package:balance_app/repository/user_info_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Bloc class of the user info bloc
class UserInfoBloc extends Bloc<UserInfoEvents, UserInfoState> {
  UserInfoRepository repository = UserInfoRepository();

  UserInfoBloc._();
  factory UserInfoBloc.create() => UserInfoBloc._()..add(UserInfoEvents.fetch);

  @override
  UserInfoState get initialState => UserInfoLoading();

  @override
  Stream<UserInfoState> mapEventToState(UserInfoEvents event) async* {
    yield UserInfoSuccess(await repository.getUserInfo());
  }
}