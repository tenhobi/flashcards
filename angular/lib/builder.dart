// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:build/build.dart';
import 'package:sass_builder/sass_builder.dart' as sass;

Builder scssBuilder(BuilderOptions options) =>
    // ignore: strong_mode_invalid_cast_new_expr, new_with_non_type
    sass.SassBuilder(outputExtension: '.scss.css');
