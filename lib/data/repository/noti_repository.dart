import 'package:agora_vai/data/service/noti_service.dart';
import 'package:agora_vai/domain/model/notificacao.dart';

class NotiRepository {
  final NotiService _notiService;

  NotiRepository({required NotiService notiService})
    : _notiService = notiService;

  Future<void> showNotification(Notificacao notificacao) async {
    await _notiService.showNotification(notificacao);
  }
}
