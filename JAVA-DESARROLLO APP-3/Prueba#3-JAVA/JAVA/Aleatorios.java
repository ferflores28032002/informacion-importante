/*
    Implementar un programa en Java que genere una secuencia de enteros al azar entre 0 y 10. El programa debe ir
 desplegando cada entero en pantalla junto con un mensaje que diga si es par o no lo es. Además, el programa debe ir
 sumando todos los valores impares que se vayan generando. El procesamiento debe detenerse en el momento en que la
 suma supere el valor 25.
 Al finalizar, el programa debe desplegar en pantalla la suma calculada.

 Ejemplo:
    Una posible ejecución sería la siguiente:
    7 – impar
    2 – par
    4 – par
    3 – impar
    9 – impar
    6 – par
    1 – impar
    3 – impar
    8 – par
    5 – impar
 El procesamiento se detuvo en el 5 porque en ese instante la suma de todos los impares generados superó a 25
 (7+3+9+1+3+5=28)

 */

class NumerosAleatorios {

    private int aleatorio;
    private int suma = 0;
    
    public void GenerarAleatorios() {

        for (int i = 0; i < 30; i++) {

            aleatorio = (int) (Math.random() * 10);

            if (aleatorio % 2 == 0) {
                System.out.println(aleatorio + " - es par");
            } else {
                System.out.println(aleatorio + " - es Impar");

                suma += aleatorio;

                if (suma >= 25) break;

            }

        }
        System.out.println("\nLa suma Total es: " + suma);
    }

}

public class Aleatorios {

    public static void main(String[] args) {
        
        System.out.println("\tGeneracion de Numeros aleatorios");
        System.out.println("Detener hasta que la suma de impares supere 25\n");
        
        NumerosAleatorios numAle1 = new NumerosAleatorios();
        numAle1.GenerarAleatorios();
    }
}
