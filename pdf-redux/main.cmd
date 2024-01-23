::----------start main.cmd-----------
@Echo off 
CALL function.cmd 10 first 
Echo %_description% - %_number% 

CALL function.cmd 15 second 
Echo %_description% - %_number% 
::----------end main.cmd-------------

