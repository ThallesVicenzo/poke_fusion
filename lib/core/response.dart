abstract class Response<F, S> {
  F get asFailure => (this as Failure<F, S>).failure;

  S get asSuccess => (this as Success<F, S>).data;

  bool get isSuccess => this is Success<F, S>;

  bool get isFailure => this is Failure<F, S>;

  R deal<R>({
    required R Function(F failure) onFail,
    required R Function(S success) onSuccess,
  }) {
    return this is Failure<F, S>
        ? onFail(
            (this as Failure<F, S>).failure,
          )
        : onSuccess(
            (this as Success<F, S>).data,
          );
  }

  Response();

  factory Response.fail(F failure) {
    return Failure(failure);
  }

  factory Response.success(S data) {
    return Success(data);
  }
}

class Success<F, S> extends Response<F, S> {
  final S data;

  Success(this.data);
}

class Failure<F, S> extends Response<F, S> {
  final F failure;

  Failure(this.failure);
}

extension ResponseExtension on Object {
  Response<F, S> asAnswer<F, S>() {
    assert(this is F || this is S,
        "Expected ${F.runtimeType} or ${S.runtimeType} but got $runtimeType");
    if (this is S) {
      return Response.success(this as S);
    } else if (this is F) {
      return Response.fail(this as F);
    } else {
      throw Exception(
        "Expected ${F.runtimeType} or ${S.runtimeType} but got $runtimeType",
      );
    }
  }
}
