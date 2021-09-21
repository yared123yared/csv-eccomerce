import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../main.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  String langy = language;

  getLanguage() {
    return langy;
  }

  setLanguage(String lang) {
    langy = lang;

    emit(LanguageSuccess());
  }

  //Drawer
  String tDashBoard() {
    if (getLanguage() == "🇬🇧") {
      return "Dashboard";
    } else {
      return "Tableau de bord";
    }
  }

  String tShop() {
    if (getLanguage() == "🇬🇧") {
      return "Shops";
    } else {
      return "Boutique";
    }
  }

  String tOrders() {
    if (getLanguage() == "🇬🇧") {
      return "Orders";
    } else {
      return "Ordres";
    }
  }

  String tPayments() {
    if (getLanguage() == "🇬🇧") {
      return "Payments";
    } else {
      return "Paiements";
    }
  }

  String tReports() {
    if (getLanguage() == "🇬🇧") {
      return "Reports";
    } else {
      return "Rapports";
    }
  }

  String tClientManagement() {
    if (getLanguage() == "🇬🇧") {
      return "Client Management";
    } else {
      return "La gestion des clients";
    }
  }

  String tSignout() {
    if (getLanguage() == "🇬🇧") {
      return "Sign out";
    } else {
      return "Déconnexion";
    }
  }

  //Orders

  String tAllOrders() {
    if (getLanguage() == "🇬🇧") {
      return "All Orders";
    } else {
      return "Tous les ordres";
    }
  }

  String tOrdersByDebt() {
    if (getLanguage() == "🇬🇧") {
      return "Orders By Debt";
    } else {
      return "Commandes par dette";
    }
  }

// Reposrts

  String tSalesReport() {
    if (getLanguage() == "🇬🇧") {
      return "Sales Report";
    } else {
      return "Rapport des ventes";
    }
  }

  String tCollectionReport() {
    if (getLanguage() == "🇬🇧") {
      return "Collection Report";
    } else {
      return "Rapport de collecte";
    }
  }

  String tCustomerByDebt() {
    if (getLanguage() == "🇬🇧") {
      return "Customer By Debt";
    } else {
      return "Client par dette";
    }
  }

  //Payments

  String tBankDeposit() {
    if (getLanguage() == "🇬🇧") {
      return "Bank Deposit";
    } else {
      return "Dépôt bancaire";
    }
  }

  //Client Management

  String tClients() {
    if (getLanguage() == "🇬🇧") {
      return "Clients";
    } else {
      return "clientes";
    }
  }

  String tInvoices() {
    if (getLanguage() == "🇬🇧") {
      return "Invoices";
    } else {
      return "Factures";
    }
  }
  ///////////////////////////////
  /// DashBoard Screen

  String tCreditLimit() {
    if (getLanguage() == "🇬🇧") {
      return "Credit Limit";
    } else {
      return "Limite de crédit";
    }
  }

  String tActivityPeriod() {
    if (getLanguage() == "🇬🇧") {
      return "Activity Period:";
    } else {
      return "Période d'activité :";
    }
  }

  String tTotalDebts() {
    if (getLanguage() == "🇬🇧") {
      return "Total Debts";
    } else {
      return "Dettes totales";
    }
  }

  String tTotalPayments() {
    if (getLanguage() == "🇬🇧") {
      return "Total Payments";
    } else {
      return "Paiements totaux";
    }
  }

  String tRecentOrders() {
    if (getLanguage() == "🇬🇧") {
      return "Recent Orders";
    } else {
      return "Dernières commandes";
    }
  }

  String tSearchbyName() {
    if (getLanguage() == "🇬🇧") {
      return "Search by Name";
    } else {
      return "Recherche par nom";
    }
  }

  String tDailyDebtCollection() {
    if (getLanguage() == "🇬🇧") {
      return "Daily Debt Collection";
    } else {
      return "Recouvrement quotidien de créances";
    }
  }

  String tMonthlyDebtCollection() {
    if (getLanguage() == "🇬🇧") {
      return "Monthly Debt Collection";
    } else {
      return "Recouvrement mensuel de créances";
    }
  }

  String tTotalCollection() {
    if (getLanguage() == "🇬🇧") {
      return "Total Collection";
    } else {
      return "Collecte totale";
    }
  }

  String tMonthlyCollection() {
    if (getLanguage() == "🇬🇧") {
      return "Monthly Collection";
    } else {
      return "Collecte mensuelle";
    }
  }

  String tFrom() {
    if (getLanguage() == "🇬🇧") {
      return "From";
    } else {
      return "De";
    }
  }

  String tTo() {
    if (getLanguage() == "🇬🇧") {
      return "To";
    } else {
      return "À";
    }
  }

  //Containersss

  String tORDERNUMBER() {
    if (getLanguage() == "🇬🇧") {
      return "ORDER NUMBER";
    } else {
      return "NUMÉRO DE COMMANDE";
    }
  }

  String tCLIENT() {
    if (getLanguage() == "🇬🇧") {
      return "CLIENT";
    } else {
      return "CLIENTS";
    }
  }

  String tDATE() {
    if (getLanguage() == "🇬🇧") {
      return "DATE";
    } else {
      return "DATE";
    }
  }

  String tTOTAL() {
    if (getLanguage() == "🇬🇧") {
      return "TOTAL";
    } else {
      return "LE TOTAL";
    }
  }

  String tTotaL() {
    if (getLanguage() == "🇬🇧") {
      return "Total";
    } else {
      return "Le Total";
    }
  }

  String tCheckout() {
    if (getLanguage() == "🇬🇧") {
      return "Checkout";
    } else {
      return "Vérifier";
    }
  }

  String tDEBT() {
    if (getLanguage() == "🇬🇧") {
      return "DEBT";
    } else {
      return "DETTE";
    }
  }

  ////////////////////
  ///All Orders Screen

  String tORDER() {
    if (getLanguage() == "🇬🇧") {
      return "ORDER";
    } else {
      return "ORDRE";
    }
  }

  String tPAIDAMOUNT() {
    if (getLanguage() == "🇬🇧") {
      return "PAID AMOUNT";
    } else {
      return "MONTANT PAYÉ";
    }
  }

