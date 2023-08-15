import 'dart:convert';

class ResponseClass {
  ResponseClass({
    required this.message,
    required this.status,
  });
  final String message;
  final int status;

  ResponseClass copyWith({
    String? message,
    int? status,
    int? userId,
  }) {
    return ResponseClass(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'status': status,
    };
  }

  factory ResponseClass.fromMap(Map<String, dynamic> map) {
    return ResponseClass(
      message: map['message'] as String,
      status: map['status'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseClass.fromJson(String source) =>
      ResponseClass.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Response(message: $message, status: $status)';

  @override
  bool operator ==(covariant ResponseClass other) {
    if (identical(this, other)) return true;

    return other.message == message && other.status == status;
  }

  @override
  int get hashCode => message.hashCode ^ status.hashCode;
}
