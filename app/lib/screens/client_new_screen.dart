import 'package:app/Blocs/clients/bloc/clients_bloc.dart';
import 'package:app/Widget/Home/bottom-navigation/bottomNavigation.dart';
import 'package:app/Widget/clients/Common/custom_file_input.dart';
import 'package:app/Widget/clients/Common/custom_textfield.dart';
import 'package:app/Widget/clients/Common/file_pick_button.dart';
import 'package:app/Widget/clients/new_client/documents.dart';
import 'package:app/Widget/clients/new_client/general_information.dart';
import 'package:app/Widget/clients/new_client/shipping_address.dart';
import 'package:app/Widget/clients/new_client/steper.dart';
import 'package:app/constants/constants.dart';
import 'package:app/models/login_info.dart';
import 'package:app/screens/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flash/flash.dart';

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
  final List<String> titles = [
    'General Information',
    'Shipping Address',
    'Documents'
  ];

  void _createClient() {}

  void _onPhotoButtonPressed() async {
    ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    photoController.text = image!.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Create Client'),
          centerTitle: true,
          backgroundColor: primaryColor,
          leading: GestureDetector(
            onTap: () => _scaffoldKey.currentState!.openDrawer(),
            child: Container(
              height: 5.0,
              width: 5.0,
              child: ImageIcon(
                AssetImage('assets/images/left-align.png'),
              ),
            ),
          ),
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Theme.of(context)
                  .primaryColor //This will change the drawer background to blue.
              //other styles
              ),
          child: AppDrawer(),
        ),
        drawerEnableOpenDragGesture: true,
        bottomNavigationBar: HomeBottomNavigation(),
        body: BlocBuilder<ClientsBloc, ClientsState>(builder: (context, state) {
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
                    onStepContinue: () => () {
                      currentStep < 2 ? setState(() => currentStep += 1) : Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        }));
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
              validator: (value) {},
              obsecureText: false,
              isRequired: true,
            ),
            CustomTextField(
              textFieldName: 'Last Name',
              controller: lastNameController,
              validator: (value) {},
              obsecureText: false,
              isRequired: true,
            ),
            CustomTextField(
              textFieldName: 'Mobile',
              controller: firstNameController,
              validator: (value) {},
              obsecureText: false,
              isRequired: true,
            ),
            CustomTextField(
              textFieldName: 'Email',
              controller: emailController,
              validator: (value) {},
              obsecureText: false,
              isRequired: true,
            ),
            CustomFileInput(
              textFieldName: 'Photo',
              controller: photoController,
              isRequired: false,
              onPressed: () {},
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
          onAddNewPressed: () {},
          onDefaultAddressPressed: () {},
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
          onAddNewPressed: () {},
          documentNameField: CustomTextField(
            textFieldName: 'Documents',
            controller: shipAddrController,
            validator: (value) {},
            obsecureText: false,
            isRequired: false,
          ),
          documentPicker: CustomFileInput(
            textFieldName: 'Choose file',
            controller: photoController,
            isRequired: false,
            onPressed: () => _onPhotoButtonPressed,
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
