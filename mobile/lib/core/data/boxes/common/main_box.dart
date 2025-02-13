part of '../../boxes.dart';

abstract class MainBox {

  CollectionSchema<dynamic> get schema;

  bool get isEncrypted => false;

  String get encryptionKeyName => BoxKeys.hiveBoxDefaultEncryptionKey;


  bool _isInitialized = false;

  Isar? _isar;

  Future<void> init() async {
    if (_isInitialized) {
      return;
    }

    // isEncrypted
    if (false) {
      // var key = SecureStorage().get(encryptionKeyName);
      // if (key.isEmpty) {
      //   final generatedKey = Isar.getInstance().generateSecureKey();
      //   SecureStorage().set(encryptionKeyName, hiveGeneratedKey);
      //   key = hiveGeneratedKey;
      // }
      // final encryptionKey = base64Url.decode(key);
      // try {
      //   _box = await Hive.openBox(
      //     boxKey,
      //     encryptionCipher: HiveAesCipher(encryptionKey),
      //   );
      // } catch (_) {
      //   printLog('[FluxBox] Failed to open encrypted box $boxKey. Deleting...');
      //   await Hive.deleteBoxFromDisk(boxKey);
      //   _box = await Hive.openBox(
      //     boxKey,
      //     encryptionCipher: HiveAesCipher(encryptionKey),
      //   );
      // }
    } else {
      final dir = await getApplicationDocumentsDirectory();
       _isar = await Isar.open(
        [schema],
        directory: dir.path,
      );
    }
    _isInitialized = true;
  }

  Isar get isar {
    final result = _isar;
    if (result == null) {
      throw Exception('[FluxBox] $schema is not initialized');
    }
    return result;
  }

}