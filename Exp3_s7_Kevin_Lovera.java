
package exp3_s7_kevin_lovera;
import java.util.ArrayList;
import java.util.Scanner;
    

public class Exp3_s7_Kevin_Lovera {
    
    ArrayList<Ventas> listaVentas=new ArrayList<>();
    
    class Ventas {
    String nombreCliente;
    String asiento;
    int cantidad;
    int totalPagado;
    
    public Ventas(String nombreCliente, String asiento, int cantidad, int totalPagado){
    this.nombreCliente=nombreCliente;
    this.asiento=asiento;
    this.cantidad=cantidad;
    this.totalPagado=totalPagado;
 
    };


}
    
    String teatroMoro="Teatro Moro";
  
    Scanner sc=new Scanner (System.in);
    
    static int menu;
    static int ingresosTotalesTeatro;
    
    //Variables de instancia
    int descuentos;
    int entradasVendidas;
    int precioFinal;
    int totalPagado;
    
    String tipoCliente;
    String respuesta;
    String tipoAsiento;
    
    
    //Precio base de los distintos asientos
    int precioBaseVip=20000;
    int precioBasePlatea=18000;
    int precioBaseBalcon=15000;
    int precioBase=0;
    
    
    
    
    public void menuTeatro(){
        
        do {
        System.out.println("\n****" +teatroMoro+ "****");
        System.out.println("1. Venta de entradas");
        System.out.println("2. Visualizar resumen de ventas");
        System.out.println("3. Boleta");
        System.out.println("4. Salir del menu\n");
        menu=sc.nextInt();
        
        
        switch (menu) {
            
            
            case 1: 
                ventaEntradas();
                break;
                
                
                
            case 2:
                visualizarVentas();
                break;
                
                
            case 3:
                boletaTeatro();
                break;
                
            case 4:    
            
      
        }
        if (menu<=0 || menu >=5) {
            System.out.println("Ingrese una opcion valida por favor");
        }
        } while(menu!=4);
        System.out.println("Gracias por visitar el " + teatroMoro);
  
    }
    
    public void ventaEntradas(){
        boolean asientoValido=false;
    
        while(!asientoValido) {
            
        
        System.out.println("Hola, por favor escribe que tipo de asiento quieres");
        System.out.println("Vip");
        System.out.println("Platea");
        System.out.println("Balcon");
        tipoAsiento=sc.next().toLowerCase();
        
        switch (tipoAsiento){
            
        
            case "vip":
                System.out.println("Haz elegido el asiento vip");
                asientoValido=true;
                precioBase=precioBaseVip;
                break;
              
            case "platea":
                System.out.println("Haz elegido el asiento platea");
                asientoValido=true;
                precioBase=precioBasePlatea;
                break;
                
            case "balcon": 
                System.out.println("Haz elegido el asiento balcon");
                asientoValido=true;
                precioBase=precioBaseBalcon;
                break;
                
            default: System.out.println("Haz escrito un asiento incorrecto, por favor intenta nuevamente");    

        }
      }
        
        
        
        
        System.out.println("Eres estudiante?");
        respuesta=sc.next().toLowerCase();
        
        if(respuesta.equalsIgnoreCase("si")) {
           descuentos=10;
        tipoCliente="Estudiante";
      }
       else {
         System.out.println("Eres de tercera edad?");
        respuesta=sc.next().toLowerCase();
        
        if(respuesta.equalsIgnoreCase("si")) {
            descuentos=15;
            tipoCliente="Tercera edad";
        } else {
            tipoCliente="General";
            descuentos=0;
        }
       }
        
        precioFinal=precioBase -(precioBase*descuentos/100);
        
        
        System.out.println("Cuantas entradas de ese tipo deseas llevar?");
        entradasVendidas=sc.nextInt();
        
        
        totalPagado=precioFinal*entradasVendidas;
        
        System.out.println("Su nombre por favor");
        String nombreCliente=sc.next();
        
        Ventas nuevaVenta= new Ventas(nombreCliente, tipoAsiento, entradasVendidas, totalPagado);
        listaVentas.add(nuevaVenta);
        
        System.out.println("Venta realidada con exito " +nombreCliente);
        
        
        
        
    }
    
    
    public void visualizarVentas(){
        
        System.out.println("\n----Visualizacion de venta----");
        
        if (listaVentas.isEmpty()){
            System.out.println("Aun no hay una venta realizada, por favor, haga la venta y lo intenta nuevamente");
        } else {
            for (Ventas venta: listaVentas) {
                System.out.println("Nombre cliente: " + venta.nombreCliente);
                System.out.println("Asiento: " + venta.asiento);
                System.out.println("Cantidad de entradas: " +venta.cantidad);
                System.out.println("Total a pagar: " + venta.totalPagado+"$\n");
            }
        }
        
        for (Ventas venta: listaVentas){
            ingresosTotalesTeatro+=venta.totalPagado;
            System.out.println("Los ingresos totales del teatro por todas las ventas son: " +ingresosTotalesTeatro);
            
        }
        
    }
    
    
    
    public void boletaTeatro(){
        
        if(listaVentas.isEmpty()) {
            System.out.println("No hay ninguna venta registrada, por favor, haga una venta e intenta nuevamente");
        } else {
        
        boolean ventaEncontrada=false;
        
        System.out.println("Ingresa tu nombre por favor");
        String nombreClienteBoleta=sc.next();
        
        for(Ventas venta: listaVentas) {
            if (venta.nombreCliente.equalsIgnoreCase(nombreClienteBoleta))
            {
        
        
        System.out.println("\n-----------------------------");
        System.out.println("\t"+teatroMoro+"");
        System.out.println("Nombre del cliente: "+ venta.nombreCliente);
        System.out.println("Ubicacion de asiento: "+venta.asiento);
        System.out.println("Tipo de cliente: " +tipoCliente);
        System.out.println("Costo base: " + precioBase+"$" );
        System.out.println("Descuento aplicado: " +descuentos+"%");
        System.out.println("Costo final con descuento:" +precioFinal+"$");
        System.out.println("Cantidad de entradas: " +venta.cantidad);
        System.out.println("Monto total a pagar: " +venta.totalPagado+"$");
        System.out.println("------------------------------");
        System.out.println("Gracias por visitar el " +teatroMoro);
        System.out.println("------------------------------\n");
        ventaEncontrada=true;
        break;
            }
    if (ventaEncontrada==false) {
        System.out.println("No se encontro ninguna venta con este nombre");
    }
        }
    
    }
   }
    
   
    public static void main(String[] args) {
        
        Exp3_s7_Kevin_Lovera teatroMoro=new Exp3_s7_Kevin_Lovera();
        teatroMoro.menuTeatro();
        
    }
    
}
