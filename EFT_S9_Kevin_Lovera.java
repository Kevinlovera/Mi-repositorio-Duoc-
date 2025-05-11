
package eft_s9_kevin_lovera;

import java.util.ArrayList;
import java.util.Scanner;

public class EFT_S9_Kevin_Lovera {
     
    ArrayList<Ventas> listaVentas=new ArrayList<>();
    
    class Ventas {
   
    String asiento;
    int cantidad;
    int totalPagado;
    int fila;
    int columna;
    String tipoCliente;
    
    
    public Ventas( String asiento, int cantidad, int totalPagado, int fila, int columna, String tipoCliente) {
    this.asiento=asiento;
    this.cantidad=cantidad;
    this.totalPagado=totalPagado;
    this.fila = fila;
    this.columna = columna; 
    this.tipoCliente = tipoCliente;
    };
   }
 
     Scanner sc = new Scanner (System.in);
   
    int totalBoleta = 0;
    int opcionTeatro;
    int entradasAcomprar;
    int elegirAsiento;
    int posicionDelAsiento;
    int edad;
    String tipoClientes;
    
    String [][] asientos = new String [5][5];
    String [] zonasDeAsientos = {"Vip", "Platea", "Plateab", "Palcos", "Balcon",};
    int [] precioBaseAsientos=  {3000, 25000, 22000, 18000, 15000};
    int descuento;
    
    int precioCompra;
    
    String nombreTeatro= "Teatro moro";
    
    public EFT_S9_Kevin_Lovera() {
        // Inicializa todos los asientos a "D" (disponibles)
        for (int fila = 0; fila < asientos.length; fila++) {
            for (int columna = 0; columna < asientos[fila].length; columna++) {
                asientos[fila][columna] = "D";  // Marca todos los asientos como disponibles
            }
        }
    }
 
    public static void main(String[] args) {
       
        
        EFT_S9_Kevin_Lovera teatroMoro = new EFT_S9_Kevin_Lovera();
        teatroMoro.menuTeatro();
        
    }
    
    public void menuTeatro() {
        
        do {
        
        System.out.println("\n|||||||"+nombreTeatro+"|||||||");
        System.out.println("Estimado usuario, por favor elija una opcion\n");
        
        System.out.println("1. Ver asientos disponibles");
        System.out.println("2. Comprar entradas");
        System.out.println("3. Ver ventas");
        System.out.println("4. Cancelar venta");
        System.out.println("5. Ver boleta");
        System.out.println("6. Salir\n");
        opcionTeatro = sc.nextInt();
        sc.nextLine();
        
        switch (opcionTeatro) 
        {
            
            case 1:
                mostrarPlano();
                break;
                
            case 2:
                comprarEntrada();
                break;
                
            case 3:
                verVentas();
                break;
                    
            case 4:
                cancelarVenta();
                break;
                
            case 5:
                boleta();
                break;
                
            case 6:
                System.out.println("Gracias por visitar el teatro moro");
                break;
                }
            } while (opcionTeatro!=6);
         }     
    
    
    public void mostrarPlano(){
        
        System.out.println("||||Planos de los asientos||||");
        
        
        for (int fila = 0; fila < asientos.length; fila++) {
            System.out.print(zonasDeAsientos[fila]);
            for (int columna = 0; columna < asientos[fila].length; columna++) {
            
            if (asientos[fila][columna] == null || asientos[fila][columna].equals("D"))
            {
                System.out.print("[D]"); 
            } else {
                System.out.print("[X]");
            }
            
        }
             System.out.println();
      } 
       System.out.println(); 
   }
    
    
    public void comprarEntrada() { 
        
        String respuestaEstudiante;
        String respuestaMujer;
        
        System.out.println("\nCuantas entradas desea comprar?");
        entradasAcomprar = sc.nextInt();
        
        if (entradasAcomprar <= 0 || entradasAcomprar > 25 - listaVentas.size()) {
            System.out.println("No se puede comprar esa cantidad de entradas");
            System.out.println("Asientos disponibles: " + (25 - listaVentas.size()));
            return;
        }
        
        for (int i = 0; i < entradasAcomprar; i++) {
        
        System.out.println("\nPor favor elija el tipo de asiento que desea");
        mostrarPlano();
        
        System.out.println("\nPor favor elige la zona del asiento que deseas:");
        System.out.println("0. Vip");
        System.out.println("1. Platea");
        System.out.println("2. Platea B");
        System.out.println("3. Palcos ");
        System.out.println("4. Balcon");
        elegirAsiento = sc.nextInt();
        
         if (elegirAsiento < 0 || elegirAsiento >= asientos.length) {
         System.out.println("Zona invalida. Intente nuevamente.");
         i--;
         continue;
        }

        
        System.out.println("Ahora elige el numero del asiento de la fila del tipo de asiento que haz elegido");
        System.out.println("0 a 4 ");
        posicionDelAsiento = sc.nextInt();
        
         if (posicionDelAsiento < 0 || posicionDelAsiento >= asientos[elegirAsiento].length) {
         System.out.println("Numero de asiento invalido. Intente nuevamente.");
          i--;
        continue;
        }
        
        
        if (asientos[elegirAsiento][posicionDelAsiento]!= null && !asientos[elegirAsiento][posicionDelAsiento].equals("D")){
            System.out.println("Ese asiento ya esta ocupado, por favor elige otro" );
            i--;
            continue;
        }
        
        System.out.println("Excelente, me podrias decir que edad tienes?");
        edad = sc.nextInt();
        
        if (edad <= 0 || edad >= 100 ) {
            System.out.println("Ha escrito una edad invalida, por favor ingrese una correcta");
        } else {
            if (edad >= 5 && edad <= 11) {
                descuento = 10;
                System.out.println("Felicidades tendras un 10% de descuento por ser un nene ");
                System.out.println("Que te diviertas mucho en el teatro");
                tipoClientes = "Peque";
                
            } else if (edad >= 65 && edad <= 99) {
                descuento = 25;
                    System.out.println("Felicidades, usted tendra un descuento del 25% por ser de tercera edad");
                    tipoClientes = "Tercera edad";
            } else {
                    
            System.out.println("Eres estudiante?");
            respuestaEstudiante = sc.next().toLowerCase();
            
            if (respuestaEstudiante.equals("si")) {
                
              descuento = 15;
                System.out.println("Felicidades, tienes un descuento del 15% por ser estudiante");
                tipoClientes = "estudiante";
            } else { 
                
            sc.nextLine();
            System.out.println("Eres mujer?");
            respuestaMujer = sc.nextLine().toLowerCase();
                
                if (respuestaMujer.equals("si")) {
                    descuento = 20;
                    System.out.println("Felicidades tendras un 20% de descuento por ser mujer");
                    tipoClientes = "Mujer";
                } else {
                    tipoClientes = "General";
                    descuento = 0;
                }
              }
           }
         }
        
        precioCompra = precioBaseAsientos[elegirAsiento] - (precioBaseAsientos[elegirAsiento] * descuento / 100);
        
        totalBoleta += precioCompra;
        
        asientos [elegirAsiento][posicionDelAsiento] = "X";
        
        
        Ventas nuevaVenta= new Ventas(zonasDeAsientos[elegirAsiento]+ "[" +posicionDelAsiento+ "]", 1, precioCompra, elegirAsiento, posicionDelAsiento, tipoClientes);
        listaVentas.add(nuevaVenta);
        
        
        System.out.println("\nResumen de compra:");
        System.out.println("Zona: " + zonasDeAsientos[elegirAsiento]);
        System.out.println("Asiento: " + posicionDelAsiento);
        System.out.println("Precio base: $" + precioBaseAsientos[elegirAsiento]);
        System.out.println("Descuento aplicado: " + descuento + "%");
        System.out.println("Precio final: $" + precioCompra);
        
        
      }
    }
    public void verVentas() {
        
        if (listaVentas.isEmpty()) {
            System.out.println("No hay ventas hechas aun");
        } else { System.out.println("\n Lista de ventas:");
            
            for (Ventas ventas : listaVentas) {
                
                System.out.println("\n=====Entrada " + nombreTeatro+"=====");
                System.out.println("Asiento: " + ventas.asiento);
                System.out.println("Precio por entrada: " + ventas.totalPagado);
                System.out.println("Tipo de cliente:" + ventas.tipoCliente);
                
                
            }
        }
        
        
    }
    
