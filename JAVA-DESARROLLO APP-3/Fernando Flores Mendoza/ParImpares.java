
import java.util.*;

class ParImpar {

    private int A;

    public ParImpar() {
        A = 4;
    }

    //Sobrecarga de constructores
    public ParImpar(int A) {
        this.A = A;
    }

    public String CalcularParImpar() {
        String res = (A % 2 == 0) ? (A + " Es par") : (A + " Es impar");
        return res;
    }

    //Método Getters
    public String getMostrarDato() {
        return "El Valor es: " + this.A;
    }

}

public class ParImpares {

    public static void main(String[] args) {

        Scanner entrada = new Scanner(System.in);

        int opcion;

        System.out.println("¡Números Pares - Impares!");

        do {
            System.out.println("\n1-Llamar al constructor 1\n2-LLamar al constructor 2\n3-Ver valor de A\n4-salir");
            System.out.print("\n\nOpcion:");
            opcion = entrada.nextInt();

            //LLAMAMOS AL CONTRUCTOR 1
            ParImpar peticion1 = new ParImpar();

            switch (opcion) {
                case 1:
                    System.out.println(peticion1.CalcularParImpar());
                    break;
                case 2:
                    System.out.println("Ingrese Número:");
                    int num = entrada.nextInt();
                    //LLAMAMOS AL CONTRUCTOR 2
                    ParImpar peticion2 = new ParImpar(num);
                    System.out.println(peticion2.CalcularParImpar());
                    break;
                case 3:
                    System.out.println(peticion1.getMostrarDato());
                    break;
                case 4:
                    System.exit(0);
                default:
                    System.out.println("Opcion Incorrecta");
                    break;

            }

        } while (opcion != 0);

    }
}
