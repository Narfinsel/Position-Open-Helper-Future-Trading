//+------------------------------------------------------------------+
//|                                                   LineDrawer.mqh |
//|                               Copyright 2022, Svetozar Pasulschi |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Svetozar Pasulschi"
#property link      "https://www.mql5.com"

#include <MyFiles\GraphicalObjectCreator.mqh>


// ------------------------------------------------------------------------------------------------------ +
// ------------------------------------------ HORIZONTAL LINE ------------------------------------------- +
// ------------------------------------------------------------------------------------------------------ +
bool drawHorizontalLine_L (long chart_ID, int sub_window, string name, double price, color clr, ENUM_LINE_STYLE style, int width, bool back, bool selectable, bool selected,  bool hidden, long z_order, bool withDelete){
   if(withDelete==true && ObjectFind(0, name) >= 0)
      ObjectDelete(0, name);
   return HLineCreate( chart_ID, sub_window, name, price, clr, style, width, back, selectable, selected, hidden, z_order);
}

bool drawHorizontalLine_S (long chart_ID, int sub_window, string name, double price, color clr, ENUM_LINE_STYLE style, int width, bool back, bool selectable, bool withDelete){
   if(withDelete==true && ObjectFind(0, name) >= 0)
      ObjectDelete(0, name);
   return HLineCreate( chart_ID, sub_window, name, price, clr, style, width, back, selectable, false, false, 0);
}



// ------------------------------------------------------------------------------------------------------ +
// ------------------------------------------- VERTICAL LINE -------------------------------------------- +
// ------------------------------------------------------------------------------------------------------ +
bool drawVerticalLine_L (long chart_ID, int sub_window, string name, datetime time, color clr, ENUM_LINE_STYLE style, int width, bool back, bool selectable, bool selected, bool ray, bool hidden, long z_order, bool withDelete){
   if(withDelete==true && ObjectFind(0, name) >= 0)
      ObjectDelete(0, name);
   return VLineCreate( chart_ID, sub_window, name, time, clr, style, width, back, selectable, selected, ray, hidden, z_order);
}

bool drawVerticalLine_S (long chart_ID, int sub_window, string name, datetime time, color clr, ENUM_LINE_STYLE style, int width, bool back, bool selectable, bool withDelete){
   if(withDelete==true && ObjectFind(0, name) >= 0)
      ObjectDelete(0, name);
   return VLineCreate( chart_ID, sub_window, name, time, clr, style, width, back, selectable, false, false, 0);
}
