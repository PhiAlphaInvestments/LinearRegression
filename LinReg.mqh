//+------------------------------------------------------------------+
//|                                                       LinReg.mqh |
//|                                                 William Nicholas |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "William Nicholas"
#property link      "https://www.mql5.com"



class LinReg{


      private:
      double Mean(double &L[]);
      double m_X[];
      double m_Y[];
      public:
      LinReg(double &X[] ,double &Y[] );
      double Beta();
      double Intercept();
      double Std( double &L[]);



};


double LinReg::Std(double &L[]){

      int L_Size = ArraySize(L);
   
   double mu = Mean(L);
   
   
   double std = 0; 
   
   for( int i = 0 ; i < L_Size; i++){
   
      std += pow(L[i]-mu,2);
   
   
   }


   return MathSqrt(std/double(L_Size-1)); 



}



LinReg::LinReg(double &X[],double &Y[]){


   int X_Size = ArraySize(X);
   int Y_Size = ArraySize(Y);
   
   
   if( X_Size == Y_Size){
   
      ArrayResize(m_X, X_Size);
      ArrayResize(m_Y, Y_Size);
      
      for( int i = 0 ; i < X_Size; i++){
      
         
         m_X[i]= X[i];
         m_Y[i] = Y[i];
      
      }
   
   
   
   
   }
   else{
   
      Print("X and Y are not the same size"); 
   
   
   }


};


double LinReg::Mean(double &L[]){

   int L_Size = ArraySize(L);
   
   
   double mu = 0; 
   
   for( int i = 0 ; i < L_Size; i++){
   
      mu += L[i];
   
   
   }


   return mu/double(L_Size); 




};


double LinReg::Beta(void){


   int N = ArraySize(m_X);
   
   double S1 = 0;
   
   for( int i = 0 ; i < N; i++){
   
      S1 += ( m_X[i]*m_Y[i]);
   
   
   }   
   
   S1 = S1*double(N);
   
   double S2a = 0;   
   double S2b = 0;
   
   
   for( int i = 0 ; i < N; i++){
   
      S2a += ( m_X[i]);
   
   
   };
   
   
   
   for( int i = 0 ; i < N; i++){
   
      S2b += ( m_Y[i]);
   
   
   };
   
   double S3 = 0;
   
    for( int i = 0 ; i < N; i++){
   
      S3 += pow( m_X[i],2);
   
   
   };
   S3 = double(N)*S3;
   
   return (S1 - S2a*S2b)/(S3-pow(S2a,2));

};




double LinReg::Intercept(void){


      int N = ArraySize(m_X);

      double S1 =0;
      
      for( int i = 0 ; i<N ; i++){
      
         S1 +=( m_X[i]*m_Y[i]);
      
      };

      double S2a = 0;
      double S2b = 0;
      
      for( int i =0 ; i< N ; i++){
      
         S2a += (m_X[i]);
      
      };


      
      for( int i =0 ; i< N ; i++){
      
         S2b += (m_Y[i]);
      
      };
      
      double S3 = 0;
      
      for( int i =0 ; i<N ; i++){
      
         S3 += pow(m_X[i],2);
      
      }

      return ( S2b*S3 - S2a*S1)/( double(N)*S3 - pow(S2a,2));
}







