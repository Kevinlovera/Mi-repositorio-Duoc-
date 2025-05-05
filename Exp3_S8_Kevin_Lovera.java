package exp3_s8_kevin_lovera;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Exp3_S8_Kevin_Lovera {  
    Scanner sc = new Scanner(System.in);
    
     //estos seran lo arreglos para los asientos (5x5)
     String[][] asientos = new String [5][5];
     
     int [] precioZonas = {2500, 20000, 18000, 17000, 15000};
     double [] precioFinalVentas = new  double[25];
     int [] idVentas = new int [25];
     int [] filaVentasAsientoVendido = new int [25];
     int [] colVentasAsientoVendido = new int [25];
     int [] idCliente = new int [25];
     String [] tipoCliente = new String [25];
     String[] nombreZonas = {"Vip", "Palcos", "Platea", "Platea2", "Balcon"};
    
    List<String> listaReserva = new ArrayList<>();
            
     
    

    //Variables de instancia
    String nombreTeatro = "Teatro moro";
    boolean tieneReserva = false;
    
   
    static int opcionMenu;
 
    public static void main(String[] args) {
        
        Exp3_S8_Kevin_Lovera teatroMoro = new Exp3_S8_Kevin_Lovera();
        teatroMoro.menuOpciones();
                
    }
    
     public void menuOpciones(){
         
         
         do {
        
         System.out.println("\nBienvenido al " + nombreTeatro );
         System.out.println("\tMenu");
         System.out.println("1. Ver asientos disponibles");
         System.out.println("2. reservar entrada");
         System.out.println("3. Comprar entrada");
         System.out.println("4. ver venta");
         System.out.println("5. imprimir boleta");
         System.out.println("6. Salir del menu");
         opcionMenu = sc.nextInt();
         
         switch (opcionMenu) {
             
             case 1:
                 mostrarAsientos();
                 break;
                 
             case 2: 
                  reservarAsientos();
                  break;
                 
             case 3:
                 comprarEntrada();
                 break;
                 
             case 4: 
                 verVentas();
                 break;
                 
             case 5:
                 boletaImpresa();
                 break;
                 
             case 6: 
                 break;
                 
             
         } 
      } while (opcionMenu !=6); 
         System.out.println("Gracias por haber visitado al teatro moro");

}
     
     public void mostrarAsientos(){
         
         System.out.println("Asientos del teatro");
         
         String [] zonas = {"\nVip\t", "Palcos\t", "Platea\t", "Platea2\t", "Balcon\t"};
         
        for (int i = 0; i < asientos.length; i++) {
            System.out.print(zonas[i] + "");
            for (int j = 0; j < asientos[i].length; j++) {
                if (asientos[i][j]==null || asientos[i][j].equals("D")) {
                    System.out.print("[D]");
                } else if (asientos[i][j].equals("R")) {
                    System.out.print("[R]");
                } else {
                    System.out.print("[X]");
                } 
            }
            System.out.println();
        }
         
     }
     
     public void reservarAsientos() {
         mostrarAsientos();
         
         System.out.println("\nPor favor elige la zona del asiento que deseas:");
         System.out.println("0 para vip");
         System.out.println("1 para palcos");
         System.out.println("2 para platea");
         System.out.println("3 para platea2 ");
         System.out.println("4 para Balcon");
         int zonaAsientoElegido = sc.nextInt();
         
         if (zonaAsientoElegido < 0 || zonaAsientoElegido >=asientos.length) {
             System.out.println("Ha elegido una zona para el asiento incorrecta, por favor intente nuevamente");
             return;    
         } 
         
         System.out.println("introduzca que numero de la zona que ha elegido desea el asiento");
         System.out.println("[0] [1] [2] [3] [4] (0 para el asiento que esta mas a la "
                 + " izquierda y 4 para el asiento que esta mas a la derecha)");
        int numeroAsiento = sc.nextInt();
        
        if (numeroAsiento < 0 || numeroAsiento >=  asientos.length) {
            System.out.println("Ha elegido un numero de asiento incorrecto, intente  nuevamente");
            return;
        }
        
        
        String estadoAsiento = asientos[zonaAsientoElegido][numeroAsiento]; 
        
        if (estadoAsiento == null || estadoAsiento.equals("D")){
            System.out.println("Estimado el asiento esta disponible,"
                    + " escribe tu id de cliente"); 
            int idClienteReserva = sc.nextInt();
        
          
            
            asientos[zonaAsientoElegido][numeroAsiento] = "R";  
            
            
            listaReserva.add("reserva | cliente id: " + idClienteReserva +
                    "| Zona: " + zonaAsientoElegido + 
                    "| Asiento: " + numeroAsiento);
            
            tieneReserva=true;
            
            System.out.println("Asiento reservado correctamente");
            
        } else {System.out.println("Asiento se encuentra ocupado");
      }
    } 
     

     
     public void comprarEntrada() { if (tieneReserva==true) {
         System.out.println("Estos son los asientos reservados: ");
         mostrarAsientos();
         
         System.out.println("\nPor favor eliga con un numero la zona correspodiente que eligio en la reserva");
         System.out.println("0 para vip");
         System.out.println("1 para palcos");
         System.out.println("2 para platea");
         System.out.println("3 para platea2 ");
         System.out.println("4 para Balcon");
         int laZonaElegida = sc.nextInt();
         
         System.out.println("\npor favor escriba nuevamente que numero de asiento elijio (0 al 4) ");
         int numeroAsientoss = sc.nextInt();
         
         if (!"R".equals(asientos[laZonaElegida][numeroAsientoss])) {
            System.out.println("Este asiento no está reservado o ya ha sido comprado. Intente con otro.");
           return;  
         } 
         
         System.out.println("Ingrese su id de cliente");
         int id = sc.nextInt();
         
         String tipoClienteElegir;
         
         while(true) {
         System.out.println("Que tipo de cliente eres? (Estudiante / tercera edad / general): ");
         tipoClienteElegir = sc.next().toLowerCase();
         
         if (tipoClienteElegir.equalsIgnoreCase("Estudiante") || tipoClienteElegir.equalsIgnoreCase("tercera edad") || tipoClienteElegir.equalsIgnoreCase("General")) {
          break;   
         } else {
             System.out.println("Tipo de cliente no valido, ingrese correctamente el tipo de cliente");
         }
         }
         
         
         
         
         
         
         
          double descuento = 0;
         
         if (tipoClienteElegir.equals("estudiante")) {
             descuento = 0.10;
             
         } else if (tipoClienteElegir.equals("tercera edad")) {
           descuento = 0.15;  
           
         } else {
             descuento = 0;
         }
         
     
         int precioBase = precioZonas[laZonaElegida];
        
         double precioFinal = precioBase - (precioBase * descuento);
         
         
         
         asientos[laZonaElegida][numeroAsientoss] = ("X");
         
         for (int i = 0; i < idVentas.length; i++) {
             if (idVentas[i] == 0) {
                 idVentas[i] = i+1;
              precioFinalVentas[i] = precioFinal;
              filaVentasAsientoVendido[i] = laZonaElegida;   
              colVentasAsientoVendido[i] = numeroAsientoss;
              idCliente[i] = id;
              tipoCliente[i] = tipoClienteElegir;
              break;
                 
    
             }
             
         }
         
         tieneReserva=false;
         
           System.out.println("Compra realizada con exito: ");
           System.out.println("Precio: " + precioFinal);
     
     } else { System.out.println("No tiene reservas activas, por favor haga una reserva primero"); 
     }
   }
     
     public void verVentas() {
         System.out.println("Ventas realizadas");
         
         boolean hayVentas = false;
         
         for (int i = 0; i < idVentas.length; i++) {
             if (idVentas[i]!=0) {
                 hayVentas = true;
                 break;
             }
         }
         if (!hayVentas) {
             System.out.println("No hay venta aun");
             return;
         }
         for (int i = 0; i <idVentas.length; i++) {
             if (idVentas[i] != 0) {
                 System.out.println("Id de ventas: " +idVentas[i]);
                 System.out.println("Id de cliente: "+idCliente[i]);
                 System.out.println("Tipo de cliente: " +tipoCliente[i]);
                 System.out.println("Zona del asiento: "+nombreZonas[filaVentasAsientoVendido[i]]);
                 System.out.println("Numero del asiento: " +colVentasAsientoVendido[i]);
             }
         }
         
     }
     
     public void boletaImpresa() {
         
         System.out.println("Por favor ingresa el ID de la venta para el cual desea imprimir la boleta");
         int idVentasBoleta = sc.nextInt();
         
         for (int i = 0; i <idVentas.length; i++) {
             if (idVentas[i] == idVentasBoleta) {
                   
              System.out.println("|||||Boleta de compra|||||");
              System.out.println("ID del cliente: " +idCliente[i]);
              System.out.println("Tipo de cliente: " +tipoCliente[i]);
              System.out.println("Zona del asiento: " + nombreZonas[filaVentasAsientoVendido[i]]);
              System.out.println("Numero del asiento: " + colVentasAsientoVendido[i]);
              System.out.println("Precio final: " +precioFinalVentas[i]);
         
             }
         }
         
       
     }
     
     
}

