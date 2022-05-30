//+------------------------------------------------------------------+
//|                                               TradeOrganizer.mqh |
//|                               Copyright 2022, Svetozar Pasulschi |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Svetozar Pasulschi"
#property link      "https://www.mql5.com"

#include <MyFiles\GeneralQueries.mqh>
#include <MyFiles\GeneralGenerator.mqh>


// ----------------------------- MAGIC NUMBER -----------------------------
// ------------------------------------------------------------------------
// @TESTED OK
/* Return unique MAGIC NUMBER for your EA (based on Symbol, Period, and EAid).*/
int magicNumberGenerator (int eaExpertId){
   int maxExpertId = (int) (INT_MAX /MathPow(10, 6) -1);
   if(eaExpertId < 1)
      eaExpertId = MathRand() / 32;
   if(eaExpertId > maxExpertId )
      eaExpertId = maxExpertId;
   
   int magicNumberComputed = (int) (eaExpertId *MathPow(10, 6) + generateUniqueLongIntOfSize(4));
   return magicNumberComputed;
}


MqlTradeResult CreateAndSendOrder (string symbol, ENUM_ORDER_TYPE order_type, double volume, double price_open, ENUM_TRADE_REQUEST_ACTIONS trade_action, double price_sl, double price_tp, 
                                   string comment, long magic_number, bool doPrints){ 
   MqlTradeRequest request = {};       //--- prepare a request 
      ZeroMemory(request);
      request.symbol = symbol;         // symbol
      request.type = order_type;       // order type
      request.volume = volume;         // volume in 0.1 lot
      request.price  = price_open;     // price open
      request.action = trade_action;   // setting a pending order
      request.sl = price_sl;           // stop Loss is not specified
      request.tp = price_tp;           // take Profit is not specified
      request.comment = comment;       // comment
      request.deviation = 5;
      request.magic  = magic_number;   // magic number
   MqlTradeResult result = {};         //--- send a trade request 
   bool order_outcome = OrderSend(request, result); 
   if(doPrints == true){
      Print(__FUNCTION__, " REQUEST  :   ", "   Order= ", request.order,   "   Symbol= ", request.symbol,  "   Type = ", request.type,   "   Action= ", request.action,   "   Position = ", request.position, 
                                            "   Volume= ", request.volume, "   Price= ", request.price,    "   SL= ", request.sl,        "   TP = ", request.tp,          "   Comment = ", request.comment  );
      Print(__FUNCTION__, " : ", result.comment);  //--- write the server reply to log  
      if(order_outcome)
          Print(__FUNCTION__, " : ", order_outcome);
      if(result.retcode == 10016)                  //--- return code of the trade server reply 
         Print(__FUNCTION__, " : ", "   Bid= ", result.bid,     "   Ask= ", result.ask,                "   Open = ", result.price,       "   Comment= ", result.comment, "   Deal= ", result.deal,
                                    "   Order= ", result.order, "   Request_id= ", result.request_id,  "   Retcode = ", result.retcode,  "   Volume = ", result.volume  );
   }
   return result; 
}

MqlTradeResult SendInstantOrder (string symbol, ENUM_ORDER_TYPE order_type, double volume, double price_sl, double price_tp, string comment, long magic_number, bool doPrints){
   double price_open= -1;
   if(order_type == ORDER_TYPE_BUY)    price_open = SymbolInfoDouble( symbol, SYMBOL_BID); // was SYMBOL_ASK
   if(order_type == ORDER_TYPE_SELL)   price_open = SymbolInfoDouble( symbol, SYMBOL_BID);
   
   return CreateAndSendOrder ( symbol, order_type, volume, price_open, TRADE_ACTION_DEAL, price_sl, price_tp, comment, magic_number, doPrints);
}

MqlTradeResult SendPendingOrder (string symbol, ENUM_ORDER_TYPE order_type, double volume, double price_open_pend, double price_sl, double price_tp, string comment, long magic_number, bool doPrints){  
   return CreateAndSendOrder ( symbol, order_type, volume, price_open_pend, TRADE_ACTION_PENDING, price_sl, price_tp, comment, magic_number, doPrints);
}



/* ------------------------------------------------------------------------------------------------------------------------------------------------------------ */
/* ---------------------------------------------------------        CHECK OPEN ORDER/POSITION        ---------------------------------------------------------- */
/* ------------------------------------------------------------------------------------------------------------------------------------------------------------ */

// @TESTED
/* Detects if on your symbol there is a market position (with buy/sell) or pending order (limit order with buy/sell limit/stop). [MQL5] */
bool checkIfPositionOrOrderOpenExistsOnSymbol (string aSymbol){
   return checkIfPendingOrderExistsOnSymbol (aSymbol) || checkIfPositionOpenedExistsOnSymbol (aSymbol);
}


// @TESTED
/* Detects if on your symbol there is a pending order (limit order with buy/sell limit/stop). [MQL5] */
// ORDERS      - are pending orders (buy_limit, sell_stop, etc). Their number is gathered by: OrdersTotal()
bool checkIfPendingOrderExistsOnSymbol (string aSymbol){
   if (OrdersTotal() > 0){
      ulong oTicket;
      for(int i=0; i < OrdersTotal(); i++){
         oTicket = OrderGetTicket(i);
         if( OrderSelect(oTicket) == true)
            if(OrderGetString(ORDER_SYMBOL) == aSymbol)
               return true;
      }  
   }
   return false;
}

