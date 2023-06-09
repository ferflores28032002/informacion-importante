/*
    Define tres clases, casa, salonCasa y cocinaCasa. La clase salonCasa debe tener como atributos
    numerosDeTelevisores (int) y typoSalon (String) y disponer de un constructor que los inicialice a
    0 y desconocido. La clase cocinaCasa debe tener como atributos: esIndependientes (boolean) y 
    numerosDeFuego (int) y un constructor que los inicialice a false y 0. La clase casa tendra los 
    siguientes atributos: superficie (double), direccion (string), salonCasa (tipo salonCasa) 
    y cocina (tipo cocinaCasa) defina un constructor para la clase casa que establezca sus valores
    de defecto los atributos simples y que cree nuevos objetos si se trata de atributos objetos.
    Compila el codigo para comprobar que no presente errores, crea un objeto de tipo casa. Comprueba
    que se inicializaron correctamente consultando el valor de sus atributos despues de haber creado
    los objetos.
 */

import java.util.*;

class CocinaCasa {

    private boolean esIndependiente;
    private int numeroFuego;

    public CocinaCasa() {
        this.esIndependiente = false;
        this.numeroFuego = 0;
    }

    //Sobrecarga de constructores
    public CocinaCasa(boolean esIndependiente, int numeroFuego) {
        this.esIndependiente = esIndependiente;
        this.numeroFuego = numeroFuego;
    }

    //M�todo Getter
    public String getCocinaCasa() {
        return "\nesIndependiente: " + this.esIndependiente + "\nN�meroFuego: " + this.numeroFuego;
    }

}

// ********************************************************************************
class SalonCasa {

    private int numeroDeTelevisores;
    private String tipoSalon;

    public SalonCasa() {
        this.numeroDeTelevisores = 0;
        this.tipoSalon = "Desconocido";
    }

    //Sobrecarga de constructores
    public SalonCasa(int numeroDeTelevisores, String tipoSalon) {
        this.numeroDeTelevisores = numeroDeTelevisores;
        this.tipoSalon = tipoSalon;
    }

    //M�todo Getter
    public String getSalonCasa() {
        return "\nN� Televisores: " + this.numeroDeTelevisores + "\ntipo salon: " + this.tipoSalon;
    }
}

// ********************************************************************************
class Casa {

    private double superficie;
    private String direccion;

    //Instancias de la clase CocinaCasa
    CocinaCasa cocinaHouse1 = new CocinaCasa();
    CocinaCasa cocinaHouse2 = new CocinaCasa(true, 5);

    //Instancias de la clase SalonCasa
    SalonCasa salonHouse1 = new SalonCasa();
    SalonCasa salonHouse2 = new SalonCasa(4, "Salon Multiuso");

    public Casa() {
        this.superficie = 102.45;
        this.direccion = "Donde venden frijoles 2C arriba";
    }

    //M�todo Gettes
    public String getinfoCasa() {
        return "\nSuperficie: " + this.superficie + " mt" + "\nDireccion: " + this.direccion;
    }

    public String getDatosPorDefectos() {
        return "Datos: " + getinfoCasa() + this.cocinaHouse1.getCocinaCasa()
                + this.salonHouse1.getSalonCasa();
    }

    public String getDatosModificados() {
        return "Datos: " + getinfoCasa() + this.cocinaHouse2.getCocinaCasa()
                + this.salonHouse2.getSalonCasa();
    }

    //M�todo Setter
    public void SetSuperficie(double superficie) {
        if (superficie > 10 && superficie <= 200) {
            this.superficie = superficie;
            System.out.println("\n\n�Se ha modificado la superficie perfectamente!");
        } else {
            System.out.println("\n\nError: No se acepta superficies menores que 10. o mayores que 200!");
        }
    }
}

public class House {

    public static void main(String[] args) {

        Scanner entrada = new Scanner(System.in);

        Casa casa1 = new Casa();
        Casa casa2 = new Casa();

        System.out.println("\t*** Casa #1 ****\n");
        System.out.println(casa1.getDatosPorDefectos());
        System.out.println("\n\t*** Casa #2 ****\n");
        System.out.println(casa2.getDatosModificados());

        System.out.println("\nIngrese la nueva superficie: ");
        double newSuperficie = entrada.nextDouble();
        casa2.SetSuperficie(newSuperficie);
        System.out.println("\n*** La casa #2 ***\n" + casa2.getDatosModificados());
    }
}
