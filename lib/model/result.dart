// 데이터 처리의 성공 실패를 담을 객체
abstract class Result<T> {
  factory Result.success(T data) = Success;

  factory Result.error(String e) = Error;
}

class Success<T> implements Result<T> {
  final T data;

  Success(this.data);
}

class Error<T> implements Result<T> {
  final String e;

  Error(this.e);
}
