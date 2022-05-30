//+------------------------------------------------------------------+
//|                                    GraphicalInterfaceCreator.mqh |
//|                               Copyright 2022, Svetozar Pasulschi |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Svetozar Pasulschi"
#property link      "https://www.mql5.com"

#include <Controls\Dialog_v1.mqh>
#include <Controls\Button.mqh>
#include <Controls\Label.mqh>
#include <Controls\Edit.mqh>



bool CreateUIAppDialog (long chart_ID, int sub_window, const string name, const int x_upperleft, const int y_upperleft, const int x_lowerright, const int y_lowerright){
   CAppDialog cAppDialog;
   if( !cAppDialog.Create(chart_ID, name, sub_window, x_upperleft, y_upperleft, x_lowerright, y_lowerright) ){
      Print( "  !cAppDialog.Create(chart_ID, name, sub_window, x_upperleft, y_upperleft, x_lowerright, y_lowerright) = false");
      Print(__FUNCTION__, " :: created AppDialog -- ", cAppDialog.Name() );
      cAppDialog.Run();
      return true;
   }
   else{
      Print(__FUNCTION__, " :: no AppDialog -- ");
      return false;
   }   
}


CDialog  * CreateUIDialog (long chart_ID, int sub_window, const string name, const int x_upperleft, const int y_upperleft, const int x_lowerright, const int y_lowerright){
   CDialog * cDialog = new CDialog();
   if( !cDialog.Create(chart_ID, name, sub_window, x_upperleft, y_upperleft, x_lowerright, y_lowerright) )
      return cDialog;
   else{
      delete cDialog;
      return NULL;
   }   
}

CButton * CreateUIButton (long chart_ID, int sub_window, const string name, const int x_upperleft, const int y_upperleft, const int x_lowerright, const int y_lowerright){
   CButton * cButton = new CButton();
   if( !cButton.Create(chart_ID, name, sub_window, x_upperleft, y_upperleft, x_lowerright, y_lowerright) )
      return cButton;
   else{
      delete cButton;
      return NULL;
   }
}

CLabel * CreateUILabel (long chart_ID, int sub_window, const string name, const int x_upperleft, const int y_upperleft, const int x_lowerright, const int y_lowerright){
   CLabel * cLabel = new CLabel();
   if( !cLabel.Create(chart_ID, name, sub_window, x_upperleft, y_upperleft, x_lowerright, y_lowerright) )
      return cLabel;
   else{
      delete cLabel;
      return NULL;
   }
}

CEdit * CreateUIEdit (long chart_ID, int sub_window, const string name, const int x_upperleft, const int y_upperleft, const int x_lowerright, const int y_lowerright){
   CEdit * cEdit = new CEdit();
   if( !cEdit.Create(chart_ID, name, sub_window, x_upperleft, y_upperleft, x_lowerright, y_lowerright) )
      return cEdit;
   else{
      delete cEdit;
      return NULL;
   }
}
