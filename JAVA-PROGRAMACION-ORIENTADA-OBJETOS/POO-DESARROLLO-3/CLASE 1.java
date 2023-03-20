
import java.io.*;

public class Letras {
    public static void main(String [] arg)throws IOException
    {
        char primero, segundo;

        System.out.println("Ingrese su primera incial y segunda");
        System.out.flush();

        primero=(char)System.in.read();
        segundo=(char)System.in.read();


        System.out.println("Hola " + primero + "." + segundo);
    } 
}
