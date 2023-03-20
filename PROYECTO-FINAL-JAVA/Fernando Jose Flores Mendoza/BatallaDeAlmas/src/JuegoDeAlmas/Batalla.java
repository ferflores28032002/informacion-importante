package JuegoDeAlmas;

import java.util.*;

public class Batalla extends Thread {

    public static void main(String[] args) {

        Humanos obj = new Humanos();
        Angeles obj2 = new Angeles();
        Demonios obj3 = new Demonios();
        Scanner entrada = new Scanner(System.in);
        int contador = 0;
        int opcion = 0;

        do {

            try {

                System.out.println("******************************************************\n");
                System.out.println("\t\tBatalla de Almas");
                System.out.println("\n\t\t1 - Jugar\n\t\t2 - Salir");

                System.out.println("\n\n******************************************************");

                System.out.print("\n\tOpcion: ");
                opcion = entrada.nextInt();

            } catch (InputMismatchException e) {

                System.out.println("\n¡No es un Numero, es una cadena!\n");
                entrada.nextLine();
            }

            switch (opcion) {
                case 1:

                    System.out.println("\n**** Un nuevo ser acaba de morir ... Una nueva batalla se acerca .. ****\n");

                    try {

                        Thread.sleep(5000);

                        obj.genearNames(1);

                        System.out.println("\n**** Angeles y demonios disputaran su alma ****");
                        Thread.sleep(5000);

                    } catch (InterruptedException e) {
                        System.out.println("Error en el ciclo de espera del Thread");
                    }
                    int ataque = 0;

                    do {


                        try {
                            System.out.print("\nPresione un numero para generar ataque aleatoriamente -> ");

                            ataque = entrada.nextInt();

                        } catch (InputMismatchException e) {

                            System.out.println("\n¡No es un Numero, es una cadena!\n");
                            entrada.nextLine();
                        }

                        int aleatorio = (int) (Math.random() * 6);

                        switch (aleatorio) {
                            case 0:
                                System.out.println("***************************************");
                                System.out.println("bondad Inicial -> " + " " + obj.getBondad());
                                System.out.println("maldad Inicial -> " + " " + obj.getMaldad());
                                System.out.println("Ataque -> [Engañar] -->  " + obj.engañar(obj2.fe));
                                System.out.println("bondad --> " + obj.getBondad());
                                System.out.println("maldad --> " + obj.getMaldad());
                                System.out.println("Fe --> " + obj.getFe());

                                if (obj.fe > 50 || obj.bondad > 60) {
                                    obj.rezar();
                                    obj.setFes(1);
                                }

                                System.out.println("***************************************");
                                System.out.println("\tAtaque del demonio");
                                System.out.println("***************************************");
                                contador += 1;
                                System.out.println("Intentos: (" + contador + "-5)");
                                break;
                            case 1:
                                System.out.println("***************************************");
                                System.out.println("bondad Inicial -> " + " " + obj.getBondad());
                                System.out.println("maldad Inicial -> " + " " + obj.getMaldad());
                                System.out.println("Ataque -> [Seducir] -->  " + obj.seducir(obj.inteligencia));
                                System.out.println("bondad --> " + obj.getBondad());
                                System.out.println("maldad --> " + obj.getMaldad());
                                System.out.println("Fe --> " + obj.getFe());
                                if (obj.fe > 50 || obj.bondad > 60) {
                                    obj.rezar();
                                    obj.setFes(1);
                                }
                                System.out.println("***************************************");
                                System.out.println("\tAtaque del demonio");
                                System.out.println("***************************************");
                                contador += 1;
                                System.out.println("Intentos: (" + contador + "-5)");
                                break;
                            case 2:
                                System.out.println("***************************************");
                                System.out.println("bondad Inicial -> " + obj.getBondad());
                                System.out.println("maldad Inicial ->  " + obj.getMaldad());
                                System.out.println("Ataque -> [Tentar] --> " + obj.tentar(obj.inteligencia, obj3.maldad));
                                System.out.println("bondad --> " + obj.getBondad());
                                System.out.println("maldad --> " + obj.getMaldad());
                                System.out.println("Fe --> " + obj.getFe());

                                if (obj.fe > 50 || obj.bondad > 60) {
                                    obj.rezar();
                                    obj.setFes(1);
                                }
                                System.out.println("***************************************");
                                System.out.println("\tAtaque del demonio");
                                System.out.println("***************************************");
                                contador += 1;
                                System.out.println("Intentos: (" + contador + "-5)");
                                break;
                            case 3:
                                System.out.println("***************************************");
                                System.out.println("bondad Inicial -> " + obj.getBondad());
                                System.out.println("maldad Inicial -> " + obj.getMaldad());
                                System.out.println("Ataque -> [Guiar]  --> " + obj.guiar(obj.inteligencia));
                                System.out.println("bondad --> " + obj.getBondad());
                                System.out.println("maldad --> " + obj.getMaldad());
                                System.out.println("Fe --> " + obj.getFe());
                                if (obj.fe > 50 || obj.bondad > 60) {
                                    obj.rezar();
                                    obj.setFes(1);
                                }
                                System.out.println("***************************************");
                                System.out.println("\tAtaque del Angel");
                                System.out.println("***************************************");
                                contador += 1;
                                System.out.println("Intentos: (" + contador + "-5)");
                                break;
                            case 4:
                                System.out.println("***************************************");
                                System.out.println("bondad Inicial -> " + obj.getBondad());
                                System.out.println("maldad Inicial -> " + obj.getMaldad());
                                System.out.println("Ataque -> [Probar] --> " + obj.probar(obj.inteligencia));
                                System.out.println("bondad --> " + obj.getBondad());
                                System.out.println("maldad --> " + obj.getMaldad());
                                System.out.println("Fe --> " + obj.getFe());
                                if (obj.fe > 50 || obj.bondad > 60) {
                                    obj.rezar();
                                    obj.setFes(1);
                                }
                                System.out.println("***************************************");
                                System.out.println("\tAtaque del Angel");
                                System.out.println("***************************************");
                                contador += 1;
                                System.out.println("Intentos: (" + contador + "-5)");

                                break;
                            case 5:
                                System.out.println("***************************************");
                                System.out.println("bondad Inicial -> " + obj.getBondad());
                                System.out.println("maldad Inicial -> " + obj.getMaldad());
                                System.out.println("Ataque -> [Proteger] --> " + obj.proteger(obj2.fe));
                                System.out.println("bondad --> " + obj.getBondad());
                                System.out.println("maldad --> " + obj.getMaldad());
                                System.out.println("Fe --> " + obj.getFe());
                                if (obj.fe > 50 || obj.bondad > 60) {
                                    obj.rezar();
                                    obj.setFes(1);
                                }
                                System.out.println("***************************************");
                                System.out.println("\tAtaque del Angel");
                                System.out.println("***************************************");
                                contador += 1;
                                System.out.println("Intentos: (" + contador + "-5)");

                                break;
                            default:
                                break;
                        }

                    } while (contador <= 4);

                    if (obj.maldad > obj.bondad) {
                        System.out.println("\n\n*** El demonio gano tu alma ***");
                    } else {
                        System.out.println("\n\n*** El angel gano tu alma ***");
                    }

                    System.out.println("*** Fin de la partida ***\n");
                    contador = 0;
                    obj.setFe();
                    obj.setBondad();
                    obj.setMaldad();

                    break;
                case 2:

                    System.exit(0);
                default:
                    System.out.println("\nLa opcion es incorrecta\n");
            }

        } while (opcion != 2);

    }

}
