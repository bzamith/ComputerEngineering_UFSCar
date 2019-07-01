/*

   DC - UFSCar - Comunicação de dados
   Baseado em: https://github.com/njh/W5100MacRaw

*/


#ifndef  W5100_H
#define W5100_H

#include <stdint.h>
#include <Arduino.h>



class Wiznet5100 {

  public:
    /**
       Constructor that uses the default hardware SPI pins
       @param cs the Arduino Chip Select / Slave Select pin (default 10)
    */
    Wiznet5100(int8_t cs = SS);


    /**
       Initialise the Ethernet controller
       Must be called before sending or receiving Ethernet frames

       @param address the local MAC address for the Ethernet interface
       @return Returns true if setting up the Ethernet interface was successful
    */
    boolean begin(const uint8_t *address);

    /**
       Shut down the Ethernet controlled
    */
    void end();

    /**
       Send an Ethernet frame
       @param data a pointer to the data to send
       @param datalen the length of the data in the packet
       @return the number of bytes transmitted
    */
    uint16_t sendFrame(const uint8_t *data, uint16_t datalen);

    /**
       Read an Ethernet frame
       @param buffer a pointer to a buffer to write the packet to
       @param bufsize the available space in the buffer
       @return the length of the received packet
               or 0 if no packet was received
    */
    uint16_t readFrame(uint8_t *buffer, uint16_t bufsize);


  private:
    static const uint16_t TxBufferAddress = 0x4000;  /* Internal Tx buffer address of the iinchip */
    static const uint16_t RxBufferAddress = 0x6000;  /* Internal Rx buffer address of the iinchip */
    static const uint8_t TxBufferSize = 0x3; /* Buffer size configuration: 0=1kb, 1=2kB, 2=4kB, 3=8kB */
    static const uint8_t RxBufferSize = 0x3; /* Buffer size configuration: 0=1kb, 1=2kB, 2=4kB, 3=8kB */
    static const uint16_t TxBufferLength = (1 << TxBufferSize) << 10; /* Length of Tx buffer in bytes */
    static const uint16_t RxBufferLength = (1 << RxBufferSize) << 10; /* Length of Rx buffer in bytes */
    static const uint16_t TxBufferMask = TxBufferLength - 1;
    static const uint16_t RxBufferMask = RxBufferLength - 1;


    int8_t _cs;
    uint8_t _mac_address[6];

    /**
       Default function to select chip.
       @note This function help not to access wrong address. If you do not describe this function or register any functions,
       null function is called.
    */
    inline void wizchip_cs_select()
    {
      digitalWrite(_cs, LOW);
    }

    /**
       Default function to deselect chip.
       @note This function help not to access wrong address. If you do not describe this function or register any functions,
       null function is called.
    */
    inline void wizchip_cs_deselect()
    {
      digitalWrite(_cs, HIGH);
    }

    /**
       Read a 1 byte value from a register.
       @param address Register address
       @return The value of register
    */
    uint8_t wizchip_read(uint16_t address);

    /**
       Reads a 2 byte value from a register.
       @param address Register address
       @return The value of register
    */
    uint16_t wizchip_read_word(uint16_t address);

    /**
       It reads sequence data from registers.
       @param address Register address
       @param pBuf Pointer buffer to read data
       @param len Data length
    */
    void wizchip_read_buf(uint16_t address, uint8_t* pBuf, uint16_t len);

    /**
       Write a 1 byte value to a register.
       @param address Register address
       @param wb Write data
       @return void
    */
    void wizchip_write(uint16_t address, uint8_t wb);

    /**
       Write a 2 byte value to a register.
       @param address Register address
       @param wb Write data
       @return void
    */
    void wizchip_write_word(uint16_t address, uint16_t word);

    /**
       It writes sequence data to registers.
       @param address Register address
       @param pBuf Pointer buffer to write data
       @param len Data length
    */
    void wizchip_write_buf(uint16_t address, const uint8_t* pBuf, uint16_t len);


    /**
       Reset WIZCHIP by softly.
    */
    void wizchip_sw_reset(void);

    /**
       It copies data to internal TX memory

       @details This function reads the Tx write pointer register and after that,
       it copies the <i>wizdata(pointer buffer)</i> of the length of <i>len(variable)</i> bytes to internal TX memory
       and updates the Tx write pointer register.
       This function is being called by send() and sendto() function also.

       @param wizdata Pointer buffer to write data
       @param len Data length
       @sa wizchip_recv_data()
    */
    void wizchip_send_data(const uint8_t *wizdata, uint16_t len);

