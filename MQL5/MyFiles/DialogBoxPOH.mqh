//+------------------------------------------------------------------+
//|                                                 DialogBoxPOH.mqh |
//|                               Copyright 2022, Svetozar Pasulschi |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Svetozar Pasulschi"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <Controls\Dialog.mqh>
#include <Controls\Button.mqh>
#include <Controls\Label.mqh>
#include <Controls\Edit.mqh>


class DialogBoxPOH  : public CAppDialog{
   private:
      CLabel cLabelVolume;
      CLabel cLabelTick;         CLabel cLabelTickVal;
      CLabel cLabelAccount;      CLabel cLabelAccountVal;
      CLabel cLabelRisk;         CLabel cLabelRiskVal;
      CLabel cLabelPoints;       CLabel cLabelPointsVal;
      CLabel cLabelComp1;        CLabel cLabelComp1Val;
      CLabel cLabelComp2;        CLabel cLabelComp2Val;
      CEdit cEdit;
      CButton cButtonOpen;
      CButton cButtonCancel;
      
      int dBoxInnerGap, dBoxOuterGap;
      int dBoxWidth, dBoxHeight;
      bool hasCreatedAppDialog;
            
      long chartForUI;
      int subwindowForUI;
      string dialog_header_title;
      string dialog_name, labelV_name, labelT_name, labelA_name, labelR_name, labelP_name, labelC1_name, labelC2_name, edit_name, buttonO_name, buttonC_name;
      string labelTval_name, labelAval_name, labelRval_name, labelPval_name, labelC1val_name, labelC2val_name;
      int dialog_ulX,   dialog_ulY,    dialog_lrX,    dialog_lrY;
      int labelV_ulX,   labelV_ulY,    labelV_lrX,    labelV_lrY;
      int labelT_ulX,   labelT_ulY,    labelT_lrX,    labelT_lrY;
      int labelA_ulX,   labelA_ulY,    labelA_lrX,    labelA_lrY;
      int labelR_ulX,   labelR_ulY,    labelR_lrX,    labelR_lrY;
      int labelP_ulX,   labelP_ulY,    labelP_lrX,    labelP_lrY;
      int labelC1_ulX,  labelC1_ulY,   labelC1_lrX,   labelC1_lrY;
      int labelC2_ulX,  labelC2_ulY,   labelC2_lrX,   labelC2_lrY;
      
      int labelTval_ulX,   labelTval_ulY,    labelTval_lrX,    labelTval_lrY;
      int labelAval_ulX,   labelAval_ulY,    labelAval_lrX,    labelAval_lrY;
      int labelRval_ulX,   labelRval_ulY,    labelRval_lrX,    labelRval_lrY;
      int labelPval_ulX,   labelPval_ulY,    labelPval_lrX,    labelPval_lrY;
      int labelC1val_ulX,  labelC1val_ulY,   labelC1val_lrX,   labelC1val_lrY;
      int labelC2val_ulX,  labelC2val_ulY,   labelC2val_lrX,   labelC2val_lrY;
      
      int edit_ulX,    edit_ulY,     edit_lrX,     edit_lrY;
      int buttonO_ulX, buttonO_ulY,  buttonO_lrX,  buttonO_lrY;
      int buttonC_ulX, buttonC_ulY,  buttonC_lrX,  buttonC_lrY;

      bool CreateElements();
      
   public:
      DialogBoxPOH();
      ~DialogBoxPOH();
      
      void setupGaps (int gapInner, int gapOuter);
      void setupWidthHeight (int dWidth, int dHeight);
      void setupChartAndSubwindow (long chart_ID, int sub_window);
      void setDialogHeaderTitle   (string aDiagTitle);
      void setupAppDialogProps    (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright);
      void setupLabelVolumeProps  (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright);
      void setupLabelTickProps    (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright);
      void setupLabelAccountProps (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright);
      void setupLabelRiskProps    (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright);
      void setupLabelPointsProps  (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright);
      void setupLabelComp1Props   (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright);
      void setupLabelComp2Props   (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright);
      
