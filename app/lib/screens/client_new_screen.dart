import 'dart:io';
import 'package:app/models/login_info.dart';
import 'package:app/screens/clients_screen.dart';
import 'package:app/screens/drawer.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
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

  // const NewClientScreen({
  //   required this.user,
  // });
  final Client? client;
  NewClientScreen({
    this.client,
  });

  @override
  _NewClientScreenState createState() => _NewClientScreenState();
}

// final _scaffoldKey = GlobalKey<ScaffoldState>();

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

  // Map<String, dynamic> values = {};
  // int currentIdx = 0;
/*
  @override
  void initState() {
    List<Map<String, dynamic>> initAdresses = [];
    if (widget.client != null) {
      values['first_name'] = widget.client!.firstName == null
          ? ''
          : widget.client!.firstName as String;
      values['last_name'] = widget.client!.lastName == null
          ? ''
          : widget.client!.lastName as String;
      values['mobile'] =
          widget.client!.mobile == null ? '' : widget.client!.mobile as String;
      values['email'] =
          widget.client!.email == null ? '' : widget.client!.email as String;
      values['city'] =
          widget.client!.city == null ? '' : widget.client!.city as String;

      addresses = widget.client!.addresses == null
          ? []
          : widget.client!.addresses as List<Addresses>;
      if (widget.client!.addresses != null) {
        for (var addr in widget.client!.addresses!) {
          Map<String, dynamic> adress = {};
          adress['id'] = addr.id == null ? '' : addr.id;
          adress['city'] = addr.city == null ? '' : addr.city as String;
          adress['street_address'] =
              addr.streetAddress == null ? '' : addr.city as String;
          adress['zip_code'] = addr.zipCode == null ? '' : addr.city as String;
          adress['state'] = addr.state == null ? '' : addr.city as String;
          adress['locality'] =
              addr.locality == null ? '' : addr.locality as String;
          adress['city'] = addr.city == null ? '' : addr.city as String;
          adress['country'] =
              addr.country == null ? '' : addr.country as String;
          adress['is_default'] =
              addr.isDefault == null ? false : addr.isDefault;
          adress['is_billing'] =
              addr.isBilling == null ? false : addr.isBilling;
          adress['company_id'] = addr.companyId == null ? '' : addr.companyId;
          initAdresses.add(adress);
        }
      } else {
        Map<String, dynamic> adress = {};
        adress['id'] = '';
        adress['city'] = '';
        adress['street_address'] = '';
        adress['zip_code'] = '';
        adress['state'] = '';
        adress['locality'] = '';
        adress['city'] = '';
        adress['country'] = '';
        adress['is_default'] = '';
        adress['is_billing'] = '';
        adress['company_id'] = '';
        initAdresses.add(adress);
      }
    } else {
      Map<String, dynamic> adress = {};
      adress['id'] = '';
      adress['street_address'] = '';
      adress['zip_code'] = '';
      adress['state'] = '';
      adress['locality'] = '';
      adress['city'] = '';
      adress['country'] = '';
      adress['is_default'] = '';
      adress['is_billing'] = '';
      adress['company_id'] = '';
      values['first_name'] = '';
      values['last_name'] = '';
      values['email'] = '';
      values['mobile'] = '';
      initAdresses.add(adress);
    }
    values['addresses'] = initAdresses;
    super.initState();
  }
*/
  void _createClient() {
    if (documentNameController.text != '') {
      if (docmentPickController.text != '') {
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
    }


    //  for (var addr in values['addresses']) {
    //   if (addr['country'] != '' || addr['country'] != null) {
    //     // allCountryBeenFilled = true;
    //   }
    // }


    CreateClientData data = CreateClientData(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      mobile: mobileController.text,
      email: emailController.text,
      addresses: addresses,
      documents: documents,
      uploadedPhoto: photoController.text,
    );
    CreateClientEvent createClientEvent = new CreateClientEvent(data: data);
    BlocProvider.of<ClientsBloc>(context, listen: false).add(createClientEvent);
  }

  void _newAddresshandler() {
    if (countryController.text == '') {
      return;
    }
    // Map<String, dynamic> adress = {};

    // List<Map<String, dynamic>> newAdresses = [...values['addresses']];
    // if (newAdresses.length > currentIdx) {
      // adress['city'] = cityController.text;
      // adress['street_address'] = streetController.text;
      // adress['zip_code'] = zipCodeController.text;
      // adress['state'] = stateController.text;
      // adress['locality'] = localityController.text;
      // adress['country'] = countryController.text;
      // adress['is_default'] = _isDefault;
      // adress['is_billing'] = _isBilling;
      // newAdresses.add(adress);
      // values['addresses'] = newAdresses;
    //   adress['city'] = '';
    //   adress['street_address'] = '';
    //   adress['zip_code'] = '';
    //   adress['state'] = '';
    //   adress['locality'] = '';
    //   adress['country'] = '';
    //   adress['is_default'] = '';
    //   adress['is_billing'] = '';
    //   newAdresses.add(adress);
    //   values['addresses'] = newAdresses;
    //   currentIdx++;
    // } else  if(newAdresses.length == currentIdx){
    //   values['addresses'][currentIdx]['city'] = cityController.text;
    //   values['addresses'][currentIdx]['street_address'] = streetController.text;
    //   values['addresses'][currentIdx]['zip_code'] = zipCodeController.text;
    //   values['addresses'][currentIdx]['state'] = stateController.text;
    //   values['addresses'][currentIdx]['locality'] = localityController.text;
    //   values['addresses'][currentIdx]['country'] = countryController.text;
    //   values['addresses'][currentIdx]['is_default'] = _isDefault;
    //   values['addresses'][currentIdx]['is_billing'] = _isBilling;
    // }

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
    if (documentNameController.text != '') {
      if (docmentPickController.text != '') {
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
    }
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

  void nextAddresshandler() {
    // values['addresses'][currentIdx]['city'] = cityController.text;
    // values['addresses'][currentIdx]['street_address'] = streetController.text;
    // values['addresses'][currentIdx]['zip_code'] = zipCodeController.text;
    // values['addresses'][currentIdx]['state'] = stateController.text;
    // values['addresses'][currentIdx]['locality'] = localityController.text;
    // values['addresses'][currentIdx]['country'] = countryController.text;
    // values['addresses'][currentIdx]['is_default'] = _isDefault;
    // values['addresses'][currentIdx]['is_billing'] = _isBilling;

    // do {
    //   currentIdx++;
    // } while (currentIdx <= addresses.length - 1);
  }

  void prevAddresshandler() {
    // values['addresses'][currentIdx]['city'] = cityController.text;
    // values['addresses'][currentIdx]['street_address'] = streetController.text;
    // values['addresses'][currentIdx]['zip_code'] = zipCodeController.text;
    // values['addresses'][currentIdx]['state'] = stateController.text;
    // values['addresses'][currentIdx]['locality'] = localityController.text;
    // values['addresses'][currentIdx]['country'] = countryController.text;
    // values['addresses'][currentIdx]['is_default'] = _isDefault;
    // values['addresses'][currentIdx]['is_billing'] = _isBilling;
    // do {
    //   currentIdx--;
    // } while (currentIdx >= 0);
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

      if (addresses.length == 0) {
        return;
      }
      // bool allCountryBeenFilled = false;
      // for (var addr in values['addresses']) {
      //   if (addr['country'] != '' || addr['country'] != null) {
      //     allCountryBeenFilled = true;
      //   }
      // }
      // if (!allCountryBeenFilled) {
      //   return;
      // }
    }
    setState(
      () {
        if (currentStep < 2) {
          currentStep += 1;
        }
      },
    );
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

  void navigateToClientScreen(BuildContext context) {
    FetchClientsEvent fetchClientEvent = new FetchClientsEvent(page: 0);
    BlocProvider.of<ClientsBloc>(context, listen: false).add(fetchClientEvent);
    Navigator.of(context).pop();
  }

  late BuildContext widgetContext;
  @override
  Widget build(BuildContext context) {
    widgetContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Client',
        ),
        centerTitle: true,
      ),
      body: ProgressHUD(
        child: BlocConsumer<ClientsBloc, ClientsState>(
          listener: (context, state) {
            final progress = ProgressHUD.of(context);
            print(state.toString());
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
              // if (isShowing) {
              print("---success");

              if (progress != null) {
                // setState(() {
                //   isShowing = false;
                // });
                progress.dismiss();
              }
              navigateToClientScreen(widgetContext);

              // Navigator.of(context).pop();
            } else if (state is ClientCreateFailedState) {
              // if (isShowing) {
              if (progress != null) {
                //     setState(() {
                //       isShowing = false;
                //     });
                progress.dismiss();
                //     // progress.dispose();
              }
              // }
              AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Client Create Fail',
                desc: '${state.message}',
                btnCancelOnPress: () {},
                btnOkOnPress: () {},
              )..show();
            } else {
              setState(() {
                isShowing = false;
              });
            }
          },
          builder: (context, state) {
            // if (state is ClientCreateSuccesstate) {
            //   // widget.onClientAddSuccess();

            // }

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  // Placeholder(),

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
      ),
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
              // initialValue: values['first_name'],
              controller: firstNameController,
              validator: (value) => LengthValidator(value, 1),
              obsecureText: false,
              isRequired: true,
            ),
            CustomTextField(
              textFieldName: 'Last Name',
              // initialValue: values['last_name'],
              controller: lastNameController,
              validator: (value) => LengthValidator(value, 1),
              obsecureText: false,
              isRequired: true,
            ),
            CustomTextField(
              textFieldName: 'Mobile',
              // initialValue: values['mobile'],
              controller: mobileController,
              validator: (value) => Validatephone(value),
              obsecureText: false,
              isRequired: true,
            ),
            CustomTextField(
              textFieldName: 'Email',
              // initialValue: values['email'],
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
          // nextAddressHandler: nextAddresshandler,
          // prevAdressHandler: prevAddresshandler,
          onAddNewPressed: _newAddresshandler,
          onDefaultAddressPressed: defaultAddressHandler,
          onBillingAddressPressed: billingAddressHandler,
          // isBilling: values['addresses'][currentIdx]['is_default'],
          // isDefault: values['addresses'][currentIdx]['is_billing'],
          isDefault: _isDefault,
          isBilling: _isBilling,
          textInput: [
            CustomTextField(
              textFieldName: 'Shipping Address',
              controller: shipAddrController,
              // initialValue: '',
              validator: (value) {},
              obsecureText: false,
              isRequired: false,
            ),
            CustomTextField(
              textFieldName: 'Street',
              // initialValue: values['addresses'][currentIdx]['street_address'],
              controller: streetController,
              validator: (value) {},
              obsecureText: false,
              isRequired: false,
            ),
            CustomTextField(
              textFieldName: 'Zip Code',
              controller: zipCodeController,
              // initialValue: values['addresses'][currentIdx]['zip_code'],
              validator: (value) {},
              obsecureText: false,
              isRequired: false,
            ),
            CustomTextField(
              textFieldName: 'Locality',
              controller: localityController,
              // initialValue: values['addresses'][currentIdx]['locality'],
              validator: (value) {},
              obsecureText: false,
              isRequired: true,
            ),
            CustomTextField(
              textFieldName: 'City',
              controller: cityController,
              // initialValue: values['addresses'][currentIdx]['city'],
              validator: (value) {},
              obsecureText: false,
              isRequired: false,
            ),
            CustomTextField(
              textFieldName: 'State',
              // initialValue: values['addresses'][currentIdx]['state'],
              controller: stateController,
              validator: (value) {},
              obsecureText: false,
              isRequired: false,
            ),
            CustomTextField(
              // initialValue: values['addresses'][currentIdx]['country'],
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
            // initialValue: '',
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