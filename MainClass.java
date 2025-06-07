package Exp1_S2_Alexander_Kevin_Grupo6_Version_Mejorada;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Locale;
import java.util.Scanner;
import java.util.*;

public class MainClass {

    static Scanner scanner = new Scanner(System.in);
    static List<CuentaClienteV2> cuentas = new ArrayList<>();

    static public void mostrarMenu() {
        System.out.println("\n-------------------------");
        System.out.println("1. Registrar cliente");
        System.out.println("2. Ver datos de cliente");
        System.out.println("3. Depositar");
        System.out.println("4. Girar");
        System.out.println("5. Consultar saldo");
        System.out.println("6. Eliminar cliente");
        System.out.println("7. Salir");
        System.out.println("-------------------------\n");
    }

    public static List<CuentaClienteV2> buscarCuentasPorRut(String rutRecibido) {
        List<CuentaClienteV2> resultado = new ArrayList<>();
        for (CuentaClienteV2 cuentaBuscada : cuentas) {
            if (cuentaBuscada.getRut().equals(rutRecibido)) {
                resultado.add(cuentaBuscada);
            }
        }
        return resultado;
    }

    public static CuentaClienteV2 seleccionarTipoDeCuenta(List<CuentaClienteV2> seleccionarCuentaCliente, String cuentaElegir) {
        System.out.println("Seleccione el tipo de cuenta para " + cuentaElegir + ":");
        for (int i = 0; i < seleccionarCuentaCliente.size(); i++) {
            System.out.println((i + 1) + ". " + seleccionarCuentaCliente.get(i).getTipoCuenta());
        }
        System.out.println("Ingrese opcion: ");
        int opcionCuenta = scanner.nextInt();
        scanner.nextLine();

        if (opcionCuenta >= 1 && opcionCuenta <= seleccionarCuentaCliente.size()) {
            return seleccionarCuentaCliente.get(opcionCuenta - 1);
        } else {
            System.out.println("Opcion invalidad");
            return null;
        }

    }

