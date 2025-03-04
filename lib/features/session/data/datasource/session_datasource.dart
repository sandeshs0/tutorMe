import 'package:tutorme/features/session/domain/entity/session_entity.dart';

abstract interface class ISessionDataSource {
  Future<List<SessionEntity>> getStudentSessions();
}
