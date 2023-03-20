/*
    Programa en java que declare una variable B de tipo entero y asignarle un valor.A continuacion
    muestra un mensaje indicando si el valor de B es positivo o negativo.Consideraremos el 0 como
    positivo . Utiliza el operador condicinal (? :) 
 */

import java.util.*;

class PosiNegativos {

    private int B;

    public PosiNegativos() {
        B = 10;
    }

    //Sobrecarga de constructores
    public PosiNegativos(int B) {
        this.B = B;
    }

    public String CalcularNegaPositivo() {
        String res = (B < 0) ? (B + " Es Negativo") : (B + " Es Positivo");
        return res;
    }

    //Método Getters
    public String getMostrarDato() {
        return "El Valor es: " + this.B;
    }

}

public class PositivosNegativos {

    public static void main(String[] args) {

        Scanner entrada = new Scanner(System.in);

        int opcion;

        System.out.println("¡Números Positivos - Negativos!");

        do {
            System.out.println("\n1-Llamar al constructor 1\n2-LLamar al constructor 2\n3-Ver valor de B\n0-salir");
            System.out.print("\n\nOpcion:");
            opcion = entrada.nextInt();

            //LLAMAMOS AL CONTRUCTOR 1
            PosiNegativos peticion1 = new PosiNegativos();

            switch (opcion) {
                case 1:
                    System.out.println(peticion1.CalcularNegaPositivo());
                    break;
                case 2:
                    System.out.println("Ingrese Número:");
                    int num = entrada.nextInt();
                    //LLAMAMOS AL CONTRUCTOR 2
                    PosiNegativos peticion2 = new PosiNegativos(num);
                    System.out.println(peticion2.CalcularNegaPositivo());
                    break;
                case 3:
                    System.out.println(peticion1.getMostrarDato());
                    break;
                case 0:
                    System.exit(0);
                default:
                    System.out.println("Opcion Incorrecta");
                    break;

            }

        } while (opcion != 0);

    }
}
