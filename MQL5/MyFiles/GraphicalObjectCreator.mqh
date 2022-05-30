//+------------------------------------------------------------------+
//|                                       GraphicalObjectCreator.mqh |
//|                               Copyright 2022, Svetozar Pasulschi |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Svetozar Pasulschi"
#property link      "https://www.mql5.com"


bool HLineCreate(const long            chart_ID =0,         // chart's ID
                 const int             sub_window =0,       // subwindow index
                 const string          name ="HLine",       // line name
                 double                price =0,            // line price
                 const color           clr =clrRed,         // line color
                 const ENUM_LINE_STYLE style =STYLE_SOLID,  // line style
                 const int             width =1,            // line width
                 const bool            back =false,         // in the background
                 const bool            selectable =true,    // is selectable
                 const bool            selected =false,     // is selected
                 const bool            hidden =true,        // hidden in the object list
                 const long            z_order =0)          // priority for mouse click
  {
   if(!price)           
      price = SymbolInfoDouble(Symbol(), SYMBOL_BID);                //--- if the price is not set, set it at the current Bid price level
   ResetLastError();                                                 //--- reset the error value
   if(!ObjectCreate(chart_ID, name, OBJ_HLINE, sub_window, 0, price)){    //--- create a horizontal line
      Print(__FUNCTION__, ": failed to create a horizontal line! Error code = ", GetLastError());
      return (false);
   }
   ObjectSetInteger(chart_ID, name, OBJPROP_COLOR, clr);             //--- set line color
   ObjectSetInteger(chart_ID, name, OBJPROP_STYLE, style);           //--- set line display style
   ObjectSetInteger(chart_ID, name, OBJPROP_WIDTH, width);           //--- set line width
   ObjectSetInteger(chart_ID, name, OBJPROP_BACK, back);             //--- display in the foreground (false) or background (true)
   //--- enable (true) or disable (false) the mode of moving the line by mouse
   //--- when creating a graphical object using ObjectCreate function, the object cannot be
   //--- highlighted and moved by default. Inside this method, selection parameter
   //--- is true by default making it possible to highlight and move the object
   ObjectSetInteger(chart_ID, name, OBJPROP_SELECTABLE, selectable);  
   ObjectSetInteger(chart_ID, name, OBJPROP_SELECTED, selected);
   ObjectSetInteger(chart_ID, name, OBJPROP_HIDDEN, hidden);         //--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID, name, OBJPROP_ZORDER, z_order);        //--- set the priority for receiving the event of a mouse click in the chart
   return(true);                                                     //--- successful execution
}


bool VLineCreate(const long            chart_ID =0,        // chart's ID
                 const int             sub_window =0,      // subwindow index
                 const string          name ="VLine",      // line name
                 datetime              time =0,            // line time
                 const color           clr =clrRed,        // line color
                 const ENUM_LINE_STYLE style =STYLE_SOLID, // line style
                 const int             width =1,           // line width
                 const bool            back =false,        // in the background
                 const bool            selectable =true,    // is selectable
                 const bool            selected =false,     // is selected
                 const bool            ray =true,          // line's continuation down
                 const bool            hidden =true,       // hidden in the object list
                 const long            z_order =0)         // priority for mouse click
  {
   if(ObjectFind(0, name) == 0)
      ObjectDelete(0, name);
   if(!time)
      time=TimeCurrent();                                         //--- if the line time is not set, draw it via the last bar
   ResetLastError();                                              //--- reset the error value
   if(!ObjectCreate(chart_ID, name, OBJ_VLINE, sub_window, time, 0)){   //--- create a vertical line
      Print(__FUNCTION__, ": failed to create a vertical line! Error code = ", GetLastError());
      return(false);
   }
   ObjectSetInteger(chart_ID, name, OBJPROP_COLOR, clr);          //--- set line color
   ObjectSetInteger(chart_ID, name, OBJPROP_STYLE, style);        //--- set line display style
   ObjectSetInteger(chart_ID, name, OBJPROP_WIDTH, width);        //--- set line width
   ObjectSetInteger(chart_ID, name, OBJPROP_BACK, back);          //--- display in the foreground (false) or background (true)
   //--- enable (true) or disable (false) the mode of moving the line by mouse
   //--- when creating a graphical object using ObjectCreate function, the object cannot be
   //--- highlighted and moved by default. Inside this method, selection parameter
   //--- is true by default making it possible to highlight and move the object
   ObjectSetInteger(chart_ID, name, OBJPROP_SELECTABLE, selectable);
   ObjectSetInteger(chart_ID, name, OBJPROP_SELECTED, selected);
   ObjectSetInteger(chart_ID, name, OBJPROP_RAY, ray);            //--- enable (true) or disable (false) the mode of displaying the line in the chart subwindows
   ObjectSetInteger(chart_ID, name, OBJPROP_HIDDEN, hidden);      //--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID, name, OBJPROP_ZORDER, z_order);     //--- set the priority for receiving the event of a mouse click in the chart
   return(true);                                                  //--- successful execution
}