    /**
       It copies data to your buffer from internal RX memory

       @details This function read the Rx read pointer register and after that,
       it copies the received data from internal RX memory
       to <i>wizdata(pointer variable)</i> of the length of <i>len(variable)</i> bytes.
       This function is being called by recv() also.

       @param wizdata Pointer buffer to read data
       @param len Data length
       @sa wizchip_send_data()
    */
    void wizchip_recv_data(uint8_t *wizdata, uint16_t len);

    /**
       It discard the received data in RX memory.
       @details It discards the data of the length of <i>len(variable)</i> bytes in internal RX memory.
       @param len Data length
    */
    void wizchip_recv_ignore(uint16_t len);

    /**
       Get @ref Sn_TX_FSR register
       @return uint16_t. Value of @ref Sn_TX_FSR.
    */
    uint16_t getSn_TX_FSR();

    /**
       Get @ref Sn_RX_RSR register
       @return uint16_t. Value of @ref Sn_RX_RSR.
    */
    uint16_t getSn_RX_RSR();


    /** Common registers */
    enum {
      MR = 0x0000,        ///< Mode Register address (R/W)
      GAR = 0x0001,       ///< Gateway IP Register address (R/W)
      SUBR = 0x0005,      ///< Subnet mask Register address (R/W)
      SHAR = 0x0009,      ///< Source MAC Register address (R/W)
      SIPR = 0x000F,      ///< Source IP Register address (R/W)
      IR = 0x0015,        ///< Interrupt Register (R/W)
      IMR = 0x0016,       ///< Socket Interrupt Mask Register (R/W)
      RTR = 0x0017,       ///< Timeout register address (1 is 100us) (R/W)
      RCR = 0x0019,       ///< Retry count register (R/W)
      RMSR = 0x001A,      ///< Receive Memory Size
      TMSR = 0x001B,      ///< Transmit Memory Size
    };

    /** Socket registers */
    enum {
      Sn_MR = 0x0400,     ///< Socket Mode register(R/W)
      Sn_CR = 0x0401,     ///< Socket command register (R/W)
      Sn_IR = 0x0402,     ///< Socket interrupt register (R)
      Sn_SR = 0x0403,     ///< Socket status register (R)
      Sn_PORT = 0x0404,   ///< Source port register (R/W)
      Sn_DHAR = 0x0406,   ///< Peer MAC register address (R/W)
      Sn_DIPR = 0x040C,   ///< Peer IP register address (R/W)
      Sn_DPORT = 0x0410,  ///< Peer port register address (R/W)
      Sn_MSSR = 0x0412,   ///< Maximum Segment Size(Sn_MSSR0) register address (R/W)
      Sn_PROTO = 0x0414,  ///< IP Protocol(PROTO) Register (R/W)
      Sn_TOS = 0x0415,    ///< IP Type of Service(TOS) Register (R/W)
      Sn_TTL = 0x0416,    ///< IP Time to live(TTL) Register (R/W)
      Sn_TX_FSR = 0x0420, ///< Transmit free memory size register (R)
      Sn_TX_RD = 0x0422,  ///< Transmit memory read pointer register address (R)
      Sn_TX_WR = 0x0424,  ///< Transmit memory write pointer register address (R/W)
      Sn_RX_RSR = 0x0426, ///< Received data size register (R)
      Sn_RX_RD = 0x0428,  ///< Read point of Receive memory (R/W)
      Sn_RX_WR = 0x042A,  ///< Write point of Receive memory (R)
    };

    /** Mode register values */
    enum {
      MR_RST = 0x80,    ///< Reset
      MR_PB = 0x10,     ///< Ping block
      MR_AI = 0x02,     ///< Address Auto-Increment in Indirect Bus Interface
      MR_IND = 0x01,    ///< Indirect Bus Interface mode
    };

