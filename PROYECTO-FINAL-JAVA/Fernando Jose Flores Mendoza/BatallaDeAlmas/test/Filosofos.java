
//Problema de los filosofos - usando hilos


class Palillos {

    private int idPalillo;
    private boolean palilloLibre = true;

    public Palillos(int idPalillo) {
        this.idPalillo = idPalillo;
    }

    public synchronized void tomarPalillo(int i) {

        while (!palilloLibre) {
            try {
                wait();
            } catch (InterruptedException e) {
                System.out.println("Error al tomar el palillo " + e);
            }

            System.out.println("El filosofo " + i + " " + " coge el palillo " + idPalillo);
            palilloLibre = false;
        }

    }

    public synchronized void quitarPalillo(int i) {
        palilloLibre = true;
        System.out.println("El filosofo " + i + " " + " suelta el palillo " + idPalillo);
        notify();
    }

}

/**
 * ***********************************************************************
 */
class Filosofo extends Thread {

    private int idFilosofo;
    private Palillos izquierda, derecha;
    private Silla silla;

    public Filosofo(int idFilosofo, Palillos izquierda, Palillos derecha, Silla silla) {
        this.idFilosofo = idFilosofo;
        this.izquierda = izquierda;
        this.derecha = derecha;
        this.silla = silla;
    }

    @Override
    public void run() {
        while (true) {
            silla.ocupar_sillas(idFilosofo);
            izquierda.tomarPalillo(idFilosofo);
            derecha.tomarPalillo(idFilosofo);

            izquierda.quitarPalillo(idFilosofo);
            derecha.quitarPalillo(idFilosofo);
            silla.liberar_sillas(idFilosofo);

        }
    }

}

/**
 * ************************************************************************
 */
class Silla {

    private int sillas_libres = 4;

    public synchronized void ocupar_sillas(int i) {
        try {

            while (sillas_libres == 0) {
                wait();
            }
            System.out.println("El filosofo " + i + " se sienta en una silla ");
            sillas_libres--;

        } catch (InterruptedException e) {
            System.out.println("Error en la clase sillas " + e);
        }
    }

    public synchronized void liberar_sillas(int i) {
        sillas_libres++;
        System.out.println("El filosofo " + i + " libera la silla ");
        notify();
    }

}

/**
 * *********************************************************************
 */
public class Filosofos {

    public static void main(String[] args) {

        //Creamo las sillas 
        Silla sillas = new Silla();

        //Creamos los palillos
        Palillos[] palillo = new Palillos[5];

        for (int i = 0; i < palillo.length; i++) {
            palillo[i] = new Palillos(i);
        }

        //Creamos los filosofos
        Filosofo[] filosofos = new Filosofo[5];

        for (int i = 0; i < filosofos.length; i++) {
            filosofos[i] = new Filosofo(i, palillo[i], palillo[(i + 1) % 5], sillas);
        }

        //Hacemos comer a los filosofos
        for (int i = 0; i < filosofos.length; i++) {
            filosofos[i].start();
        }

    }
}