// incres number pages
  String tshowing() {
    if (getLanguage() == "🇬🇧") {
      return "showing";
    } else {
      return "montrant";
    }
  }

  String tOf() {
    if (getLanguage() == "🇬🇧") {
      return "of";
    } else {
      return "de";
    }
  }

  String tentries() {
    if (getLanguage() == "🇬🇧") {
      return "entries";
    } else {
      return "entrées";
    }
  }

//Login Scree
  String tLogin() {
    if (getLanguage() == "🇬🇧") {
      return "Login";
    } else {
      return "Connexion";
    }
  }

  String tWelcomeToCSV() {
    if (getLanguage() == "🇬🇧") {
      return "Welcome to Csv";
    } else {
      return "Bienvenue sur Csv";
    }
  }

  String tEnter() {
    if (getLanguage() == "🇬🇧") {
      return "Enter";
    } else {
      return "Entrez";
    }
  }

  String tEmail() {
    if (getLanguage() == "🇬🇧") {
      return "Email";
    } else {
      return "l'e-mail";
    }
  }

  String tPassword() {
    if (getLanguage() == "🇬🇧") {
      return "Password";
    } else {
      return "le mot de passe";
    }
  }

  String tEnterCorrectEmail() {
    if (getLanguage() == "🇬🇧") {
      return "Enter Correct Email Address";
    } else {
      return "Entrez l'adresse e-mail correcte";
    }
  }

  String tPasswordTooShort() {
    if (getLanguage() == "🇬🇧") {
      return "Password Too Short";
    } else {
      return "Mot de passe trop court";
    }
  }

  String tForgotPassword() {
    if (getLanguage() == "🇬🇧") {
      return "Forgot Password?";
    } else {
      return "Mot de passe oublié";
    }
  }

  String tEmailAddress() {
    if (getLanguage() == "🇬🇧") {
      return "Email Address";
    } else {
      return "Adresse e-mail";
    }
  }

  String tProvideYourAccount1() {
    if (getLanguage() == "🇬🇧") {
      return "Provide your account email for which";
    } else {
      return "Indiquez l'e-mail de votre compte pour lequel";
    }
  }

  String tProvideYourAccount2() {
    if (getLanguage() == "🇬🇧") {
      return "you want to reset your password";
    } else {
      return "vous souhaitez réinitialiser votre mot de passe";
    }
  }

  //Payment Screen Bank Slip

  String tDate() {
    if (getLanguage() == "🇬🇧") {
      return "Amount";
    } else {
      return "Montant";
    }
  }

  String tAmount() {
    if (getLanguage() == "🇬🇧") {
      return "Amount";
    } else {
      return "Montant";
    }
  }

  String tAMOUNT() {
    if (getLanguage() == "🇬🇧") {
      return "AMOUNT";
    } else {
      return "MONTANT";
    }
  }

  String tSuccessfulDownload() {
    if (getLanguage() == "🇬🇧") {
      return "Successful Download";
    } else {
      return "Téléchargement réussi";
    }
  }

  String tUploadSlip() {
    if (getLanguage() == "🇬🇧") {
      return "Upload Slip";
    } else {
      return "Télécharger le bordereau";
    }
  }

  String tBrowse() {
    if (getLanguage() == "🇬🇧") {
      return "Browse";
    } else {
      return "Parcourir";
    }
  }

  String tSubmit() {
    if (getLanguage() == "🇬🇧") {
      return "Submit";
    } else {
      return "Soumettre";
    }
  }

  String tPleaseUploadInfo() {
    if (getLanguage() == "🇬🇧") {
      return "Please Upload info";
    } else {
      return "Veuillez télécharger des informations";
    }
  }

  String tSuccessfulUploaded() {
    if (getLanguage() == "🇬🇧") {
      return "Successful Uploaded";
    } else {
      return "Téléchargé avec succès";
    }
  }

  String tSearchbyAmount() {
    if (getLanguage() == "🇬🇧") {
      return "Search by Amount";
    } else {
      return "Recherche par montant";
    }
  }

  String tSLIP() {
    if (getLanguage() == "🇬🇧") {
      return "SLIP";
    } else {
      return "GLISSER";
    }
  }

  String tSTATUS() {
    if (getLanguage() == "🇬🇧") {
      return "STATUS";
    } else {
      return "STATUT";
    }
  }

  String tDENYREASON() {
    if (getLanguage() == "🇬🇧") {
      return "DENY REASON";
    } else {
      return "RAISON DE REFUS";
    }
  }

  String tUploadBankSlip() {
    if (getLanguage() == "🇬🇧") {
      return "Upload Bank Slip";
    } else {
      return "Télécharger le bordereau";
    }
  }
  // Sales Report

  String tCLIENTNAME() {
    if (getLanguage() == "🇬🇧") {
      return "CLIENT NAME";
    } else {
      return "NOM DU CLIENT";
    }
  }

  String tPAID() {
    if (getLanguage() == "🇬🇧") {
      return "PAID";
    } else {
      return "PAYÉ";
    }
  }

  String tClear() {
    if (getLanguage() == "🇬🇧") {
      return "Clear";
    } else {
      return "Dégager";
    }
  }

  String tExport() {
    if (getLanguage() == "🇬🇧") {
      return "Export";
    } else {
      return "Exportation";
    }
  }

  //Collection Report
  String tPAYMENTDATE() {
    if (getLanguage() == "🇬🇧") {
      return "PAYMENT DATE";
    } else {
      return "DATE DE PAIEMENT";
    }
  }

  String tPAYMENTMETHOD() {
    if (getLanguage() == "🇬🇧") {
      return "PAYMENT METHOD";
    } else {
      return "MODE DE PAIEMENT";
    }
  }

  //Client Profile dropbutton

  String tClientProfile() {
    if (getLanguage() == "🇬🇧") {
      return "Client Profile";
    } else {
      return "Profil client";
    }
  }

  String tNAME() {
    if (getLanguage() == "🇬🇧") {
      return "NAME";
    } else {
      return "NOM";
    }
  }

  String tOrder() {
    if (getLanguage() == "🇬🇧") {
      return "Order";
    } else {
      return "Ordre";
    }
  }

  String tName() {
    if (getLanguage() == "🇬🇧") {
      return "Name";
    } else {
      return "Nom";
    }
  }

  String tShippingAddresses() {
    if (getLanguage() == "🇬🇧") {
      return "Shipping Addresses";
    } else {
      return "Adresses de livraison";
    }
  }

  String tBillingAddresses() {
    if (getLanguage() == "🇬🇧") {
      return "Billing Addresses";
    } else {
      return "Adresses de facturation";
    }
  }

  String tCREDIT() {
    if (getLanguage() == "🇬🇧") {
      return "CREDIT";
    } else {
      return "CRÉDIT";
    }
  }

  String tLEVEL() {
    if (getLanguage() == "🇬🇧") {
      return "LEVEL";
    } else {
      return "NIVEAU";
    }
  }

  String tEMAIL() {
    if (getLanguage() == "🇬🇧") {
      return "EMAIL";
    } else {
      return "E-MAIL";
    }
  }

  String tPHONE() {
    if (getLanguage() == "🇬🇧") {
      return "PHONE";
    } else {
      return "TÉLÉPHONE";
    }
  }

  // invoices screen

  String tSearchClient() {
    if (getLanguage() == "🇬🇧") {
      return "Search Client";
    } else {
      return "Rechercher un client";
    }
  }

  String tSearch() {
    if (getLanguage() == "🇬🇧") {
      return "Search";
    } else {
      return "Chercher";
    }
  }

  String tInvoName() {
    if (getLanguage() == "🇬🇧") {
      return "Name";
    } else {
      return "Nom";
    }
  }

  // Clients drawer screen

  String tSearchByNameMobileEmail() {
    if (getLanguage() == "🇬🇧") {
      return "Search By Name Mobile, Email";
    } else {
      return "Recherche par nom Mobile, E-mail";
    }
  }

  String tQUANTITY() {
    if (getLanguage() == "🇬🇧") {
      return "QUANTITY";
    } else {
      return "QUANTITÉ";
    }
  }

  //Create Client Screen

  String tGeneralInformation() {
    if (getLanguage() == "🇬🇧") {
      return "General Information";
    } else {
      return "Informations générales";
    }
  }

  String tFirstName() {
    if (getLanguage() == "🇬🇧") {
      return "First Name";
    } else {
      return "Prénom";
    }
  }

  String tLastName() {
    if (getLanguage() == "🇬🇧") {
      return "Last Name";
    } else {
      return "Nom de famille";
    }
  }

  String tPhoto() {
    if (getLanguage() == "🇬🇧") {
      return "Photo";
    } else {
      return "photo";
    }
  }

  String tNext() {
    if (getLanguage() == "🇬🇧") {
      return "Next";
    } else {
      return "Prochain";
    }
  }

  //Orders Details
  String tOrderDetails() {
    if (getLanguage() == "🇬🇧") {
      return "Orders Details";
    } else {
      return "Détails des commandes";
    }
  }

  //Update Order
  String tUpdateOrder() {
    if (getLanguage() == "🇬🇧") {
      return "Update Order";
    } else {
      return "Mise à jour de la commande";
    }
  }

  String tUPDATEORDER() {
    if (getLanguage() == "🇬🇧") {
      return "UPDATE ORDER";
    } else {
      return "MISE À JOUR DE LA COMMANDE";
    }
  }

  String tRemainingAmount() {
    if (getLanguage() == "🇬🇧") {
      return "   Remaining Amount:";
    } else {
      return "   Montant restant:";
    }
  }

  String tPayment() {
    if (getLanguage() == "🇬🇧") {
      return "Payment";
    } else {
      return "Paiement";
    }
  }

  String tCART() {
    if (getLanguage() == "🇬🇧") {
      return "CART";
    } else {
      return "CHARIOT";
    }
  }

  String tAdd() {
    if (getLanguage() == "🇬🇧") {
      return "Add";
    } else {
      return "Ajouter";
    }
  }

  //Cart Screens

  String tNoItemIntheCart() {
    if (getLanguage() == "🇬🇧") {
      return "No Item In the Cart";
    } else {
      return "Aucun article dans le panier";
    }
  }

  String tPleaseaddsomeproductstothecart() {
    if (getLanguage() == "🇬🇧") {
      return "Please add some products to the cart!";
    } else {
      return "Veuillez ajouter des produits au panier!";
    }
  }

  //Add Client

  String tAddClient() {
    if (getLanguage() == "🇬🇧") {
      return "Add Client";
    } else {
      return "Ajouter un client";
    }
  }

  String tOrderCreatingfailed() {
    if (getLanguage() == "🇬🇧") {
      return "Order Creating failed";
    } else {
      return "Échec de la création de la commande";
    }
  }

  String tRemainingamountgreaterthanyourcreditlimit() {
    if (getLanguage() == "🇬🇧") {
      return "Remaining amount greater than your credit limit!";
    } else {
      return "Montant restant supérieur à votre limite de crédit!";
    }
  }

  String tRequired() {
    if (getLanguage() == "🇬🇧") {
      return "Required";
    } else {
      return "Obligatoire";
    }
  }

  String tAddNewClient() {
    if (getLanguage() == "🇬🇧") {
      return "Add New Client";
    } else {
      return "Ajouter un nouveau client";
    }
  }

  String tPayLater() {
    if (getLanguage() == "🇬🇧") {
      return "Pay Later";
    } else {
      return "Payer plus tard";
    }
  }

  String tPayNow() {
    if (getLanguage() == "🇬🇧") {
      return "Pay Now";
    } else {
      return "Payez maintenant";
    }
  }

  String tProduct() {
    if (getLanguage() == "🇬🇧") {
      return "Product";
    } else {
      return "Produit";
    }
  }

  String tCOLOR() {
    if (getLanguage() == "🇬🇧") {
      return "COLOR";
    } else {
      return "COULEUR";
    }
  }

  String tAddtoCart() {
    if (getLanguage() == "🇬🇧") {
      return "Add to Cart";
    } else {
      return "Ajouter au chariot";
    }
  }

  String tUpdateCart() {
    if (getLanguage() == "🇬🇧") {
      return "Update Cart";
    } else {
      return "Mise à jour panier";
    }
  }

  String tDescriptioncomeshere() {
    if (getLanguage() == "🇬🇧") {
      return "Description comes here";
    } else {
      return "La description vient ici";
    }
  }

  String tPRICE() {
    if (getLanguage() == "🇬🇧") {
      return "PRICE";
    } else {
      return "LE PRIX";
    }
  }

  String tModel() {
    if (getLanguage() == "🇬🇧") {
      return "Model";
    } else {
      return "Modèle";
    }
  }
}
