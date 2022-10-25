package fd_tb_pkg;
    localparam WIDTH = 16;

    `include "./tb_classes/data_item.svh"
    `include "./tb_classes/input_transaction.svh"
    `include "./tb_classes/output_transaction.svh"
    `include "./tb_classes/transaction_port.svh"

    `include "./tb_classes/input_monitor.svh"
    `include "./tb_classes/output_monitor.svh"

    `include "./tb_classes/scoreboard.svh"

    `include "./tb_classes/driver.svh"
    `include "./tb_classes/env.svh"
    `include "./tb_classes/tests/base_test.svh"
    
    //`include "./tb_classes/tests/initial_test.svh"
    `include "./tb_classes/tests/random_test.svh"
    //`include "./tb_classes/tests/factorial_test.svh"
    //`include "./tb_classes/tests/ofuf_test.svh"

endpackage : fd_tb_pkg