      void setupLabelTickValProps    (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright);
      void setupLabelAccountValProps (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright);
      void setupLabelRiskValProps    (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright);
      void setupLabelPointsValProps  (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright);
      void setupLabelComp1ValProps   (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright);
      void setupLabelComp2ValProps   (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright);
      
      void setupEditProps         (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright);
      void setupButtonOpenProps   (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright);
      void setupButtonCancelProps (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright);
      void setupDefaultSizes();
      
      
      bool setLabelVolumeText (string newText);
      bool setLabelTickText (string newText);
      bool setLabelAccountText (string newText);
      bool setLabelRiskText (string newText);
      bool setLabelPointsText (string newText);
      bool setLabelComp1Text (string newText);
      bool setLabelComp2Text (string newText);
      bool setLabelTickValText (string newText);
      bool setLabelAccountValText (string newText);
      bool setLabelRiskValText (string newText);
      bool setLabelPointsValText (string newText);
      bool setLabelComp1ValText (string newText);
      bool setLabelComp2ValText (string newText);
      void setAllLabelValTexts (string txtTick, string txtAccount, string txtRisk, string txtPoints, string txtComp1, string txtComp2);
      
      bool setEditText (string newText);
      bool setButtonOpenText (string newText);
      bool setButtonCancelText (string newText);
      void setFontsLabels (string fontStyle, int fontSize);
      void setFontsLabelsVals (string fontStyle, int fontSize);
      string getEditText ();
      string getButtonOkName ();
      string getButtonCancelName ();
      
      void minimizeAppDialog();
      void maximizeAppDialog();
      bool showAppDialog();
      bool closeAppDialog();
      bool createAllElements();
      void runAppDialog ();
      void destroyAppDialog (int reason);
      void registerChartEvent (const int id, const long & lparam, const double & dparam, const string & sparam);
};



