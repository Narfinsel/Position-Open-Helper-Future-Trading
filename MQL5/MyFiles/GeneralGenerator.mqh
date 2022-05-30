//+------------------------------------------------------------------+
//|                                             GeneralGenerator.mqh |
//|                               Copyright 2022, Svetozar Pasulschi |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Svetozar Pasulschi"
#property link      "https://www.mql5.com"


/* @TESTED
Generates a random cipher between 0-9.
*/
int generateRandomNumber_0_9(){
   return (int)(MathRand()/3276.7);
}


/* @TESTED
Generates a random long number of a given length:
int numDigits=3   will generate  152
int numDigits=9   will generate  934576309
*/
long generateUniqueLongIntOfSize (int numDigitsForInt){
   long digit=0, random;
   for(int i=0; i < numDigitsForInt; i++){
      random = generateRandomNumber_0_9();
      digit += (random * (int) MathPow(10, i));
   }
   return digit;
}


/* @TESTED
Generates a unique name for your objects, with a custom string and random long number of given length:
uniquelyGeneratedStringObjName( "MyRect", 5)    --->     MyRect_48036
*/
string uniquelyGeneratedStringObjName(string rootName, int lengthOfRandomInteger){
   string uniqueName;
   StringConcatenate(rootName, rootName, "_", (string) generateUniqueLongIntOfSize( lengthOfRandomInteger) );
   return uniqueName;
}
