/*
Created by Neloy on 20 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

import '../../../../data/client/client_constant.dart';
import '../../../../data/local/local_storage_service.dart';
import '../../../../data/model/model_notification_list.dart';
import '../../../../data/repository/repository_notification.dart';

part 'notification_status_event.dart';

part 'notification_status_state.dart';

class NotificationStatusBloc
    extends Bloc<NotificationStatusEvent, NotificationStatusState> {
  final IRepositoryNotification repositoryNotification;
  final LocalStorageService localStorageService;
  socket_io.Socket? _socket;
  String? _socketToken;
  final Set<String> _receivedNotificationIds = {};
  bool _active = false;

  NotificationStatusBloc({
    required this.repositoryNotification,
    required this.localStorageService,
  }) : super(const NotificationStatusState()) {
    on<NotificationStatusEventStart>(_onStart);
    on<NotificationStatusEventRefresh>(_onRefresh);
    on<NotificationStatusEventIncoming>(_onIncoming);
    on<NotificationStatusEventStop>(_onStop);
  }

  Future<void> _onStart(
    NotificationStatusEventStart event,
    Emitter<NotificationStatusState> emit,
  ) async {
    _active = true;
    String? token;
    try {
      token = await localStorageService.getToken();
    } catch (error) {
      debugPrint("Unable to read notification socket token: $error");
      return;
    }
    if (!_active) return;
    if (token == null || token.isEmpty) {
      _disconnect();
      emit(const NotificationStatusState());
      return;
    }

    if (_socketToken != token || _socket == null) {
      _disconnect();
      _socketToken = token;
      final socket = socket_io.io(
        ClientConstant.baseUrl,
        socket_io.OptionBuilder()
            .setTransports(["websocket"])
            .setAuth({"token": token})
            .enableReconnection()
            .disableAutoConnect()
            .build(),
      );
      _socket = socket;
      socket.onConnect((_) {
        add(const NotificationStatusEventRefresh());
      });
      socket.on("notification:new", (dynamic payload) {
        try {
          final notification = NotificationItem.fromJson(
            Map<String, dynamic>.from(payload as Map),
          );
          add(NotificationStatusEventIncoming(notification: notification));
        } catch (error) {
          debugPrint("Unable to parse incoming notification: $error");
        }
      });
      socket.on("session:revoked", (_) {
        add(const NotificationStatusEventStop());
      });
      socket.onConnectError((error) {
        debugPrint("Notification socket connection failed: $error");
      });
      socket.connect();
    }

    await _refreshUnreadCount(emit);
  }

  Future<void> _onRefresh(
    NotificationStatusEventRefresh event,
    Emitter<NotificationStatusState> emit,
  ) => _refreshUnreadCount(emit);

  Future<void> _refreshUnreadCount(
    Emitter<NotificationStatusState> emit,
  ) async {
    final result = await repositoryNotification.getUnreadCount();
    if (result.isSuccess && result.data != null) {
      emit(state.copyWith(unreadCount: result.data));
    } else {
      debugPrint(
        "Unable to refresh unread notification count: "
        "${result.message ?? ClientConstant.serverError}",
      );
    }
  }

  void _onIncoming(
    NotificationStatusEventIncoming event,
    Emitter<NotificationStatusState> emit,
  ) {
    if (!_receivedNotificationIds.add(event.notification.id)) return;
    emit(
      state.copyWith(
        unreadCount: state.unreadCount + (event.notification.isRead ? 0 : 1),
        latestNotification: event.notification,
      ),
    );
  }

  void _onStop(
    NotificationStatusEventStop event,
    Emitter<NotificationStatusState> emit,
  ) {
    _active = false;
    _disconnect();
    emit(const NotificationStatusState());
  }

  void _disconnect() {
    try {
      _socket?.disconnect();
    } catch (e) {
      debugPrint("Ignored socket teardown error: $e");
    } finally {
      _socket = null;
      _socketToken = null;
      _receivedNotificationIds.clear();
    }
  }

  @override
  Future<void> close() {
    _disconnect();
    return super.close();
  }
}
