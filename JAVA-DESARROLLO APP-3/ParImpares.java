
import java.util.*;

class ParImpars {

    private int A;

    public ParImpars() {
        A = 4;
    }

    //Sobrecarga de constructores
    public ParImpars(int A) {
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

        int opcion = 0;

        do {
            System.out.println("1-Llamar al constructor 1\n2-LLamar al constructor 2\n3-Ver valor de A");
            opcion = entrada.nextInt();

            //LLAMAMOS AL CONTRUCTOR 1
            ParImpars peticion1 = new ParImpars();

            switch (opcion) {
                case 1:
                    System.out.println(peticion1.CalcularParImpar());
                    break;
                case 2:
                    System.out.println("Ingrese Número:");
                    int num = entrada.nextInt();
                    //LLAMAMOS AL CONTRUCTOR 2
                    ParImpars peticion2 = new ParImpars(num);
                    System.out.println(peticion2.CalcularParImpar());
                    break;
                case 3:
                    System.out.println(peticion1.getMostrarDato());
                    break;
                default:
                    System.out.println("Opcion Incorrecta");
                    break;

            }

        } while (opcion != 0);

    }
}
