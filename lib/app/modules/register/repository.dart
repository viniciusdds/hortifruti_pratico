import 'package:app_hortifruti_pratico/app/data/models/user.dart';
import 'package:app_hortifruti_pratico/app/data/provider/api.dart';

class RegisterRepository {
  final Api _api;

  RegisterRepository(this._api);

  Future<UserModel> register(userProfileRequestModel) => _api.register(userProfileRequestModel);
}

