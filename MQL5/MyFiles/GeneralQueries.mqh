//+------------------------------------------------------------------+
//|                                               GeneralQueries.mqh |
//|                               Copyright 2022, Svetozar Pasulschi |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Svetozar Pasulschi"
#property link      "https://www.mql5.com"

/* |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
   ||||||||                                                                 ||||||||
   ||||||||                      GENERAL QUERIES                            ||||||||
   ||||||||                                                                 ||||||||
   ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| */


// @TESTED   
string baseCurrencySymbol(string aSymbol){    // @TESTED OK
   string baseCurrency = StringSubstr(aSymbol, 0, 3);
   return baseCurrency;
}

// @TESTED
string quoteCurrencySymbol(string aSymbol){    // @TESTED OK
   string quoteCurrency = StringSubstr(aSymbol, 3, -1);
   return quoteCurrency;
}

// @TESTED
bool isBrokerUsing5Digits(){
   int digitsEURUSD = (int) SymbolInfoInteger("EURUSD", SYMBOL_DIGITS);
   int digitsUSDJPY = (int) SymbolInfoInteger("USDJPY", SYMBOL_DIGITS);
   if(digitsEURUSD == 5  &&  digitsUSDJPY == 3)
      return true;
   else return false;
}

// @TESTED
double singlePipQuantaForSymbol(string aSymbol){
   bool is5DigitBroker = isBrokerUsing5Digits();
   if(is5DigitBroker == true)
      return SymbolInfoDouble(aSymbol, SYMBOL_POINT) * 10;
   else 
      return SymbolInfoDouble(aSymbol, SYMBOL_POINT);
}


// @TESTED
int howManyDigitsInNumberBeforeComma(double aNumber){
   int anInt = (int) aNumber;
   int digitsCount = 0;
   do{
      anInt /= 10;
      digitsCount++;
   }while (anInt != 0);
   return digitsCount;
}



bool isFuturesSymbol (string aSymbol){
   ENUM_SYMBOL_CALC_MODE instrumentType = (ENUM_SYMBOL_CALC_MODE) SymbolInfoInteger (aSymbol, SYMBOL_TRADE_CALC_MODE);
   if(instrumentType == SYMBOL_CALC_MODE_FUTURES ||
      instrumentType == SYMBOL_CALC_MODE_EXCH_FUTURES ||
      instrumentType == SYMBOL_CALC_MODE_EXCH_FUTURES_FORTS)
      return true;
   return false;
}

bool isForexSymbol (string aSymbol){
   ENUM_SYMBOL_CALC_MODE instrumentType = (ENUM_SYMBOL_CALC_MODE) SymbolInfoInteger (aSymbol, SYMBOL_TRADE_CALC_MODE);
   if(instrumentType == SYMBOL_CALC_MODE_FOREX ||
      instrumentType == SYMBOL_CALC_MODE_FOREX_NO_LEVERAGE)
      return true;
   return false;
}
