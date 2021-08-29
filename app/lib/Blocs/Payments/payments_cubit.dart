import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:app/Blocs/Payments/patments_state.dart';
import 'package:app/models/payment/payment_container_model.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PaymentsCubit extends Cubit<PaymentsState> {
  final UserPreferences userPreferences;
  PaymentsCubit(
    this.userPreferences,
  ) : super(PaymentsInitialsState());

  static PaymentsCubit get(BuildContext context) => BlocProvider.of(context);

  bool isFormDate = false;
  DateTime dateForm = DateTime.now();
  String dateFromText = "";
  TextEditingController searchController = TextEditingController();

  Future<Null> selectFormTimePicker(BuildContext context) async {
    isFormDate = true;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateForm,
      firstDate: DateTime(1940),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != dateForm) {

        
      dateForm = picked;

      dateFromText =
          "${dateForm.year.toString()}-${dateForm.month.toString()}-${dateForm.day.toString()}";

      print(dateFromText);
    }
    emit(PaymentsDateTimeState());
  }

  // APi For Payment Container

  late PayMentContainerModel payMentContainerModel;
  bool isComeData = false;
  bool isComeDataWrong = false;

  // Future postPayMentConatiner() async {
  //   String? token = await this.userPreferences.getUserToken();
  //   try {
  //     final url =
  //         Uri.parse('http://csv.jithvar.com/api/v1/paginated-collections');
  //     final response = await http.post(url,
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Accept': 'application/json',
  //           'Authorization': 'Bearer $token',
  //         },
  //         body: jsonEncode({
  //           "draw": 0,
  //           "length": 10,
  //           "search": "",
  //           "column": 0,
  //           "dir": "asc"
  //         }));
  //     if (response.statusCode == 200) {
  //       isComeData = true;
  //       isComeDataWrong = false;
  //       final extractedData =
  //           json.decode(response.body) as Map<String, dynamic>;
  //       final data = extractedData['collections'];
  //       payMentContainerModel = PayMentContainerModel.fromJson(data);

  //       //print("walid payment  ${payMentContainerModel.data![0].date}");
  //     } else {
  //       isComeData = false;
  //       isComeDataWrong = true;
  //       throw Exception('Failed to load courses');
  //     }
  //   } catch (e) {
  //     print("Exception throuwn $e");
  //   }
  //   emit(FeatchDataSucessCPaymentState());
  // }

  //dowanload image
  bool isImageLoding = false;
  saveImage({required int index}) async {

    
    final url =
        "https://csv.jithvar.com/storage/${payMentContainerModel.data![index].photo!.filePath}";
    var status = await Permission.storage.request();

    if (status.isGranted) {
      var response = await Dio()
          .get(url, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: "${payMentContainerModel.data![index].photo!.name}");
      isImageLoding = true;
      //isImageLoding = true;
      emit(PaymentsImageDowanloadedState());

      print(result);
    }
    //isImageLoding = false;
  }

  //uploade image

  // Api uploade data and Images

  late File image;
  var imageTemporary;

  // Future imageUpload() async {
  //   try {
  //     isComeImageName = true;
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image == null) return;
  //     imageTemporary = File(image.path);
  //     this.image = imageTemporary;
  //     // print("walid image ${imageTemporary}");
  //   } catch (e) {
  //     isComeImageName = false;
  //     print("Faild to pick image $e");
  //   }
  //   emit(PaymentsUploadImageState());
  // }

  File? file;
  String? imageName;
  bool isComeImageName = false;

  Future pickerCamera() async {
    try {
      isComeImageName = true;
      final myFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      file = File(myFile!.path);
      imageName = file!.path.split("/").last;
    } catch (e) {
      isComeImageName = false;
      print("Faild to pick image $e");
    }
    emit(PaymentsUploadImageState());
  }

  void clealuploade() {
    isFormDate = false;
    isComeImageName = false;

    emit(ClearPaymentSubmint());
  }

  int? amount;

  Future uploadImage({required String date}) async {
    String? token = await this.userPreferences.getUserToken();
    if (file == null) return;

    String base64 = base64Encode(file!.readAsBytesSync());

    final url = Uri.parse('http://csv.jithvar.com/api/v2/user-cash');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "amount": amount,
          "date": date,
          "uploaded_photo": "data:image/jpeg;base64,$base64"
        }));

    if (response.statusCode == 201) {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      print("=========================55========");
      print(extractedData);
      print("=========================55========");
    } else {
      throw Exception('Failed to load courses');
    }
  }
}
