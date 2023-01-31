import 'package:flutter/foundation.dart';

extension CastFloat32List on List<Object?> {
  Float32List toFloat32List() {
    final List<double> doubles = cast<double>();

    return Float32List.fromList(doubles);
  }
}
