import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:app/Blocs/clients/bloc/clients_bloc.dart';
import 'package:app/Widget/clients/Common/custom_file_input.dart';
import 'package:app/Widget/clients/Common/custom_textfield.dart';
import 'package:app/Widget/clients/new_client/documents.dart';
import 'package:app/Widget/clients/new_client/general_information.dart';
import 'package:app/Widget/clients/new_client/shipping_address.dart';
import 'package:app/Widget/clients/new_client/steper.dart';
import 'package:app/models/client.dart';
import 'package:app/validation/validator.dart';

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

  Map<String, dynamic> values = {};
  int currentIdx = 0;

  bool isInitialized = false;
  void initialize() {
    print("initial state ---${this.widget.client == null}");

    List<Map<String, dynamic>> initAdresses = [];
    if (widget.client != null) {
      print("79");
      setState(() {
        values['first_name'] = this.widget.client!.firstName == null
            ? ''
            : this.widget.client!.firstName as String;
        values['last_name'] = this.widget.client!.lastName == null
            ? ''
            : this.widget.client!.lastName as String;
        values['mobile'] = this.widget.client!.mobile == null
            ? ''
            : this.widget.client!.mobile as String;
        values['email'] = this.widget.client!.email == null
            ? ''
            : this.widget.client!.email as String;
        firstNameController.text = values['first_name'];
        lastNameController.text = values['last_name'];
        emailController.text = values['email'];
        mobileController.text = values['mobile'];
        values['city'] = this.widget.client!.city == null
            ? ''
            : this.widget.client!.city as String;

        addresses = this.widget.client!.addresses == null
            ? []
            : this.widget.client!.addresses as List<Addresses>;
      });
      // print(values['first_name']);

      if (this.widget.client!.addresses != null) {
        for (var addr in this.widget.client!.addresses!) {
          Map<String, dynamic> adress = {};

          adress['id'] = addr.id == null ? '' : addr.id;
          adress['street_address'] =
              addr.streetAddress == null ? '' : addr.streetAddress as String;
          adress['zip_code'] =
              addr.zipCode == null ? '' : addr.zipCode as String;
          adress['state'] = addr.state == null ? '' : addr.state as String;
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
        adress['is_default'] = false;
        adress['is_billing'] = false;
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
      adress['is_default'] = false;
      adress['is_billing'] = false;
      adress['company_id'] = '';
      values['first_name'] = '';
      values['last_name'] = '';
      values['email'] = '';
      values['mobile'] = '';
      initAdresses.add(adress);
    }
    setState(() {
      values['addresses'] = initAdresses;
      updateFields();
      isInitialized = true;
    });
    print(jsonEncode(values['addresses']).toString());
  }

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
    addresses.clear();
    for (var addr in (values['addresses'] as List<Map<String, dynamic>>)) {
      if (addr['country'] != ''
          // || addr['country'] != null
          ) {
        // isCountryFilled = true;
        // print("country----${addr['country']}");
        addresses.add(
          Addresses(
            country: addr['country'],
            streetAddress: addr['street_address'],
            city: addr['city'],
            isDefault: addr['is_default'],
            locality: addr['locality'],
            state: addr['state'],
            zipCode: addr['zip_code'],
            isBilling: addr['is_billing'],
          ),
        );
      }
    }

    CreateEditData data = CreateEditData(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      mobile: mobileController.text,
      email: emailController.text,
      addresses: addresses,
      documents: documents,
      uploadedPhoto: photoController.text,
    );
    if (widget.client != null) {
      if (widget.client!.id != null) {
        data.id = widget.client!.id.toString();
        UpdateClientEvent updateClientEvent = new UpdateClientEvent(data: data);
        BlocProvider.of<ClientsBloc>(context, listen: false)
            .add(updateClientEvent);
        return;
      }
    }

    CreateClientEvent createClientEvent = new CreateClientEvent(data: data);
    BlocProvider.of<ClientsBloc>(context, listen: false).add(createClientEvent);
  }

  void _newAddresshandler() {
    updateAddressValues();
    clear();
    List<Map<String, dynamic>> newAdresses = [...values['addresses']];
    Map<String, dynamic> adress = {};
    // if (newAdresses.length > currentIdx) {
    adress['city'] = '';
    adress['street_address'] = '';
    adress['zip_code'] = '';
    adress['state'] = '';
    adress['locality'] = '';
    adress['country'] = '';
    adress['is_default'] = false;
    adress['is_billing'] = false;
    newAdresses.add(adress);
    setState(() {
      values['addresses'] = newAdresses;
    });
    setState(() {
      currentIdx =
          (values['addresses'] as List<Map<String, dynamic>>).length - 1;
    });

    // updateAddressValues();
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
      values['addresses'][currentIdx]['is_default'] =
          !values['addresses'][currentIdx]['is_default'];
    });
  }

  void billingAddressHandler() {
    setState(() {
      _isBilling = !_isBilling;
      values['addresses'][currentIdx]['is_billing'] =
          !values['addresses'][currentIdx]['is_billing'];
    });
  }

  void nextAddresshandler() {
    updateAddressValues();

    if ((currentIdx + 1) <=
        (values['addresses'] as List<Map<String, dynamic>>).length - 1) {
      setState(() {
        currentIdx++;
      });
    }

    updateFields();
  }

  void prevAddresshandler() {
    updateAddressValues();
    if (currentIdx - 1 >= 0) {
      setState(() {
        currentIdx--;
      });
    }
    updateFields();
  }

  void updateCounter() async {
    // print(currentStep);
    if (currentStep == 0) {
      if (firstNameController.text == '' ||
          lastNameController.text == '' ||
          mobileController.text == '' ||
          emailController.text == '') {
        return;
      }

      setState(
        () {
          if (currentStep < 2) {
            print("---");
            currentStep += 1;
          }
        },
      );
    if(widget.client==null){
      _getAddressFromLatLng();
    }
    } else if (currentStep == 1) {
      if (countryController.text != '') {
        updateAddressValues();
        // clear();
      }

      bool isCountryFilled = false;
      for (var addr in values['addresses']) {
        if (addr['country'] != '') {
          isCountryFilled = true;
        }
      }
      if (isCountryFilled == false) {
        print("322---has no country information");
        return;
      }
      setState(() {
        currentIdx = 0;
      });
      setState(
        () {
          if (currentStep < 2) {
            print("---");
            currentStep += 1;
          }
        },
      );
    }
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

  void updateAddressValues() {
    setState(() {
      values['addresses'][currentIdx]['city'] = cityController.text;
      values['addresses'][currentIdx]['street_address'] = streetController.text;
      values['addresses'][currentIdx]['zip_code'] = zipCodeController.text;
      values['addresses'][currentIdx]['state'] = stateController.text;
      values['addresses'][currentIdx]['locality'] = localityController.text;
      values['addresses'][currentIdx]['country'] = countryController.text;
      values['addresses'][currentIdx]['is_default'] = _isDefault;
      values['addresses'][currentIdx]['is_billing'] = _isBilling;
    });
  }

  void clear() {
    setState(() {
      countryController.clear();
      stateController.clear();
      streetController.clear();
      cityController.clear();
      localityController.clear();
      zipCodeController.clear();
      _isDefault = false;
      _isBilling = false;
      values['addresses'][currentIdx]['is_billing'] = false;
      values['addresses'][currentIdx]['is_default'] = false;
    });
  }

  void updateFields() {
    // firstNameController.text = values['first_name'];
    // lastNameController.text = values['last_name'];
    // mobileController.text = values['mobile'];
    // emailController.text = values['email'];
    setState(() {
      stateController.text = values['addresses'][currentIdx]['state'];
      cityController.text = values['addresses'][currentIdx]['city'];
      streetController.text = values['addresses'][currentIdx]['street_address'];
      zipCodeController.text = values['addresses'][currentIdx]['zip_code'];
      localityController.text = values['addresses'][currentIdx]['locality'];
      countryController.text = values['addresses'][currentIdx]['country'];
      _isBilling = values['addresses'][currentIdx]['is_billing'];
      _isDefault = values['addresses'][currentIdx]['is_default'];
    });
  }

  late Position _currentPosition;
  late String _currentAddress;
  late BuildContext widgetContext;
  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      initialize();
      print("---isInitialiezed ${isInitialized}");
    }
    widgetContext = context;
    late Widget title;
    late String progresstitle;
    if (this.widget.client != null) {
      if (this.widget.client!.id != null) {
        title = Text('Update Client');
        progresstitle = 'Updating';
      } else {
        title = Text('Create Client');
        progresstitle = 'Creating';
      }
    } else {
      title = Text('Create Client');
      progresstitle = 'Creating';
    }

    return Scaffold(
      appBar: AppBar(
        title: title,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            ///
            FetchClientsEvent fetchClientEvent = new FetchClientsEvent(page: 0);
            BlocProvider.of<ClientsBloc>(context, listen: false)
                .add(fetchClientEvent);
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ProgressHUD(
        child: BlocConsumer<ClientsBloc, ClientsState>(
          listener: (context, state) {
            final progress = ProgressHUD.of(context);
            // print(state.toString());
            if (state is ClientCreatingState || state is ClientUpdatingState) {
              if (!isShowing) {
                if (progress != null) {
                  setState(() {
                    isShowing = true;
                  });

                  progress.showWithText(progresstitle);
                }
              }
            } else if (state is ClientCreateSuccesstate ||
                state is ClientUpdateSuccesstate) {
              // if (isShowing) {
              // print("---success");

              if (progress != null) {
                setState(() {
                  isShowing = false;
                });
                progress.dismiss();
              }
              navigateToClientScreen(widgetContext);

              // Navigator.of(context).pop();
            } else if (state is ClientCreateFailedState) {
              // if (isShowing) {
              setState(() {
                isShowing = false;
              });
              if (progress != null) {
                progress.dismiss();
                //     // progress.dispose();
              }

              AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Client Create Fail',
                desc: '${state.message}',
                btnCancelOnPress: () {},
                btnOkOnPress: () {},
              )..show();
            } else if (state is ClientUpdateFailedState) {
              setState(() {
                isShowing = false;
              });
              if (progress != null) {
                progress.dismiss();
              }
              AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Update Client Fail',
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
              initialValue: values['first_name'],
              controller: firstNameController,
              validator: (value) => LengthValidator(value, 1),
              obsecureText: false,
              isRequired: true,
            ),
            CustomTextField(
              textFieldName: 'Last Name',
              initialValue: values['last_name'],
              controller: lastNameController,
              validator: (value) => LengthValidator(value, 1),
              obsecureText: false,
              isRequired: true,
            ),
            CustomTextField(
              textFieldName: 'Mobile',
              initialValue: values['mobile'],
              controller: mobileController,
              validator: (value) => Validatephone(value),
              obsecureText: false,
              isRequired: true,
            ),
            CustomTextField(
              textFieldName: 'Email',
              initialValue: values['email'],
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
          nextAddressHandler: nextAddresshandler,
          prevAdressHandler: prevAddresshandler,
          onAddNewPressed: _newAddresshandler,
          onDefaultAddressPressed: defaultAddressHandler,
          onBillingAddressPressed: billingAddressHandler,
          isBilling: values['addresses'][currentIdx]['is_billing'],
          isDefault: values['addresses'][currentIdx]['is_default'],
          // isDefault: _isDefault,
          // isBilling: _isBilling,
          textInput: [
            CustomTextField(
              textFieldName: 'Shipping Address',
              controller: shipAddrController,
              initialValue: '',
              validator: (value) {},
              obsecureText: false,
              isRequired: false,
            ),
            CustomTextField(
              textFieldName: 'Street',
              initialValue: values['addresses'][currentIdx]['street_address'],
              controller: streetController,
              validator: (value) {},
              obsecureText: false,
              isRequired: false,
            ),
            CustomTextField(
              textFieldName: 'Zip Code',
              controller: zipCodeController,
              initialValue: values['addresses'][currentIdx]['zip_code'],
              validator: (value) {},
              obsecureText: false,
              isRequired: false,
            ),
            CustomTextField(
              textFieldName: 'Locality',
              controller: localityController,
              initialValue: values['addresses'][currentIdx]['locality'],
              validator: (value) {},
              obsecureText: false,
              isRequired: true,
            ),
            CustomTextField(
              textFieldName: 'City',
              controller: cityController,
              initialValue: values['addresses'][currentIdx]['city'],
              validator: (value) {},
              obsecureText: false,
              isRequired: false,
            ),
            CustomTextField(
              textFieldName: 'State',
              initialValue: values['addresses'][currentIdx]['state'],
              controller: stateController,
              validator: (value) {},
              obsecureText: false,
              isRequired: false,
            ),
            CustomTextField(
              initialValue: values['addresses'][currentIdx]['country'],
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
            initialValue: '',
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

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];
      if (place != null) {
        setState(() {
          values['addresses'][currentIdx]['city'] = place.subLocality;
          values['addresses'][currentIdx]['street_address'] = place.street;
          values['addresses'][currentIdx]['zip_code'] = place.postalCode;
          values['addresses'][currentIdx]['state'] = place.administrativeArea;
          values['addresses'][currentIdx]['locality'] = place.locality;
          values['addresses'][currentIdx]['country'] = place.country;
          values['addresses'][currentIdx]['is_default'] = _isDefault;
          values['addresses'][currentIdx]['is_billing'] = _isBilling;
        });
      }
      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}


// Future<LocationData> getCurrentLocation() async {
//   Location location = new Location();

//   bool _serviceEnabled;
//   PermissionStatus _permissionGranted;
//   LocationData _locationData;
//   try {
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         throw Exception("location service is not enabled");
//       }
//     }

//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         throw Exception("permission denied");
//       }
//     }
//     _locationData = await location.getLocation();
//   } catch (e) {
//     throw e;
//   }

//   return _locationData;
// }