    /** Socket Mode Register values @ref Sn_MR */
    enum {
      Sn_MR_CLOSE = 0x00,  ///< Unused socket
      Sn_MR_TCP = 0x01,    ///< TCP
      Sn_MR_UDP = 0x02,    ///< UDP
      Sn_MR_IPRAW = 0x03,  ///< IP LAYER RAW SOCK
      Sn_MR_MACRAW = 0x04, ///< MAC LAYER RAW SOCK
      Sn_MR_ND = 0x20,     ///< No Delayed Ack(TCP) flag
      Sn_MR_MF = 0x40,     ///< Use MAC filter
      Sn_MR_MULTI = 0x80,  ///< support multicating
    };

    /** Socket Command Register values */
    enum {
      Sn_CR_OPEN = 0x01,      ///< Initialise or open socket
      Sn_CR_CLOSE = 0x10,     ///< Close socket
      Sn_CR_SEND = 0x20,      ///< Update TX buffer pointer and send data
      Sn_CR_SEND_MAC = 0x21,  ///< Send data with MAC address, so without ARP process
      Sn_CR_SEND_KEEP = 0x22, ///< Send keep alive message
      Sn_CR_RECV = 0x40,      ///< Update RX buffer pointer and receive data
    };

    /** Socket Interrupt register values */
    enum {
      Sn_IR_CON = 0x01,      ///< CON Interrupt
      Sn_IR_DISCON = 0x02,   ///< DISCON Interrupt
      Sn_IR_RECV = 0x04,     ///< RECV Interrupt
      Sn_IR_TIMEOUT = 0x08,  ///< TIMEOUT Interrupt
      Sn_IR_SENDOK = 0x10,   ///< SEND_OK Interrupt
    };

    /** Socket Status Register values */
    enum {
      SOCK_CLOSED = 0x00,      ///< Closed
      SOCK_INIT = 0x13,        ///< Initiate state
      SOCK_LISTEN = 0x14,      ///< Listen state
      SOCK_SYNSENT = 0x15,     ///< Connection state
      SOCK_SYNRECV = 0x16,     ///< Connection state
      SOCK_ESTABLISHED = 0x17, ///< Success to connect
      SOCK_FIN_WAIT = 0x18,    ///< Closing state
      SOCK_CLOSING = 0x1A,     ///< Closing state
      SOCK_TIME_WAIT = 0x1B,   ///< Closing state
      SOCK_CLOSE_WAIT = 0x1C,  ///< Closing state
      SOCK_LAST_ACK = 0x1D,    ///< Closing state
      SOCK_UDP = 0x22,         ///< UDP socket
      SOCK_IPRAW = 0x32,       ///< IP raw mode socket
      SOCK_MACRAW = 0x42,      ///< MAC raw mode socket
    };

    /**
       Set Mode Register
       @param (uint8_t)mr The value to be set.
       @sa getMR()
    */
    inline void setMR(uint8_t mode) {
      wizchip_write(MR, mode);
    }

    /**
       Get Mode Register
       @return uint8_t. The value of Mode register.
       @sa setMR()
    */
    inline uint8_t getMR() {
      return wizchip_read(MR);
    }

    /**
       Set local MAC address
       @param (uint8_t*)shar Pointer variable to set local MAC address. It should be allocated 6 bytes.
       @sa getSHAR()
    */
    inline void setSHAR(const uint8_t* macaddr) {
      wizchip_write_buf(SHAR, macaddr, 6);
    }

    /**
       Get local MAC address
       @param (uint8_t*)shar Pointer variable to get local MAC address. It should be allocated 6 bytes.
       @sa setSHAR()
    */
    inline void getSHAR(uint8_t* macaddr) {
      wizchip_read_buf(SHAR, macaddr, 6);
    }

    /**
       Get @ref Sn_TX_WR register
       @param (uint16_t)txwr Value to set @ref Sn_TX_WR
       @sa GetSn_TX_WR()
    */
    inline uint16_t getSn_TX_WR() {
      return wizchip_read_word(Sn_TX_WR);
    }

    /**
       Set @ref Sn_TX_WR register
       @param (uint16_t)txwr Value to set @ref Sn_TX_WR
       @sa GetSn_TX_WR()
    */
    inline void setSn_TX_WR(uint16_t txwr) {
      wizchip_write_word(Sn_TX_WR, txwr);
    }

    /**
       Get @ref Sn_RX_RD register
       @regurn uint16_t. Value of @ref Sn_RX_RD.
       @sa setSn_RX_RD()
    */
    inline uint16_t getSn_RX_RD() {
      return wizchip_read_word(Sn_RX_RD);
    }