// @TESTED
/* Detects if on your symbol there is a open position (market order with buy/sell). [MQL5] */
// POSITIONS   - are executed trades (buy, sell). Their number is gathered by: PositionsTotal()
bool checkIfPositionOpenedExistsOnSymbol (string aSymbol){
   if (PositionsTotal() > 0){
      ulong pTicket;
      for(int i=0; i < PositionsTotal(); i++){
         pTicket = PositionGetTicket(i);
         if( PositionSelect(aSymbol) == true){
            return true;
         }
      }
   }
   return false;
}
/* ------------------------------------------------------------------------------------------------------------------------------------------------------------ */
/* ------------------------------------------------------------------------------------------------------------------------------------------------------------ */
/* ------------------------------------------------------------------------------------------------------------------------------------------------------------ */


//+------------------------------------------------------------------+ 
//| Returns the first deal ticket in history or -1                   | 
//+------------------------------------------------------------------+ 
ulong GetFirstDealTicket (int forLastXDays, bool doPrints){
   if(!GetTradeHistory (forLastXDays, doPrints)){                 //--- request history for the last 7 days
      if(doPrints)
         Print(__FUNCTION__," HistorySelect() returned false");   //--- notify on unsuccessful call and return -1
      return -1;
   }
   ulong first_deal, deals = HistoryOrdersTotal(); 
   if(deals > 0){
      if(doPrints)   Print("Deals = ", deals); 
      first_deal = HistoryDealGetTicket(0); 
      if(doPrints)   PrintFormat(" first_deal = %d", first_deal); 
      return first_deal; 
   } 
   return -1;
}
  

//+------------------------------------------------------------------+ 
//| Returns the last deal ticket in history or -1                    | 
//+------------------------------------------------------------------+ 
ulong GetLastDealTicket (int forLastXDays, bool doPrints){
   if(!GetTradeHistory (forLastXDays, doPrints)){                 //--- request history for the last 7 days
      if(doPrints)
         Print(__FUNCTION__," HistorySelect() returned false");   //--- notify on unsuccessful call and return -1
      return -1;
   }
   ulong last_deal, deals = HistoryOrdersTotal(); 
   if(deals > 0){             //--- work with orders if there are any 
      last_deal = HistoryDealGetTicket((int)deals-1); 
      if(doPrints)   PrintFormat("last_deal = %d",last_deal); 
      return last_deal; 
   } 
   return -1;        //--- no deal found, return -1 
}
  
  
//+--------------------------------------------------------------------------+ 
//| Requests history for the last days and returns false in case of failure  | 
//+--------------------------------------------------------------------------+ 
bool GetTradeHistory (int forLastXDays, bool doPrints){ 
   datetime to = TimeCurrent();     //--- set a week period to request trade history 
   datetime from = to -forLastXDays *PeriodSeconds(PERIOD_D1); 
   ResetLastError();                //--- make a request and check the result 
   if(!HistorySelect(from, to)){
      if(doPrints)
         Print(__FUNCTION__," HistorySelect=false. Error code=", GetLastError()); 
      return false; 
   } 
   return true;                     //--- history received successfully 
}









bool validateMqlTradeRequest(MqlTradeRequest & request){
   bool isBuying  =  (request.type == ORDER_TYPE_BUY  &&  request.type == ORDER_TYPE_BUY_LIMIT  &&  request.type == ORDER_TYPE_BUY_STOP);
   bool isSelling =  (request.type == ORDER_TYPE_SELL &&  request.type == ORDER_TYPE_SELL_LIMIT &&  request.type == ORDER_TYPE_SELL_STOP);
   bool validBuyPrices  = (isBuying  &&  (request.sl < request.price  &&  request.price < request.tp) );
   bool validSellPrices = (isSelling &&  (request.sl > request.price  &&  request.price > request.tp) );
   if(validBuyPrices || validSellPrices)
      return true;
   return false;
}


// @TESTED
/* Normalize and covert a price like 4438.12 to 4438.00 / 4438.25 when tick size is 0.25. 
   Otherwise, the Futures will not open trade due to "invalid stops" error.
*/
double normalizeFuturePriceLevelToTickQuants (string aSymbol, double aLevel){
   double tick_size  = SymbolInfoDouble (aSymbol, SYMBOL_TRADE_TICK_SIZE );
   int symbol_digits = (int) SymbolInfoInteger (aSymbol, SYMBOL_DIGITS);
   double normalizedLvl = NormalizeDouble( (long)aLevel, symbol_digits);
   
   double normLvl1 = normalizedLvl;
   double normLvl2 = normalizedLvl + tick_size;
   
   while(true){
      if (normLvl1 <= aLevel  &&  aLevel <= normLvl2)
         break;
      else if (normLvl1 > aLevel  &&  aLevel > normLvl2)
         break;         
      normLvl1 += tick_size;
      normLvl2 += tick_size;
   }
   normLvl1 = NormalizeDouble(normLvl1, symbol_digits);
   normLvl2 = NormalizeDouble(normLvl2, symbol_digits);
   if( MathAbs(aLevel - normLvl1) < MathAbs(aLevel - normLvl2))
      normalizedLvl = normLvl1;
   else
      normalizedLvl = normLvl2;
   return normalizedLvl;
   
}

// @TESTED
string displayFutureTickSizeAndValue (string aSymbol, bool doPrint){
   double tick_value = SymbolInfoDouble (aSymbol, SYMBOL_TRADE_TICK_VALUE );
   double tick_size  = SymbolInfoDouble (aSymbol, SYMBOL_TRADE_TICK_SIZE );
   string tick_currency = SymbolInfoString (aSymbol, SYMBOL_CURRENCY_MARGIN );
   string strTickSizeValue;
   StringConcatenate (strTickSizeValue, "TICK Size / Value   :  ", tick_size, " / ",tick_value, " ", tick_currency );
   if(doPrint)
      Print(__FUNCTION__, "      ", strTickSizeValue);
   return strTickSizeValue;
}