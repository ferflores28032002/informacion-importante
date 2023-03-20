
//Mostrar Números (5  4  3  2  1  0) usando recursividad

public class MostrarNumeros {

    public static void Mostrar(int numero) {
        if (numero > 0) Mostrar(numero - 1);
        System.out.println(numero);
    }
   
    public static void main(String[] args) {
        Mostrar(5);
    }
}

// public static void Mostrar(int numero) {
// if (numero > 0) {
// Mostrar(numero - 1);
// System.out.println(numero);
// }
// }

// public static void main(String[] ar) {
// Mostrar(10);
// }
