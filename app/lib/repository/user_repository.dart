import '../data_provider/user_data_provider.dart';
import '../models/login_info.dart';

class UserRepository {
  final UserDataProvider userDataProvider;

  UserRepository({
    required this.userDataProvider,
  });

  Future<LoggedUserInfo> login(LoginInfo user) async {
    return await userDataProvider.login(user);
  }
}
