import 'dart:convert';
import 'dart:io';
import 'package:app/Blocs/location/bloc/location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
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
import 'package:sms/sms.dart';

import 'clients_screen.dart';

class ClientEditScreen extends StatefulWidget {
  static const routeName = 'client_new';

  // const NewClientScreen({
  //   required this.user,
  // });
  final Client? client;
  ClientEditScreen({
    this.client,
  });

  @override
  _ClientEditScreenState createState() => _ClientEditScreenState();
}

// final _scaffoldKey = GlobalKey<ScaffoldState>();

class _ClientEditScreenState extends State<ClientEditScreen> {
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
  final generalInfoFormKey = GlobalKey<FormState>();
  final addressInfoFormKey = GlobalKey<FormState>();

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
  bool isFetchingAddress = false;
  Placemark? currentPlace;
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
      print("0");
      if (generalInfoFormKey.currentState != null) {
        print("1");

        if (generalInfoFormKey.currentState!.validate() == false) {
          print("2");

          return;
        }
      }
      print("3");

      if (firstNameController.text == '' ||
          lastNameController.text == '' ||
          mobileController.text == '' ||
          emailController.text == '') {
        return;
      }
      if (widget.client == null) {
        var currTime = DateTime.now();
        var timeStamp = currTime.millisecondsSinceEpoch;
        FetchCurrentLocationEvent fetchLocationEvent =
            new FetchCurrentLocationEvent(status: timeStamp.toString());
        BlocProvider.of<LocationBloc>(context, listen: false)
            .add(fetchLocationEvent);
      } else {
        print("id is not null");
      }
      setState(
        () {
          if (currentStep < 2) {
            currentStep += 1;
          }
        },
      );
    } else if (currentStep == 1) {
      if (addressInfoFormKey.currentState != null) {
        if (!addressInfoFormKey.currentState!.validate()) {
          print("1");
          return;
        }
      }
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

  void onFetchSuccessHandler(Placemark place) {
    print("fetch success handler");
    if (place != null) {
      print("place is not null");
      // setState(() {
      if (place.subLocality != null) {
        print("sublocal");
        values['addresses'][currentIdx]['city'] = place.subLocality;
        cityController.text = values['addresses'][currentIdx]['city'];
      }

      if (place.street != null) {
        print("street");
        values['addresses'][currentIdx]['street_address'] = place.street;
        streetController.text =
            values['addresses'][currentIdx]['street_address'].toString();
      }
      if (place.postalCode != null || place.postalCode != '') {
        print("postal");
        values['addresses'][currentIdx]['zip_code'] = place.postalCode;
        zipCodeController.text = values['addresses'][currentIdx]['zip_code'];
      }
      if (place.administrativeArea != null || place.administrativeArea != '') {
        values['addresses'][currentIdx]['state'] = place.administrativeArea;
        stateController.text = values['addresses'][currentIdx]['state'];
      }
      if (place.locality != null || place.locality != '') {
        values['addresses'][currentIdx]['locality'] = place.locality;
        localityController.text = values['addresses'][currentIdx]['locality'];
      }
      if (place.country != null || place.country != '') {
        values['addresses'][currentIdx]['country'] = place.country;
        countryController.text = values['addresses'][currentIdx]['country'];
      }
      values['addresses'][currentIdx]['is_default'] = _isDefault;
      values['addresses'][currentIdx]['is_billing'] = _isBilling;
      // });
    } else {
      print("place is  null");
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
    FetchClientsEvent fetchClientEvent = new FetchClientsEvent(loadMore: false);
    BlocProvider.of<ClientsBloc>(context, listen: false).add(fetchClientEvent);
    Navigator.popAndPushNamed(context, ClientsScreen.routeName);
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
            FetchClientsEvent fetchClientEvent =
                new FetchClientsEvent(loadMore: false);
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
              // message will be send here.
              List<String> recipents = ["916897173", "0939546094"];

              _sendSMS("message", recipents);
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
          formKey: generalInfoFormKey,
          textInput: [
            CustomTextField(
              minLength: 1,
              textFieldName: 'First Name',
              initialValue: values['first_name'],
              controller: firstNameController,
              validator: null,
              obsecureText: false,
              isRequired: true,
            ),
            CustomTextField(
              minLength: 1,
              textFieldName: 'Last Name',
              initialValue: values['last_name'],
              controller: lastNameController,
              validator: null,
              obsecureText: false,
              isRequired: true,
            ),
            CustomTextField(
              minLength: 10,
              textFieldName: 'Mobile',
              initialValue: values['mobile'],
              controller: mobileController,
              validator: Validatephone,
              obsecureText: false,
              isRequired: true,
            ),
            CustomTextField(
              minLength: 10,
              textFieldName: 'Email',
              initialValue: values['email'],
              controller: emailController,
              validator: validateEmail,
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
          formKey: addressInfoFormKey,
          nextAddressHandler: nextAddresshandler,
          prevAdressHandler: prevAddresshandler,
          onAddNewPressed: _newAddresshandler,
          onCurrrentAddressFetchSuccessState: onFetchSuccessHandler,
          onDefaultAddressPressed: defaultAddressHandler,
          onBillingAddressPressed: billingAddressHandler,
          isBilling: values['addresses'][currentIdx]['is_billing'],
          isDefault: values['addresses'][currentIdx]['is_default'],
          isCreating: (widget.client == null),
          // isDefault: _isDefault,
          // isBilling: _isBilling,
          textInput: [
            CustomTextField(
              minLength: 0,
              textFieldName: 'Shipping Address',
              controller: shipAddrController,
              initialValue: '',
              validator: null,
              obsecureText: false,
              isRequired: false,
            ),
            CustomTextField(
              minLength: 0,
              textFieldName: 'Street',
              initialValue: values['addresses'][currentIdx]['street_address'],
              controller: streetController,
              validator: null,
              obsecureText: false,
              isRequired: false,
            ),
            CustomTextField(
              minLength: 0,
              textFieldName: 'Zip Code',
              controller: zipCodeController,
              initialValue: values['addresses'][currentIdx]['zip_code'],
              validator: null,
              obsecureText: false,
              isRequired: false,
            ),
            CustomTextField(
              minLength: 0,
              textFieldName: 'Locality',
              controller: localityController,
              initialValue: values['addresses'][currentIdx]['locality'],
              validator: null,
              obsecureText: false,
              isRequired: false,
            ),
            CustomTextField(
              minLength: 0,
              textFieldName: 'City',
              controller: cityController,
              initialValue: values['addresses'][currentIdx]['city'],
              validator: null,
              obsecureText: false,
              isRequired: false,
            ),
            CustomTextField(
              minLength: 0,
              textFieldName: 'State',
              initialValue: values['addresses'][currentIdx]['state'],
              controller: stateController,
              validator: null,
              obsecureText: false,
              isRequired: false,
            ),
            CustomTextField(
              minLength: 2,
              initialValue: values['addresses'][currentIdx]['country'],
              textFieldName: 'Country',
              controller: countryController,
              validator: null,
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
            minLength: 0,
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

  void _sendSMS(String message, List<String> recipents) async {
    // String _result = await sendSMS(message: message, recipients: recipents)
    //     .catchError((onError) {
    //   print(onError);
    // });
    // print(_result);
    SmsSender sender = SmsSender();
    String address = "0916897173";

    SmsMessage message = SmsMessage(address, 'New Client Created!');
    message.onStateChanged.listen((state) {
      if (state == SmsMessageState.Sent) {
        print("SMS is sent!");
      } else if (state == SmsMessageState.Delivered) {
        print("SMS is delivered!");
      }
    });
    sender.sendSms(message);
  }
}