bool DialogBoxPOH :: CreateElements (){
   this.hasCreatedAppDialog = CAppDialog::Create (chartForUI, dialog_header_title, subwindowForUI, dialog_ulX, dialog_ulY, dialog_lrX, dialog_lrY);
   bool isLabelVolOk = false, isLabelTickOk = false, isLabelAccountOk= false, isLabelRiskOk= false, isLabelPointsOk= false, isEditOk= false, isButtonOpenOk= false, isButtonCancelOk= false;
   bool isLabelComp1Ok= false, isLabelComp2Ok= false;
   bool isLabelTickValOk = false, isLabelAccountValOk= false, isLabelRiskValOk= false, isLabelPointsValOk= false, isLabelComp1ValOk= false, isLabelComp2ValOk= false;
   
   if( this.hasCreatedAppDialog ){
      Show();
      if( cLabelVolume.Create (chartForUI, labelV_name,  subwindowForUI, labelV_ulX,   labelV_ulY,  labelV_lrX,  labelV_lrY) == true)
         if( Add (cLabelVolume) == true)
            if( cLabelVolume.Text( "Volume" ) ){
               cLabelVolume.Show();
               isLabelVolOk = true;
            }
      if( cLabelTick.Create (chartForUI, labelT_name,  subwindowForUI, labelT_ulX,  labelT_ulY,   labelT_lrX,   labelT_lrY) == true)
         if( Add (cLabelTick) == true)
            if( cLabelTick.Text( "Tick" ) ){
               cLabelTick.Show();
               isLabelTickOk = true;
            }
      if( cLabelAccount.Create (chartForUI, labelA_name,  subwindowForUI, labelA_ulX,   labelA_ulY,  labelA_lrX,  labelA_lrY) == true)
         if( Add (cLabelAccount) == true)
            if( cLabelAccount.Text( "Account") ){
               cLabelAccount.Show();
               isLabelAccountOk = true;
            }
      if( cLabelRisk.Create (chartForUI, labelR_name,  subwindowForUI, labelR_ulX,   labelR_ulY,  labelR_lrX,  labelR_lrY) == true)
         if( Add (cLabelRisk) == true)
            if( cLabelRisk.Text( "Risk") ){
               cLabelRisk.Show();
               isLabelRiskOk = true;
            }
      if( cLabelPoints.Create (chartForUI, labelP_name,  subwindowForUI, labelP_ulX,   labelP_ulY,  labelP_lrX,  labelP_lrY) == true)
         if( Add (cLabelPoints) == true)
            if( cLabelPoints.Text( "Points") ){
               cLabelPoints.Show();
               isLabelPointsOk = true;
            }
      if( cLabelComp1.Create (chartForUI, labelC1_name,  subwindowForUI, labelC1_ulX,   labelC1_ulY,  labelC1_lrX,  labelC1_lrY) == true)
         if( Add (cLabelComp1) == true)
            if( cLabelComp1.Text( "Comp1") ){
               cLabelComp1.Show();
               isLabelComp1Ok = true;
            }
      if( cLabelComp2.Create (chartForUI, labelC2_name,  subwindowForUI, labelC2_ulX,   labelC2_ulY,  labelC2_lrX,  labelC2_lrY) == true)
         if( Add (cLabelComp2) == true)
            if( cLabelComp2.Text( "Comp2") ){
               cLabelComp2.Show();
               isLabelComp2Ok = true;
            }                        

      if( cLabelTickVal.Create (chartForUI, labelTval_name,  subwindowForUI, labelTval_ulX,  labelTval_ulY,   labelTval_lrX,   labelTval_lrY) == true)
         if( Add (cLabelTickVal) == true)
            if( cLabelTickVal.Text( "Tick" ) ){
               cLabelTickVal.Show();
               isLabelTickValOk = true;
            }
      if( cLabelAccountVal.Create (chartForUI, labelAval_name,  subwindowForUI, labelAval_ulX,   labelAval_ulY,  labelAval_lrX,  labelAval_lrY) == true)
         if( Add (cLabelAccountVal) == true)
            if( cLabelAccountVal.Text( "Account") ){
               cLabelAccountVal.Show();
               isLabelAccountValOk = true;
            }
      if( cLabelRiskVal.Create (chartForUI, labelRval_name,  subwindowForUI, labelRval_ulX,   labelRval_ulY,  labelRval_lrX,  labelRval_lrY) == true)
         if( Add (cLabelRiskVal) == true)
            if( cLabelRiskVal.Text( "Risk") ){
               cLabelRiskVal.Show();
               isLabelRiskValOk = true;
            }
      if( cLabelPointsVal.Create (chartForUI, labelPval_name,  subwindowForUI, labelPval_ulX,   labelPval_ulY,  labelPval_lrX,  labelPval_lrY) == true)
         if( Add (cLabelPointsVal) == true)
            if( cLabelPointsVal.Text( "Points") ){
               cLabelPointsVal.Show();
               isLabelPointsValOk = true;
            }
      if( cLabelComp1Val.Create (chartForUI, labelC1val_name,  subwindowForUI, labelC1val_ulX,   labelC1val_ulY,  labelC1val_lrX,  labelC1val_lrY) == true)
         if( Add (cLabelComp1Val) == true)
            if( cLabelComp1Val.Text( "Comp1") ){
               cLabelComp1Val.Show();
               isLabelComp1ValOk = true;
            }
      if( cLabelComp2Val.Create (chartForUI, labelC2val_name,  subwindowForUI, labelC2val_ulX,   labelC2val_ulY,  labelC2val_lrX,  labelC2val_lrY) == true)
         if( Add (cLabelComp2Val) == true)
            if( cLabelComp2Val.Text( "Comp2") ){
               cLabelComp2Val.Show();
               isLabelComp2ValOk = true;
            }       
      
      if( cEdit.Create (chartForUI, edit_name,   subwindowForUI, edit_ulX,    edit_ulY,   edit_lrX,   edit_lrY) == true)
         if( Add (cEdit) == true)
            if( cEdit.Text("Edit") ){
               cEdit.Show();
               isEditOk = true;
            }
      
      if( cButtonOpen.Create (chartForUI, buttonO_name, subwindowForUI, buttonO_ulX,  buttonO_ulY, buttonO_lrX, buttonO_lrY) == true)
         if( Add (cButtonOpen) == true)
            if( cButtonOpen.Text("Open") ){
               cButtonOpen.Show();
               isButtonOpenOk = true;
            }
      if( cButtonCancel.Create (chartForUI, buttonC_name, subwindowForUI, buttonC_ulX,  buttonC_ulY, buttonC_lrX, buttonC_lrY) == true)
         if( Add (cButtonCancel) == true)
            if( cButtonCancel.Text("Open") ){
               cButtonCancel.Show();
               isButtonCancelOk = true;
            }
      
      if( isLabelVolOk && isLabelTickOk && isLabelAccountOk && isLabelRiskOk && isLabelPointsOk && isLabelComp1Ok && isLabelComp2Ok && isEditOk && isButtonOpenOk && isButtonCancelOk)
         return true;
   }
   return false;
}



