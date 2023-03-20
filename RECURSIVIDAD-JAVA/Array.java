
//Recorrer un array de datos pares de forma recursiva

class Array {

    public static void MostrarElementosArray(int array[], int posicion) {
        if (posicion != (array.length)) {
            System.out.println(array[posicion]);
            MostrarElementosArray(array, posicion + 1);
        }
    }
    public static void main(String[] args) {
        int array[] = { 2, 4, 6, 8, 10, 12, 16, 18, 20 };
        MostrarElementosArray(array, 0);
    }
}

