package exp1_s1_alexander_kevin_grupo6;

public class Cliente {

    private String rutCliente;
    private String nombreCliente;
    private String apellidoPaternoCliente;
    private String apellidoMaternoCliente;
    private String domicilioCliente;
    private String comunaCliente;
    private int numeroTelefonoCliente;
    private CuentaCorrienteCliente cuenta;

    public Cliente(String rutCliente, String nombreCliente, String apellidoPaterno, String apellidoMaternoCliente, String domicilioCliente, String comunaCliente, int numeroTelefono,
            int numeroDeCuenta) {

        this.rutCliente = rutCliente;
        this.nombreCliente = nombreCliente;
        this.apellidoPaternoCliente = apellidoPaterno;
        this.apellidoMaternoCliente = apellidoMaternoCliente;
        this.domicilioCliente = domicilioCliente;
        this.comunaCliente = comunaCliente;
        this.numeroTelefonoCliente = numeroTelefono;
        this.cuenta  = new CuentaCorrienteCliente (numeroDeCuenta,0);

    }

    public String getRutCliente() {
        return rutCliente;
    }

    public void setRutCliente(String rutCliente) {
        this.rutCliente = rutCliente;
    }

    public String getNombreCliente() {
        return nombreCliente;
    }

    public void setNombreCliente(String nombreCliente) {
        this.nombreCliente = nombreCliente;
    }

    public String getApellidoPaternoCliente() {
        return apellidoPaternoCliente;
    }

    public void setApellidoPaternoCliente(String apellidoPaternoCliente) {
        this.apellidoPaternoCliente = apellidoPaternoCliente;
    }

    public String getApellidoMaternoCliente() {
        return apellidoMaternoCliente;
    }

    public void setApellidoMaternoCliente(String apellidoMaternoCliente) {
        this.apellidoMaternoCliente = apellidoMaternoCliente;
    }

    public String getDomicilioCliente() {
        return domicilioCliente;
    }

    public void setDomicilioCliente(String domicilioCliente) {
        this.domicilioCliente = domicilioCliente;
    }

    public String getComunaCliente() {
        return comunaCliente;
    }

    public void setComunaCliente(String comunaCliente) {
        this.comunaCliente = comunaCliente;
    }

    public int getNumeroTelefonoCliente() {
        return numeroTelefonoCliente;
    }

    public void setNumeroTelefonoCliente(int numeroTelefonoCliente) {
        this.numeroTelefonoCliente = numeroTelefonoCliente;
    }

    public CuentaCorrienteCliente getCuenta() {
        return cuenta;
    }

    public void setCuenta(CuentaCorrienteCliente cuenta) {
        this.cuenta = cuenta;
    }
   

    
    public void mostrarDatos(){
        
        System.out.println("\n ----------------");
        System.out.println("\nRut: " + rutCliente);
        System.out.println("Nombre: " + nombreCliente);
        System.out.println("Apellido paterno: " + apellidoPaternoCliente);
        System.out.println("Apellido materno: " + apellidoMaternoCliente);
        System.out.println("Domicilio: " +domicilioCliente);
        System.out.println("Comuna de residencia: " + comunaCliente);
        System.out.println("Telefono: " + numeroTelefonoCliente);
        System.out.println("Numero de cuenta " + cuenta.getNumeroCuenta());
        System.out.println("Saldo actual: " + cuenta.getSaldo());
        System.out.println("---------------\n");
        
        
        
        
    }

}
