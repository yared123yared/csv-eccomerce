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
      return "Clients";
    } else {
      return "Clients";
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

  String tEnterEmail() {
    if (getLanguage() == "🇬🇧") {
      return "Enter Email";
    } else {
      return "Entrez l'e-mail";
    }
  }

  String tEnterPassword() {
    if (getLanguage() == "🇬🇧") {
      return "Enter Password";
    } else {
      return "Entrer le mot de passe";
    }
  }

  String tForgotPassword() {
    if (getLanguage() == "🇬🇧") {
      return "Forgot Password";
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

  String tProvideYourAccount() {
    if (getLanguage() == "🇬🇧") {
      return "Provide your account email for which you want to reset your password";
    } else {
      return "Indiquez l'e-mail de votre compte pour lequel vous souhaitez réinitialiser votre mot de passe";
    }
  }

  //Payment Screen Bank Slip

  String tAmount() {
    if (getLanguage() == "🇬🇧") {
      return "Amount";
    } else {
      return "Montant";
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
}
