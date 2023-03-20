/*
 Crea una clase llamada Contador que contenga un único atributo entero llamado cont.

 La clase tendrá los siguientes constructores:

 1 - Constructor por defecto
 2 - Constructor con parámetros para inicializar el contador con un valor no negativo. 
     Si el valor inicial que se recibe es negativo el contador tomará el valor cero como valor inicial.
 
 Además de los métodos getter y setter, la clase contendrá los métodos:

 3 - incrementar: incrementa el contador en una unidad.
 4 - decrementar: decrementa el contador en una unidad. 
     El contador nunca podrá tener un valor negativo.
 
 Si al decrementar se alcanza un valor negativo el contador toma el valor cero.
 Una vez creada la clase, escribe un método main para probar la clase.
 */
import java.util.*;

class ManipularContador {

    private int cont;

    public ManipularContador() {
        this.cont = 0;
    }

    public void ManipularContador(int inicializacion) {
        if (inicializacion < 0) {
            System.out.println("\nEl Valor es Negativo, por ende no podemos inicializar el contador con ese valor!");
        } else {
            this.cont = inicializacion;
            System.out.println("\nEl contador a sido inicializado con el valor de: " + inicializacion);
        }
    }
    
    //Métodos

    public int incrementar() { 
        return this.cont += 1; 
    }

    public String decrementar() {
        
        if (this.cont > 0) return ""+(this.cont -= 1);
        
        return "Ya no puedes decrementar mas el contador";
    }

    public void getCont() {
        System.out.println("\nEl valor del contador es: " + this.cont);
    }

}


// ******************************************************

public class Contador {

    public static void main(String[] args) {
        
        int opcion = 0;
        Scanner entrada = new Scanner(System.in);
        ManipularContador contador1 = new ManipularContador();


        do {
            System.out.println("\n\tC O N T A D O R");
            System.out.println("\n1-Aumentar\n2-Decrementar\n3-Inicializar\n4-ver\n5-Salir");
            System.out.println("\nOpcion: ");
            opcion = entrada.nextInt();

            switch (opcion) {
                case 1:
                    System.out.println("\nIncrementamos : " + contador1.incrementar());
                    break;
                case 2:

                    System.out.println("Decrementamos : " + contador1.decrementar());
                    break;
                case 3:
                    System.out.println("\nIngrese el valor: ");
                    int inicializar = entrada.nextInt();
                    contador1.ManipularContador(inicializar);
                    break;
                case 4:
                    contador1.getCont();
                    break;
                case 5:
                    System.exit(0);
                    break;
                default:
                    System.out.println("\nLa opcion es incorrecta");
            }

        } while (opcion != 5);

    }
}
