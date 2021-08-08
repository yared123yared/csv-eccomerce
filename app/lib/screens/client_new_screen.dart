import 'dart:io';
import 'package:app/screens/drawer.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import 'package:app/Blocs/clients/bloc/clients_bloc.dart';
import 'package:app/Widget/clients/Common/custom_file_input.dart';
import 'package:app/Widget/clients/Common/custom_textfield.dart';
import 'package:app/Widget/clients/new_client/documents.dart';
import 'package:app/Widget/clients/new_client/general_information.dart';
import 'package:app/Widget/clients/new_client/shipping_address.dart';
import 'package:app/Widget/clients/new_client/steper.dart';
import 'package:app/constants/constants.dart';
import 'package:app/models/client.dart';
import 'package:app/validation/validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class NewClientScreen extends StatefulWidget {
  static const routeName = 'client_new';

  // final LoggedUserInfo user;

  // const NewClientScreen({
  //   required this.user,
  // });
  NewClientScreen();

  @override
  _NewClientScreenState createState() => _NewClientScreenState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();

class _NewClientScreenState extends State<NewClientScreen> {
  int currentStep = 0;
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController mobileController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController photoController = new TextEditingController();

  final TextEditingController shipAddrController = new TextEditingController();
  final TextEditingController streetController = new TextEditingController();
  final TextEditingController zipCodeController = new TextEditingController();
  final TextEditingController localityController = new TextEditingController();
  final TextEditingController cityController = new TextEditingController();
  final TextEditingController stateController = new TextEditingController();
  final TextEditingController countryController = new TextEditingController();

  final TextEditingController documentNameController =
      new TextEditingController();
  final TextEditingController docmentPickController =
      new TextEditingController();
  final List<String> titles = [
    'General Information',
    'Shipping Address',
    'Documents'
  ];
  List<Docs> documents = [];
  List<Addresses> addresses = [];
  bool _isDefault = false;
  bool _isBilling = false;

  void _createClient() {
    print('---create started--');

    print('---valid--');
    CreateClientData data = CreateClientData(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      mobile: mobileController.text,
      email: emailController.text,
      addresses: addresses,
      documents: documents,
      uploadedPhoto: photoController.text,
    );
    CreateClientEvent loginEvent = new CreateClientEvent(data: data);
    BlocProvider.of<ClientsBloc>(context).add(loginEvent);
  }

  void _newAddresshandler() {
    if (countryController.text == '') {
      return;
    }

    addresses.add(
      Addresses(
        country: countryController.text,
        streetAddress: streetController.text,
        city: cityController.text,
        isDefault: _isDefault,
        locality: localityController.text,
        state: stateController.text,
        zipCode: zipCodeController.text,
        isBilling: _isBilling,
      ),
    );
    setState(() {
      countryController.clear();
      stateController.clear();
      streetController.clear();
      cityController.clear();
      localityController.clear();
      zipCodeController.clear();
      _isDefault = false;
      _isBilling = false;
    });
  }

  void _newDocumentHandler() {
    if (documentNameController.text == '') {
      return;
    }
    if (docmentPickController.text == '') {
      return;
    }
    documents.add(
      Docs(
        name: documentNameController.text,
        path: docmentPickController.text,
      ),
    );
    setState(() {
      docmentPickController.clear();
      documentNameController.clear();
    });
  }

  void defaultAddressHandler() {
    setState(() {
      _isDefault = !_isDefault;
    });
  }

  void billingAddressHandler() {
    setState(() {
      _isBilling = !_isBilling;
    });
  }

