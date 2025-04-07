
package exp2_semana4_kevin_lovera;

import java.util.Scanner;

public class Exp2_semana4_Kevin_Lovera {   
    public static void main(String[] args) {
        Scanner sc=new Scanner (System.in);
        
        String nombre;   
        int menu;
        int zona=0;
        boolean salir =false;
        String sitio = null;
        int precioBase=15000;
       
        System.out.println("Hola estimado usuario, bienvenido al Teatro Moro nuevamente ");
        
        System.out.println ("Por favor ingrese su nombre");
        nombre = sc.nextLine();
        
         for(int i=0; !salir; i++){
            System.out.println("Menu Principal:");
            System.out.println("Desea comprar una entrada?");
            System.out.println("1. Oprima 1 si lo desea");
            System.out.println("2. Oprima para salir");
            System.out.println("Seleccione una opcion por favor:");
             menu= sc.nextInt();
             
    
            System.out.println("Por favor eliga el lugar del asiento");
                       
             
                if (menu==1) {
               
                   System.out.println("Zona A");
                   System.out.println("Zona B");
                   System.out.println("Zona C");
                   System.out.println("Zona D");
                   System.out.println("Zona E");
                   System.out.println("Zona F");
                  System.out.println("Ingrese numero de zona por favor");
                 zona=sc.nextInt();
                   
                switch (zona) {
                    case 1:
                        System.out.println("Haz elegido la zona A");
                        sitio= "Zona A";
                        break;
                    case 2:
                        System.out.println("Haz elegido la zona B");
                        sitio= "Zona B";
                        break;
                    case 3:
                        System.out.println("Haz elegido la zona C");
                        sitio="Zona C";
                        break;
                    case 4:
                        System.out.println("Haz elegido la zona D");
                        sitio="Zona D";
                        break;
                    case 5:
                        System.out.println("Haz elegido la zona E");
                        sitio="Zona E";
                        break;
                    case 6:
                        System.out.println("Haz elegido la zona F");
                        sitio="Zona F";
                        break;
                    default:
                        System.out.println("Zona invalida");
                       
                        
                        
                       
                        
                System.out.print("Ingrese su edad: ");
                int edad = sc.nextInt();

                int descuento = 0;
                if (edad >= 60) {
                    descuento = 15;
                } else if (edad >= 18 && edad <= 25) {
                    descuento = 10;
                }

                int precioFinal = precioBase - (precioBase*descuento / 100);

                System.out.println("----- Resumen de Compra -----");
                System.out.println("Ubicación: " + sitio);
                System.out.println("Precio Base: $" + precioBase);
                System.out.println("Descuento: " + descuento + "%");
                System.out.println("Precio Final: $" + precioFinal);
                System.out.println("-----------------------------");
                        
                        
                        
                        
                
                   
        
     
                   
            }
        
                  
          } 
                else if (menu==2) {
                System.out.println("Gracias por visitar el programa, vuelva pronto");
                salir=true;}
                else {System.out.println("Opcion invalida");}
                 
         }
         
      }
}
                 
             
         
             
             
    
             
             
          
    

                
                 
                 
             
            
            
        
        
    
            
    
    




