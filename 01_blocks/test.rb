name = 'ben'
proc = Proc.new { puts name } 
name = 'camillo'
proc.call # output: camillo