    /**
       Set @ref Sn_RX_RD register
       @param (uint16_t)rxrd Value to set @ref Sn_RX_RD
       @sa getSn_RX_RD()
    */
    inline void setSn_RX_RD(uint16_t rxrd) {
      wizchip_write_word(Sn_RX_RD, rxrd);
    }

    /**
       Set @ref Sn_MR register
       @param (uint8_t)mr Value to set @ref Sn_MR
       @sa getSn_MR()
    */
    inline void setSn_MR(uint8_t mr) {
      wizchip_write(Sn_MR, mr);
    }

    /**
       Get @ref Sn_MR register
       @return uint8_t. Value of @ref Sn_MR.
       @sa setSn_MR()
    */
    inline uint8_t getSn_MR() {
      return wizchip_read(Sn_MR);
    }

    /**
       Set @ref Sn_CR register, then wait for the command to execute
       @param (uint8_t)cr Value to set @ref Sn_CR
       @sa getSn_CR()
    */
    void setSn_CR(uint8_t cr);

    /**
       Get @ref Sn_CR register
       @return uint8_t. Value of @ref Sn_CR.
       @sa setSn_CR()
    */
    inline uint8_t getSn_CR() {
      return wizchip_read(Sn_CR);
    }

    /**
       Get @ref Sn_SR register
       @return uint8_t. Value of @ref Sn_SR.
    */
    inline uint8_t getSn_SR() {
      return wizchip_read(Sn_SR);
    }

    /**
       Get @ref Sn_IR register
       @return uint8_t. Value of @ref Sn_IR.
       @sa setSn_IR()
    */
    inline uint8_t getSn_IR() {
      return wizchip_read(Sn_IR);
    }

    /**
       Set @ref Sn_IR register
       @param (uint8_t)ir Value to set @ref Sn_IR
       @sa getSn_IR()
    */
    inline void setSn_IR(uint8_t ir) {
      wizchip_write(Sn_IR, ir);
    }
};

#endif // W5100_H



#include <SPI.h>


uint8_t Wiznet5100::wizchip_read(uint16_t address)
{
  uint8_t ret;

  wizchip_cs_select();
  SPI.transfer(0x0F);
  SPI.transfer((address & 0xFF00) >>  8);
  SPI.transfer((address & 0x00FF) >>  0);
  ret = SPI.transfer(0);
  wizchip_cs_deselect();

  return ret;
}

uint16_t Wiznet5100::wizchip_read_word(uint16_t address)
{
  return ((uint16_t)wizchip_read(address) << 8) + wizchip_read(address + 1);
}


void Wiznet5100::wizchip_read_buf(uint16_t address, uint8_t* pBuf, uint16_t len)
{
  for (uint16_t i = 0; i < len; i++)
  {
    pBuf[i] = wizchip_read(address + i);
  }
}

void Wiznet5100::wizchip_write(uint16_t address, uint8_t wb)
{
  wizchip_cs_select();
  SPI.transfer(0xF0);
  SPI.transfer((address & 0xFF00) >>  8);
  SPI.transfer((address & 0x00FF) >>  0);
  SPI.transfer(wb);    // Data write (write 1byte data)
  wizchip_cs_deselect();
}

void Wiznet5100::wizchip_write_word(uint16_t address, uint16_t word)
{
  wizchip_write(address,   (uint8_t)(word >> 8));
  wizchip_write(address + 1, (uint8_t) word);
}

void Wiznet5100::wizchip_write_buf(uint16_t address, const uint8_t* pBuf, uint16_t len)
{
  for (uint16_t i = 0; i < len; i++)
  {
    wizchip_write(address + i, pBuf[i]);
  }
}

void Wiznet5100::setSn_CR(uint8_t cr) {
  // Write the command to the Command Register
  wizchip_write(Sn_CR, cr);

  // Now wait for the command to complete
  while ( wizchip_read(Sn_CR) );
}

uint16_t Wiznet5100::getSn_TX_FSR()
{
  uint16_t val = 0, val1 = 0;
  do
  {
    val1 = wizchip_read_word(Sn_TX_FSR);
    if (val1 != 0)
    {
      val = wizchip_read_word(Sn_TX_FSR);
    }
  } while (val != val1);
  return val;
}


