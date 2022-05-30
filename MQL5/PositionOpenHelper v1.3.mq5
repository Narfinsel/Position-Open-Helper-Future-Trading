//+------------------------------------------------------------------+
//|                                      PositionOpenHelper v1.3.mq5 |
//|                               Copyright 2022, Svetozar Pasulschi |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+              

/* FLAWED / BUGGED */
/* FLAWED / BUGGED */
/* FLAWED / BUGGED */
/* FLAWED / BUGGED */
/* FLAWED / BUGGED */
/* FLAWED / BUGGED */
/* FLAWED / BUGGED */
/* FLAWED / BUGGED */
/* FLAWED / BUGGED */

#property copyright "Copyright 2022, Svetozar Pasulschi"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <MyFiles\FutureRiskCalculator.mqh>
#include <MyFiles\LineDrawer.mqh>
#include <MyFiles\TradeOrganizer.mqh>
#include <MyFiles\DialogBoxPOH.mqh>
#include <MyFiles\FontSelection.mqh>

DialogBoxPOH * dialogBoxPoh;

#define chart_ID 0
#define sub_window 0
enum OPEN_TRADE_TYPE  {MARKET_OPEN = 54658, PLANNED_OPEN = 54659};

// ---------- DESING ----------
input color    colorSL = clrTomato;                      // Color for Stop-Loss
input color    colorTP = clrYellowGreen;                 // Color for Take-Profit
input color    colorOP = clrOrange;                      // Color for Open
input int      lineWidth = 1;                            // Line-width for Horizontal lines
// -------- OPEN TRADE --------
input double   riskPercentage = 1.0;                     // Risk Percentage
input OPEN_TRADE_TYPE tradeTypeOpen = MARKET_OPEN;       // Trade Type (Market / Planned)
// -------- BEHAVIOUR --------
input bool   doPrintTradeTraces = true;                  // Print Trade Traces
input bool   doDeleteObjectsAfterOpenTrade = true;       // Delete Objects after Opening Trade
input bool   doRemoveEADeleteAllAfterOpenTrade = false;  // Remove EA & Delete Objects after Opening Trade


int magicNumberForTrade = 400400;;
string lineNameForSl = "Horiz-Line_Sl_for_PriceShow";
string lineNameForTp = "Horiz-Line_Tp_for_PriceShow";
string lineNameForOp = "Horiz-Line_Op_for_PriceShow";
string buttonOpenTrade = "Button_Open_Position";
string buttonRemoveObj = "Button_Remove_EA";
double initialPositionSlLine;
double initialPositionTpLine;
double initialPositionOpLine;
double plannedPositionSl=0, plannedPositionTp=0, plannedPositionOp=0;
int digitsPrice;
bool isFuture = false;
FutureRiskCalculator * frCalculator;
ENUM_ORDER_TYPE orderComputed;


