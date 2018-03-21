rem Transforms the 16 bit input into another seemingly psenduo random number
rem in the same range. Every input 16 bit input will generate a different
rem 16 bit output. This is called a Feistel network.
func feistelNet(frame)
  local l = frame band 0xff
  local r = frame rshift 8
  for i = 0 to 8
    let nl = r
    let F = (((r * 11) + (r rshift 5) + 7 * 127) xor r) band 0xff
    r = l xor F
    l = nl
  next i
  return ((r lshift 8) bor l) band 0xffff
end

sub draw_pixels()
  local frame = 0
  local screen_width = 320
  local screen_height = 200
  local t1 = ticks
  local tn
  while 1
    if (frame == 65536) then
      exit loop
    endif
    let fn = feistelNet(frame)
    let x = fn % screen_width
    let y = floor(fn / screen_width)
    if (x < screen_width && y < screen_height) then
      pset x,y,4
    endif
    tn = ticks
    if (tn == t1) then
      
'      delay 1
    endif
    local t1 = tn
    frame++
  wend
end

draw_pixels
