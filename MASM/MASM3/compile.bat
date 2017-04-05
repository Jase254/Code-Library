set projectName=MASM3
\masm32\bin\ml /c /Zi /Fl /coff String1.asm
\masm32\bin\ml /c /Zi /Fl /coff %projectName%.asm

\masm32\bin\Link /debug /SUBSYSTEM:CONSOLE /ENTRY:_start  /out:%projectName%.exe %projectName%.obj  String1.obj  C:\masm32\lib\kernel32.lib io.obj convutil.obj utility.obj  
%projectName%.exe