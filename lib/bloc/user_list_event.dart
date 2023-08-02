//part of 'user_list_bloc.dart';

//@immutable
import '../model/user.dart';

abstract class UserListEvent{}

class AddUser extends UserListEvent{   // call- userListBloc(context).add(AddUser(user: user));
  final User user;

  AddUser({required this.user});
}

class DeleteUser extends UserListEvent {   // call- userListBloc(context).add(DeleteUSer(user: user));
  final User user;
  DeleteUser({required this.user});
}

class UpdateUser extends UserListEvent {    // call- userListBloc(context).add(UpdateUser(user: user));
  final User user;
  UpdateUser({required this.user});
}