bool DialogBoxPOH :: setLabelVolumeText (string newText){
   return this.cLabelVolume.Text( newText );
}
bool DialogBoxPOH :: setLabelTickText (string newText){
   return this.cLabelTick.Text( newText );
}
bool DialogBoxPOH :: setLabelAccountText (string newText){
   return this.cLabelAccount.Text( newText );
}
bool DialogBoxPOH :: setLabelRiskText (string newText){
   return this.cLabelRisk.Text( newText );
}
bool DialogBoxPOH :: setLabelPointsText (string newText){
   return this.cLabelPoints.Text( newText );
}
bool DialogBoxPOH :: setLabelComp1Text (string newText){
   return this.cLabelComp1.Text( newText );
}
bool DialogBoxPOH :: setLabelComp2Text (string newText){
   return this.cLabelComp2.Text( newText );
}
bool DialogBoxPOH :: setLabelTickValText (string newText){
   return this.cLabelTickVal.Text( newText );
}
bool DialogBoxPOH :: setLabelAccountValText (string newText){
   return this.cLabelAccountVal.Text( newText );
}
bool DialogBoxPOH :: setLabelRiskValText (string newText){
   return this.cLabelRiskVal.Text( newText );
}
bool DialogBoxPOH :: setLabelPointsValText (string newText){
   return this.cLabelPointsVal.Text( newText );
}
bool DialogBoxPOH :: setLabelComp1ValText (string newText){
   return this.cLabelComp1Val.Text( newText );
}
bool DialogBoxPOH :: setLabelComp2ValText (string newText){
   return this.cLabelComp2Val.Text( newText );
}
bool DialogBoxPOH :: setEditText (string newText){
   return this.cEdit.Text( newText );
}
bool DialogBoxPOH :: setButtonOpenText (string newText){
   return this.cButtonOpen.Text( newText );
}
bool DialogBoxPOH :: setButtonCancelText (string newText){
   return this.cButtonCancel.Text( newText );
}
void DialogBoxPOH :: setAllLabelValTexts (string txtTick, string txtAccount, string txtRisk, string txtPoints, string txtComp1, string txtComp2){
   this.setLabelTickValText ( txtTick);
   this.setLabelAccountValText ( txtAccount);
   this.setLabelRiskValText ( txtRisk);
   this.setLabelPointsValText ( txtPoints);
   this.setLabelComp1ValText ( txtComp1);
   this.setLabelComp2ValText ( txtComp2);
}

string DialogBoxPOH :: getEditText (){
   return this.cEdit.Text();
}
string DialogBoxPOH :: getButtonOkName (){
   return this.buttonO_name;
}
string DialogBoxPOH :: getButtonCancelName (){
   return this.buttonC_name;
}


