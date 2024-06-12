class CancellationException implements Exception {
  /// Construct a [CancellationException].
  const CancellationException();

  @override
  String toString() => 'CancellationException';
}