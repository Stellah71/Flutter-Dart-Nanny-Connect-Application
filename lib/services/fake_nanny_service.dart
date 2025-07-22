import '../models/nanny.dart';

class FakeNannyService {
  static List<Nanny> getAvailableNannies() {
    return [
      Nanny(name: "Mary Wanjiku", phone: "0712345678", experience: "3"),
      Nanny(name: "Jane Atieno", phone: "0798765432", experience: "5"),
    ];
  }
}
