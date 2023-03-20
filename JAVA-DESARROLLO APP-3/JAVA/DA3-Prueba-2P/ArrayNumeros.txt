
import java.util.*;

/*  ---- Problema #10 Array -----
 Contruir un programa en java que permita encontrar el número mayor y el número menor
 deuna serie de numeros ingresados por teclado, como primera entrada se le dara el tamaño
 del arreglo y luego los datos, tambien se le debe indicar cuantas veces se repitio tanto el 
 numero menor como el mayor
 */
class MayorMenor {

    Scanner entrada = new Scanner(System.in);

    public void calcularMayorMenor(int rango) {

        int[] array = new int[rango];
        int mayor, menor;
        int contMayor = 0, contMenor = 0;

        for (int i = 0; i < array.length; i++) {
            System.out.println("Ingrese el numero " + i);
            array[i] = entrada.nextInt();
        }

        mayor = menor = array[0];

        //Ciclo para encontrar el numero mayor y menor
        for (int i = 0; i < array.length; i++) {

            if (array[i] > mayor) mayor = array[i];
            
            if (array[i] < menor) menor = array[i];
        
        }

        //Ciclo para saber cuantas veces se repite el numero mayor y menor
        for (int i = 0; i < array.length; i++) {

            if (mayor == array[i]) contMayor++;

            if (menor == array[i]) contMenor++;
        }

        System.out.println("\t -- Resultados --\nEl numero mayor es " + mayor + " y se repite " + contMayor + " veces!");
        System.out.println("\nEl numero menor es " + menor + " y se repite " + contMenor + " veces!");
    }

}

class ArrayNumeros {

    public static void main(String[] args) {
        
        Scanner entrada = new Scanner(System.in);
        MayorMenor obj1 = new MayorMenor();

        System.out.println("¡Hola!, ¿De que tamaño quieres el array?");
        int tamanio = entrada.nextInt();
        obj1.calcularMayorMenor(tamanio);

    }
}
