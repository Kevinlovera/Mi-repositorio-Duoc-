
package exp_2_semana4_kevin_lovera;

import java.util.Scanner;


public class Exp_2_semana4_Kevin_Lovera {
    
    public static void main(String[] args) {
      


        Scanner sc=new Scanner (System.in);
        
        String nombre;   
        int menu;
        int zona;
        boolean salir =false;
        String sitio = null;
        int precioBase=15000;
        int numAsiento;
        int descuento=0;
       
        System.out.println("Hola estimado usuario, bienvenido al Teatro Moro nuevamente ");
        
        System.out.println ("Por favor ingrese su nombre");
        nombre = sc.nextLine();
        
         for(salir=false; !salir;){
            System.out.println("Menu Principal:");
            System.out.println("Hola "+nombre+ " Desea comprar una entrada?");
            System.out.println("1. Oprima 1 si lo desea");
            System.out.println("2. Oprima para salir");
            System.out.println("Seleccione una opcion por favor:");
            menu= sc.nextInt();
            
            switch (menu) {
                case 1:
                    System.out.println("Seleccione la zona por favor:");
                    System.out.println("| A | B | C | D | E | F |");
                    System.out.println("1. Zona A");
                    System.out.println("2. Zona B");
                    System.out.println("3. Zona C");
                    System.out.println("4. Zona D");
                    System.out.println("5. Zona E");
                    System.out.println("6. Zona F");
            
            do{
            zona=sc.nextInt();
            
                        switch (zona){   
                  
                        case 1:
                            System.out.println("1. zona A");
                            sitio= "Zona A";
                           break;
                        case 2:
                            System.out.println("2. zona B");
                            sitio= "Zona B";
                           break;
                        case 3:
                            System.out.println("3. zona c");
                            sitio="Zona C";
                           break;
                        case 4:
                            System.out.println("4. zona D");
                            sitio="Zona D";
                            break;
                        case 5:
                            System.out.println("5. zona E");
                            sitio="Zona E";
                            break;
                        case 6:
                            System.out.println("6. zona F");
                            sitio="Zona F";
                            break;
                       
                       default:
                        System.out.println("Opcion invalida, eliga una zona correcta nuevamente");
                        System.out.println("| A | B | C | D | E |");
                        System.out.println("1. Zona A ");
                        System.out.println("2. Zona B");
                        System.out.println("3. Zona C");
                        System.out.println("4. Zona D");
                        System.out.println("5. Zona E");}
                        
            }while (zona<1 || zona>6);
            
            
            
                        do {
                        System.out.println("Que numero de asiento desea?");
                            System.out.println("| 1 | 2 | 3 | 4 | 5 |");
                        System.out.println("Eliga un numero del 1 al 5");
                        numAsiento=sc.nextInt();
                        
                        if (numAsiento<1 || numAsiento>5) {System.out.println("escriba un codigo valido");}
                        
                        } while (numAsiento <1 || numAsiento>5);
                     
                
                       
                        System.out.println(" Que edad tienes? " + nombre);
                        int edad = sc.nextInt();
                        
                        if (edad >65) {descuento =15;}
                         else if (edad>=18 && edad<=25){descuento=10;}
                        
                        int precioFinal = precioBase -(precioBase*descuento/100);
                        
                            
                            System.out.println(" Resumen de Compra ");
                            System.out.println("Ubicacion: " + sitio + " Asiento "+ numAsiento);
                            System.out.println("Precio Base: $" + precioBase);
                            System.out.println("Descuento: " + descuento + "%");
                            System.out.println("Precio Final: $" + precioFinal);
                            System.out.println("-----------------------------");
                            
                            break;
                            
                case 2: 
                    salir=true;
                    System.out.println("Gracias por habernos visitado " +nombre);
                    break;
                 
         }
       }
    }
}

                 
         
         
      

                 
    
    