  void _UploadPhotoHandler() async {
    ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        photoController.text = image.path;
      }
    });
  }

  bool isShowing = false;
  void _PickDocumentHandler() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        docmentPickController.text = file.path;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: BlocConsumer<ClientsBloc, ClientsState>(
        listener: (context, state) {
          final progress = ProgressHUD.of(context);
          if (state is ClientCreatingState) {
            if (!isShowing) {
              if (progress != null) {
                setState(() {
                  isShowing = true;
                });
                progress.showWithText('Creating Client');
              }
            }
          } else if (state is ClientCreateSuccesstate) {
            if (isShowing) {
              if (progress != null) {
                setState(() {
                  isShowing = false;
                });
                progress.dismiss();
              }
            }
            Navigator.of(context).pop();
          } else {
            if (isShowing) {
              if (progress != null) {
                setState(() {
                  isShowing = false;
                });
                progress.dismiss();
                // progress.dispose();
              }
            }
          }
        },
        builder: (context, state) {
          Widget palaceHolder = SizedBox(
            height: 0,
          );
          if (state is ClientCreateFailedState) {
            palaceHolder = Center(
              child: Text(
                state.message,
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  color: Theme.of(context).accentColor,
                  child: Text(
                    titles[currentStep],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  color: Theme.of(context).accentColor,
                  height: MediaQuery.of(context).size.height - 50,
                  child: StepCreateClient(
                    steps: getSteps(),
                    currentStep: currentStep,
                    onStepTapped: (int step) {
                      setState(() => currentStep = step);
                    },
                    onStepContinue:
                        currentStep < 2 ? updateCounter : _createClient,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  updateCounter() {
    print(currentStep);
    if (currentStep == 0) {
      if (firstNameController.text == '' ||
          lastNameController.text == '' ||
          mobileController.text == '' ||
          emailController.text == '') {
        return;
      }
    } else if (currentStep == 1) {
      if (countryController.text != '') {
        addresses.add(
          Addresses(
            country: countryController.text,
            streetAddress: streetController.text,
            city: cityController.text,
            isDefault: _isDefault,
            locality: localityController.text,
            state: stateController.text,
            zipCode: zipCodeController.text,
            isBilling: _isBilling,
          ),
        );
        if (addresses.length == 0) {
          return;
        }
        setState(() {
          countryController.clear();
          stateController.clear();
          streetController.clear();
          cityController.clear();
          localityController.clear();
          zipCodeController.clear();
          _isDefault = false;
          _isBilling = false;
        });
      }
    }
    setState(
      () {
        if (currentStep < 2) {
          currentStep += 1;
        }
      },
    );
  }

  Step getClientAddStep(
    String title,
    Widget content,
    bool isActive,
    StepState state,
  ) {
    return Step(
      title: new Text(title),
      content: content,
      isActive: isActive,
      state: state,
    );
  }

  List<Step> getSteps() {
    return [
      getClientAddStep(
        '',
        GeneralInformation(
          textInput: [
            CustomTextField(
              textFieldName: 'First Name',
              controller: firstNameController,
              validator: (value) => LengthValidator(value, 1),
              obsecureText: false,
              isRequired: true,
            ),
            CustomTextField(
              textFieldName: 'Last Name',
              controller: lastNameController,
              validator: (value) => LengthValidator(value, 1),
              obsecureText: false,
              isRequired: true,
            ),
            CustomTextField(
              textFieldName: 'Mobile',
              controller: mobileController,
              validator: (value) => Validatephone(value),
              obsecureText: false,
              isRequired: true,
            ),
            CustomTextField(
              textFieldName: 'Email',
              controller: emailController,
              validator: (value) => validateEmail(value),
              obsecureText: false,
              isRequired: true,
            ),
            CustomFileInput(
              textFieldName: 'Photo',
              controller: photoController,
              isRequired: false,
              onPressed: _UploadPhotoHandler,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
        currentStep >= 0,
        currentStep == 0 ? StepState.editing : StepState.complete,
      ),
      getClientAddStep(
        '',
        Shipping(
          onAddNewPressed: _newAddresshandler,
          onDefaultAddressPressed: defaultAddressHandler,
          onBillingAddressPressed: billingAddressHandler,
          isBilling: _isBilling,
          isDefault: _isDefault,
          textInput: [
            CustomTextField(
              textFieldName: 'Shipping Address',
              controller: shipAddrController,
              validator: (value) {},
              obsecureText: false,
              isRequired: false,
            ),
            CustomTextField(
              textFieldName: 'Street',
              controller: streetController,
              validator: (value) {},
              obsecureText: false,
              isRequired: false,
            ),
            CustomTextField(
              textFieldName: 'Zip Code',
              controller: zipCodeController,
              validator: (value) {},
              obsecureText: false,
              isRequired: false,
            ),
            CustomTextField(
              textFieldName: 'Locality',
              controller: localityController,
              validator: (value) {},
              obsecureText: false,
              isRequired: true,
            ),
            CustomTextField(
              textFieldName: 'City',
              controller: cityController,
              validator: (value) {},
              obsecureText: false,
              isRequired: false,
            ),
            CustomTextField(
              textFieldName: 'State',
              controller: stateController,
              validator: (value) {},
              obsecureText: false,
              isRequired: false,
            ),
            CustomTextField(
              textFieldName: 'Country',
              controller: countryController,
              validator: (value) {},
              obsecureText: false,
              isRequired: true,
            ),
          ],
          onNextPressed: () => setState(() => currentStep = 2),
        ),
        currentStep >= 1,
        currentStep == 1
            ? StepState.editing
            : currentStep < 1
                ? StepState.disabled
                : StepState.complete,
      ),
      getClientAddStep(
        '',
        Documents(
          onAddNewPressed: _newDocumentHandler,
          documentNameField: CustomTextField(
            textFieldName: 'Document Name',
            controller: documentNameController,
            validator: (value) {},
            obsecureText: false,
            isRequired: false,
          ),
          documentPicker: CustomFileInput(
            textFieldName: 'Choose file',
            controller: docmentPickController,
            isRequired: false,
            onPressed: _PickDocumentHandler,
          ),

          // fileInput: CustomFileButton(title: 'Choose file',),
        ),
        currentStep >= 2,
        currentStep == 2
            ? StepState.editing
            : currentStep < 2
                ? StepState.disabled
                : StepState.complete,
      ),
    ];
  }
}