void DialogBoxPOH :: setFontsLabels (string fontStyle, int fontSize){
   if(fontSize <  5)  fontSize=  5;
   if(fontSize > 48)  fontSize= 48;
   
   this.cLabelTick.FontSize (fontSize);
   this.cLabelAccount.FontSize (fontSize);
   this.cLabelRisk.FontSize (fontSize);
   this.cLabelPoints.FontSize (fontSize);
   this.cLabelComp1.FontSize (fontSize);
   this.cLabelComp2.FontSize (fontSize);
   this.cLabelTick.Font (fontStyle);
   this.cLabelAccount.Font (fontStyle);
   this.cLabelRisk.Font (fontStyle);
   this.cLabelPoints.Font (fontStyle);
   this.cLabelComp1.Font (fontStyle);
   this.cLabelComp2.Font (fontStyle);
   
}
void DialogBoxPOH :: setFontsLabelsVals (string fontStyle, int fontSize){
   if(fontSize <  5)  fontSize=  5;
   if(fontSize > 48)  fontSize= 48;
   
   this.cLabelTickVal.FontSize (fontSize);
   this.cLabelAccountVal.FontSize (fontSize);
   this.cLabelRiskVal.FontSize (fontSize);
   this.cLabelPointsVal.FontSize (fontSize);
   this.cLabelComp1Val.FontSize (fontSize);
   this.cLabelComp2Val.FontSize (fontSize);
   this.cLabelTickVal.Font (fontStyle);
   this.cLabelAccountVal.Font (fontStyle);
   this.cLabelRiskVal.Font (fontStyle);
   this.cLabelPointsVal.Font (fontStyle);
   this.cLabelComp1Val.Font (fontStyle);
   this.cLabelComp2Val.Font (fontStyle);
}


void DialogBoxPOH :: minimizeAppDialog(){
   this.Minimize();
}
void DialogBoxPOH :: maximizeAppDialog(){
   this.Maximize();
}
bool DialogBoxPOH :: showAppDialog(){
   return this.Visible(true);
   
}
bool DialogBoxPOH :: closeAppDialog(){
   return this.Visible(false);
}
bool DialogBoxPOH :: createAllElements(){
   return this.CreateElements();
}

void DialogBoxPOH :: runAppDialog (){
   this.Run();
}

void DialogBoxPOH :: destroyAppDialog (int reason){
   this.Destroy(reason);
}

void DialogBoxPOH :: registerChartEvent (const int id, const long & lparam, const double & dparam, const string & sparam){
   ChartEvent(id, lparam, dparam, sparam);
}


//+----------------------------------------------------------------------------------------------------------------------------------------+
//+------------------------------------------------------------  SETTERS ------------------------------------------------------------------+
//+----------------------------------------------------------------------------------------------------------------------------------------+
void DialogBoxPOH :: setupChartAndSubwindow (long chart_ID, int sub_window){
   this.chartForUI = chart_ID;
   this.subwindowForUI = sub_window;
}
void DialogBoxPOH :: setupGaps (int gapInner, int gapOuter){
   this.dBoxInnerGap = gapInner;
   this.dBoxOuterGap = gapOuter;
}
void DialogBoxPOH :: setupWidthHeight (int dWidth, int dHeight){
   this.dBoxWidth = dWidth;
   this.dBoxHeight = dHeight;

}
void DialogBoxPOH :: setDialogHeaderTitle (string aDiagTitle){
   this.dialog_header_title = aDiagTitle;
}
void DialogBoxPOH :: setupAppDialogProps (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright){
   this.dialog_name = name;
   this.dialog_ulX = x_upperleft;
   this.dialog_ulY = y_upperleft;
   this.dialog_lrX = x_lowerright;
   this.dialog_lrY = y_lowerright;
}
void DialogBoxPOH :: setupLabelVolumeProps (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright){
   this.labelV_name = name;
   this.labelV_ulX = x_upperleft;
   this.labelV_ulY = y_upperleft;
   this.labelV_lrX = x_lowerright;
   this.labelV_lrY = y_lowerright;
}
void DialogBoxPOH :: setupLabelTickProps (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright){
   this.labelT_name = name;
   this.labelT_ulX = x_upperleft;
   this.labelT_ulY = y_upperleft;
   this.labelT_lrX = x_lowerright;
   this.labelT_lrY = y_lowerright;
}
void DialogBoxPOH :: setupLabelAccountProps (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright){
   this.labelA_name = name;
   this.labelA_ulX = x_upperleft;
   this.labelA_ulY = y_upperleft;
   this.labelA_lrX = x_lowerright;
   this.labelA_lrY = y_lowerright;
}
void DialogBoxPOH :: setupLabelRiskProps    (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright){
   this.labelR_name = name;
   this.labelR_ulX = x_upperleft;
   this.labelR_ulY = y_upperleft;
   this.labelR_lrX = x_lowerright;
   this.labelR_lrY = y_lowerright;
}
void DialogBoxPOH :: setupLabelPointsProps  (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright){
   this.labelP_name = name;
   this.labelP_ulX = x_upperleft;
   this.labelP_ulY = y_upperleft;
   this.labelP_lrX = x_lowerright;
   this.labelP_lrY = y_lowerright;
}
void DialogBoxPOH :: setupLabelComp1Props   (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright){
   this.labelC1_name = name;
   this.labelC1_ulX = x_upperleft;
   this.labelC1_ulY = y_upperleft;
   this.labelC1_lrX = x_lowerright;
   this.labelC1_lrY = y_lowerright;
}
void DialogBoxPOH :: setupLabelComp2Props   (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright){
   this.labelC2_name = name;
   this.labelC2_ulX = x_upperleft;
   this.labelC2_ulY = y_upperleft;
   this.labelC2_lrX = x_lowerright;
   this.labelC2_lrY = y_lowerright;
}

