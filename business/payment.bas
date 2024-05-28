
'#sec:Main
''Payment.bas
'' 09/06/2004
''version 1.0
''By Adolfo Leon Sepulveda
''Amortization''s table of loan with monthly payments
''Example:
'' input:
''  Loan : 100000
''  Nro payments: 36
''  Annual Interes Rate: 12
''Output:
''  Amortization Table in Palm Memo Pad"
  declare func payment(loan,MonthInteresRate,NroPayments)
  local pago, capi, Tinte, Tbal, Total
  local loan,  NroPayments, AnnualInteresRate
  local MonthInteresRate, bal, pmt
  local	k

  OPEN "memo:Amortization" FOR OUTPUT AS #1
 
  pago = 0
  capi = 0
  Tinte = 0.0
  Tbal =0.0
  total = 0.0
  Print "Amortization of loan with monthly payments"
  input "Loan: "; loan
  Input "Nro Payments: ";NroPayments
  input "Annual Interes Rate: "; AnnualInteresRate
  AnnualInteresRate = AnnualInteresRate/100
  MonthInteresRate = AnnualInteresRate/12
print "Processing.."
  pmt = payment(loan,MonthInteresRate,NroPayments)
  bal = loan
  print #1,"Amortization of loan with monthly payments"
  print #1, "Mount of loan: $";
  print #1, using "###,###.#";loan
  print #1,"Nro of payments:";
  print #1, using "###"; NroPayments
  print #1,"Month Interes";
  print #1, using "###0.00%"; MonthInteresRate*100

  print #1, "Nro                              Month           "
  print #1, "Pmt  Princ          Int      Pmt              Bal"
  print #1, using "## "; k;
  
  print #1,spc(48);
   print #1, using "###,###";bal

  for k =1 to NroPayments
    Inte = MonthInteresRate * bal
    capi = (pmt-inte)
    bal = bal - capi
    Tinteres = Tinteres + inte
    Tbal  = Tbal + capi
    total = total +  pmt
    print #1, using "### "; k;
    print #1, using "  ###,###"; capi, inte, pmt;
print #1, using "  ###,###";bal
  next k
  print #1,"           ==== ==== ===="
  print #1, using "       ###,###";tbal;
  print #1, using "###,###";tinteres;
 print #1, using "###,###"; total
 print "See results in Amortization of Memo Pad"
  close #1
end

func payment(loan,MonthInteresRate,NroPayments)
local tmp
  tmp = (1 + MonthInteresRate)^NroPayments
  payment = MonthInteresRate * loan * tmp / (tmp - 1)
end
'
