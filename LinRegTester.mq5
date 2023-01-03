//+------------------------------------------------------------------+
//|                                                 LinRegTester.mq5 |
//|                                                 William Nicholas |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+


#include <LinReg.mqh>

int OnInit()
  {
//---

   
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   ObjectDelete(_Symbol,"LinReg");
   ObjectDelete(_Symbol,"LinReg+std");
   ObjectDelete(_Symbol,"LinReg-std");
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
   double Num[50];
   double Price[50];
   for(int i = 0 ; i < 50;i++){
   
      Num[i]=i;
      Price[50-i-1]=iClose(_Symbol,PERIOD_M1,0+i);
   
   
   }
   
   MqlRates PriceInfo[];
   ArraySetAsSeries(PriceInfo,true);
   LinReg LR(Num, Price);
   int Data = CopyRates(_Symbol, PERIOD_M1,0,120,PriceInfo);
   Print( LR.Beta(),"x+",LR.Intercept());
   
   ObjectCreate(_Symbol,"LinReg",OBJ_TREND,0,PriceInfo[49].time,LR.Intercept(),PriceInfo[0].time,LR.Beta()*49+PriceInfo[0].close);
   
   
   ObjectSetInteger(0,"LinReg",OBJPROP_COLOR,Red);
   ObjectSetInteger(0,"LinReg",OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(0,"LinReg",OBJPROP_WIDTH,1);
   
   
   
   
   
   
   ObjectCreate(_Symbol,"LinReg+std",OBJ_TREND,0,PriceInfo[49].time,LR.Intercept() + LR.Std(Price),PriceInfo[0].time,LR.Beta()*49+PriceInfo[0].close+ LR.Std(Price));
   
   
   ObjectSetInteger(0,"LinReg+std",OBJPROP_COLOR,Blue);
   ObjectSetInteger(0,"LinReg+std",OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(0,"LinReg+std",OBJPROP_WIDTH,1);
   
   
   
   
   ObjectCreate(_Symbol,"LinReg-std",OBJ_TREND,0,PriceInfo[49].time,LR.Intercept() - LR.Std(Price),PriceInfo[0].time,LR.Beta()*49+PriceInfo[0].close- LR.Std(Price));
   
   
   ObjectSetInteger(0,"LinReg-std",OBJPROP_COLOR,Blue);
   ObjectSetInteger(0,"LinReg-std",OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(0,"LinReg-std",OBJPROP_WIDTH,1);
   
   
   
   
   
  }
//+------------------------------------------------------------------+
