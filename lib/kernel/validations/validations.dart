class Validations {
  static const email = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const onlyLetters = r'^[a-zA-ZáéíóúÁÉÍÓÚüÜ\s]+$';
  static const onlyNumbers = r"^[0-9]+$";
  static const phone = r"^[0-9]{10}$";
  static const password =
      r"^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[^a-zA-Z0-9]).{8,}$";
}
