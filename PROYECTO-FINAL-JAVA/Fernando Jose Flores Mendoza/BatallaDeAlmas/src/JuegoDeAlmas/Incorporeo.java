package JuegoDeAlmas;

public class Incorporeo {

    public double fe, maldad, bondad;

    public Incorporeo() {
        fe = (int) (Math.random() * 100);
        maldad = (int) (Math.random() * 100);
        bondad = (int) (Math.random() * 100);
    }

    public void setFe() {
        this.fe = (int) (Math.random() * 100);
    }

    public void setFes(double fe) {
        this.fe += fe;
    }

    public void setMaldad() {
        this.maldad = (int) (Math.random() * 100);
    }

    public void setBondad() {
        this.bondad = (int) (Math.random() * 100);
    }

    public double getFe() {
        return fe;
    }

    public double getMaldad() {
        return maldad;
    }

    public double getBondad() {
        return bondad;
    }

    public double engañar(double angelfe) {

        double resultado = 0;

        resultado = (fe / angelfe) * ((bondad - maldad) / angelfe);

        this.maldad += (resultado);

        return resultado;
    }

    public double seducir(double inteligencia) {

        double resultado = 0;

        resultado = (bondad - maldad) - inteligencia / (fe - bondad);
        this.maldad += (resultado);

        return resultado;
    }

    public double tentar(double inteligencia, double demoMaldad) {

        double resultado = 0;

        resultado = ((fe + maldad) / inteligencia) / (bondad - demoMaldad);
        this.maldad += (resultado);

        return resultado;
    }

    public double guiar(double inteligencia) {

        double resultado = 0;

        resultado = (bondad - maldad - inteligencia) / (fe - maldad);
        this.bondad += (resultado);

        return resultado;
    }

    public double probar(double inteligencia) {
        double resultado = 0;

        resultado = fe - (maldad * maldad) / inteligencia / (bondad - maldad);
        this.bondad += (resultado);

        return resultado;
    }

    public double proteger(double angelfe) {
        double resultado = 0;

        resultado = fe * (bondad - maldad) / angelfe;
        this.bondad += resultado;

        return resultado;
    }

}
