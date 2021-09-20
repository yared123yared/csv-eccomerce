import 'dart:io';

import 'package:app/constants/constants.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExportButton extends StatefulWidget {
  const ExportButton({Key? key}) : super(key: key);

  @override
  _ExportButtonState createState() => _ExportButtonState();
}

class _ExportButtonState extends State<ExportButton> {
  final Dio dio = Dio();
  bool loading = false;
  double progress = 0;

  Future<bool> saveVideo(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;
          String newPath = "";
          print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/RPSApp";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File(directory.path + "/$fileName");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        await dio.download(url, saveFile.path,
            onReceiveProgress: (value1, value2) {
          setState(() {
            progress = value1 / value2;
          });
        });
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  downloadFile() async {
    setState(() {
      loading = true;
      progress = 0;
    });
    bool downloaded = await saveVideo(
        "https://images.unsplash.com/photo-1630980942883-0d68b18c93c8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=376&q=80",
        "csv.JPEG");
    if (downloaded) {
      print("File Downloaded");
    } else {
      print("Problem Downloading File");
    }
    setState(() {
      loading = false;
    });
  }
  // bool loading = false;
  // double progress = 0.0;
  // final Dio dio = Dio();
  // Future<bool> saveFile(String url, String fileName) async {
  //   Directory directory;
  //   try {
  //     if (Platform.isAndroid) {
  //       if (await requestPrimation(Permission.storage)) {
  //         directory = (await getExternalStorageDirectory())!;

  //         String newPath = '';
  //         //  /storage/emulated/0/Android/data/com.example.app/files

  //         List<String> folders = directory.path.split('/');
  //         for (int x = 1; x < folders.length; x++) {
  //           String folder = folders[x];
  //           if (folder != 'Android') {
  //             newPath += '/' + folder;
  //           } else {
  //             break;
  //           }
  //         }
  //         newPath = newPath + '/CSV';
  //         directory = Directory(newPath);
  //         print(directory.path);
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       if (await requestPrimation(Permission.photos)) {
  //         directory = await getTemporaryDirectory();
  //       } else {
  //         return false;
  //       }
  //     }
  //     if (!await directory.exists()) {
  //       await directory.create(recursive: true);
  //     }
  //     if (await directory.exists()) {
  //       File saveFile = File(directory.path + '/$fileName');
  //       await dio.download(url, saveFile.path,
  //           onReceiveProgress: (downloaded, totalSize) {
  //         setState(() {
  //           progress = downloaded / totalSize;
  //         });
  //       });
  //       if (Platform.isIOS) {
  //        await ImageGallerySaver.saveFile(saveFile.path,isReturnPathOfIOS: true);
  //       }
  //       return true;
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   return false;
  // }

  // Future<bool> requestPrimation(Permission permission) async {
  //   if (await permission.isGranted) {
  //     return true;
  //   } else {
  //     var result = await permission.request();
  //     if (result == PermissionStatus.granted) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   }
  // }

  // dowanloadFile() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   bool dowanload = await saveFile(
  //       'http://csv.jithvar.com/storage/excel/collections1630656699.xlsx',
  //       'csv.xlsx');
  //   if (dowanload) {
  //     print('file Dowanloaded');
  //   } else {
  //     print('Problem file Dowanloaded');
  //   }
  //   setState(() {
  //     loading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LanguageCubit>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: loading
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: LinearProgressIndicator(
                minHeight: 10,
                value: progress,
              ),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: primaryColor,
                minimumSize: const Size(400, 55),
                shape: const StadiumBorder(),
              ),
              onPressed: downloadFile,
              child: Text(
                cubit.tExport(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
    );
  }

  // Future<void> createExcel() async {
  //   final Workbook workbook = Workbook();
  //   final Worksheet sheet = workbook.worksheets[0];
  //   sheet.getRangeByName('A1').setText('Creatd At');
  //   sheet.getRangeByName('B1').setText('Order #');
  //   sheet.getRangeByName('C1').setText('Client Name');
  //   sheet.getRangeByName('D1').setText('Total Amount');
  //   sheet.getRangeByName('E1').setText('Paid Amount');
  //   sheet.getRangeByName('F1').setText('Remaining Amount');

  //   final List<int> bytes = workbook.saveAsStream();
  //   workbook.dispose();

  //   final String path = (await getApplicationSupportDirectory()).path;
  //   final String fileName = '$path/Output.xlsx';
  //   final File file = File(fileName);
  //   await file.writeAsBytes(bytes, flush: true);
  //   OpenFile.open(fileName);
  // }
}
