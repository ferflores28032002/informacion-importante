/*
  6 - Realice la implementación del diagrama de clases que se muestra en la parte superior.
  Como podrá apreciar todos los empleados tienen nombres, apellidos, salarioBase y salario como atributos en común.
  La forma del cálculo del salario varia para cada sub clase. Es la siguiente:
  Jefe: salario es igual al salario base
  Trabajador por comisión: este trabajador tiene un salario base más un porcentaje por las ventas realizadas.
  Trabajador por destajo (por producción): su salario es igual al salario base más el total de piezas producidas por el salario de producir
  dicha pieza.
  La implementación deberá de leer desde el teclado, según corresponda la instancia a la que se haga referencia. Deberá de incluir un
  menú:
  1 Jefe
  2 Trabajador por comisión
  3 Trabajador por destajo
  9 Salir de menú


  Cuando se realicen las llamadas a las diferencias instancias del método imprimir deberán de incluir un mensaje indicando el tipo de
  instancia. Por ejemplo:
  Soy un jefe
  Soy un trabajador por comisión
  Soy un trabajador por destajo

 */

import java.util.*;

abstract class Empleado {

    String nombres;
    String Apellidos;
    double salarioBase;
    double salario;

    public Empleado(String nombres, String Apellidos, double salarioBase) {
        this.nombres = nombres;
        this.Apellidos = Apellidos;
        this.salarioBase = salarioBase;
    }

    public void getPerfil() {
        System.out.println("\tInformacion Personal");
        System.out.println("Nombres: " + this.nombres);
        System.out.println("Apellidos: " + this.Apellidos);
        System.out.println("Salario Base: " + this.salarioBase);
    }

    //Método abstracto
    public abstract void calcularSalario();

}

//=================================================================//

class Jefe extends Empleado {

    public Jefe() {
        super("Fernando Jose", "Flores Mendoza", 1200.56);
    }

    @Override
    public void calcularSalario() {
        System.out.println("¡Hola! soy un jefe y mi salario es: " + this.salarioBase);
    }

}

//=================================================================//
class TrabajadorComision extends Empleado {

    double Comision;
    double ventas;

    public TrabajadorComision(double Comision, double ventas) {
        super("Brayan Gutierrez", "Lezama", 1500.00);
        this.Comision = Comision;
        this.ventas = ventas;
    }

    @Override
    public void calcularSalario() {
        double aumento = this.Comision * this.ventas;

        System.out.println("¡Hola! soy un Soy un trabajador por comisión y mi sueldo es: " + (aumento + this.salarioBase));
    }
}

//===============================================================//

class TrabajadorDespajo extends Empleado {

    double piezas;
    double salarioPorPiezas;

    public TrabajadorDespajo(double piezas, double salarioPorPiezas) {
        super("Brayan Gutierrez", "Lezama", 1500.00);
        this.piezas = piezas;
        this.salarioPorPiezas = salarioPorPiezas;
    }

    @Override
    public void calcularSalario() {
        double aumento = this.piezas * this.salarioPorPiezas;

        System.out.println("¡Hola! soy un Soy un Soy un trabajador por destajo y mi sueldo es: " + (aumento + this.salarioBase));
    }
}

//==============================================================//

public class Trabajadores {

    public static void main(String[] args) {

        int opcion = 0;
        Scanner entrada = new Scanner(System.in);

        do {

            try {

                System.out.println("\n1-Jefe\n2-Trabajador por comisión\n3- Trabajador por destajo\n4-Salir del menu\n\nOpcion: ");
                opcion = entrada.nextInt();

            } catch (InputMismatchException e) {
                
                System.out.println("¡No es un Numero, es una cadena!");
                entrada.nextLine();
            }

            switch (opcion) {
                case 1:

                    Jefe jefe1 = new Jefe();
                    jefe1.getPerfil();
                    jefe1.calcularSalario();

                    break;
                case 2:

                    TrabajadorComision trabaj1 = new TrabajadorComision(4, 10);
                    trabaj1.getPerfil();
                    trabaj1.calcularSalario();

                    break;
                case 3:

                    TrabajadorDespajo trabaj2 = new TrabajadorDespajo(20, 30);
                    trabaj2.getPerfil();
                    trabaj2.calcularSalario();

                    break;
                case 4:
                    System.exit(0);

                    break;
                default:
                    System.out.println("¡Opcion invalida!");
            }

        } while (opcion != 4);

    }

}
