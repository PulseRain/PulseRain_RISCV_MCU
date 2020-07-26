/*
###############################################################################
# Copyright (c) 2019, PulseRain Technology LLC 
#
# This program is distributed under a dual license: an open source license, 
# and a commercial license. 
# 
# The open source license under which this program is distributed is the 
# GNU Public License version 3 (GPLv3).
#
# And for those who want to use this program in ways that are incompatible
# with the GPLv3, PulseRain Technology LLC offers commercial license instead.
# Please contact PulseRain Technology LLC (www.pulserain.com) for more detail.
#
###############################################################################
*/

`default_nettype none

module single_port_ram_8bit #(parameter ADDR_WIDTH = 14, RAM_INDEX) (
            input  wire [ADDR_WIDTH - 1 : 0]         addr,
            input  wire [7 : 0]                      din,
            input  wire                              write_en, 
            input  wire                              clk,
            output wire [7 : 0]         dout
);
    
            reg [ADDR_WIDTH - 1 : 0] addr_reg;
            reg [7:0]   mem [0 : (2**ADDR_WIDTH) - 1] /* synthesis syn_ramstyle = "no_rw_check" */;

            generate 
            
            
                if (RAM_INDEX == 0) begin
                    initial begin
                        $readmemh("mem_init_0.mem", mem);
                    end
                end
            
                if (RAM_INDEX == 1) begin
                    initial begin
                        $readmemh("mem_init_1.mem", mem);
                    end
                end
                
                if (RAM_INDEX == 2) begin
                    initial begin
                        $readmemh("mem_init_2.mem", mem);
                    end
                end
                
                if (RAM_INDEX == 3) begin
                    initial begin 
                        $readmemh("mem_init_3.mem", mem);
                    end
                end
                
            endgenerate

            assign dout = mem[addr_reg];

            always@(posedge clk) begin
                addr_reg <= addr;   
                
                if(write_en) begin
                    mem[addr] <= din;
                end
            end
            
    
endmodule 



`default_nettype wire