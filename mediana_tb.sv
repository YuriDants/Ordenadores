// Autor: Yuri Siqueira Dantas
// Feito no EDA Playground 

module tb;
	logic clk, rst;
  logic [7:0] entr_u[8:0];
  logic [7:0]sai_u;
	logic flag;
	
	mediana dut(
		.clk (clk),
		.reset (rst),
      .entrada (entr_u),
      .saida (sai_u),
		.flag (flag)
		);
       	 int fixed_seed =10;
		
	initial 
	begin
      $dumpfile("dump.vcd");
      $dumpvars;
     
      $urandom (fixed_seed);
      	#1 rst = 1'b0;
      	clk = 1'b0;
		#1 rst = 1'b1;


      for(int i = 0; i < 4; i++) begin
        #1 rst = 1;
        
        entr_u[0] = $urandom_range(0,255);
        entr_u[1] = $urandom_range(0,255);
        entr_u[2] = $urandom_range(0,255);
        entr_u[3] = $urandom_range(0,255);
        entr_u[4] = $urandom_range(0,255);
        entr_u[5] = $urandom_range(0,255);
        entr_u[6] = $urandom_range(0,255);
        entr_u[7] = $urandom_range(0,255);
        entr_u[8] = $urandom_range(0,255);
        $display("Sequencia a ser ordenada:%h %h %h %h %h %h %h %h %h ", entr_u[0],entr_u[1],entr_u[2],entr_u[3],entr_u[4],entr_u[5],entr_u[6],entr_u[7],entr_u[8]); 
        #1 rst = 0;
        for (int j = 0; flag == 0; j++) begin
				#1 clk = 1;
				#1 clk = 0; 
				if (flag == 1)
                  begin
                    $display("terminou:%h , em clocks ", sai_u); 
                  end
			end
		end
		$finish();
	end
  
 endmodule