uint16_t Wiznet5100::getSn_RX_RSR()
{
  uint16_t val = 0, val1 = 0;
  do
  {
    val1 = wizchip_read_word(Sn_RX_RSR);
    if (val1 != 0)
    {
      val = wizchip_read_word(Sn_RX_RSR);
    }
  } while (val != val1);
  return val;
}

void Wiznet5100::wizchip_send_data(const uint8_t *wizdata, uint16_t len)
{
  uint16_t ptr;
  uint16_t size;
  uint16_t dst_mask;
  uint16_t dst_ptr;

  ptr = getSn_TX_WR();

  dst_mask = ptr & TxBufferMask;
  dst_ptr = TxBufferAddress + dst_mask;

  if (dst_mask + len > TxBufferLength)
  {
    size = TxBufferLength - dst_mask;
    wizchip_write_buf(dst_ptr, wizdata, size);
    wizdata += size;
    size = len - size;
    dst_ptr = TxBufferAddress;
    wizchip_write_buf(dst_ptr, wizdata, size);
  }
  else
  {
    wizchip_write_buf(dst_ptr, wizdata, len);
  }

  ptr += len;

  setSn_TX_WR(ptr);
}

void Wiznet5100::wizchip_recv_data(uint8_t *wizdata, uint16_t len)
{
  uint16_t ptr;
  uint16_t size;
  uint16_t src_mask;
  uint16_t src_ptr;

  ptr = getSn_RX_RD();

  src_mask = ptr & RxBufferMask;
  src_ptr = RxBufferAddress + src_mask;


  if ( (src_mask + len) > RxBufferLength )
  {
    size = RxBufferLength - src_mask;
    wizchip_read_buf(src_ptr, wizdata, size);
    wizdata += size;
    size = len - size;
    src_ptr = RxBufferAddress;
    wizchip_read_buf(src_ptr, wizdata, size);
  }
  else
  {
    wizchip_read_buf(src_ptr, wizdata, len);
  }

  ptr += len;

  setSn_RX_RD(ptr);
}

void Wiznet5100::wizchip_recv_ignore(uint16_t len)
{
  uint16_t ptr;

  ptr = getSn_RX_RD();
  ptr += len;
  setSn_RX_RD(ptr);
}

void Wiznet5100::wizchip_sw_reset()
{
  setMR(MR_RST);
  getMR(); // for delay

  setSHAR(_mac_address);
}


Wiznet5100::Wiznet5100(int8_t cs)
{
  _cs = cs;
}

boolean Wiznet5100::begin(const uint8_t *mac_address)
{
  memcpy(_mac_address, mac_address, 6);

  pinMode(_cs, OUTPUT);
  wizchip_cs_deselect();

  SPI.begin();
  SPI.setClockDivider(SPI_CLOCK_DIV4); // 4 MHz?
  SPI.setBitOrder(MSBFIRST);
  SPI.setDataMode(SPI_MODE0);

  wizchip_sw_reset();

  // Set the size of the Rx and Tx buffers
  wizchip_write(RMSR, RxBufferSize);
  wizchip_write(TMSR, TxBufferSize);

  // Set our local MAC address
  setSHAR(_mac_address);

  // Open Socket 0 in MACRaw mode
  setSn_MR(Sn_MR_MACRAW);
  setSn_CR(Sn_CR_OPEN);
  if (getSn_SR() != SOCK_MACRAW) {
    // Failed to put socket 0 into MACRaw mode
    return false;
  }

  // Success
  return true;
}

void Wiznet5100::end()
{
  setSn_CR(Sn_CR_CLOSE);

  // clear all interrupt of the socket
  setSn_IR(0xFF);

  // Wait for socket to change to closed
  while (getSn_SR() != SOCK_CLOSED);
}

uint16_t Wiznet5100::readFrame(uint8_t *buffer, uint16_t bufsize)
{
  uint16_t len = getSn_RX_RSR();

  if (len > 0)
  {
    uint8_t head[2];
    uint16_t data_len = 0;

    wizchip_recv_data(head, 2);
    setSn_CR(Sn_CR_RECV);

    data_len = head[0];
    data_len = (data_len << 8) + head[1];
    data_len -= 2;

    if (data_len > bufsize)
    {
      // Packet is bigger than buffer - drop the packet
      wizchip_recv_ignore(data_len);
      setSn_CR(Sn_CR_RECV);
      return 0;
    }

    wizchip_recv_data(buffer, data_len);
    setSn_CR(Sn_CR_RECV);

    // W5100 doesn't have any built-in MAC address filtering
    if ((buffer[0] & 0x01) || memcmp(&buffer[0], _mac_address, 6) == 0)
    {
      // Addressed to an Ethernet multicast address or our unicast address
      return data_len;
    } else {
      return 0;
    }
  }

  return 0;
}

