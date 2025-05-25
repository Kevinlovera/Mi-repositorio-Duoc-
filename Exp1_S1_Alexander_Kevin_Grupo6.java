package exp1_s1_alexander_kevin_grupo6;

import java.util.ArrayList;
import java.util.Scanner;

public class Exp1_S1_Alexander_Kevin_Grupo6 {

    static int opcionMenu;

    static ArrayList<Cliente> agregarClientes = new ArrayList<>();

    static Scanner input = new Scanner(System.in);

    public static void main(String[] args) {

        Cliente cliente = null;

        while (opcionMenu != 6) { //While para que se repita el menu y el usuario desee salir.
            System.out.println("\nEstimado usuario, seleccione una opcion a continuacion");
            System.out.println("\n-------Bank Boston-------");
            System.out.println("\n1. Registrar cliente. ");
            System.out.println("2. Ver dato de cliente. ");
            System.out.println("3. Depositar. ");
            System.out.println("4. Girar. ");
            System.out.println("5. Consultar saldo. ");
            System.out.println("6. Salir. ");
            System.out.println("\n-------------------------");
            opcionMenu = input.nextInt();
            input.nextLine(); //Limpiar el buffer

            switch (opcionMenu) {

                case 1:
                    String rut;
                    do {
                        System.out.println("Estimado cliente, ingrese su rut por favor");
                        rut = input.nextLine();

                        if (rut.length() < 11 || rut.length() > 12) {
                            System.out.println("Ingrese un numero de rut completo (con puntos y guion) ");
                        }
                    } while (rut.length() < 10 || rut.length() > 12);

                    System.out.println("Por favor ingrese su nombre");
                    String nombreCliente = input.nextLine();

                    System.out.println("Ingrese su apellido paterno");
                    String apellidoPaterno = input.nextLine();

                    System.out.println("Ingrese su apellido materno");
                    String apellidoMaterno = input.nextLine();

                    System.out.println("Ingrese su domicilio (Nombre de calle)");
                    String domicilio = input.nextLine();

                    System.out.println("Ingrese comuna del cliente");
                    String comunaCliente = input.nextLine();

                    System.out.println("Ingrese su numero de telefono");
                    int numTlfn = input.nextInt();
                    input.nextLine();

                    System.out.println("Ingrese numero de cuenta corriente: ");
                    int cuentaCorriente = input.nextInt();

                    cliente = new Cliente(rut, nombreCliente, apellidoPaterno, apellidoMaterno,
                            domicilio, comunaCliente, numTlfn, cuentaCorriente);

                    agregarClientes.add(cliente);
                    System.out.println("Cliente registrado exitosamente");

                    break;

                case 2:
                    System.out.println("Ingrese rut del cliente: ");
                    rut = input.nextLine();

                    Cliente clientess = buscarCliente(agregarClientes, rut);

                    if (clientess != null) {
                        clientess.mostrarDatos();
                    } else {
                        System.out.println("Cliente no encontrado.");
                    }

                    break;

                case 3:
                    System.out.println("Ingrese su rut por favor");
                    rut = input.nextLine();

                    cliente = buscarCliente(agregarClientes, rut);

                    if (cliente != null) {

                        System.out.println("Ingrese el monto a depositar");
                        int montoDeposito = input.nextInt();

                        input.nextLine();

                        if (cliente.getCuenta().depositar(montoDeposito)) {
                            System.out.println("Deposito exitoso");
                        } else {
                            System.out.println("Monto invalido");
                        }

                    } else {
                        System.out.println("Cliente no encontrado");
                    }
                    break;

                case 4:
                    System.out.println("Ingrese su rut por favor: ");
                    rut = input.nextLine();

                    cliente = buscarCliente(agregarClientes, rut);

                    if (cliente != null) {

                        System.out.println("Ingrese el monto a girar");
                        int montoGiro = input.nextInt();
                        input.nextLine();

                        if (montoGiro < 0) {
                            System.out.println("El monto a girar debe ser mayor a 0");
                        } else if (montoGiro > cliente.getCuenta().getSaldo()) {
                            System.out.println("Saldo insuficiente para girar");
                        } else {
                            cliente.getCuenta().girar(montoGiro);
                            System.out.println("Giro exitoso");
                        }
                    } else {
                        System.out.println("Cliente no encontrado");
                    }

                    break;

                case 5:
                    System.out.println("Ingrese su rut por favor: ");
                    rut = input.nextLine();

                    cliente = buscarCliente(agregarClientes, rut);

                    if (cliente != null) {
                        System.out.println("Saldo actual: " + cliente.getCuenta().getSaldo() + " pesos");
                    }

                    break;

                case 6:
                    System.out.println("Gracias por haber visitado Bank Boston, hasta luego");
                    break;

                default:
                    System.out.println("\nHa ingresado una opcion invalida!");
                    break;

            }

        }

    }

    // Método para buscar cliente en la lista por RUT
    //Este método recorre la lista de clientes y retorna el objeto Cliente que tiene el mismo rut que estás buscando.
    public static Cliente buscarCliente(ArrayList<Cliente> lista, String rutBuscado) {
        for (Cliente c : lista) {
            if (c.getRutCliente().equalsIgnoreCase(rutBuscado)) {
                return c;
            }
        }
        return null; //Si no encuentra el cliente

    }
}
