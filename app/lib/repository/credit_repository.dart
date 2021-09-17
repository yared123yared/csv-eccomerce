import 'package:app/data_provider/credit_data_provider.dart';
import 'package:app/models/users.dart';

import '../data_provider/user_data_provider.dart';
import '../models/login_info.dart';

class CreditRepository {
  final CreditDataProvider creditDataProvider;
  CreditRepository({
    required this.creditDataProvider,
  });

  Future<User> UpdateUserInformation(int user_id) async {
    return await creditDataProvider.UpdateUserInformation(user_id);
  }
}
