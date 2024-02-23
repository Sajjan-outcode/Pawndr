import '../../../features/login/models/login_form_validation_model.dart';
import '../../api/resource/resource.dart';
import '../entities/oauth_token_entity.dart';

abstract class AuthRepository {
  Future<Result<OauthTokenEntity>> loginUser(
      LoginRequestModel loginRequestModel);
  Future<Result<OauthTokenEntity>> fetchCachedToken();
  Future<void> logout();
}
