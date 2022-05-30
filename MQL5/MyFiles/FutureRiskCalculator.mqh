//+------------------------------------------------------------------+
//|                                         FutureRiskCalculator.mqh |
//|                               Copyright 2022, Svetozar Pasulschi |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Svetozar Pasulschi"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property description "MQL5"

class FutureRiskCalculator{
   private:
      string   frcSymbol;
      double   frcOpenPositionPrice;
      double   frcStopLossPrice;
      double   frcRiskPercentage;
      
      string strTickValue;
      string strAccountBalance;
      string strRiskPercentage;
      string strStopLossPoints;
      string strCompVol1;
      string strCompVol2;
      
      FutureRiskCalculator();
      double computeRiskValue (double riskPercent);
      double computeTradeVolume (double priceOpen, double priceStopLoss, double riskAmmount);
      void setupFrCalculator (string aSymbol, double aLevelOpen, double aLevelStopLoss, double aRiskPerc);
      void setupStrings();
            
   public:
      ~FutureRiskCalculator();
      FutureRiskCalculator (string aSymbol, double aLevelOpen, double aLevelStopLoss, double aRiskPerc);
      FutureRiskCalculator (string aSymbol, double aRiskPerc);
      FutureRiskCalculator (string aSymbol);
      void setFrcLevelsOpenAndStopLoss(double aLevelOpen, double aLevelStopLoss);
      void setFrcLevelStopLoss(double aLevelStopLoss);
      void setFrcLevelOpen(double aLevelOpen);
      void setFrcRiskPerg (double aRiskPerc);
      string getStrTickValue();
      string getStrAccountBalance();
      string getStrRiskPercentage();
      string getStrStopLossPoints();
      string getStrCompVol1();
      string getStrCompVol2();
      
      double getRiskedAmount();
      double getTradeVolume();
      void printStringVolComputations();
};

// ------------------------------------------------------------------------------------------------------
// -------------------------------------- RISK & VOLUME CALCULATOR --------------------------------------
// ------------------------------------------------------------------------------------------------------

double FutureRiskCalculator :: getRiskedAmount(){
   return computeRiskValue (this.frcRiskPercentage);
}

double FutureRiskCalculator :: getTradeVolume(){
   return computeTradeVolume ( this.frcOpenPositionPrice, this.frcStopLossPrice, computeRiskValue(this.frcRiskPercentage) );
}


double FutureRiskCalculator :: computeRiskValue (double riskPercent){
   double myBalance = AccountInfoDouble (ACCOUNT_BALANCE);
   string currencyAccount = AccountInfoString (ACCOUNT_CURRENCY);
   
   if(0.1 < riskPercent && riskPercent < 10.1){
      double riskAccCurrency = myBalance *riskPercent /100;
      
      string currencyPair = this.frcSymbol;
      string quoteCurrency = SymbolInfoString(this.frcSymbol, SYMBOL_CURRENCY_PROFIT);
      string newPair;
      StringConcatenate(newPair, currencyAccount, quoteCurrency);
      StringTrimRight(newPair);
      StringTrimLeft(newPair);
      string conversionPair = newPair;
      double rateForAccountConversion = SymbolInfoDouble(conversionPair, SYMBOL_BID);
      
      if(rateForAccountConversion == 0.0){
         string first  = StringSubstr(conversionPair, 0, 3);
         string second = StringSubstr(conversionPair, 3, -1);
         string inverted = second + first;
         rateForAccountConversion = SymbolInfoDouble(inverted, SYMBOL_BID);
      }
      if(currencyAccount == quoteCurrency){
         rateForAccountConversion = 1.0;
      }
      double riskValue = riskAccCurrency * rateForAccountConversion;
      StringConcatenate (strRiskPercentage, " Risk Value for  ", riskPercent,"% of  ", myBalance, " ", currencyAccount," balance:  ", NormalizeDouble(riskValue, 1), " ", quoteCurrency);
      return riskValue;
   }
   return -1.0;
}

