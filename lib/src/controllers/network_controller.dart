import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/utils/dialog_utils.dart';

class NetworkController extends GetxController {
  var isConnected = false.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint('Could not check connectivity status : error is: $e');
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(
    List<ConnectivityResult> connectivityResult,
  ) async {
    if (connectivityResult.contains(ConnectivityResult.none)) {
      isConnected(false);
      DialogUtils.showNoInternetDialog();
    } else {
      closeDialog();
    }
  }

  Future<bool> retryConnectionCheck() async {
    final result = await _connectivity.checkConnectivity();
    if (!result.contains(ConnectivityResult.none)) {
      closeDialog();
      return true;
    } else {
      DialogUtils.showNoInternetDialog();
      isConnected(false);
      return false;
    }
  }

  void closeDialog() {
    isConnected(true);
    if (Get.isDialogOpen!) Get.back();
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
