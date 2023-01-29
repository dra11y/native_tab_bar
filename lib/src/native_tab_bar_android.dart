// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import './native_tab_bar_platform_interface.dart';

/// The Android implementation of [NativeTabBarPlatform].
class NativeTabBarAndroid extends NativeTabBarPlatform {
  /// Registers this class as the default instance of [NativeTabBarPlatform]
  static void registerWith() {
    NativeTabBarPlatform.instance = NativeTabBarAndroid();
  }

  @override
  // https://material.io/components/tabs/android#scrollable-tabs
  // Material: "48dp (inline text) or 72dp (non-inline text and icon)"
  // double get defaultHeight => 80; // Material3
  double get defaultHeight => 56; // Legacy Material

  @override
  String get viewType => 'com.dra11y.flutter.native_tab_bar.android';

  Map<String, dynamic> creationParams = <String, dynamic>{};

  @override
  Widget buildPlatformWidget(NativeTabBarState state, BuildContext context) {
    return AndroidView(
      viewType: viewType,
      creationParamsCodec: const JSONMessageCodec(),
      creationParams: {
        'id': state.id,
      },
      onPlatformViewCreated: (viewId) async {
        return onPlatformViewCreated(
          id: state.id,
          state: state,
          context: context,
        );
      },
    );
  }
}
