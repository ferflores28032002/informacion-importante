/*
 6 - Cree una jerarqu�a de herencia de Roedores: Rat�n, Gerbo, Hamster, etc. En la clase base, proporcione
 los m�todos que son comunes a todos los roedores, y redefina aquellos en las clases derivadas para
 que tengan diferentes comportamientos dependiendo del tipo espec�fico de roedor. Cree un array de
 objetos a Roedor, rell�nelo con distintos tipos de roedores y llame a los m�todos de la clase base para
 ver lo que ocurre.

 */

abstract class Roedores {

    public void caracterisricasComunes() {
        System.out.println("Soy un roedor, son relativamente peque�o y tengo patas cortas");
    }

    //El m�todo abstracto para definir el color del roedor
    public abstract void HabitadAndColor();

}

//=======================================================//
class Rata extends Roedores {

    String color;

    public Rata(String color) {
        this.color = color;
    }

    public void HabitadAndColor() {
        System.out.println("Soy una Rata y me expando en nidos escondidos en tierra y mi color es " + this.color);
    }
}

//=======================================================//
class Gerbo extends Roedores {

    String color;

    public Gerbo(String color) {
        this.color = color;
    }

    public void HabitadAndColor() {
        System.out.println("Soy un Gerbo y Por lo tanto, estoy acostumbrado tanto al fr�o invierno como al caluroso verano y mi color es " + this.color);
    }
}

//====================================================//
class Hamster extends Roedores {

    String color;

    public Hamster(String color) {
        this.color = color;
    }

    public void HabitadAndColor() {
        System.out.println("Soy un Hamster y  me gusta cavar t�neles para descansar y mi color es " + this.color);
    }
}

public class Animal {

    public static void main(String[] args) {

        Rata rata[] = {new Rata("Blanco"), new Rata("Negra")};

        Gerbo gerbo[] = {new Gerbo("Gris"), new Gerbo("Blanco")};

        Hamster hamster[] = {new Hamster("oscuro"), new Hamster("cafe claro")};

        System.out.println("\tRatas\n");
        for (int i = 0; i < rata.length; i++) {
            rata[i].HabitadAndColor();
            rata[i].caracterisricasComunes();

        }

        System.out.println("\n\tGerbos\n");
        for (int i = 0; i < gerbo.length; i++) {
            gerbo[i].HabitadAndColor();
            gerbo[i].caracterisricasComunes();

        }
        System.out.println("\n\tHamster\n");
        for (int i = 0; i < hamster.length; i++) {
            hamster[i].HabitadAndColor();
            hamster[i].caracterisricasComunes();

        }

    }
}
