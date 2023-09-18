library addon.globals;

String globalBarcodeResult = '';
String globalBarcodeLokasiResult = '';
String currentNameAuditor = '';
List<String> globalBarcodeBarangResults = [];

void setGlobalBarcodeResult(String barcodeResult) {
  globalBarcodeResult = barcodeResult;
}

void setGlobalBarcodeLokasiResult(String barcodeAuditResult){
  globalBarcodeLokasiResult = barcodeAuditResult;
}
