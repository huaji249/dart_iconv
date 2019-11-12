import 'dart:ffi' as ffi;
import 'dart:ffi' show Uint8Pointer,Int64Pointer;
import 'dart:typed_data';
import 'package:meta/meta.dart';
import 'package:ffi/ffi.dart';
typedef _iconv_open_native=ffi.Pointer<ffi.Void> Function(ffi.Pointer<Utf8>,ffi.Pointer<Utf8>);
typedef _iconv_native=ffi.Int64 Function(ffi.Pointer<ffi.Void>,
    ffi.Pointer<ffi.Uint8>,ffi.Pointer<ffi.Int64>,
    ffi.Pointer<ffi.Uint8>,ffi.Pointer<ffi.Int64>
    );
typedef _iconv_close_native=ffi.Int64 Function(ffi.Pointer<ffi.Void>);
typedef _iconv=int Function(ffi.Pointer<ffi.Void>,
    ffi.Pointer<ffi.Uint8>,ffi.Pointer<ffi.Int64>,
    ffi.Pointer<ffi.Uint8>,ffi.Pointer<ffi.Int64>
    );
typedef _iconv_close=int Function(ffi.Pointer<ffi.Void>);
final _lib=ffi.DynamicLibrary.open(r"C:\Users\hhnnh\CLionProjects\iconvTest\bin\libdiconv.dll");
final _open=_lib.lookupFunction<_iconv_open_native,_iconv_open_native>("diconv_open");
final _conv=_lib.lookupFunction<_iconv_native,_iconv>("diconv");
final _close=_lib.lookupFunction<_iconv_close_native,_iconv_close>("diconv_close");
class Iconv{
  ffi.Pointer<ffi.Void> _tp;
  Iconv({String tocode ="utf-8",@required String formcode ="gbk"}){_tp=_open(Utf8.toUtf8(tocode),Utf8.toUtf8(formcode));}
  Uint8List conv(Uint8List form){
    final ilenp=allocate<ffi.Int64>();
    final olenp=allocate<ffi.Int64>();
    int outleng=form.length*2+1;
    ilenp[0]=form.length+1;
    olenp[0]=outleng;
    final ffi.Pointer<ffi.Uint8> ipointer=allocate<ffi.Uint8>(count: form.length+1);
    final opinter=allocate<ffi.Uint8>(count: outleng);
    final Uint8List ibyt=ipointer.asTypedList(form.length + 1);
    ibyt.setAll(0,form);
    ibyt[form.length]=0;
    _conv(_tp,ipointer,ilenp,opinter,olenp);
    return opinter.asTypedList(outleng);
  }
  void close(){
    _close(_tp);
  }
}