import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  StorageService._();
  static final instance = StorageService._();
  final _storage = FirebaseStorage.instance;

  Future<String> uploadBytes({
    required String path,
    required Uint8List data,
    String contentType = 'image/jpeg',
  }) async {
    final ref = _storage.ref(path);
    final meta = SettableMetadata(contentType: contentType);
    final task = await ref.putData(data, meta);
    return await task.ref.getDownloadURL();
  }

  Future<void> delete(String path) async {
    await _storage.ref(path).delete();
  }
}
