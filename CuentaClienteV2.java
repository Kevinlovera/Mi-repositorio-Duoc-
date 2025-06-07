package Exp1_S2_Alexander_Kevin_Grupo6_Version_Mejorada;

import java.text.NumberFormat;
import java.util.Locale;

public abstract class CuentaClienteV2 implements MostrarDatosV2 {

    int saldo;
    int numeroDeCuenta;
    String tipoCuenta;
    private String rut;
    private String nombre;
    private String apellidoPaterno;
    private String apellidoMaterno;
    private String domicilio;
    private String comuna;
    private String numeroTelefono;

    public CuentaClienteV2(int saldo, int numeroDeCuenta, String tipoCuenta, String rut, String nombre, String apellidoPaterno, String apellidoMaterno, String domicilio, String comuna, String numeroTelefono) {
        this.saldo = saldo;
        this.numeroDeCuenta = numeroDeCuenta;
        this.tipoCuenta = tipoCuenta;
        this.rut = rut;
        this.nombre = nombre;
        this.apellidoPaterno = apellidoPaterno;
        this.apellidoMaterno = apellidoMaterno;
        this.domicilio = domicilio;
        this.comuna = comuna;
        this.numeroTelefono = numeroTelefono;
    }

    protected Locale locale = Locale.forLanguageTag("es-CL");
    protected NumberFormat numberFormat = NumberFormat.getCurrencyInstance(locale);

    public int getSaldo() {
        return saldo;
    }

    public void setSaldo(int saldo) {
        this.saldo = saldo;
    }

    public int getNumeroDeCuenta() {
        return numeroDeCuenta;
    }

    public void setNumeroDeCuenta(int numeroDeCuenta) {
        this.numeroDeCuenta = numeroDeCuenta;
    }

    public String getTipoCuenta() {
        return tipoCuenta;
    }

    public void setTipoCuenta(String tipoCuenta) {
        this.tipoCuenta = tipoCuenta;
    }

    public String getRut() {
        return rut;
    }

    public void setRut(String rut) {
        this.rut = rut;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidoPaterno() {
        return apellidoPaterno;
    }

    public void setApellidoPaterno(String apellidoPaterno) {
        this.apellidoPaterno = apellidoPaterno;
    }

    public String getApellidoMaterno() {
        return apellidoMaterno;
    }

    public void setApellidoMaterno(String apellidoMaterno) {
        this.apellidoMaterno = apellidoMaterno;
    }

    public String getDomicilio() {
        return domicilio;
    }

    public void setDomicilio(String domicilio) {
        this.domicilio = domicilio;
    }

    public String getComuna() {
        return comuna;
    }

    public void setComuna(String comuna) {
        this.comuna = comuna;
    }

    public String getNumeroTelefono() {
        return numeroTelefono;
    }

    public void setNumeroTelefono(String numeroTelefono) {
        this.numeroTelefono = numeroTelefono;
    }

    public Locale getLocale() {
        return locale;
    }

    public void setLocale(Locale locale) {
        this.locale = locale;
    }

    public NumberFormat getNumberFormat() {
        return numberFormat;
    }

    //Datos del cliente
    public void setNumberFormat(NumberFormat numberFormat) {
        this.numberFormat = numberFormat;
    }

    public abstract void deposito(int cantidad);

    /*
Metodo deposito que permite al cliente depositar dinero a su cuenta. De-
be ser siempre mayor a 0. Monto depositado será convertido a pesos CL
     */
    public abstract void giro(int cantidad);

    /*
Metodo giro para que cliente pueda retirar dinero de su cuenta. 
Como se puede ver en el codigo, no permitirá girar dinero por un monto 0
, ni tampoco por monto superiro al saldo actual de su cuenta.
     */
    @Override
    public void mostrarInformacion() {
        System.out.println("----- Datos del Cliente -----");
        System.out.println("Nombre completo: " + nombre + " " + apellidoPaterno + " " + apellidoMaterno);
        System.out.println("RUT: " + rut);
        System.out.println("Domicilio: " + domicilio + ", Comuna: " + comuna);
        System.out.println("Teléfono: " + numeroTelefono);
        System.out.println("Tipo de cuenta: " + tipoCuenta);
        System.out.println("Número de cuenta: " + numeroDeCuenta);
        System.out.println("Saldo actual: " + numberFormat.format(saldo));
        System.out.println("-----------------------------");
    }

}