//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnChartEvent(const int id, 
                  const long &lparam, 
                  const double &dparam, 
                  const string &sparam){
   //---
   if(isFuture==true){
      if(id == CHARTEVENT_OBJECT_CLICK){
         if(sparam == buttonOpenTrade){

            if (ObjectGetInteger(chart_ID, lineNameForSl, OBJPROP_TYPE) == OBJ_HLINE)
               plannedPositionSl = NormalizeDouble( ObjectGetDouble(chart_ID, lineNameForSl, OBJPROP_PRICE), digitsPrice);
            if (ObjectGetInteger(chart_ID, lineNameForTp, OBJPROP_TYPE) == OBJ_HLINE)
               plannedPositionTp = NormalizeDouble( ObjectGetDouble(chart_ID, lineNameForTp, OBJPROP_PRICE), digitsPrice);
               
            double BID_PRICE = SymbolInfoDouble(_Symbol, SYMBOL_BID);
            double ASK_PRICE = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
               
            if(plannedPositionSl!=0 && plannedPositionTp!=0){
               if(tradeTypeOpen == MARKET_OPEN){
                  
                  orderComputed = selectOrderTypeBasedOnLevels( MARKET_OPEN, BID_PRICE, 0.0, plannedPositionSl, plannedPositionTp);
                  double volume = showDialogWithCompVolume (BID_PRICE, plannedPositionSl );
                  dialogBoxPoh.registerChartEvent(id, lparam, dparam, sparam);
               }
               if(tradeTypeOpen == PLANNED_OPEN){
                  if (ObjectGetInteger(chart_ID, lineNameForOp, OBJPROP_TYPE) == OBJ_HLINE)
                     plannedPositionOp = NormalizeDouble( ObjectGetDouble(chart_ID, lineNameForOp, OBJPROP_PRICE), digitsPrice);
                     
                     orderComputed = selectOrderTypeBasedOnLevels( PLANNED_OPEN, BID_PRICE, plannedPositionOp, plannedPositionSl, plannedPositionTp);
                     double volume = showDialogWithCompVolume (plannedPositionOp, plannedPositionSl );
                     dialogBoxPoh.registerChartEvent(id, lparam, dparam, sparam);

               }
            }
         }
         else if(sparam == buttonRemoveObj){
            deleteObjects();
         }
         else if(sparam == dialogBoxPoh.getButtonOkName() ){
            if(dialogBoxPoh == NULL)
               createDialogBox();
               
            double volumeEdit = StringToDouble ( dialogBoxPoh.getEditText());
            double normalizedPlannedOp = normalizeFuturePriceLevelToTickQuants ( _Symbol, plannedPositionOp);
            double normalizedPlannedSl = normalizeFuturePriceLevelToTickQuants ( _Symbol, plannedPositionSl);
            double normalizedPlannedTp = normalizeFuturePriceLevelToTickQuants ( _Symbol, plannedPositionTp);
            
            MqlTradeResult result;
            if(orderComputed ==  ORDER_TYPE_BUY){
               result = SendInstantOrder (_Symbol, ORDER_TYPE_BUY, volumeEdit, normalizedPlannedSl, normalizedPlannedTp, "by Position Open Helper v1.2", magicNumberForTrade, doPrintTradeTraces);
            }
            else if(orderComputed ==  ORDER_TYPE_SELL)
               result = SendInstantOrder (_Symbol, ORDER_TYPE_SELL, volumeEdit, normalizedPlannedSl, normalizedPlannedTp, "by Position Open Helper v1.2", magicNumberForTrade, doPrintTradeTraces);
            
            else if(orderComputed ==  ORDER_TYPE_BUY_LIMIT)
               result = SendPendingOrder (_Symbol, ORDER_TYPE_BUY_LIMIT, volumeEdit, normalizedPlannedOp, normalizedPlannedSl, normalizedPlannedTp, "by Position Open Helper v1.2", magicNumberForTrade, doPrintTradeTraces);
            
            else if(orderComputed ==  ORDER_TYPE_SELL_LIMIT)
               result = SendPendingOrder (_Symbol, ORDER_TYPE_SELL_LIMIT, volumeEdit, normalizedPlannedOp, normalizedPlannedSl, normalizedPlannedTp, "by Position Open Helper v1.0", magicNumberForTrade, doPrintTradeTraces);
            
            else if(orderComputed ==  ORDER_TYPE_BUY_STOP)
               result = SendPendingOrder (_Symbol, ORDER_TYPE_BUY_STOP, volumeEdit, normalizedPlannedOp, normalizedPlannedSl, normalizedPlannedTp, "by Position Open Helper v1.2", magicNumberForTrade, doPrintTradeTraces);
            
            else if(orderComputed ==  ORDER_TYPE_SELL_STOP)
               result = SendPendingOrder (_Symbol, ORDER_TYPE_SELL_STOP, volumeEdit, normalizedPlannedOp, normalizedPlannedSl, normalizedPlannedTp, "by Position Open Helper v1.0", magicNumberForTrade, doPrintTradeTraces);
            
            else
               Print(__FUNCTION__, "  :  ", "Invalid Position of lines relative to each other / market prices.");
            
            if( result.retcode == TRADE_RETCODE_PLACED  || result.retcode == TRADE_RETCODE_DONE ){
                  dialogBoxPoh.closeAppDialog();
                  if(doDeleteObjectsAfterOpenTrade)
                     deleteObjects();
                  if(doRemoveEADeleteAllAfterOpenTrade)
                     ExpertRemove();
            }
         }
         else if(sparam == dialogBoxPoh.getButtonCancelName() ){
            dialogBoxPoh.closeAppDialog();
         }
         else if(sparam == (string) ON_APP_CLOSE  ||  id == ON_APP_CLOSE){
            dialogBoxPoh.closeAppDialog();
         }      
      }
      else if(id == CHARTEVENT_OBJECT_DRAG){
         if(sparam == lineNameForOp){
            plannedPositionOp = NormalizeDouble( ObjectGetDouble(chart_ID, lineNameForOp, OBJPROP_PRICE), digitsPrice);
            orderComputed = selectOrderTypeBasedOnLevels (tradeTypeOpen, SymbolInfoDouble(_Symbol, SYMBOL_BID), plannedPositionOp, plannedPositionSl, plannedPositionTp);
            updateDialogWithCompVolume (plannedPositionOp, plannedPositionSl);
         }
         else if(sparam == lineNameForSl){
            plannedPositionSl = NormalizeDouble( ObjectGetDouble(chart_ID, lineNameForSl, OBJPROP_PRICE), digitsPrice);
            orderComputed = selectOrderTypeBasedOnLevels (tradeTypeOpen, SymbolInfoDouble(_Symbol, SYMBOL_BID), plannedPositionOp, plannedPositionSl, plannedPositionTp);
            if(orderComputed == ORDER_TYPE_BUY || orderComputed == ORDER_TYPE_SELL)
               updateDialogWithCompVolume (SymbolInfoDouble(_Symbol, SYMBOL_BID), plannedPositionSl);
            else if(orderComputed == ORDER_TYPE_BUY_LIMIT || orderComputed == ORDER_TYPE_SELL_LIMIT ||
                    orderComputed == ORDER_TYPE_BUY_STOP  || orderComputed == ORDER_TYPE_SELL_STOP )
               updateDialogWithCompVolume (plannedPositionOp, plannedPositionSl);
            else
               updateDialogWithCompVolume (SymbolInfoDouble(_Symbol, SYMBOL_BID), plannedPositionSl);
         }
         else if(sparam == lineNameForTp){
            plannedPositionTp = NormalizeDouble( ObjectGetDouble(chart_ID, lineNameForTp, OBJPROP_PRICE), digitsPrice);
         }
      }
      dialogBoxPoh.registerChartEvent(id, lparam, dparam, sparam);
   }
}
//+------------------------------------------------------------------+
ENUM_ORDER_TYPE selectOrderTypeBasedOnLevels (OPEN_TRADE_TYPE orderType, double lvlBid, double lvlOp, double lvlSl, double lvlTp){
   if(orderType == MARKET_OPEN){
      if(lvlSl < lvlBid  &&  lvlBid < lvlTp){         // BUY
         return ORDER_TYPE_BUY;
      }
      else if(lvlSl > lvlBid  &&  lvlBid > lvlTp){    // SELL
         return ORDER_TYPE_SELL;
      }
   }
   else if(orderType == PLANNED_OPEN){
      if(lvlOp < lvlBid  &&  lvlSl < lvlOp  &&  lvlOp < lvlTp){         // BUY-LIMIT
         return ORDER_TYPE_BUY_LIMIT;
      }
      else if(lvlOp > lvlBid  &&  lvlSl > lvlOp  &&  lvlOp > lvlTp){   // SELL-LIMIT   
         return ORDER_TYPE_SELL_LIMIT;
      }
      else if(lvlOp > lvlBid  &&  lvlSl < lvlOp  &&  lvlOp < lvlTp){   // BUY-LIMIT
         return ORDER_TYPE_BUY_STOP;
      }
      else if(lvlOp < lvlBid  &&  lvlSl > lvlOp  &&  lvlOp > lvlTp){   // SELL-LIMIT
         return ORDER_TYPE_SELL_STOP;
      }
   }
   return -1;
}


