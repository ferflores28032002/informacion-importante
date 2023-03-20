package JuegoDeAlmas;

public class Humanos extends Incorporeo implements Espiritual {

    public int inteligencia;

    public void rezar() {
        System.out.println("Estoy Rezando para aumentar mi fe en un punto");
    }

    public Humanos() {
        this.inteligencia = (int) (Math.random() * 200);
    }

    /**
     * ** Generamos los nombre de los humanos aleatorios ***
     */

    public String[] generarNombresAleatorios(int cantidad) {
        String[] nombresAleatorios = new String[cantidad];

        String[] nombres = {"Jordan", "David", "Sergio", "Jorge", "Yadira", "Brayan", "Carmen", "luis",
            "Jordin", "Yatzari", "Milton", "Andrea", "Sofia", "Marvin", "Sugeylin", "Amy", "Benjamin",
            "Andres", "Norman", "Marcela"};
        String[] apellidos = {"Gomez", "Guerrero", "Cardenas", "Lopez", "Vallecillo", "Mendoza", "Cariaga", "Carillo",
            "Diaz", "Castillo", "Ruiz", "Castro", "Salazar", "Santamarina", "Cano", "", "Flores",
            "Carballo"};

        for (int i = 0; i < cantidad; i++) {
            nombresAleatorios[i] = "[Nombre] -> " + nombres[(int) (Math.floor(Math.random() * ((nombres.length - 2) - 0 + 1) + 0))] + " "
                    + apellidos[(int) (Math.floor(Math.random() * ((apellidos.length - 1) - 0 + 1) + 0))];
        }
        return nombresAleatorios;
    }

    /**
     * Imprime un arreglo de String
     *
     * @param nombresGenerados arreglo con los nombres generados
     */
    public void imprimir(String[] nombresGenerados) {
        for (int i = 0; i < nombresGenerados.length; i++) {
            System.out.println(nombresGenerados[i]);

        }
    }

    public void genearNames(int numero) {
        imprimir(generarNombresAleatorios(numero));
    }

}