uint16_t Wiznet5100::sendFrame(const uint8_t *buf, uint16_t len)
{
  // Wait for space in the transmit buffer
  while (1)
  {
    uint16_t freesize = getSn_TX_FSR();
    if (getSn_SR() == SOCK_CLOSED) {
      return -1;
    }
    if (len <= freesize) break;
  };

  wizchip_send_data(buf, len);
  setSn_CR(Sn_CR_SEND);

  while (1)
  {
    uint8_t tmp = getSn_IR();
    if (tmp & Sn_IR_SENDOK)
    {
      setSn_IR(Sn_IR_SENDOK);
      // Packet sent ok
      break;
    }
    else if (tmp & Sn_IR_TIMEOUT)
    {
      setSn_IR(Sn_IR_TIMEOUT);
      // There was a timeout
      return -1;
    }
  }

  return len;
}




void printPaddedHex(uint8_t byte)
{
  char str[2];
  str[0] = (byte >> 4) & 0x0f;
  str[1] = byte & 0x0f;

  for (int i = 0; i < 2; i++) {
    // base for converting single digit numbers to ASCII is 48
    // base for 10-16 to become lower-case characters a-f is 87
    if (str[i] > 9) str[i] += 39;
    str[i] += 48;
    Serial.print(str[i]);
  }
}

void printMACAddress(const uint8_t address[6])
{
  for (uint8_t i = 0; i < 6; ++i) {
    printPaddedHex(address[i]);
    if (i < 5)
      Serial.print(':');
  }
  Serial.println();
}



const byte mac_address[] = {
  0xae, 0x03, 0xf3, 0xc7, 0x08, 0x78
};

Wiznet5100 w5100;

void setup() {
  // Setup serial port for debugging
  Serial.begin(115200);
  Serial.println("[W5100MacRaw]");

  w5100.begin(mac_address);
}


uint8_t buffer[800];
uint8_t send_count = 0;


unsigned long previousMillis = 0;
const long interval = 10000;

void loop() {

  uint16_t len = w5100.readFrame(buffer, sizeof(buffer));
  if ( len > 0 ) {
    Serial.print("Len=");
    Serial.println(len, DEC);

    Serial.print("Dest=");
    printMACAddress(&buffer[0]);
    Serial.print("Src=");
    printMACAddress(&buffer[6]);

    // 0x0800 = IPv4
    // 0x0806 = ARP
    // 0x86DD = IPv6
    Serial.print("Type=0x");
    printPaddedHex(buffer[12]);
    printPaddedHex(buffer[13]);
    Serial.println();
    
    Serial.println("BYTES:");
    for (int i = 0; i < len; i++) {
      printPaddedHex(buffer[i]);
      Serial.print(" ");
    }    
    Serial.println();
 
    Serial.print("Byte 15=");
    Serial.println(buffer[15], DEC);

    if (buffer[12] == 0x88 && buffer[13] == 0xB5) {
      Serial.println("ACAO! Acender LED");
    }

    Serial.println();
  }

  unsigned long currentMillis = millis();

  if (currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis;

    for (int i = 0; i < len; i++) {
      buffer[i] = 0xFF;
    }

    //Destino pode ser fixo ou broadcast (0xFF 6 vezes)
    buffer[0] = 0x34;
    buffer[1] = 0x23;
    buffer[2] = 0x87;
    buffer[3] = 0x74;
    buffer[4] = 0xca;
    buffer[5] = 0xf5;
/*
    buffer[0] = 0xFF;
    buffer[1] = 0xFF;
    buffer[2] = 0xFF;
    buffer[3] = 0xFF;
    buffer[4] = 0xFF;
    buffer[5] = 0xFF;
*/
    
    
    memcpy(&buffer[0], &buffer[0], 6);   // Set Destination to Source
    memcpy(&buffer[6], mac_address, 6);  // Set Source to our MAC address
    buffer[14] = send_count++;
    w5100.sendFrame(buffer, len);


  }
}

