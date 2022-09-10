package fast_multiplicator_tb_pkg;
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
    `include "./tb_classes/base_test.svh"
    

    `include "./tb_classes/random_test.svh"

endpackage : fast_multiplicator_tb_pkg