void DialogBoxPOH :: setupLabelTickValProps (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright){
   this.labelTval_name = name;
   this.labelTval_ulX = x_upperleft;
   this.labelTval_ulY = y_upperleft;
   this.labelTval_lrX = x_lowerright;
   this.labelTval_lrY = y_lowerright;
}
void DialogBoxPOH :: setupLabelAccountValProps (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright){
   this.labelAval_name = name;
   this.labelAval_ulX = x_upperleft;
   this.labelAval_ulY = y_upperleft;
   this.labelAval_lrX = x_lowerright;
   this.labelAval_lrY = y_lowerright;
}
void DialogBoxPOH :: setupLabelRiskValProps    (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright){
   this.labelRval_name = name;
   this.labelRval_ulX = x_upperleft;
   this.labelRval_ulY = y_upperleft;
   this.labelRval_lrX = x_lowerright;
   this.labelRval_lrY = y_lowerright;
}
void DialogBoxPOH :: setupLabelPointsValProps  (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright){
   this.labelPval_name = name;
   this.labelPval_ulX = x_upperleft;
   this.labelPval_ulY = y_upperleft;
   this.labelPval_lrX = x_lowerright;
   this.labelPval_lrY = y_lowerright;
}
void DialogBoxPOH :: setupLabelComp1ValProps   (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright){
   this.labelC1val_name = name;
   this.labelC1val_ulX = x_upperleft;
   this.labelC1val_ulY = y_upperleft;
   this.labelC1val_lrX = x_lowerright;
   this.labelC1val_lrY = y_lowerright;
}
void DialogBoxPOH :: setupLabelComp2ValProps   (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright){
   this.labelC2val_name = name;
   this.labelC2val_ulX = x_upperleft;
   this.labelC2val_ulY = y_upperleft;
   this.labelC2val_lrX = x_lowerright;
   this.labelC2val_lrY = y_lowerright;
}

void DialogBoxPOH :: setupEditProps (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright){
   this.edit_name = name;
   this.edit_ulX = x_upperleft;
   this.edit_ulY = y_upperleft;
   this.edit_lrX = x_lowerright;
   this.edit_lrY = y_lowerright;
}
void DialogBoxPOH :: setupButtonOpenProps (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright){
   this.buttonO_name = name;
   this.buttonO_ulX = x_upperleft;
   this.buttonO_ulY = y_upperleft;
   this.buttonO_lrX = x_lowerright;
   this.buttonO_lrY = y_lowerright;
}
void DialogBoxPOH :: setupButtonCancelProps (string name, int x_upperleft, int y_upperleft, int x_lowerright, int y_lowerright){
   this.buttonC_name = name;
   this.buttonC_ulX = x_upperleft;
   this.buttonC_ulY = y_upperleft;
   this.buttonC_lrX = x_lowerright;
   this.buttonC_lrY = y_lowerright;
}





//+----------------------------------------------------------------------------------------------------------------------------------------+
//+----------------------------------------------------  CONSTUCTORS & DESTRUCTORS --------------------------------------------------------+
//+----------------------------------------------------------------------------------------------------------------------------------------+

