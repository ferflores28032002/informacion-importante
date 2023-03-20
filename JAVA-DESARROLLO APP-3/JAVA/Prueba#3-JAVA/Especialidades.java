/*
    Crear una clase docente que tiene como atributo privado el nombre y el apellido, tipo, que 
    puede ser ciencia / letra, y horas, crear un contructutor publico que inicialize todo los
    atributos, metodos de acceso get, set para todos los atributos, un metodo que retorno
    nombre y apellido, un metodo que retorno sueldo bruto , un metodo que retorno un descuento
    de 10%  y un metodo que retorne sueldo neto, una clase pincipal que manipule a Docente;
 */


class Persona{
    
    private String nombre;
    private String apellido;
    
    
    public Persona(String nombre, String apellido){
        this.nombre = nombre;
        this.apellido = apellido;
    }  

    public String getNombre() {
        return nombre;
    }

    public String getApellido() {
        return apellido;
    }
    
    
}

//CLASE DOCENTE

class Docente extends Persona{
    
    private String tipo;
    private double salarioBrutoMensual;
    private double INSS;
    
    public Docente(String nombre, String apellido,String tipo, double sBruto, double INSS){
        super(nombre, apellido);
        this.tipo = tipo;
        this.salarioBrutoMensual = sBruto;
        this.INSS = INSS;
    }

    public String getTipo() {
        return tipo;
    }

    public double getSalarioBrutoMensual() {
        return salarioBrutoMensual;
    }

    public double getINSS() {
        return INSS;
    }
    
    public double SalarioNeto(){
        return salarioBrutoMensual - INSS;
    }
    public double Descuento(){
        return salarioBrutoMensual-(salarioBrutoMensual * 0.10);
    }
    
    
}




public class Especialidades {
    public static void main(String[] args) {
        Docente docente1 = new Docente("Fernando", "Flores","Letras", 5000.31, 500.56);
        
        System.out.println("\tDatos: \n");
        
        System.out.println("Nombre: "+docente1.getNombre());
        System.out.println("Apellido: "+docente1.getApellido());
        System.out.println("Tipo: "+docente1.getTipo());
        System.out.println("Cobro INSS: "+docente1.getINSS());
        System.out.println("Salario Bruto Mensual: "+docente1.getSalarioBrutoMensual());
        System.out.println("Descuento del 10% aplicado: "+docente1.Descuento());
        System.out.println("Salario Neto: "+docente1.SalarioNeto());
        
    }
    
}
