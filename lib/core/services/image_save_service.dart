import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:movies_app/core/helpers/snackbar.dart';

class ImageSaveService {
  static Future<bool> _requestStoragePermission() async {
    try {
      if (Platform.isAndroid) {
        // For Android, we'll use a simple approach that works for most versions
        final status = await Permission.storage.request();
        debugPrint('Storage permission status: $status');

        if (status.isGranted) {
          return true;
        }

        // If storage permission is denied, check if we're on Android 13+ and try photos
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt >= 33) {
          final photosStatus = await Permission.photos.request();
          debugPrint('Photos permission status: $photosStatus');
          return photosStatus.isGranted;
        }

        return false;
      } else if (Platform.isIOS) {
        final status = await Permission.photosAddOnly.request();
        debugPrint('iOS photos add only permission status: $status');
        return status.isGranted;
      }
      return false;
    } catch (e) {
      debugPrint('Permission request error: $e');
      // If permission request fails, let's try to save anyway
      return true;
    }
  }

  static Future<String> _getPermissionDeniedMessage() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        final sdkInt = androidInfo.version.sdkInt;

        if (sdkInt >= 33) {
          return 'Please allow access to photos in Settings > Apps > Movies App > Permissions';
        } else {
          return 'Please allow storage access in Settings > Apps > Movies App > Permissions';
        }
      } else if (Platform.isIOS) {
        return 'Please allow access to photos in Settings > Movies App > Photos';
      }
    } catch (e) {
      debugPrint('Error getting permission message: $e');
    }
    return 'Please allow storage access in device settings';
  }

  static Future<void> debugPermissions() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      debugPrint('=== PERMISSION DEBUG INFO ===');
      debugPrint('Android SDK: ${androidInfo.version.sdkInt}');
      debugPrint('Storage: ${await Permission.storage.status}');
      debugPrint('Photos: ${await Permission.photos.status}');
      debugPrint(
        'ManageExternalStorage: ${await Permission.manageExternalStorage.status}',
      );
      debugPrint('=============================');
    }
  }

  static Future<void> saveImageFromUrl({
    required String imageUrl,
    required BuildContext context,
  }) async {
    try {
      // Show initial message explaining permission requirement
      showSnackBar(
        'You need to grant storage permission to save images',
        isError: false,
      );

      // Wait for 1 second
      await Future.delayed(const Duration(seconds: 1));

      // Debug current permissions
      await debugPermissions();

      // Show loading message
      showSnackBar('Requesting permissions...', isError: false);

      // Request storage permission
      final hasPermission = await _requestStoragePermission();
      if (!hasPermission) {
        final message = await _getPermissionDeniedMessage();
        showSnackBar(message, isError: true);

        // Optionally open app settings
        debugPrint('Opening app settings for permission');
        await openAppSettings();
        return;
      }

      // Show downloading message
      showSnackBar('Downloading image...', isError: false);

      // Download the image
      final response = await http
          .get(
            Uri.parse(imageUrl),
            headers: {'User-Agent': 'Mozilla/5.0 (compatible; Flutter app)'},
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode != 200) {
        showSnackBar(
          'Failed to download image (${response.statusCode})',
          isError: true,
        );
        return;
      }

      final bytes = response.bodyBytes;
      if (bytes.isEmpty) {
        showSnackBar('Downloaded image is empty', isError: true);
        return;
      }

      // Save image to gallery
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(bytes),
        quality: 100,
        name: "movie_image_${DateTime.now().millisecondsSinceEpoch}",
      );

      // Check result
      if (result != null && result['isSuccess'] == true) {
        showSnackBar('Image saved to gallery successfully!', isError: false);
      } else {
        final error = result?['errorMessage'] ?? 'Unknown error occurred';
        showSnackBar('Failed to save image: $error', isError: true);
      }
    } catch (e) {
      debugPrint('Save image error: $e');
      if (e.toString().contains('MissingPluginException')) {
        showSnackBar(
          'Plugin not properly configured. Please restart the app.',
          isError: true,
        );
      } else {
        showSnackBar('Error saving image: ${e.toString()}', isError: true);
      }
    }
  }
}
