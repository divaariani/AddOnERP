library addon.globals;

String globalBarcodeMesinResult = '';
String globalBarcodeLokasiResult = '';
String globalBarcodeBarangResult = '';
String globalBarcodeMobilResult = '';
List<String> globalBarcodeBarangResults = [];
List<String> globalBarcodeBarangGudangResults = [];

void setGlobalBarcodeResult(String barcodeMachineResult) {
  globalBarcodeMesinResult = barcodeMachineResult;
}

void setGlobalBarcodeLokasiResult(String barcodeAuditResult){
  globalBarcodeLokasiResult = barcodeAuditResult;
}

void setGlobalBarcodeBarangResult(String barcodeBarangResult) {
  globalBarcodeBarangResult = barcodeBarangResult;
}

void setGlobalBarcodeMobilResult(String barcodeGudangResult){
  globalBarcodeMobilResult = barcodeGudangResult;
}
