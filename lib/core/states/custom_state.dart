import 'package:flutter/material.dart';

sealed class CustomState<T> {
  const factory CustomState.loading() = AsyncLoading<T>;
  const factory CustomState.initial() = AsyncInitial<T>;
  const factory CustomState.data(T value) = AsyncData<T>;
  const factory CustomState.failure(String error) = AsyncError<T>;
}

class AsyncInitial<T> implements CustomState<T> {
  const AsyncInitial();
  @override
  String toString() => 'AsyncInitial<${T.runtimeType}>';
}

class AsyncLoading<T> implements CustomState<T> {
  const AsyncLoading();
  @override
  String toString() => 'AsyncLoading<${T.runtimeType}>';
}

class AsyncData<T> implements CustomState<T> {
  const AsyncData(this.value);
  final T value;

  @override
  String toString() => 'AsyncData<$T>($value)';
}

class AsyncError<T> implements CustomState<T> {
  const AsyncError(this.error);
  final String error;

  @override
  String toString() => 'AsyncError<$T>($error)';
}

extension AsyncExtension<T> on CustomState<T> {
  String? get error => (this is AsyncError) ? (this as AsyncError).error : null;
  T? get value => (this is AsyncData<T>) ? (this as AsyncData<T>).value : null;

  bool get isLoading => this is AsyncLoading;
  bool get isInitial => this is AsyncInitial;
  bool get isSuccess => this is AsyncData<T>;
  bool get isError => this is AsyncError;

  W on<W>({
    required W Function(T) onData,
    required W Function(String) onError,
    required W Function() onLoading,
    required W Function() onInitial,
  }) {
    if (this is AsyncLoading) {
      return onLoading();
    } else if (this is AsyncInitial) {
      return onInitial();
    } else if (this is AsyncData<T>) {
      return onData((this as AsyncData<T>).value);
    } else if (this is AsyncError) {
      return onError((this as AsyncError).error);
    } else {
      throw Exception('Invalid state');
    }
  }

  W onMayNull<W>({
    required W Function(T?) onData,
    required W Function(String) onError,
    required W Function() onLoading,
    required W Function() onInitial,
  }) {
    if (this is AsyncLoading) {
      return onLoading();
    } else if (this is AsyncInitial) {
      return onInitial();
    } else if (this is AsyncData<T>) {
      return onData((this as AsyncData<T>).value);
    } else if (this is AsyncError) {
      return onError((this as AsyncError).error);
    } else {
      throw Exception('Invalid state');
    }
  }

  Widget when({
    required Widget Function(T) data,
    required Widget Function(String) failure,
    Widget Function()? loading,
    Widget Function()? initial,
  }) {
    if (this is AsyncLoading) {
      return loading?.call() ?? const CircularProgressIndicator();
    } else if (this is AsyncInitial) {
      return initial?.call() ?? loading?.call() ?? const CircularProgressIndicator();
    } else if (this is AsyncData<T>) {
      return data((this as AsyncData<T>).value);
    } else if (this is AsyncError) {
      return failure((this as AsyncError).error);
    } else {
      throw Exception('Invalid state');
    }
  }

  Widget whenDataOrFailure({
    required Widget Function(String failure) failure,
    required Widget Function(T data) data,
  }) {
    if (this is AsyncLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (this is AsyncInitial) {
      return const Center(child: CircularProgressIndicator());
    } else if (this is AsyncData<T>) {
      return data((this as AsyncData<T>).value);
    } else if (this is AsyncError) {
      return failure((this as AsyncError).error);
    } else {
      throw Exception('Invalid state');
    }
  }

  Widget whenOrNull({
    required Widget Function(T?) data,
    required Widget Function(String) failure,
    Widget Function()? loading,
    Widget Function()? initial,
  }) {
    if (this is AsyncLoading) {
      return loading?.call() ?? const CircularProgressIndicator();
    } else if (this is AsyncInitial) {
      return initial?.call() ?? loading?.call() ?? const CircularProgressIndicator();
    } else if (this is AsyncData<T>) {
      return data((this as AsyncData<T>).value);
    } else if (this is AsyncError) {
      return failure((this as AsyncError).error);
    } else {
      throw Exception('Invalid state');
    }
  }
}
