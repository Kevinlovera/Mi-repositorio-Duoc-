package exp1_s1_alexander_kevin_grupo6;

public class CuentaCorrienteCliente {

    private int numeroCuenta;
    private int saldo;

    public CuentaCorrienteCliente(int numeroCuenta, int saldo) {
        this.numeroCuenta = numeroCuenta;
        this.saldo = saldo;
    }

    public int getNumeroCuenta() {
        return numeroCuenta;
    }

    public void setNumeroCuenta(int numeroCuenta) {
        this.numeroCuenta = numeroCuenta;
    }

    public int getSaldo() {
        return saldo;
    }

    public void setSaldo(int saldo) {
        this.saldo = saldo;
    }

    public boolean depositar(int monto) {
        if (monto > 0) {
            saldo += monto;
            return true;
        } else {
            System.out.println("No pudo depositarse");
            return false;
        }
    
    }
    
    public boolean girar (int monto) {
        if (monto <= 0 || monto >saldo) {
            return false;
        } else {
            saldo -= monto;
            return true;
        }
        
    }

}