DialogBoxPOH :: DialogBoxPOH(){
   this.setupChartAndSubwindow (0, 0);
   this.setupWidthHeight (200, 125);
   this.setupGaps (5, 20);
   this.setDialogHeaderTitle("Dialog POH");
}
DialogBoxPOH :: ~DialogBoxPOH(){}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
#define DIALOG_POH_X 100
#define DIALOG_POH_Y 100
#define DIALOG_POH_LENGTH 720
#define DIALOG_POH_HEIGHT 400

#define GAP_POH_OUTER 25
#define GAP_POH_INNER 5

#define EDIT_POH_SIZE_Y 25

#define BUTTON_POH_SIZE_X 90
#define BUTTON_POH_SIZE_Y 30

   int diag_Poh_x1 = DIALOG_POH_X;
   int diag_Poh_x2 = diag_Poh_x1 + DIALOG_POH_LENGTH;
   int diag_Poh_y1 = DIALOG_POH_Y;
   int diag_Poh_y2 = diag_Poh_y1 + DIALOG_POH_HEIGHT;

   int labelV_Poh_x1 = GAP_POH_OUTER;
   int labelV_Poh_x2 = labelV_Poh_x1 + DIALOG_POH_LENGTH /5;
   int labelV_Poh_y1 = GAP_POH_OUTER + 2*GAP_POH_INNER;
   int labelV_Poh_y2 = labelV_Poh_y1 + EDIT_POH_SIZE_Y;
   
   int labelLeftPohX1 = GAP_POH_OUTER;
   int labelLeftPohX2 = GAP_POH_OUTER + DIALOG_POH_LENGTH/6;
   
   int labelRightPohX1 = labelLeftPohX2 + 5*GAP_POH_INNER;
   int labelRightPohX2 = DIALOG_POH_LENGTH - GAP_POH_OUTER;
   
   int labelT_Poh_y1 = labelV_Poh_y2 + 4*GAP_POH_INNER;
   int labelT_Poh_y2 = labelT_Poh_y1 + EDIT_POH_SIZE_Y;
   
   int edit_Poh_x1 = labelV_Poh_x2 + GAP_POH_INNER;
   int edit_Poh_x2 = labelV_Poh_x2 + GAP_POH_INNER + DIALOG_POH_LENGTH /4;
   int edit_Poh_y1 = labelV_Poh_y1;
   int edit_Poh_y2 = edit_Poh_y1 + EDIT_POH_SIZE_Y;
   
   int labelA_Poh_y1 = labelT_Poh_y2 + GAP_POH_INNER;
   int labelA_Poh_y2 = labelA_Poh_y1 + EDIT_POH_SIZE_Y;
   
   int labelR_Poh_y1 = labelA_Poh_y2 + GAP_POH_INNER;
   int labelR_Poh_y2 = labelR_Poh_y1 + EDIT_POH_SIZE_Y;
   
   int labelP_Poh_y1 = labelR_Poh_y2 + GAP_POH_INNER;
   int labelP_Poh_y2 = labelP_Poh_y1 + EDIT_POH_SIZE_Y;
   
   int labelC1_Poh_y1 = labelP_Poh_y2 + 3*GAP_POH_INNER;
   int labelC1_Poh_y2 = labelC1_Poh_y1 + EDIT_POH_SIZE_Y; 
   
   int labelC2_Poh_y1 = labelC1_Poh_y2 + GAP_POH_INNER;
   int labelC2_Poh_y2 = labelC2_Poh_y1 + EDIT_POH_SIZE_Y; 
   
   int buttonC_Poh_x2 = DIALOG_POH_LENGTH - (int)1.5*GAP_POH_OUTER;
   int buttonC_Poh_x1 = buttonC_Poh_x2 - BUTTON_POH_SIZE_X;
   int buttonC_Poh_y2 = DIALOG_POH_HEIGHT - 2.2*GAP_POH_OUTER;
   int buttonC_Poh_y1 = buttonC_Poh_y2 - BUTTON_POH_SIZE_Y;
   
   int buttonO_Poh_x2 = buttonC_Poh_x1 - 6*GAP_POH_INNER;
   int buttonO_Poh_x1 = buttonO_Poh_x2 - BUTTON_POH_SIZE_X;
   int buttonO_Poh_y2 = buttonC_Poh_y2;
   int buttonO_Poh_y1 = buttonC_Poh_y1;
   
   
