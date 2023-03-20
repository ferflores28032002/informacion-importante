
//Factorial de un número usando recursividad
class Factorial {

    public static double calcularFactorial(double numero) {
        if (numero == 0) return 1;
        else return numero * calcularFactorial(numero - 1);
    }
    public static void main(String[] args) {
        double numero = 4;
        System.out.println("El factorial de " + numero + " es: " + calcularFactorial(numero));
    }

}




// public static void main(String[] args) {
// System.out.println(factoriales(5));
// }

// public static String factoriales(double num) {
// double factorial = 1;
// for (int i = 1; i <= num; i++) {
// factorial = factorial * i;
// }
// return "El Factorial de " + num + " sin recursividad es: " + factorial;
// }