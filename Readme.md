## What is the 1-Wire protocol?

 
 The 1-Wire protocol is a single-wire interface for low-speed data communication in microcontrollers and computers. The protocol operates over a single data line without a clock signal. It’s a master-slave serial communication protocol where the half-duplex bidirectional data communication with multiple slaves is solely managed and controlled by a single master.

## How the 1-Wire protocol works
Communication over the data line is initiated by the master using a reset. It pulls down the data line for 480 us and then releases it, allowing the typical pull-up resistor to pull the data line HIGH. If slave devices are connected to the bus, they respond to the reset signal by pulling the data line LOW for 60~240 us. If the line is pulled down by the slave(s), the master confirms their presence over the bus. After 60~240 us, the slave(s) release the data line, so the master can start writing.

After a reset, the master can write and read data with the slave devices. Initially, it sends ROM commands, like the search ROM command (0xF0), to access the ROM address of the slave devices. After reading the ROM addresses of all the connected 1-wire slave devices, the master device can access one by sending the Match ROM command (0x55). The ROM commands are followed by the function ones.

For example, if a 1-wire temperature sensor is connected to the bus, the microcontroller can send the function commands to start the temperature conversion, read the temperature, etc. The ROM and function commands are 8-bit long.

Since the 1-Wire standard does not use any clock signal, communication of the ‘0’ and ‘1’ bits occur by setting the logical level of the data line for a specific time slot. Usually, the time slot is 60 us long. There’s also an interval of 1us between each time slot, so that the data line is pulled HIGH again by the pull-up resistor. During each 60 us time slot, 1 bit is communicated between the master and slave. The time slot can be up to 10 times shorter if the bus is overdriven.

When the master has to write bits over the data line, it pulls the data line down.

-   To write ‘0,’ the master pulls down the data line for the full 60 us time slot, then releases it for a 1us interval between the time slots.
-   To write ‘1,’ the master pulls the data line down for a shorter period of 15 us, during the entire time slot, then releases it for a 1us interval between the time slots.

The slave devices pulse at about the mid-time slot (i.e. 30us in the 60us time slot). They have a basic monostable multivibrator to detect the duration of the pulses. The ROM and function commands are 8-bit long. The data communicated is also in groups of 8 bits. The error detection is performed by an 8-bit cyclic redundancy check.

The master reads from the slave device after sending a ROM search or function command. The read operation is controlled by the master device. The master reads from the slave bit-by-bit while data is communicated to the master in groups of 8 bits. Each bit is read in a 60 us time slot (or shorter if the bus is overdriven).

The master pulls the data line down for 1 us and releases it. Then, it samples the data from the bus after 15 us. If the slave writes ‘0’ over the bus, it keeps the line pulled down for the full 60 us of time slot, and then releases the data line for a 1us interval between the time slots. If the slave writes ‘1’over the bus, it keeps the line pulled down for 15 us, and then releases the data line for the pull-up resistor to pull the data line HIGH.

The master samples each bit after 15 us. If the bit sent by the slave is ‘0,’ the line is pulled LOW at the time of sampling. If the bit sent by the slave is ‘1,’ the line is pulled HIGH at the time of sampling.
 
 The master can communicate with up to 100 slaves on a 1-wire standard bus. However, the greater the number of 1-wire slaves connected to the bus, the more time the master needs to pull data from them. The software libraries typically use bit-banging or the UART to time pulse durations. The LSB is always sent first in the 1-Wire protocol.