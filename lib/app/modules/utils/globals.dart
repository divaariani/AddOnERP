library addon.globals;

String globalBarcodeResult = '';
String globalBarcodeLokasiResult = '';
List<String> globalBarcodeBarangResults = [];

void setGlobalBarcodeResult(String barcodeResult) {
  globalBarcodeResult = barcodeResult;
}

void setGlobalBarcodeLokasiResult(String barcodeAuditResult){
  globalBarcodeLokasiResult = barcodeAuditResult;
}
