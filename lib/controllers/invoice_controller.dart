import 'package:fagopay/models/invoice_model.dart';
import 'package:get/get.dart';

class InvoiceController extends GetxController {
  final Rx<List<Invoice>> _invoices = Rx([]);

  List<Invoice> get invoices {
    return [..._invoices.value];
  }

  set invoices(List<Invoice> invoices) {
    _invoices(invoices);
  }

  Invoice findInvoiceById(String id) {
    return invoices.firstWhere((invoice) => invoice.id == id);
  }

  
}
