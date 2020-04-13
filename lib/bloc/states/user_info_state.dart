
import 'package:balance_app/model/user_info.dart';

/// Abstract class to represent the state of the user info bloc
abstract class UserInfoState {
  const UserInfoState();
}

/// Loading State
class UserInfoLoading extends UserInfoState {}

/// State with user info
class UserInfoSuccess extends UserInfoState {
  final UserInfo value;

  const UserInfoSuccess(this.value);
}