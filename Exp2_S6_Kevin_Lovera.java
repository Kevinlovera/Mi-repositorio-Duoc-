package exp2_s6_kevin_lovera;
import java.util.TimerTask;
import java.util.Scanner;
import java.util.Timer;

    public class Exp2_S6_Kevin_Lovera {
    static Scanner sc=new Scanner (System.in); 
   
    //variables de instancia
    double precioFinal;
    boolean hayReserva=false;
    int reservasTotales;
    
    //Variables constantes
    final int capacidadSala=10;   
    static final  String NOMBRE_TEATRO="Teatro moro";
    static final int PRECIO_ENTRADA=15000;
    
    //Variables estaticas 
    static String ubicacionAsiento;
    static String nombre; 
    static String respuestaModificarVenta;
    static int totalEntradasVendidas=0;
    static int ingresosTotales=0;
    static int cantidadEntradasReservar;
    static int nuevaCantidad;
    static int diferencia; //esta variable se usara para modificar la venta de entradas mas adelante
    
    
    //metodo main 
    public static void main(String[] args) {
        
        //constructor para acceder al metodo del menu principal
        Exp2_S6_Kevin_Lovera teatroMoro=new Exp2_S6_Kevin_Lovera(); 
        teatroMoro.menuPrincipal();
   
}
    
    public void menuPrincipal(){
        
        //menu principal desde un metodo
        int opcionMenu;
        
        System.out.println("Hola, bienvenido al " +NOMBRE_TEATRO);
        System.out.println("Me darias tu nombre por favor?");
        nombre=sc.nextLine();
        
        System.out.println("Excelente " + nombre + ", me alegra que estes en el " + NOMBRE_TEATRO + ", por favor elige una de las siguientes opciones\n");
        do{
        System.out.println("1. Reservar entradas \n");
        System.out.println("2. Comprar Entradas \n");
        System.out.println("3. Modificar una venta existente\n");
        System.out.println("4. Imprimir boleta \n");
        System.out.println("5. Salir del menu");
        opcionMenu=sc.nextInt();
        
        switch (opcionMenu) {
            
            case 1: reservarEntrada();
                break;   
                
            case 2: comprarEntrada();
                break;    
                    
            case 3: modificarEntrada();        
                break;    
                    
            case 4: mostrarBoleta();
                break;
        }
        if(opcionMenu>5 || opcionMenu<=0){
    System.out.println("Escriba una opcion correcta por favor");}
        }  while(opcionMenu!=5);
        
        
        
        System.out.println("Gracias por haber visitado al teatro moro");
  
    }
    
    public void reservarEntrada() {
        
        
        System.out.println("Elija la ubicacion del asiento en las siguientes filas por favor");
        System.out.println("fila a " + "fila b " + "fila c ");
        
        sc.nextLine();
        ubicacionAsiento=sc.nextLine();
       
        System.out.println("Cuantas entradas desea reservar?");
        System.out.println("Solo hay un limite de diez entradas");
        cantidadEntradasReservar=sc.nextInt();
        
        if (cantidadEntradasReservar<= capacidadSala-totalEntradasVendidas) {
        hayReserva=true;
        reservasTotales++;
        System.out.println("Excelente, ha reservado una entrada,"
        + " ahora debe elegir la opcion de comprar entradas para confirmar(\nsolo tiene diez segundos)");  //puse punto de depuracion para ver si hizo el proceso de reserva de forma correcta
        
        Timer temporizador =new Timer(); 
        TimerTask tarea=new TimerTask(){
            @Override
            public void run(){
                if(hayReserva)
                {hayReserva=false;
                cantidadEntradasReservar=0; // Breakpoint: Confirmo que la reserva se cancela correctamente al pasar los 10 segundos.
                System.out.println("Se agoto el tiempo de la reserva, su reserva fue cancelada"); 
                }
            }   
        };
        
        temporizador.schedule(tarea, 10000);
                
        } else {
            System.out.println("No hay reservas disponibles ");
            
           
        }
  
    }
    //aca he decidido crear un metodo para comprar la entrada siempre y cuando haya una reserva hecha
   public void comprarEntrada() {
       String confirmarCompra; //decido usar una variable local para preguntarle al usuario si esta seguro si desea comprar
       if (hayReserva==true) {
           
           System.out.println("La cantidad de entradas al comprar son "+cantidadEntradasReservar );
           
           System.out.println("estas seguro que confirmas la compra?");
           confirmarCompra=sc.next();
           
           if(confirmarCompra.equalsIgnoreCase("si")){
           
           precioFinal=cantidadEntradasReservar*PRECIO_ENTRADA;
           
           totalEntradasVendidas+=cantidadEntradasReservar;
           
           ingresosTotales+=precioFinal;
           
           hayReserva=false; 
           
           System.out.println("Excelente, ha comprado la entrada con la ubicacion del asiento" + ubicacionAsiento);
       } else {
           System.out.println("Ha decidido no confirmar la compra");
       }
      } else {
           System.out.println("Estimado(a) "+ nombre + " no hay entradas reservadas aun");
       }

   } 
      
   public void modificarEntrada() {
       
       int menuModificarVenta; //aca un menu en el cual el usuario decide si cambiar las entradas a menos entradas o cancelarlas todas
       
       if (precioFinal==0){
           System.out.println("No hay ninguna entrada para modificar ");
           return;
       }
       
          System.out.println("|||||Modificar venta|||||");
          System.out.println("Deseas modificar la venta? si/no ");
          respuestaModificarVenta=sc.next(); 
          if (respuestaModificarVenta.equalsIgnoreCase("si"))
          {
          System.out.println(nombre + " hasta el momento haz comprado " + cantidadEntradasReservar + "");    
          System.out.println("Por favor elija una de las opciones ");
          System.out.println("1. Modificar cantidad de entradas");
          System.out.println("2. Cancelar venta");
          System.out.println("Por favor seleccione una opcion");
          menuModificarVenta=sc.nextInt();
          
          switch (menuModificarVenta) {
              
              case 1:  System.out.println("Modificacion de cantidad de entradas ");
                       System.out.println("Ingrese una cantidad menor que " +cantidadEntradasReservar);
                       nuevaCantidad=sc.nextInt();
          
                       if (nuevaCantidad<cantidadEntradasReservar && nuevaCantidad>0) {
                           
                           diferencia =cantidadEntradasReservar-nuevaCantidad;
                           
                           cantidadEntradasReservar=nuevaCantidad;
                           precioFinal=cantidadEntradasReservar*PRECIO_ENTRADA;
                           
                           totalEntradasVendidas-=diferencia;
                           
                           System.out.println( nombre + " haz modificado la entrada ");
                           
                       } else {
                           System.out.println(" Aun no haz hecho ninguna compra");
                       }
                       break;               
                    
            case 2:         
                System.out.println("Cancelar entradas");
                totalEntradasVendidas-=cantidadEntradasReservar;
                cantidadEntradasReservar=0;
                precioFinal=0;
                 
                System.out.println("Haz cancelado con exito");
                break;
                
           
            default: System.out.println("Opcion invalida");
          
           } 
       }
   }
   
        public void mostrarBoleta() {
            if (precioFinal>0) { // punto de depuracion aca: puedo confirma que solo se genera una boleta si hay una compra hecha.
   
                System.out.println("\n||||Boleta de pago|||||");
                System.out.println("Empresa: " +NOMBRE_TEATRO);
                System.out.println("Nombre del cliente: " +nombre);
                System.out.println("Ubicacion del asiento: " +ubicacionAsiento);
                System.out.println("Cantidad de entradas: "+ ""+cantidadEntradasReservar);
                System.out.println("Precio final pagado: "+ precioFinal); // Breakpoint: Reviso que el precio mostrado coincida con la cantidad de entradas.
                
             }else{System.out.println("Primero debe reservar y comprar entradas para mostrarle la boleta");}
             
        }
   }

