import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../main.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  String langy = language;

  int addersIdy = 0;

  getLanguage() {
    return langy;
  }

  setLanguage(String lang) {
    langy = lang;

    emit(LanguageSuccess());
  }

  //Drawer
  String tDashBoard() {
    if (getLanguage() == "🇫🇷") {
      return "Tableau de bord";
    } else {
      return "Dashboard";
    }
  }

  String tShop() {
    if (getLanguage() == "🇫🇷") {
      return "Boutique";
    } else {
      return "Shops";
    }
  }

  String tOrders() {
    if (getLanguage() == "🇫🇷") {
      return "Commandes";
    } else {
      return "Orders";
    }
  }

  String tPayments() {
    if (getLanguage() == "🇫🇷") {
      return "Paiements";
    } else {
      return "Payments";
    }
  }

  String tReports() {
    if (getLanguage() == "🇫🇷") {
      return "Rapports";
    } else {
      return "Reports";
    }
  }

  String tClientManagement() {
    if (getLanguage() == "🇫🇷") {
      return "Gestion des clients";
    } else {
      return "Client Management";
    }
  }

  String tSignout() {
    if (getLanguage() == "🇫🇷") {
      return "Déconnexion";
    } else {
      return "Sign out";
    }
  }

  //Orders

  String tAllOrders() {
    if (getLanguage() == "🇫🇷") {
      return "Toutes les commandes";
    } else {
      return "All Orders";
    }
  }

  String tOrdersByDebt() {
    if (getLanguage() == "🇫🇷") {
      return "Commande par dettes";
    } else {
      return "Orders By Debt";
    }
  }

// Reposrts

  String tSalesReport() {
    if (getLanguage() == "🇫🇷") {
      return "Rapport des ventes";
    } else {
      return "Sales Report";
    }
  }

  String tCollectionReport() {
    if (getLanguage() == "🇫🇷") {
      return "Rapport d’encaissement";
    } else {
      return "Collection Report";
    }
  }

  String tCustomerByDebt() {
    if (getLanguage() == "🇫🇷") {
      return "Client par dette";
    } else {
      return "Customer By Debt";
    }
  }

  //Payments

  String tBankDeposit() {
    if (getLanguage() == "🇫🇷") {
      return "Dépôt bancaire";
    } else {
      return "Bank Deposit";
    }
  }

  //Client Management

  String tClients() {
    if (getLanguage() == "🇫🇷") {
      return "Clients";
    } else {
      return "Clients";
    }
  }

  String tInvoices() {
    if (getLanguage() == "🇫🇷") {
      return "Factures";
    } else {
      return "Invoices";
    }
  }
  ///////////////////////////////
  /// DashBoard Screen

  String tCreditLimit() {
    if (getLanguage() == "🇫🇷") {
      return "Limite de crédit";
    } else {
      return "Credit Limit";
    }
  }

  String tActivityPeriod() {
    if (getLanguage() == "🇫🇷") {
      return "Période d'activité :";
    } else {
      return "Activity Period:";
    }
  }

  String tTotalDebts() {
    if (getLanguage() == "🇫🇷") {
      return "Dettes totales";
    } else {
      return "Total Debts";
    }
  }

  String tTotalPayments() {
    if (getLanguage() == "🇫🇷") {
      return "Paiements totaux";
    } else {
      return "Total Payments";
    }
  }

  String tRecentOrders() {
    if (getLanguage() == "🇫🇷") {
      return "Dernières commandes";
    } else {
      return "Recent Orders";
    }
  }

  String tSearchbyName() {
    if (getLanguage() == "🇫🇷") {
      return "Recherche par nom";
    } else {
      return "Search by Name";
    }
  }

  String tDailyDebtCollection() {
    if (getLanguage() == "🇫🇷") {
      return "Recouvrement quotidien de créances";
    } else {
      return "Daily Debt Collection";
    }
  }

  String tMonthlyDebtCollection() {
    if (getLanguage() == "🇫🇷") {
      return "Recouvrement mensuel de créances";
    } else {
      return "Monthly Debt Collection";
    }
  }

  String tTotalCollection() {
    if (getLanguage() == "🇫🇷") {
      return "Collecte totale";
    } else {
      return "Total Collection";
    }
  }

  String tMonthlyCollection() {
    if (getLanguage() == "🇫🇷") {
      return "Collecte mensuelle";
    } else {
      return "Monthly Collection";
    }
  }

  String tFrom() {
    if (getLanguage() == "🇫🇷") {
      return "De";
    } else {
      return "From";
    }
  }

  String tTo() {
    if (getLanguage() == "🇫🇷") {
      return "À";
    } else {
      return "To";
    }
  }

  //Containersss

  String tORDERNUMBER() {
    if (getLanguage() == "🇫🇷") {
      return "NUMÉRO DE COMMANDE";
    } else {
      return "ORDER NUMBER";
    }
  }

  String tCLIENT() {
    if (getLanguage() == "🇫🇷") {
      return "CLIENTS";
    } else {
      return "CLIENT";
    }
  }

  String tDATE() {
    if (getLanguage() == "🇫🇷") {
      return "DATE";
    } else {
      return "DATE";
    }
  }

  String tTOTAL() {
    if (getLanguage() == "🇫🇷") {
      return "LE TOTAL";
    } else {
      return "TOTAL";
    }
  }

  String tTotaL() {
    if (getLanguage() == "🇫🇷") {
      return "Le Total";
    } else {
      return "Total";
    }
  }

  String tCheckout() {
    if (getLanguage() == "🇫🇷") {
      return "Enregistrer";
    } else {
      return "Checkout";
    }
  }

  String tDEBT() {
    if (getLanguage() == "🇫🇷") {
      return "DETTE";
    } else {
      return "DEBT";
    }
  }

  ////////////////////
  ///All Orders Screen

  String tORDER() {
    if (getLanguage() == "🇫🇷") {
      return "COMMANDER";
    } else {
      return "ORDER";
    }
  }

  String tPAIDAMOUNT() {
    if (getLanguage() == "🇫🇷") {
      return "MONTANT PAYÉ";
    } else {
      return "PAID AMOUNT";
    }
  }

