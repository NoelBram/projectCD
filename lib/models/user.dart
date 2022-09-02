import 'package:equatable/equatable.dart';

class CurrentUser extends Equatable {
  final String uid;
  final bool paidUser;

  CurrentUser({required this.uid, this.paidUser = false});

  @override
  List<Object> get props => [uid, paidUser];

  @override
  bool get stringify => true;
}
