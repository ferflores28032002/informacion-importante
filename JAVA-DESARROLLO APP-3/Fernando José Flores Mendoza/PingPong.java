
//Integrante: Fernando José Flores Mendoza
//Problema del ping pong usando hilos asyncronos

class Ping extends Thread {

    @Override
    public synchronized void run() {
        for (int i = 0; i < 16; i++) {
            System.out.print("**** PING -");
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                System.out.println("Error en el ping ");
            }
        }
    }
}

class Pong extends Thread {

    @Override
    public synchronized void run() {
        for (int i = 0; i < 16; i++) {
            System.out.print(" PONG ****\n");
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                System.out.println("Error en el ping ");
            }
        }
    }
}

public class PingPong {

    public static void main(String[] args) {

        System.out.println("\tPing-Pong con hilos\n");

        Ping ping = new Ping();

        Pong pong = new Pong();

        ping.start();
        try {

            Thread.sleep(10);
        } catch (InterruptedException e) {
            System.out.println("Error en el transcurso del ping y pong");
        }
        pong.start();

    }

}
