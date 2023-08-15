
class SuccessResponseModel {
  int? status;
  String? message;

  SuccessResponseModel({
    this.status,
    this.message,
  });

  factory SuccessResponseModel.fromJson(Map<String, dynamic> json) => SuccessResponseModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
