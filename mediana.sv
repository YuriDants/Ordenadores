// Autor: Yuri Siqueira Dantas
// Feito no EDA Playground 

module ordena2_8bit(
	input reset, clk,
	input [7:0] a, b, 
  	output reg [7:0] sa, sb
);
//

  always@(posedge clk or posedge reset)
	begin
    if (reset)begin
      sa = 0;
      sb = 0;
    end
      else
          begin
          if (a < b)
          begin
              sa = b;
              sb = a;
          end
          else
          begin
              sa = a;
              sb = b;
          end
        end
	end
endmodule
module ordenador4(
	input reset, clk,
  input [7:0] entrada [3:0],
  output [7:0] saida [3:0],

);
  wire[7:0] aux[5:0];
	
      ordena2_8bit ordena2_0(reset,clk,entrada[0],entrada[1],aux[0],aux[1]);
      ordena2_8bit ordena2_1(reset,clk,entrada[2],entrada[3],aux[2],aux[3]);
      
      ordena2_8bit ordena2_2(reset,clk,aux[0],aux[2],saida[0],aux[4]);
      ordena2_8bit ordena2_3(reset,clk,aux[1],aux[3],aux[5],saida[3]);
     
      ordena2_8bit ordena2_4(reset,clk,aux[4],aux[5],saida[1],saida[2]);
    
endmodule
  module ordenador8(
	input reset, clk,
    input [7:0] entrada [7:0],
    output [7:0] saida [7:0],
    output reg flag
);
    reg [2:0]cont;
    wire[7:0] aux[17:0];
  always@(posedge clk or posedge reset)
	begin
      if(reset)
        begin
        	cont <= 0;
      		flag <= 0;
        end
      else 
        begin
          if(cont<6)
          cont <= cont + 1;
          else
            flag <= 1;
        end
    end
    ordenador4 ordena4_0(reset,clk,entrada[3:0],aux[3:0]);
      ordenador4 ordena4_1(reset,clk,entrada[7:4],aux[7:4]);
      
      ordena2_8bit ordena2_0(reset,clk,aux[0],aux[4],saida[0],aux[8]);
      ordena2_8bit ordena2_1(reset,clk,aux[1],aux[5],aux[9],aux[10]);
      ordena2_8bit ordena2_2(reset,clk,aux[2],aux[6],aux[11],aux[12]);
      ordena2_8bit ordena2_3(reset,clk,aux[3],aux[7],aux[13],saida[7]);
      
      ordena2_8bit ordena2_4(reset,clk,aux[8],aux[9],saida[1],aux[14]);
      ordena2_8bit ordena2_5(reset,clk,aux[10],aux[11],aux[15],aux[16]);
      ordena2_8bit ordena2_6(reset,clk,aux[12],aux[13],aux[17],saida[6]);
      
      ordena2_8bit ordena2_7(reset,clk,aux[14],aux[15],saida[2],saida[3]);
      ordena2_8bit ordena2_8(reset,clk,aux[16],aux[17],saida[4],saida[5]);
     
  

endmodule

module ordena9(
	input reset, clk,
  input [7:0] entrada [8:0],
  output reg [7:0] saida [8:0],
    output reg flag
);
  wire [7:0]aux[7:0];
  wire flag_8;
  reg cont;

  ordenador8 ordenador8_0(reset,clk,entrada[7:0],aux[7:0],flag_8);
  always@(posedge clk or posedge reset)
    begin
      if (entrada[8] > aux[3])begin
        if(entrada[8] > aux[1])begin
          if(entrada[8] > aux[0])
            saida[8:0] <= {aux[7:0],entrada[8]};
    else
      saida[8:0] <= {aux[7:1],entrada[8],aux[0]};
        end
  else begin
    if(entrada[8] > aux[2])
      saida[8:0] <= {aux[7:2],entrada[8],aux[1:0]};
    else
      saida[8:0] <= {aux[7:3],entrada[8],aux[2:0]};
  end

end
      else begin
        if (entrada[8] > aux[5])begin
          if (entrada[8] > aux[4])
            saida[8:0] <= {aux[7:4],entrada[8],aux[3:0]};
          else
            saida[8:0] <= {aux[7:5],entrada[8],aux[4:0]};
        end
        else begin
          if(entrada[8] > aux[6])
            saida[8:0] <= {aux[7:6],entrada[8],aux[5:0]};
          else begin
            if(entrada[8] > aux[7])
              saida[8:0] <= {aux[7],entrada[8],aux[6:0]};
            else 
              saida[8:0] <= {entrada[8],aux[7:0]};
          end
        end
      end   
end
  
  always@(posedge clk or posedge reset)
    begin
   if(reset)
        begin
        	cont <= 0;
      		flag <= 0;
        end
      else 
        if(flag_8)
       		begin
              if(cont)
                flag = 1;
              else 
                cont = 1;
            end
    end
endmodule

module mediana(
	input reset, clk,
	input [7:0] entrada [8:0],
  	output [7:0] saida,
  	output flag
);
  	
  wire [7:0] saidaMed [8:0];
  assign saida = saidaMed[4];
	
	ordena9 ordena9_0(reset, clk, entrada, saidaMed, flag);
	

endmodule
