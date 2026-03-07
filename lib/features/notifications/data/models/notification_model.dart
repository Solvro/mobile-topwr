import "package:freezed_annotation/freezed_annotation.dart";

part "notification_model.freezed.dart";
part "notification_model.g.dart";

@freezed
abstract class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required int id,
    required String title,
    required String body,
    NotificationPayload? data,
    required bool wasSent,
    required DateTime createdAt,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);
}

@freezed
abstract class NotificationPayload with _$NotificationPayload {
  const factory NotificationPayload({String? route}) = _NotificationPayload;

  factory NotificationPayload.fromJson(Map<String, dynamic> json) => _$NotificationPayloadFromJson(json);
}