bool ButtonCreate_L(const long            chart_ID =0,               // chart's ID
                  const int               sub_window =0,             // subwindow index
                  const string            name ="Button",            // button name
                  const int               pos_x =0,                  // X coordinate
                  const int               pos_y =0,                  // Y coordinate
                  const int               width =50,                 // button width
                  const int               height =18,                // button height
                  const ENUM_BASE_CORNER  corner =CORNER_LEFT_UPPER, // chart corner for anchoring
                  const string            text ="Button",            // text
                  const string            font ="Arial",             // font
                  const int               font_size =10,             // font size
                  const color             clr =clrBlack,             // text color
                  const color             back_clr =clrGainsboro,    // background color
                  const color             border_clr =clrNONE,       // border color
                  const bool              state =false,              // pressed/released
                  const bool              back =false,               // in the background
                  const bool              selectable =false,         // is selectable
                  const bool              selected =false,           // is selected
                  const bool              hidden =true,              // hidden in the object list
                  const long              z_order =0)                // priority for mouse click
  {
   ResetLastError();                                                    //--- reset the error value
   if(!ObjectCreate(chart_ID, name, OBJ_BUTTON, sub_window, 0, 0)){     //--- create the button
      Print(__FUNCTION__, ": failed to create the button! Error code = ", GetLastError());
      return(false);
   }
   ObjectSetInteger(chart_ID, name, OBJPROP_XDISTANCE, pos_x);          //--- set button coordinates
   ObjectSetInteger(chart_ID, name, OBJPROP_YDISTANCE, pos_y);
   ObjectSetInteger(chart_ID, name, OBJPROP_XSIZE, width);              //--- set button size
   ObjectSetInteger(chart_ID, name, OBJPROP_YSIZE, height);          
   ObjectSetInteger(chart_ID, name, OBJPROP_CORNER, corner);            //--- set the chart's corner, relative to which point coordinates are defined
   ObjectSetString(chart_ID, name, OBJPROP_TEXT, text);                 //--- set the text
   ObjectSetString(chart_ID, name, OBJPROP_FONT, font);                 //--- set text font
   ObjectSetInteger(chart_ID, name, OBJPROP_FONTSIZE, font_size);       //--- set font size
   ObjectSetInteger(chart_ID, name, OBJPROP_COLOR, clr);                //--- set text color
   ObjectSetInteger(chart_ID, name, OBJPROP_BGCOLOR, back_clr);         //--- set background color
   ObjectSetInteger(chart_ID, name, OBJPROP_BORDER_COLOR, border_clr);  //--- set border color
   ObjectSetInteger(chart_ID, name, OBJPROP_BACK, back);                //--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID, name, OBJPROP_STATE, state);              //--- set button state
   ObjectSetInteger(chart_ID, name, OBJPROP_SELECTABLE, selectable);    //--- enable (true) or disable (false) the mode of moving the button by mouse
   ObjectSetInteger(chart_ID, name, OBJPROP_SELECTED, selected);
   ObjectSetInteger(chart_ID, name, OBJPROP_HIDDEN, hidden);            //--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID, name, OBJPROP_ZORDER, z_order);           //--- set the priority for receiving the event of a mouse click in the chart
   return(true);                                                        //--- successful execution
}


bool ButtonCreate_S(const long            chart_ID =0,               // chart's ID
                  const int               sub_window =0,             // subwindow index
                  const string            name ="Button",            // button name
                  const int               pos_x =0,                  // X coordinate
                  const int               pos_y =0,                  // Y coordinate
                  const int               width =50,                 // button width
                  const int               height =18,                // button height
                  const ENUM_BASE_CORNER  corner =CORNER_LEFT_UPPER, // chart corner for anchoring
                  const string            text ="Button",            // text
                  const string            font ="Arial",             // font
                  const int               font_size =10,             // font size
                  const color             clr =clrBlack,             // text color
                  const color             back_clr =clrGainsboro,    // background color
                  const color             border_clr =clrNONE)       // border color
  {
  return ButtonCreate_L( chart_ID, sub_window, name, pos_x, pos_y, width, height, corner, text, font, font_size, clr, back_clr, border_clr, false, false, true, false, false, 0);
}