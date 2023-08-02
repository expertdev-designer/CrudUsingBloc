//part of 'user_list_bloc.dart';

import '../model/user.dart';

abstract class UserListState{
  List<User> users;
  UserListState({required this.users});
}

class UserListInitial extends UserListState{   //UserListBloc(): super(UserListInitial(users:[]))
  UserListInitial({required List<User> users}): super(users: users);
}

class UserListUpdated extends UserListState{   //emit latter-emit(UserListUpdated(users:state.users));
  UserListUpdated({required List<User> users}) : super(users: users);
}