double FutureRiskCalculator :: computeTradeVolume (double priceOpen, double priceStopLoss, double riskAmmount){
   double tickvalue = SymbolInfoDouble (this.frcSymbol, SYMBOL_TRADE_TICK_VALUE);
   double ticksize = SymbolInfoDouble (this.frcSymbol, SYMBOL_TRADE_TICK_SIZE);
   string quote_currency = SymbolInfoString(this.frcSymbol, SYMBOL_CURRENCY_PROFIT);
   long digitsSymbol = SymbolInfoInteger(this.frcSymbol, SYMBOL_DIGITS);
   
   double pointsBetweenOpToSl = NormalizeDouble ( MathAbs(priceOpen -priceStopLoss), (int) digitsSymbol );
   int numTicksInSl = (int) (pointsBetweenOpToSl / ticksize);
   StringConcatenate (strStopLossPoints, "Sl: ", pointsBetweenOpToSl, "       Num Ticks in Sl:  ",  numTicksInSl," x", tickvalue, " ", quote_currency, " = ", numTicksInSl* tickvalue, " ", quote_currency);
   
   int i=1;
   double volumeComp = i;
   double riskComp = i * (pointsBetweenOpToSl/ticksize) * tickvalue;
   // amount_risk = vol x tick_count x tick_val
   while(riskComp < riskAmmount){      
      riskComp = i * (pointsBetweenOpToSl/ticksize) * tickvalue;
      if(riskComp >= riskAmmount)
         break;
      i++;
   }
   if(i==1) volumeComp =i;
   if(i >1) volumeComp =i-1;
   
   double previousDiff = (volumeComp) *(pointsBetweenOpToSl/ticksize) *tickvalue -riskAmmount;
   double nextDiff =     (volumeComp+1) *(pointsBetweenOpToSl/ticksize) *tickvalue -riskAmmount;
   previousDiff = NormalizeDouble (previousDiff, 1);
   nextDiff     = NormalizeDouble (nextDiff, 1);
   riskAmmount  = NormalizeDouble (riskAmmount, 1);
   
   riskComp = volumeComp * (pointsBetweenOpToSl/ticksize) * tickvalue;
   riskComp = NormalizeDouble (riskComp, 1);
   StringConcatenate (strCompVol1, "Volume: ", (volumeComp+0), "   Risk Comp/Ammount:  ", riskComp, " ", quote_currency, "  /  ", riskAmmount, " ", quote_currency);
   
   riskComp = (volumeComp+1) * (pointsBetweenOpToSl/ticksize) * tickvalue;
   riskComp = NormalizeDouble (riskComp, 1);
   StringConcatenate (strCompVol2, "Volume: ", (volumeComp+1), "   Risk Comp/Ammount:  ", riskComp, " ", quote_currency, "  /  ", riskAmmount, " ", quote_currency);
   
   return volumeComp;
}


void FutureRiskCalculator :: printStringVolComputations (){
   Print (this.strTickValue);
   Print (this.strAccountBalance);
   Print (this.strRiskPercentage);
   Print (this.strStopLossPoints);
   Print (this.strCompVol1);
   Print (this.strCompVol2);   
}

void FutureRiskCalculator :: setupStrings(){
   double tick_value = SymbolInfoDouble (this.frcSymbol, SYMBOL_TRADE_TICK_VALUE );
   double tick_size  = SymbolInfoDouble (this.frcSymbol, SYMBOL_TRADE_TICK_SIZE );
   string tick_currency = SymbolInfoString (this.frcSymbol, SYMBOL_CURRENCY_MARGIN );
   string quote_currency = SymbolInfoString(_Symbol, SYMBOL_CURRENCY_PROFIT);
   
   StringConcatenate (strTickValue,       "TICK Size / Value   : ", tick_size, " / ",tick_value, " ", tick_currency );
   StringConcatenate (strAccountBalance,  "ACCOUNT BALANCE     : ", AccountInfoDouble(ACCOUNT_BALANCE), " ", AccountInfoString(ACCOUNT_CURRENCY) );
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
FutureRiskCalculator :: ~FutureRiskCalculator(){}
FutureRiskCalculator :: FutureRiskCalculator(){
   this.setupFrCalculator (_Symbol, 0.0, 0.0, 1.0);
}

FutureRiskCalculator :: FutureRiskCalculator (string aSymbol){
   this.setupFrCalculator (aSymbol, 0.0, 0.0, 1.0);
}

FutureRiskCalculator :: FutureRiskCalculator (string aSymbol, double aRiskPerc){
   this.setupFrCalculator (aSymbol, 0.0, 0.0, aRiskPerc);
}

FutureRiskCalculator :: FutureRiskCalculator (string aSymbol, double aLevelOpen, double aLevelStopLoss, double aRiskPerc){
   this.setupFrCalculator (aSymbol, aLevelOpen, aLevelStopLoss, aRiskPerc);
}

void FutureRiskCalculator :: setupFrCalculator (string aSymbol, double aLevelOpen, double aLevelStopLoss, double aRiskPerc){
   this.frcSymbol = aSymbol;
   this.setFrcLevelsOpenAndStopLoss (aLevelOpen, aLevelStopLoss);
   this.setFrcRiskPerg (aRiskPerc);
   this.setupStrings();
}


void FutureRiskCalculator :: setFrcLevelsOpenAndStopLoss(double aLevelOpen, double aLevelStopLoss){
   this.setFrcLevelOpen (aLevelOpen);
   this.setFrcLevelStopLoss (aLevelStopLoss);
}
void FutureRiskCalculator :: setFrcLevelStopLoss(double aLevelStopLoss){
   this.frcStopLossPrice = aLevelStopLoss;
}
void FutureRiskCalculator :: setFrcLevelOpen(double aLevelOpen){
   this.frcOpenPositionPrice = aLevelOpen;
}
void FutureRiskCalculator :: setFrcRiskPerg (double aRiskPerc){
   if(aRiskPerc <  1.0)  aRiskPerc=  1.0;
   if(aRiskPerc > 20.0)  aRiskPerc= 20.0;
   this.frcRiskPercentage = aRiskPerc;
}

string FutureRiskCalculator :: getStrTickValue(){
   return this.strTickValue;
}
string FutureRiskCalculator :: getStrAccountBalance(){
   return this.strAccountBalance;
}
string FutureRiskCalculator :: getStrRiskPercentage(){
   return this.strRiskPercentage;
}
string FutureRiskCalculator :: getStrStopLossPoints(){
   return this.strStopLossPoints;
}
string FutureRiskCalculator :: getStrCompVol1(){
   return this.strCompVol1;
}
string FutureRiskCalculator :: getStrCompVol2(){
   return this.strCompVol2;
}
//+------------------------------------------------------------------+
