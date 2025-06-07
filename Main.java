
package Exp1_S2_Alexander_Kevin_Grupo6_Version_Mejorada;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Locale;
import java.util.Scanner;
import java.util.*;

public class Main {


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

    public static List<CuentaClienteV2> buscarCuentasPorRut(String rut) {
        List<CuentaClienteV2> resultado = new ArrayList<>();
        for (CuentaClienteV2 cuenta : cuentas) {
            if (cuenta.getRut().equals(rut)) {
                resultado.add(cuenta);
            }
        }
        return resultado;
    }

    public static CuentaClienteV2 seleccionarCuentaPorTipo(List<CuentaClienteV2> cuentasCliente, String accion) {
        System.out.println("Seleccione tipo de cuenta para " + accion + ":");
        for (int i = 0; i < cuentasCliente.size(); i++) {
            System.out.println((i + 1) + ". " + cuentasCliente.get(i).getTipoCuenta());
        }
        System.out.print("Ingrese opción: ");
        int opcion = scanner.nextInt();
        scanner.nextLine();
        if (opcion >= 1 && opcion <= cuentasCliente.size()) {
            return cuentasCliente.get(opcion - 1);
        } else {
            System.out.println("Opción inválida.");
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
                    int tipoCuenta = scanner.nextInt();
                    scanner.nextLine();

                    boolean existeCuentaTipo = false;
                    for (CuentaClienteV2 c : cuentas) {
                        if (c.getRut().equals(rut) && c.getTipoCuenta().equals(
                                tipoCuenta == 1 ? "Corriente" : tipoCuenta == 2 ? "Ahorro" : "Crédito")) {
                            System.out.println("Ya existe una cuenta de ese tipo para este cliente.");
                            existeCuentaTipo = true;
                            break;
                        }
                    }
                    

                    int saldoInicial = 0;
                    int numeroCuenta = 1000 + cuentas.size();

                    CuentaClienteV2 nuevaCuenta = null;

                    switch (tipoCuenta) {
                        case 1:
                            nuevaCuenta = new CuentaCorrienteV2(saldoInicial, numeroCuenta, "Corriente", rut, nombre, apellidoPaterno, apellidoMaterno, domicilio, comuna, numeroTelefono);
                            break;
                        case 2:
                            nuevaCuenta = new CuentaAhorroV2(saldoInicial, numeroCuenta, "Ahorro", rut, nombre, apellidoPaterno, apellidoMaterno, domicilio, comuna, numeroTelefono);
                            break;
                        case 3:
                            nuevaCuenta = new CuentaCreditoV2(saldoInicial, numeroCuenta, "Crédito", rut, nombre, apellidoPaterno, apellidoMaterno, domicilio, comuna, numeroTelefono);
                            break;
                        default:
                            System.out.println("Tipo de cuenta inválido.");
                            continue;
                    }

                    cuentas.add(nuevaCuenta);
                    System.out.println("Cliente registrado con éxito.");
                    break;

                case 2:
                    System.out.println("Ingrese RUT del cliente a consultar:");
                    rut = scanner.nextLine();
                    List<CuentaClienteV2> cuentasCliente = buscarCuentasPorRut(rut);
                    if (!cuentasCliente.isEmpty()) {
                        for (CuentaClienteV2 c : cuentasCliente) {
                            c.mostrarInformacion();
                            System.out.println("-------------------");
                        }
                    } else {
                        System.out.println("Cliente no encontrado.");
                    }
                    break;

                case 3:
                    System.out.println("Ingrese RUT del cliente para depositar:");
                    rut = scanner.nextLine();
                    cuentasCliente = buscarCuentasPorRut(rut);
                    if (!cuentasCliente.isEmpty()) {
                        CuentaClienteV2 cuentaSeleccionada = seleccionarCuentaPorTipo(cuentasCliente, "depositar");
                        if (cuentaSeleccionada != null) {
                            System.out.println("Ingrese cantidad a depositar:");
                            int cantidad = scanner.nextInt();
                            scanner.nextLine();
                            cuentaSeleccionada.deposito(cantidad);
                        }
                    } else {
                        System.out.println("Cliente no encontrado.");
                    }
                    break;

                case 4:
                    System.out.println("Ingrese RUT del cliente para girar:");
                    rut = scanner.nextLine();
                    cuentasCliente = buscarCuentasPorRut(rut);
                    if (!cuentasCliente.isEmpty()) {
                        CuentaClienteV2 cuentaSeleccionada = seleccionarCuentaPorTipo(cuentasCliente, "girar");
                        if (cuentaSeleccionada != null) {
                            System.out.println("Ingrese cantidad a girar:");
                            int cantidad = scanner.nextInt();
                            scanner.nextLine();
                            cuentaSeleccionada.giro(cantidad);
                        }
                    } else {
                        System.out.println("Cliente no encontrado.");
                    }
                    break;

                case 5:
                    System.out.println("Ingrese RUT del cliente para consultar saldo:");
                    rut = scanner.nextLine();
                    cuentasCliente = buscarCuentasPorRut(rut);
                    if (!cuentasCliente.isEmpty()) {
                        CuentaClienteV2 cuentaSeleccionada = seleccionarCuentaPorTipo(cuentasCliente, "consultar saldo");
                        if (cuentaSeleccionada != null) {
                            System.out.println("Saldo actual: " + numberFormat.format(cuentaSeleccionada.getSaldo()));
                        }
                    } else {
                        System.out.println("Cliente no encontrado.");
                    }
                    break;

                case 6:
                    System.out.println("Ingrese RUT del cliente que desea eliminar:");
                    rut = scanner.nextLine();
                    cuentasCliente = buscarCuentasPorRut(rut);
                    if (!cuentasCliente.isEmpty()) {
                        cuentas.removeAll(cuentasCliente);
                        System.out.println("Cliente(s) eliminado(s) con éxito.");
                    } else {
                        System.out.println("Cliente no encontrado.");
                    }
                    break;

                case 7:
                    System.out.println("Gracias por usar Bank Boston. ¡Hasta pronto!");
                    break;

                default:
                    System.out.println("Opción inválida. Intente nuevamente.");
            }

        } while (opcionMenu != 7);

        scanner.close();
    }
}