double showDialogWithCompVolume (double priceOpen, double priceSL){
   frCalculator.setFrcLevelOpen (priceOpen );
   frCalculator.setFrcLevelStopLoss (priceSL);
   double volume = frCalculator.getTradeVolume();                     
   dialogBoxPoh.showAppDialog();
   setAppDialogTextBasedOnFrcCalc (frCalculator);
   dialogBoxPoh.setEditText( (string) volume );
   
   return volume;
}

double updateDialogWithCompVolume (double priceOpen, double priceSL){
   frCalculator.setFrcLevelOpen (priceOpen );
   frCalculator.setFrcLevelStopLoss (priceSL);
   double volume = frCalculator.getTradeVolume();
   setAppDialogTextBasedOnFrcCalc (frCalculator);
   dialogBoxPoh.setEditText( (string) volume );
   return volume;
}

void setAppDialogTextBasedOnFrcCalc (FutureRiskCalculator * aFrcCalc){
   if (aFrcCalc != NULL && dialogBoxPoh != NULL){
      dialogBoxPoh.setAllLabelValTexts (  aFrcCalc.getStrTickValue(),      aFrcCalc.getStrAccountBalance(),
                                          aFrcCalc.getStrRiskPercentage(), aFrcCalc.getStrStopLossPoints(),
                                          aFrcCalc.getStrCompVol1(),       aFrcCalc.getStrCompVol2() );
   }
}

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
void createDialogBox(){
   dialogBoxPoh.createAllElements();
   dialogBoxPoh.setLabelVolumeText    ("Volume Computed: ");
   dialogBoxPoh.setLabelAccountText   ("Account Balance: ");
   dialogBoxPoh.setLabelTickText      ("Tick Value: ");
   dialogBoxPoh.setLabelRiskText      ("Risk Percentage :");
   dialogBoxPoh.setLabelPointsText    ("Stop Loss Points: ");
   dialogBoxPoh.setLabelComp1Text     ("Lot Size Option 1: ");
   dialogBoxPoh.setLabelComp2Text     ("Lot Size Option 2: ");
   dialogBoxPoh.setLabelTickValText   ("T");
   dialogBoxPoh.setLabelRiskValText   ("R");
   dialogBoxPoh.setLabelPointsValText ("P");
   dialogBoxPoh.setLabelComp1ValText  ("Lot Size 1");
   dialogBoxPoh.setLabelComp2ValText  ("Lot Size 2");
   
   dialogBoxPoh.setButtonOpenText     ("Open");
   dialogBoxPoh.setButtonCancelText   ("Cancel");
   dialogBoxPoh.setEditText           ( "0.00");
   
   dialogBoxPoh.setFontsLabels     (FONT_ARIAL_BLACK, 10);
   dialogBoxPoh.setFontsLabelsVals (FONT_ARIAL, 10);
   dialogBoxPoh.maximizeAppDialog();
   dialogBoxPoh.runAppDialog();
   dialogBoxPoh.closeAppDialog();
}

