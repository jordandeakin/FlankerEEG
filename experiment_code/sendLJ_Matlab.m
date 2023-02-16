% % Basic command/response example using MATLAB, .NET and the UD driver.
% %
% % support@labjack.com
% %
% 
%  
%  
% 4.3.5 - Digital I/O
% There are eight IOTypes used to write or read digital I/O information:
% 
% LJ_ioGET_DIGITAL_BIT         //Also sets direction to input.
% LJ_ioGET_DIGITAL_BIT_DIR
% LJ_ioGET_DIGITAL_BIT_STATE
% LJ_ioGET_DIGITAL_PORT        //Also sets directions to input.  x1 is number of bits.
% LJ_ioGET_DIGITAL_PORT_DIR    //x1 is number of bits.
% LJ_ioGET_DIGITAL_PORT_STATE  //x1 is number of bits.
% 
% LJ_ioPUT_DIGITAL_BIT         //Also sets direction to output.
% LJ_ioPUT_DIGITAL_PORT        //Also sets directions to output.  x1 is number of bits.
% DIR is short for direction. 0=input and 1=output.
% 
% The general bit and port IOTypes automatically control direction, but the _DIR and _STATE ones do not. These can be used to read the current condition of digital I/O without changing the current condition. Note that the _STATE reads are actually doing a read using the input circuitry, not reading the state value last written. When you use LJ_ioGET_DIGITAL_BIT_STATE or LJ_ioGET_DIGITAL_PORT_STATE on a line set to output, it leaves it set as output, but it is doing an actual state read based on the voltage(s) on the pin(s). So if you set a line to output-high, but then something external is driving it low, it might read low.
% 
% When a request is done with one of the port IOTypes, the Channel parameter is used to specify the starting bit number, and the x1 parameter is used to specify the number of applicable bits. The bit numbers corresponding to different I/O are:
% 
% 0-7    FIO0-FIO7
% 8-15   EIO0-EIO7
% 16-19  CIO0-CIO3
% Note that the GetResult function does not have an x1 parameter. That means that if two (or more) port requests are added with the same IOType and Channel, but different x1, the result retrieved by GetResult would be undefined. The GetFirstResult/GetNextResult commands do have the x1 parameter, and thus can handle retrieving responses from multiple port requests with the same IOType and Channel.
% 
% Following is example pseudocode for various digital I/O operations:
% 
% //Execute the pin_configuration_reset IOType so that all
% //pin assignments are in the factory default condition.
% //The ePut function is used, which combines the add/go/get. 
% ePut (lngHandle, LJ_ioPIN_CONFIGURATION_RESET, 0, 0, 0);
% 
% 
% //Now, an add/go/get block to execute multiple requests.
% 
% //Request a read from FIO2.
% AddRequest (lngHandle, LJ_ioGET_DIGITAL_BIT, 2, 0, 0, 0);
% 
% //Request a read from FIO4-EIO5 (10-bits starting
% //from digital channel #4).
% AddRequest (lngHandle, LJ_ioGET_DIGITAL_PORT, 4, 0, 10, 0);
% 
% //Set FIO3 to output-high.
% AddRequest (lngHandle, LJ_ioPUT_DIGITAL_BIT, 3, 1, 0, 0);
% 
% //Set EIO6-CIO2 (5-bits starting from digital channel #14)
% //to b10100 (=d20).  That is EIO6=0, EIO7=0, CIO0=1,
% //CIO1=0, and CIO2=1.
% AddRequest (lngHandle, LJ_ioPUT_DIGITAL_PORT, 14, 20, 5, 0);
% 
% //Execute the requests.
% GoOne (lngHandle);
% 
% //Get the FIO2 read.
% GetResult (lngHandle, LJ_ioGET_DIGITAL_BIT, 2, &dblValue);
% 
% //Get the FIO4-EIO5 read.
% GetResult (lngHandle, LJ_ioGET_DIGITAL_PORT, 4, &dblValue);

 function [e] = sendLJ_Matlab(L,ecode,duration)

 % L Labjack object
 % ecode trigger to send, in decimal
 % duration sleep time between the trigger and bringing it back to zero
 
 % From https://labjack.com/support/datasheets/u3/high-level-driver/example-pseudocode/dio
 %   When a request is done with one of the port IOTypes, the Channel
 %   parameter is used to specify the starting bit number, and the x1
 %   parameter is used to specify the number of applicable bits. The bit
 %   numbers corresponding to different I/O are:
 
 % 0-7    FIO0-FIO7
 % 8-15   EIO0-EIO7
 % 16-19  CIO0-CIO3
 
 if nargin < 3, duration = .002; end %2ms
 
 startChan   = 0;
 nbits       = 8; % could this be changed to 16? 9 to 15 are not read by the EEG system
 
 % send trigger 
 L.ljudObj.AddRequest (L.ljhandle, LabJack.LabJackUD.IO.PUT_DIGITAL_PORT, startChan, ecode, nbits, 0);
 L.ljudObj.GoOne (L.ljhandle);

WaitSecs(duration);

% reset pins to zero
L.ljudObj.AddRequest (L.ljhandle, LabJack.LabJackUD.IO.PUT_DIGITAL_PORT, startChan, 0, nbits, 0);
L.ljudObj.GoOne (L.ljhandle);


end
