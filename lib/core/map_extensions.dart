extension MapExtensions<K, V> on Map<K, V> {
  R getValue<R>(K key) {
    try {
      return this[key] as R;
    } catch (e) {
      return throw Exception(
        'Not found type: ${R.toString()} in key: $key in \n '
        'Map :$this \n error: ${e.toString()}}',
      );
    }
  }
}
