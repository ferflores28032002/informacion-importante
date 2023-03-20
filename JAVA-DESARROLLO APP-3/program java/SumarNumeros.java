
// Sumar Números ( 5 + 4 + 3 + 2 + 1) usando la recursividad
public class SumarNumeros {

    public static int Suma(int numero) {
        int resp = 0;
        if (numero > 0)
            resp = numero += Suma(numero + 1);
        return resp;
    }

    public static void main(String[] args) {
        System.out.println(Suma(5));
    }
}
