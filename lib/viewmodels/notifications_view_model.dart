import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghiazzi/models/notification_model.dart';
import 'package:ghiazzi/repositories/notifications_repository.dart';

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsError extends NotificationsState {
  final String message;
  NotificationsError(this.message);
}

class NotificationsSuccess extends NotificationsState {
  final List<NotificationModel> notifications;
  NotificationsSuccess(this.notifications);
}

class NotificationsViewModel extends Cubit<NotificationsState> {
  final NotificationsRepository notificationsRepository;

  NotificationsViewModel(this.notificationsRepository)
    : super(NotificationsInitial());

  Future<void> getNotifications(String token) async {
    emit(NotificationsLoading());
    try {
      final response = await notificationsRepository.getNotifications(token);
      final notifications =
          (response['notifications'] as List)
              .map((notification) => NotificationModel.fromJson(notification))
              .toList();
      emit(NotificationsSuccess(notifications));
    } catch (e) {
      emit(NotificationsError(e.toString()));
    }
  }
}