    public static void main(String[] args) {

        Locale locale = new Locale("es", "CL");
        NumberFormat numberFormat = NumberFormat.getCurrencyInstance(locale);

        int opcionMenu;

        System.out.println("\nBienvenido a Bank Boston");
        System.out.println("Puede registrarse y operar múltiples cuentas bancarias.");
        System.out.println("--------------------------------------------------------\n");

        do {

            System.out.println("Seleccione una opción:");
            mostrarMenu();
            opcionMenu = scanner.nextInt();
            scanner.nextLine(); // Limpiar buffer

            switch (opcionMenu) {

                case 1:
                    System.out.println("Ingrese su RUT (con puntos y guión): ");
                    String rut = scanner.nextLine();

                    if (!(rut.contains(".") && rut.contains("-") && rut.length() >= 11 && rut.length() <= 12)) {
                        System.out.println("RUT incorrecto. Intente nuevamente.");
                        break;
                    }

                    System.out.println("Ingrese nombre: ");
                    String nombre = scanner.nextLine();
                    System.out.println("Ingrese apellido paterno:");
                    String apellidoPaterno = scanner.nextLine();
                    System.out.println("Ingrese apellido materno:");
                    String apellidoMaterno = scanner.nextLine();
                    System.out.println("Ingrese domicilio:");
                    String domicilio = scanner.nextLine();
                    System.out.println("Ingrese comuna:");
                    String comuna = scanner.nextLine();
                    System.out.println("Ingrese número de teléfono:");
                    String numeroTelefono = scanner.nextLine();

                    System.out.println("\nSeleccione tipo de cuenta:");
                    System.out.println("1. Corriente");
                    System.out.println("2. Ahorro");
                    System.out.println("3. Crédito");
                    int tipoDeCuentaElegida = scanner.nextInt();
                    scanner.nextLine();

                    boolean existeAlgunTipoDeCuenta = false;
                    for (CuentaClienteV2 c : cuentas) {
                        if (c.getRut().equals(rut) && c.getTipoCuenta().equals(tipoDeCuentaElegida == 1 ? "Corriente" : tipoDeCuentaElegida == 2 ? "Ahorro" : "Credito")) {
                            System.out.println("Ya existe una cuenta con este tipo para este cliente");
                            existeAlgunTipoDeCuenta = true;
                            break;
                        }
                    }

                    int saldoInicial = 0;
                    int numeroDeCuenta = 1000 + cuentas.size();

                    CuentaClienteV2 nuevaCuentaCreada = null;

                    switch (tipoDeCuentaElegida) {

                        case 1:
                            nuevaCuentaCreada = new CuentaCorrienteV2(saldoInicial, numeroDeCuenta, "Corriente", rut, nombre, apellidoPaterno, apellidoMaterno, domicilio, comuna, numeroTelefono);
                            break;

                        case 2:
                            nuevaCuentaCreada = new CuentaAhorroV2(saldoInicial, numeroDeCuenta, "Ahorro", rut, nombre, apellidoPaterno, apellidoMaterno, domicilio, comuna, numeroTelefono);
                            break;

                        case 3:
                            nuevaCuentaCreada = new CuentaCreditoV2(saldoInicial, numeroDeCuenta, "Crédito", rut, nombre, apellidoPaterno, apellidoMaterno, domicilio, comuna, numeroTelefono);
                            break;

                        default:
                            System.out.println("Tipo de cuenta inválido.");
                            break;

                    }

                    if (nuevaCuentaCreada != null) {
                        cuentas.add(nuevaCuentaCreada);
                        System.out.println("Cuenta creada con éxito");
                    }

                case 2:

                    System.out.println("Ingrese rut del cliente  a consultar: ");
                    rut = scanner.nextLine();

                    List<CuentaClienteV2> cuentasDelCliente = buscarCuentasPorRut(rut);

                    if (!cuentasDelCliente.isEmpty()) {
                        for (CuentaClienteV2 c : cuentasDelCliente) {
                            c.mostrarInformacion();
                            System.out.println("==============");
                        }
                    } else {
                        System.out.println("Cliente no encontrado");
                    }
                    break;

                case 3:

                    System.out.println("Ingrese el rut del cliente para depositar: ");
                    rut = scanner.nextLine();
                    List<CuentaClienteV2> cuentasClientess = buscarCuentasPorRut(rut);
                    if (!cuentasClientess.isEmpty()) {
                        CuentaClienteV2 cuentaSeleccionadaDeposito = seleccionarTipoDeCuenta(cuentasClientess, "depositar");

                        if (cuentaSeleccionadaDeposito != null) {
                            System.out.println("Ingrese cantidad a depositar:");
                            int cantidadDeposito = scanner.nextInt();
                            scanner.nextLine();

                            cuentaSeleccionadaDeposito.deposito(cantidadDeposito);
                        }

                    } else {
                        System.out.println("Cliente no encontrado");
                    }
                    break;

                case 4:
                    System.out.println("Ingrese el rut del cliente para girar: ");
                    rut = scanner.nextLine();
                    List<CuentaClienteV2> cuentasDelClienteNuevo = buscarCuentasPorRut(rut);

                    if (!cuentasDelClienteNuevo.isEmpty()) {
                        CuentaClienteV2 cuentaSeleccionadaGiro = seleccionarTipoDeCuenta(cuentasDelClienteNuevo, "girar");
                        if (cuentaSeleccionadaGiro != null) {
                            System.out.println("Ingrese cantidad a girar:");
                            int cantidad = scanner.nextInt();
                            scanner.nextLine();
                            cuentaSeleccionadaGiro.giro(cantidad);
                        }
                    } else {
                        System.out.println("Cliente no encontrado.");
                    }
                    break;

                case 5:
                    System.out.println("Ingrese rut del cliente para consultar saldo: ");
                    rut = scanner.nextLine();

                    List<CuentaClienteV2> cuentaClienteConsultarSaldo = buscarCuentasPorRut(rut);

                    if (!cuentaClienteConsultarSaldo.isEmpty()) {

                        CuentaClienteV2 cuentaSeleccionadaSaldo = seleccionarTipoDeCuenta(cuentaClienteConsultarSaldo, "consultar saldo");

                        if (cuentaSeleccionadaSaldo != null) {

                            System.out.println("Saldo actual: " + numberFormat.format(cuentaSeleccionadaSaldo.saldo));
                        } else {
                            System.out.println("Cliente no encontrado. ");
                        }
                        break;

                    }

                case 6:
                    System.out.println("Ingrese el rut del ciente a eliminar: ");
                    rut = scanner.nextLine();
                    List<CuentaClienteV2> eliminarCliente = buscarCuentasPorRut(rut);

                    if (!eliminarCliente.isEmpty()) {
                        cuentas.removeAll(eliminarCliente);
                        System.out.println("Cliente eliminado con exito");
                    } else {
                        System.out.println("Cliente no encontrado");
                    }
                    break;

                case 7:
                    System.out.println("Gracias por usar Bank Boston. Hasta pronto!");
                    break;

                default:
                    System.out.println("Opcion invalida, intente de nuevo. ");

            }
        } while (opcionMenu != 7);
    }
}
