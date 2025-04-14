package exp2_s5_kevin_lovera;
import java.util.Scanner;

public class Exp2_S5_Kevin_Lovera {

    public static void main(String[] args) {
    Scanner sc=new Scanner(System.in);
  
    String ubicacion="";
    int descuento, totalPagar, montoFinalTotal=0;
    int precioBase=15000, precio;
    int totalEntradas=0;
    int tipoEntradas, vip=0, plateaAlta=0, plateaBaja=0, palcos=0;
    
    boolean salir=false;
    String promocion= "Excelente, se ganara un chocolate por comprar mas de dos entradas";
    
        
        System.out.println("Hola usuario buen dia, antes de mostrarte el menu me gustaria saber tu nombre, como te llamas?");
        String nombre=sc.next();
        System.out.println(""+"Hola " +nombre + ", bienvenido al menu del teatro moro");
        
        for(salir=false; !salir;) {
        System.out.println("Por favor elige una opcion a continuacion \n");
        System.out.println("1. Promociones disponibles");
        System.out.println("2. Mostrar entradas disponibles");
        System.out.println("3. comprar entradas");
        System.out.println("4. Buscar informacion de mis entradas");
        System.out.println("5. Eliminar entradas");
        System.out.println("6. Salir del menu");
        
        int menu=sc.nextInt();
         
         switch (menu) {
             case 1: 
                     System.out.println("||||Promociones disponibles||||\n");
                     System.out.println("Si compras 2 entradas o mas, ganara un chocolate \n ");
                     break;
                             
         
             case 2: System.out.println("Vip [][][][][]");
                     System.out.println("Platea baja [][][][][] ");
                     System.out.println("Platea alta [][][][][] ");
                     System.out.println("Palcos [][][][][]\n");
                     break;
             
             
             case 3: System.out.println("Estas son las entradas para elegir");
                     System.out.println("1. Vip");
                     System.out.println("2. Platea baja");
                     System.out.println("3. Platea alta");
                     System.out.println("4. palcos");
                     tipoEntradas=sc.nextInt();
                     
                     
                     int cantidad=0;
                     System.out.println("Cuantas entradas desea?");
                     cantidad=sc.nextInt();
                     totalEntradas+=cantidad;
                     
                     do {
                     switch (tipoEntradas) {
                     
                         case 1: System.out.println("Entrada: Vip");
                                 vip+=cantidad;
                                 ubicacion="Vip";
                                 break;
                         
                         case 2: System.out.println("Entrada: Platea baja");
                                 plateaBaja+=cantidad;
                                 ubicacion="Platea baja";
                                 break;
                                 
                         case 3: System.out.println("Entrada: Platea Alta"); 
                                 plateaAlta+=cantidad;
                                 ubicacion="Platea alta";
                                 break;
                                 
                         case 4: System.out.println("Entrada: Palcos");
                                 palcos+=cantidad;
                                 ubicacion="Palcos";
                                 break;
                         
                         
                         default:System.out.println("Ingrese un tipo de entrada correcta" );
                                 System.out.println("Estas son las entradas para elegir");
                                 System.out.println("1. Vip");
                                 System.out.println("2. Platea baja");
                                 System.out.println("3. Platea alta");
                                 System.out.println("4. palcos"); }
                                 break;
                               
                     } while (tipoEntradas <1 || tipoEntradas >4);
                    
                  
                      
                     System.out.println("Eres estudiante?");
                     String estudiante=sc.next();
                     
                     if  (estudiante.equalsIgnoreCase("si")) {
                         descuento=10;} 
                     else {
                        System.out.println("Eres adulto mayor de tercera edad?");
                        String adultoMayor=sc.next();
                        if (adultoMayor.equalsIgnoreCase("si")) {
                        descuento=15; }
                        else {descuento=0;
                        
                       }
                    }
                 
                   precio=precioBase -(precioBase*descuento/100);
                   
                    totalPagar = precio*cantidad;
                    
                    montoFinalTotal+=totalPagar;
                   
                   
                   System.out.println("Tipo de entrada: "+ubicacion);
                   System.out.println("Cantidad de entradas "+ cantidad);
                   System.out.println("Precio con descuento: " +precio);
                   System.out.println("Descuento aplicado " + descuento + "%");
                   System.out.println("Total a pagar "+ totalPagar);
                   
                   if (totalEntradas>=2){System.out.println(promocion);}
                   
                   break;
                   
                    case 4: System.out.println("Cantidad de entradas compradas: " + totalEntradas);      
                            System.out.println("Vip: " +vip);
                            System.out.println("Platea Baja: " +plateaBaja);
                            System.out.println("Platea Alta " +plateaAlta);
                            System.out.println("Palcos " +palcos);
                            System.out.println("Monto total: "+ montoFinalTotal);
                            break;
                            
                    case 5:  
                           System.out.println("\n   Eliminar entrada  ");
                           System.out.println("¿Que tipo de entrada deseas eliminar?"); 
                           System.out.println("1. Vip");
                           System.out.println("2. Platea baja");
                           System.out.println("3. Platea alta");
                           System.out.println("4. Palcos");
                           int tipoEliminar = sc.nextInt();

                    boolean eliminado = false;
                    
                    switch (tipoEliminar) {
                        case 1:
                            if (vip > 0) {
                                vip--;
                               eliminado = true;
                            }
                            break;
                        case 2:
                            if  (plateaBaja > 0) {
                                plateaBaja--;
                                eliminado = true;
                            }
                            break;
                        case 3:
                            if (plateaAlta>0) {
                                plateaAlta--;
                                eliminado = true;
                            }
                            break;
                        case 4:
                            if (palcos > 0) {
                                palcos--;
                                eliminado = true;
                            }
                            
                            break;
                            
                        default:
                            System.out.println("Opción inválida.");
                    }
                    if (eliminado) {
                        totalEntradas--;
                        System.out.println("Entrada eliminada exitosamente.");
                    } else {
                        System.out.println("No hay para eliminar este tipo de entrada.");
                    }
                    break;      
                            
        
                    case 6: salir=true;
                    System.out.println("Gracias por visitar el teatro moro");
                    break;
                    
                    default: System.out.println("escoge una opcion valida");
            }
         }
     }    
  }
    

