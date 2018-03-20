const webPath = "http://smallbasic.github.io/samples/node/"
const lineSpacing = 1.25*txth("Q")
cg = 255

func bn(node, name)
  bn.value = webPath + node + ".bas"
  bn.label = name
  bn.type = "link"
  bn.isExit = true
  bn.x = 2
  bn.y = -lineSpacing
  cg = IFF(cg < 5, 255, cg - 5)
  bn.color = rgb(64,128, cg)
end
color 15,0
print cat(3) + "SmallBASIC featured samples" + cat(0)

dim frm
frm.inputs << bn("5000", "[Android] Stopit")
frm.inputs << bn("5001", "[Android] Silly words")
frm.inputs << bn("1407", "3d rotating cube with message [harixxx]") 'nice one harixxx!
frm.inputs << bn("1613", "NIM [jsalai]")
frm.inputs << bn("1409", "Mastermind [MGA & Johnno]")
frm.inputs << bn("1408", "Trees reflected [B+=MGA]")
frm.inputs << bn("1399", "Fire demo [Harixxx]")  'fixed to work on laptop and my Android both
frm.inputs << bn("1386", "Shuffleboard test [Johnno]")
frm.inputs << bn("1268", "Mandala Life [MGA]")
frm.inputs << bn("1353", "Beziers Autograph Book  [J Vibe & MGA]")
frm.inputs << bn("1346", "Classic Sliding Blocks puzzle")
frm.inputs << bn("1396", "Persian Carpets [Anne Burns]")
frm.inputs << bn("1404", "Bulls and cows [many]")
frm.inputs << bn("1566", "Sierpinski in Space [B+=MGA]")
frm.inputs << bn("1267", "Full Screen Lava  [MGA/John Rodgers]")
frm.inputs << bn("1266", "DuckDuckGo Search  [chrisws]")
frm.inputs << bn("1265", "Charming the Snow Snake  [Peter W & MGA]")
frm.inputs << bn("1406", "Texting [B+=MGA]")
frm.inputs << bn("1264", "Aquarium with plasma fish  [MGA]")
frm.inputs << bn("1275", "Mine Sweeper 4SB  [B+=MGA]")
frm.inputs << bn("1413", "Blushing snowflakes  [many]")
frm.inputs << bn("1334", "Glitter Hopalong [Acorn update]")
frm.inputs << bn("1332", "Factor a Number  [updated FTLK sample]")
frm.inputs << bn("1340", "Rotating Star Mouse Chaser  [tsh73 & MGA]")
frm.inputs << bn("174",  "Sierpinsky forest [B+=MGA]")
frm.inputs << bn("1349", "Boing [B+]")
frm.inputs << bn("1348", "Rock Paper Scissors Lizard Spock Game [B+]")
frm.inputs << bn("1350", "Fireworks [B+]")
frm.inputs << bn("155",  "Hangman v2 [B+ Eric Toft]")
frm.inputs << bn("166",  "Plasma Magnifico")
frm.inputs << bn("1531", "A look at Trig [B+=MGA]")
frm.inputs << bn("144",  "Lakeside")
frm.inputs << bn("1411", "Gray Scale test [shian & MGA]")
frm.inputs << bn("175",  "RGB match and chart [Keijo Koskinen & B+=MGA]")
frm.inputs << bn("170",  "Screen Info [B+=MGA]")
frm.inputs << bn("147",  "Sine Cube [Mennonite & B+]")
frm.inputs << bn("1343", "Guts [J Vibe]")
frm.inputs << bn("146",  "Patterns [Peter W & MGA]")
frm.inputs << bn("168",  "Follow Me [B+=MGA]")
frm.inputs << bn("1157", "S Virjee fractal")
frm.inputs << bn("1383", "Angel Feather [PeterMaria]")
frm.inputs << bn("1389", "Analog Clock [Code Library Update]")
frm.inputs << bn("1574", "000 Getting Started [B+=MGA]")
frm.inputs << bn("1575", "001 3 Ways to PRINT hello 5 times [B+=MGA]")
frm.inputs << bn("1576", "002 Numeric Variables [B+=MGA]")
frm.inputs << bn("1577", "003 Conditional Branching [B+=MGA]")
frm.inputs << bn("1578", "004 Loops [B+=MGA]")
frm.inputs << bn("1579", "005 Challenge [B+=MGA]")
frm.inputs << bn("1580", "006 Arrays+ [B+=MGA]")
frm = form(frm)
while 1
  frm.doEvents()
wend
print ""