void DialogBoxPOH :: setupDefaultSizes (){
   this.setupAppDialogProps    ( "diagPoh1",   diag_Poh_x1,    diag_Poh_y1,     diag_Poh_x2,     diag_Poh_y2 );
   this.setupLabelVolumeProps  ( "labelPohV",  labelV_Poh_x1,  labelV_Poh_y1,   labelV_Poh_x1,   labelV_Poh_y1 );
   
   this.setupLabelTickProps    ( "labelPohT",   labelLeftPohX1,  labelT_Poh_y1,   labelLeftPohX2,   labelT_Poh_y1 );
   this.setupLabelAccountProps ( "labelPohA",   labelLeftPohX1,  labelA_Poh_y1,   labelLeftPohX2,   labelA_Poh_y1 );
   this.setupLabelRiskProps    ( "labelPohR",   labelLeftPohX1,  labelR_Poh_y1,   labelLeftPohX2,   labelR_Poh_y1 );
   this.setupLabelPointsProps  ( "labelPohP",   labelLeftPohX1,  labelP_Poh_y1,   labelLeftPohX2,   labelP_Poh_y1 );
   this.setupLabelComp1Props   ( "labelPohC1",  labelLeftPohX1,  labelC1_Poh_y1,  labelLeftPohX2,   labelC1_Poh_y1 );
   this.setupLabelComp2Props   ( "labelPohC2",  labelLeftPohX1,  labelC2_Poh_y1,  labelLeftPohX2,   labelC2_Poh_y1 );
   
   this.setupLabelTickValProps    ( "labelPohTv",   labelRightPohX1,  labelT_Poh_y1,   labelRightPohX2,  labelT_Poh_y2 );
   this.setupLabelAccountValProps ( "labelPohAv",   labelRightPohX1,  labelA_Poh_y1,   labelRightPohX2,  labelA_Poh_y2 );
   this.setupLabelRiskValProps    ( "labelPohRv",   labelRightPohX1,  labelR_Poh_y1,   labelRightPohX2,  labelR_Poh_y2 );
   this.setupLabelPointsValProps  ( "labelPohPv",   labelRightPohX1,  labelP_Poh_y1,   labelRightPohX2,  labelP_Poh_y2 );
   this.setupLabelComp1ValProps   ( "labelPohC1v",  labelRightPohX1,  labelC1_Poh_y1,  labelRightPohX2,  labelC1_Poh_y2 );
   this.setupLabelComp2ValProps   ( "labelPohC2v",  labelRightPohX1,  labelC2_Poh_y1,  labelRightPohX2,  labelC2_Poh_y2 );
   
   this.setupEditProps         ( "editPoh1",   edit_Poh_x1,    edit_Poh_y1,     edit_Poh_x2,     edit_Poh_y2 );
   this.setupButtonOpenProps   ( "bttnPohO1",  buttonO_Poh_x1, buttonO_Poh_y1,  buttonO_Poh_x2,  buttonO_Poh_y2 );
   this.setupButtonCancelProps ( "bttnPohC1",  buttonC_Poh_x1, buttonC_Poh_y1,  buttonC_Poh_x2,  buttonC_Poh_y2 );
}



/*
// -------------------------------- HOW TO INITIALIZE --------------------------------

void initDialogBox(){
   dialogBoxPoh = new DialogBoxPOH ();
   dialogBoxPoh.setupChartAndSubwindow (chart_ID, sub_window);
   dialogBoxPoh.setupDefaultSizes();
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
   dialogBoxPoh.maximizeAppDialog();
   dialogBoxPoh.runAppDialog();   
}

// -------------------------------- HOW TO DE-INITIALIZE --------------------------------
void OnDeinit(const int reason){ 
   delete dialogBoxPoh;
}

// -------------------------------- HOW TO RESPOND TO EVENTS --------------------------------
void OnChartEvent(const int id,           // event ID  
                  const long& lparam,     // event parameter of the long type
                  const double& dparam,   // event parameter of the double type
                  const string& sparam){  // event parameter of the string type
   dialogBoxPoh.registerChartEvent(id, lparam, dparam, sparam);
}
*/