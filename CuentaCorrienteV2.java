
package Exp1_S2_Alexander_Kevin_Grupo6_Version_Mejorada;


public class CuentaCorrienteV2 extends CuentaClienteV2 {
    
     public CuentaCorrienteV2(int saldo, int numeroDeCuenta, String tipoCuenta, String rut, String nombre, String apellidoPaterno, String apellidoMaterno, String domicilio, String comuna, String numeroTelefono) {
        super(saldo, numeroDeCuenta, tipoCuenta, rut, nombre, apellidoPaterno, apellidoMaterno, domicilio, comuna, numeroTelefono);
    }

    @Override
    public void giro(int cantidad) {

        if (saldo > 0 && cantidad <= saldo) {
            saldo -= cantidad;
            System.out.println("Giro realizado por: " + numberFormat.format(cantidad));
            System.out.println("Saldo actual: " + numberFormat.format(saldo));
        } else {
            System.out.println("No se puedo realizar transaccion por saldo insuficiente");
        }
    }

    @Override
    public void deposito(int cantidad) {

        if (cantidad > 0) {
            System.out.println("Deposito realizado por: " + numberFormat.format(cantidad));
            saldo += cantidad;
            System.out.println("Saldo actual: " + numberFormat.format(saldo));
        } else {
            System.out.println("Tiene que abonar mas de $0 a su cuenta");
        }
    }
}
    
    