// incres number pages
  String tshowing() {
    if (getLanguage() == "🇫🇷") {
      return "montrant";
    } else {
      return "showing";
    }
  }

  String tOf() {
    if (getLanguage() == "🇫🇷") {
      return "de";
    } else {
      return "of";
    }
  }

  String tentries() {
    if (getLanguage() == "🇫🇷") {
      return "entrées";
    } else {
      return "entries";
    }
  }

//Login Scree
  String tLogin() {
    if (getLanguage() == "🇫🇷") {
      return "Connexion";
    } else {
      return "Login";
    }
  }

  String tWelcomeToCSV() {
    if (getLanguage() == "🇫🇷") {
      return "Bienvenue sur Csv";
    } else {
      return "Welcome to Csv";
    }
  }

  String tEnter() {
    if (getLanguage() == "🇫🇷") {
      return "Entrez";
    } else {
      return "Enter";
    }
  }

  String tEmail() {
    if (getLanguage() == "🇫🇷") {
      return "l'e-mail";
    } else {
      return "Email";
    }
  }

  String tPassword() {
    if (getLanguage() == "🇫🇷") {
      return "le mot de passe";
    } else {
      return "Password";
    }
  }

  String tEnterCorrectEmail() {
    if (getLanguage() == "🇫🇷") {
      return "Entrez l'adresse e-mail correcte";
    } else {
      return "Enter Correct Email Address";
    }
  }

  String tPasswordTooShort() {
    if (getLanguage() == "🇫🇷") {
      return "Mot de passe trop court";
    } else {
      return "Password Too Short";
    }
  }

  String tForgotPassword() {
    if (getLanguage() == "🇫🇷") {
      return "Mot de passe oublié";
    } else {
      return "Forgot Password?";
    }
  }

  String tEmailAddress() {
    if (getLanguage() == "🇫🇷") {
      return "Adresse e-mail";
    } else {
      return "Email Address";
    }
  }

  String tProvideYourAccount1() {
    if (getLanguage() == "🇫🇷") {
      return "Indiquez l'e-mail de votre compte pour lequel";
    } else {
      return "Provide your account email for which";
    }
  }

  String tProvideYourAccount2() {
    if (getLanguage() == "🇫🇷") {
      return "vous souhaitez réinitialiser votre mot de passe";
    } else {
      return "you want to reset your password";
    }
  }

  //Payment Screen Bank Slip

  String tDate() {
    if (getLanguage() == "🇫🇷") {
      return "Montant";
    } else {
      return "Amount";
    }
  }

  String tAmount() {
    if (getLanguage() == "🇫🇷") {
      return "Montant";
    } else {
      return "Amount";
    }
  }

  String tAMOUNT() {
    if (getLanguage() == "🇫🇷") {
      return "MONTANT";
    } else {
      return "AMOUNT";
    }
  }

  String tSuccessfulDownload() {
    if (getLanguage() == "🇫🇷") {
      return "Téléchargement réussi";
    } else {
      return "Successful Download";
    }
  }

  String tUploadSlip() {
    if (getLanguage() == "🇫🇷") {
      return "Télécharger le bordereau";
    } else {
      return "Upload Slip";
    }
  }

  String tBrowse() {
    if (getLanguage() == "🇫🇷") {
      return "Parcourir";
    } else {
      return "Browse";
    }
  }

  String tSubmit() {
    if (getLanguage() == "🇫🇷") {
      return "Soumettre";
    } else {
      return "Submit";
    }
  }

  String tPleaseUploadInfo() {
    if (getLanguage() == "🇫🇷") {
      return "Veuillez télécharger des informations";
    } else {
      return "Please Upload info";
    }
  }

  String tSuccessfulUploaded() {
    if (getLanguage() == "🇫🇷") {
      return "Téléchargé avec succès";
    } else {
      return "Successful Uploaded";
    }
  }

  String tSearchbyAmount() {
    if (getLanguage() == "🇫🇷") {
      return "Recherche par montant";
    } else {
      return "Search by Amount";
    }
  }

  String tSLIP() {
    if (getLanguage() == "🇫🇷") {
      return "GLISSER";
    } else {
      return "SLIP";
    }
  }

  String tSTATUS() {
    if (getLanguage() == "🇫🇷") {
      return "STATUT";
    } else {
      return "STATUS";
    }
  }

  String tDENYREASON() {
    if (getLanguage() == "🇬🇧") {
      return "RAISON DE REFUS";
    } else {
      return "DENY REASON";
    }
  }

  String tUploadBankSlip() {
    if (getLanguage() == "🇫🇷") {
      return "Télécharger le bordereau";
    } else {
      return "Upload Bank Slip";
    }
  }
  // Sales Report

  String tCLIENTNAME() {
    if (getLanguage() == "🇫🇷") {
      return "NOM DU CLIENT";
    } else {
      return "CLIENT NAME";
    }
  }

  String tPAID() {
    if (getLanguage() == "🇫🇷") {
      return "PAYÉ";
    } else {
      return "PAID";
    }
  }

  String tClear() {
    if (getLanguage() == "🇫🇷") {
      return "Dégager";
    } else {
      return "Clear";
    }
  }

  String tExport() {
    if (getLanguage() == "🇫🇷") {
      return "Exportation";
    } else {
      return "Export";
    }
  }

  //Collection Report
  String tPAYMENTDATE() {
    if (getLanguage() == "🇫🇷") {
      return "DATE DE PAIEMENT";
    } else {
      return "PAYMENT DATE";
    }
  }

  String tPAYMENTMETHOD() {
    if (getLanguage() == "🇫🇷") {
      return "MODE DE PAIEMENT";
    } else {
      return "PAYMENT METHOD";
    }
  }

  //Client Profile dropbutton

  String tClientProfile() {
    if (getLanguage() == "🇫🇷") {
      return "Profil client";
    } else {
      return "Client Profile";
    }
  }

  String tNAME() {
    if (getLanguage() == "🇫🇷") {
      return "NOM";
    } else {
      return "NAME";
    }
  }

  String tOrder() {
    if (getLanguage() == "🇫🇷") {
      return "Commander";
    } else {
      return "Order";
    }
  }

  String tName() {
    if (getLanguage() == "🇫🇷") {
      return "Nom";
    } else {
      return "Name";
    }
  }

  String tShippingAddresses() {
    if (getLanguage() == "🇫🇷") {
      return "Adresses de livraison";
    } else {
      return "Shipping Addresses";
    }
  }

  String tBillingAddresses() {
    if (getLanguage() == "🇫🇷") {
      return "Adresses de facturation";
    } else {
      return "Billing Addresses";
    }
  }

  String tCREDIT() {
    if (getLanguage() == "🇫🇷") {
      return "CRÉDIT";
    } else {
      return "CREDIT";
    }
  }

  String tLEVEL() {
    if (getLanguage() == "🇫🇷") {
      return "NIVEAU";
    } else {
      return "LEVEL";
    }
  }

  String tEMAIL() {
    if (getLanguage() == "🇫🇷") {
      return "E-MAIL";
    } else {
      return "EMAIL";
    }
  }

  String tPHONE() {
    if (getLanguage() == "🇫🇷") {
      return "TÉLÉPHONE";
    } else {
      return "PHONE";
    }
  }

  // invoices screen

  String tSearchClient() {
    if (getLanguage() == "🇫🇷") {
      return "Rechercher un client";
    } else {
      return "Search Client";
    }
  }

  String tSearch() {
    if (getLanguage() == "🇫🇷") {
      return "Chercher";
    } else {
      return "Search";
    }
  }

  String tInvoName() {
    if (getLanguage() == "🇫🇷") {
      return "Nom";
    } else {
      return "Name";
    }
  }

  // Clients drawer screen

  String tSearchByNameMobileEmail() {
    if (getLanguage() == "🇫🇷") {
      return "Recherche par nom Mobile, E-mail";
    } else {
      return "Search By Name Mobile, Email";
    }
  }

  String tQUANTITY() {
    if (getLanguage() == "🇫🇷") {
      return "QUANTITÉ";
    } else {
      return "QUANTITY";
    }
  }

  //Create Client Screen

  String tGeneralInformation() {
    if (getLanguage() == "🇫🇷") {
      return "Informations générales";
    } else {
      return "General Information";
    }
  }

  String tFirstName() {
    if (getLanguage() == "🇫🇷") {
      return "Prénom";
    } else {
      return "First Name";
    }
  }

  String tLastName() {
    if (getLanguage() == "🇫🇷") {
      return "Nom de famille";
    } else {
      return "Last Name";
    }
  }

  String tPhoto() {
    if (getLanguage() == "🇫🇷") {
      return "Photo";
    } else {
      return "Photo";
    }
  }

  String tNext() {
    if (getLanguage() == "🇫🇷") {
      return "Prochain";
    } else {
      return "Next";
    }
  }

  //Orders Details
  String tOrderDetails() {
    if (getLanguage() == "🇫🇷") {
      return "Détails des commandes";
    } else {
      return "Orders Details";
    }
  }

  //Update Order
  String tUpdateOrder() {
    if (getLanguage() == "🇫🇷") {
      return "Mise à jour de la commande";
    } else {
      return "Update Order";
    }
  }

  String tUPDATEORDER() {
    if (getLanguage() == "🇫🇷") {
      return "MISE À JOUR DE LA COMMANDE";
    } else {
      return "UPDATE ORDER";
    }
  }

  String tRemainingAmount() {
    if (getLanguage() == "🇫🇷") {
      return "   Montant restant:";
    } else {
      return "   Remaining Amount:";
    }
  }

  String tPayment() {
    if (getLanguage() == "🇫🇷") {
      return "Paiement";
    } else {
      return "Payment";
    }
  }

  String tCART() {
    if (getLanguage() == "🇫🇷") {
      return "CHARIOT";
    } else {
      return "CART";
    }
  }

  String tAdd() {
    if (getLanguage() == "🇫🇷") {
      return "Ajouter";
    } else {
      return "Add";
    }
  }

  //Cart Screens

  String tNoItemIntheCart() {
    if (getLanguage() == "🇫🇷") {
      return "Aucun article dans le panier";
    } else {
      return "No Item In the Cart";
    }
  }

  String tPleaseaddsomeproductstothecart() {
    if (getLanguage() == "🇫🇷") {
      return "Veuillez ajouter des produits au panier!";
    } else {
      return "Please add some products to the cart!";
    }
  }

  //Add Client

  String tAddClient() {
    if (getLanguage() == "🇫🇷") {
      return "Ajouter un client";
    } else {
      return "Add Client";
    }
  }

  String tOrderCreatingfailed() {
    if (getLanguage() == "🇫🇷") {
      return "Échec de la création de la commande";
    } else {
      return "Order Creating failed";
    }
  }

  String tRemainingamountgreaterthanyourcreditlimit() {
    if (getLanguage() == "🇫🇷") {
      return "Montant restant supérieur à votre limite de crédit!";
    } else {
      return "Remaining amount greater than your credit limit!";
    }
  }

  String tRequired() {
    if (getLanguage() == "🇫🇷") {
      return "Obligatoire";
    } else {
      return "Required";
    }
  }

  String tAddNewClient() {
    if (getLanguage() == "🇫🇷") {
      return "Ajouter un nouveau client";
    } else {
      return "Add New Client";
    }
  }

  String tPayLater() {
    if (getLanguage() == "🇫🇷") {
      return "Payer plus tard";
    } else {
      return "Pay Later";
    }
  }

  String tPayNow() {
    if (getLanguage() == "🇫🇷") {
      return "Payez maintenant";
    } else {
      return "Pay Now";
    }
  }

  String tProduct() {
    if (getLanguage() == "🇫🇷") {
      return "Produit";
    } else {
      return "Product";
    }
  }

  String tCOLOR() {
    if (getLanguage() == "🇫🇷") {
      return "COULEUR";
    } else {
      return "COLOR";
    }
  }

  String tAddtoCart() {
    if (getLanguage() == "🇫🇷") {
      return "Ajouter au chariot";
    } else {
      return "Add to Cart";
    }
  }

  String tUpdateCart() {
    if (getLanguage() == "🇫🇷") {
      return "Mise à jour panier";
    } else {
      return "Update Cart";
    }
  }

  String tDescriptioncomeshere() {
    if (getLanguage() == "🇫🇷") {
      return "Pas de description";
    } else {
      return "No have Description";
    }
  }

  String tPRICE() {
    if (getLanguage() == "🇫🇷") {
      return "LE PRIX";
    } else {
      return "PRICE";
    }
  }

  String tModel() {
    if (getLanguage() == "🇫🇷") {
      return "Modèle";
    } else {
      return "Model";
    }
  }
}
