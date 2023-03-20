/*
    Escribe un programa en java que declare un variable A de tipo entero y asignarle un valor
    a continuacion, muestra un mensaje indicando si A es par o impar. Utilizando el operador condicinal
    (? :) dentro del println para resolverlo
 */
import java.util.*;

public class Numeros {

    public static void main(String[] args) {

        Scanner entrada = new Scanner(System.in);
        int opcion = 0;

        while (opcion != 1) {
            System.out.println("Ingrese el Número: ");
            int numero = entrada.nextInt();

            System.out.println((numero % 2 == 0) ? (numero + " Es par ") : (numero + " es impar"));

            System.out.println("\n\nPresione 1 si desea salir u otro para seguir!");
            opcion = entrada.nextInt();
        }
        System.out.println("Ha salido del programa!");

    }
}
