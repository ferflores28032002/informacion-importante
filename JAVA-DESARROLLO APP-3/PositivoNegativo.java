/*
    Programa en java que declare una variable B de tipo entero y asignarle un valor.A continuacion
    muestra un mensaje indicando si el valor de B es positivo o negativo.Consideraremos el 0 como
    positivo . Utiliza el operador condicinal (? :) 
 */

import java.util.*;
public class PositivoNegativo {

    public static void main(String[] args) {
        Scanner entrada = new Scanner(System.in);
        int opcion = 0;

        while (opcion != 1) {
            System.out.println("Ingrese el Número: ");
            int B = entrada.nextInt();

            System.out.println((B<0) ? (B + " Es Negativo") : (B + " es Positivo"));

            System.out.println("\n\nPresione 1 si desea salir u otro para seguir!");
            opcion = entrada.nextInt();
        }
        System.out.println("Ha salido del programa!");
    }
}
