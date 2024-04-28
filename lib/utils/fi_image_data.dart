import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class CxImageData {
  XFile image ;
  Uint8List? _buffer ;
  CxImageData({required this.image, Uint8List?  buffer}){
    _buffer = buffer ;
  }

  Uint8List? get buffer => _buffer ;

  Future<CxImageData?> load() async {
    _buffer =  await image.readAsBytes() ;
    return this ;
  }
}