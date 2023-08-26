public class secondLargest {
    
    public static void getSecondLargest(){
        Integer [] a=new Integer[]{22,22};
            Integer largest = 0;
        Integer secondLargest = -1;
        if(a.size()>2){
        for(Integer i = 0; i < a.size(); i++){
            if(a[i] > largest){
                secondLargest = largest;
                largest = a[i];
            }
            else if(a[i]!=largest && a[i]>secondLargest){
                secondLargest = a[i];
            }
        }
        }
        if(secondLargest == -1){
            System.debug('No second Largest');
        }
        else{
            System.debug('secondLargest'+secondLargest);
            }
    }
}