public class j_FutureMethodDayGoals {
    public j_FutureMethodDayGoals(){
        takeAShower(); //30 minutes
        haveBreakfast(); //30 minutes
        repairCar(); //3 hours
        watchAMovie(); //3hours
        
        //Total = 7hours if we proceed in synchronous way
    }
    
    public static void takeAShower(){                 
        System.debug('taking shower right now');
    }
    
    public static void haveBreakfast(){
        System.debug('having break right now');
    }
    
    @future
    public static void repairCar(){
        System.debug('car is getting repaired');
    }
    
    @future
    public static void watchAMovie(){
        System.debug('watching a right now');
    }
    
}