void toCreateHorizontalLinesForPriceVisualization(){
   double min, max;
   ChartGetDouble(chart_ID, CHART_PRICE_MAX, sub_window, max);
   ChartGetDouble(chart_ID, CHART_PRICE_MIN, sub_window, min);
   initialPositionSlLine = (min +(max-min) *1/3);
   initialPositionTpLine = (min +(max-min) *2/3);
   initialPositionOpLine = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   //Print(" Sl= ", initialPositionSlLine, "     Tp= ", initialPositionTpLine, "     Op= ", initialPositionOpLine);

   drawHorizontalLine_S (chart_ID, sub_window, lineNameForSl, initialPositionSlLine, colorSL, STYLE_SOLID, lineWidth, false, true, true );
   drawHorizontalLine_S (chart_ID, sub_window, lineNameForTp, initialPositionTpLine, colorTP, STYLE_SOLID, lineWidth, false, true, true );
   if(tradeTypeOpen == PLANNED_OPEN)
      drawHorizontalLine_S(chart_ID, sub_window, lineNameForOp, initialPositionOpLine, colorOP, STYLE_SOLID, lineWidth, false, true, true );
   ButtonCreate_S (chart_ID, sub_window, buttonOpenTrade, 15, 30, 100, 25, CORNER_LEFT_UPPER, "Open Position", "Arial Bold", 9, clrBlack, clrGold, clrSandyBrown);
   ButtonCreate_S (chart_ID, sub_window, buttonRemoveObj, 15, 65, 100, 25, CORNER_LEFT_UPPER, "Remove", "Arial Bold", 9, clrBlack, clrSilver, clrGray);
}


int OnInit(){
   isFuture = isFuturesSymbol(_Symbol);
   if(isFuture){
      digitsPrice = (int)  SymbolInfoInteger(_Symbol, SYMBOL_DIGITS);
      StringConcatenate(lineNameForSl, "Horiz-Line_Sl_for_PriceShow", "___", _Symbol, "___", _Period);
      StringConcatenate(lineNameForTp, "Horiz-Line_Tp_for_PriceShow", "___", _Symbol, "___", _Period);
      StringConcatenate(lineNameForOp, "Horiz-Line_Op_for_PriceShow", "___", _Symbol, "___", _Period);
      StringConcatenate(buttonOpenTrade, "Button_Open_Position", "___", _Symbol, "___", _Period);
      StringConcatenate(buttonRemoveObj, "Button_Remove_Objects", "___", _Symbol, "___", _Period);
      magicNumberForTrade = magicNumberGenerator (magicNumberForTrade);
      
      frCalculator = new FutureRiskCalculator(_Symbol, riskPercentage);  
      
      dialogBoxPoh = new DialogBoxPOH ();
      dialogBoxPoh.setupChartAndSubwindow (chart_ID, sub_window);
      dialogBoxPoh.setDialogHeaderTitle  ("Position Open Helper v1.2");
      dialogBoxPoh.setupDefaultSizes();
      createDialogBox();
      //if(UninitializeReason() != REASON_CHARTCHANGE)
      toCreateHorizontalLinesForPriceVisualization();
   }
   else
      Print(__FUNCTION__," - ", _Symbol," is not a Futures instrument.");
   return(INIT_SUCCEEDED);
}

void deleteObjects(){
   ObjectDelete(chart_ID, lineNameForSl);
   ObjectDelete(chart_ID, lineNameForTp);
   ObjectDelete(chart_ID, lineNameForOp);
   ObjectDelete(chart_ID, buttonOpenTrade);
   ObjectDelete(chart_ID, buttonRemoveObj);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason){
   deleteObjects();
   delete frCalculator;
   delete dialogBoxPoh;
}