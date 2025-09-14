import 'package:chef_app/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserIdUseCase {
  final AuthRepository repository;

  GetCurrentUserIdUseCase(this.repository);

  Future<String?> call() async {
    return await repository.getCurrentUserId();
  }
}