    public void cancelarVenta() {
        if (listaVentas.isEmpty()) {
            System.out.println("No hay ventas aun, intente nuevamente");
            return;
        }
        
        System.out.println("Ventas realizadas");
        
        
        for (int i = 0; i< listaVentas.size(); i++) {
            Ventas venta = listaVentas.get(i);
            
            System.out.println(i + "asiento: " +venta.asiento);
            System.out.println("Cantidad: " + venta.cantidad);
            System.out.println("precio entrada: " + venta.totalPagado);
            System.out.println("Tipo de cliente: " + venta.tipoCliente);
            
            
            
        }
        
        System.out.println("Digite el numero de venta que desea eliminar");
        int ventaEliminar = sc.nextInt();
        
        if (ventaEliminar < 0 || ventaEliminar  >= listaVentas.size()) {
            System.out.println("El numero ingresado es incorrecto");
            return;
        }
        
        Ventas ventaCancelada = listaVentas.get(ventaEliminar);
        
         //Libera el asiento
        asientos[ventaCancelada.fila][ventaCancelada.columna] = "D";
        
       totalBoleta -= ventaCancelada.totalPagado; 
       
        //Eliminar venta
       listaVentas.remove(ventaEliminar);
       
        System.out.println("Venta cancelada exitosamente");
        
    }
    
    public void boleta() {
        
        if (listaVentas.isEmpty()) {
            System.out.println("No hay boleta disponible aun");
            return; }
        
        
    System.out.println("======== Boleta ========");
    
    for (Ventas ventaBoleta: listaVentas) {
        
        System.out.println("Asiento: " + ventaBoleta.asiento);
        System.out.println("Precio: " + ventaBoleta.totalPagado);
        System.out.println("Tipo de cliente: " + ventaBoleta.tipoCliente);
        System.out.println("----------------");
    }
    
        System.out.println("Total a pagar por todas las entradas: " + totalBoleta);
        System.out.println("Cantidad de entradas: " + listaVentas.size());
  }
    
}


                
          
        
        
        
        
        
  

