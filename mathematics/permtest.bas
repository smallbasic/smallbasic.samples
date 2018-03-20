
''Small BASIC code for a two-sample permutation test
''Based on QB code I found on my hard drive

cls
? "Permutation Test for Two Independent Samples"
?
input "What is the size (N) of the first sample:  ", m
input "What is the size (N) of the second sample: ", n
?
mn = m + n

dim x(1 to mn), index(1 to mn)
? "Enter the data for group 1 (one datum at a time)."
For i = 1 to m
  print "Group 1 No. ";i; " = ";
  input x(i)
next i

? "Enter the data for group 2 (one datum at a time)."
For i = 1 to n
  print "Group 2 No. ";i; " = ";
  input x(m + i)
next i

''Get totals and set indexes

total = sum(x)

for i=1 to mn
  tot2 = tot2 + x(i)
  if i = m then crit1 = tot2
  index(i)=i
next i

nperm = 1 '' # of permutations
uppertail = 1  '' # in uppertail


label loop1
  i=m
  label loop2
    if index(i)=mn then
      i=i-1
      if i=0 then
        goto Findings
      else
        goto loop2
      end if
    end if
    index(i) = index(i) + 1
    if i < m then   ''get next element of permutation
      i = i + 1
      index(i) = index(i-1)
      goto loop2
    else  ''evaluate current sum
      nperm = nperm + 1
      tot1 = 0
      for i = 1 to m
        tot1 = tot1 + x(index(i))
        ''? index(i); " ";  ''**************************
      next i
      if tot1 >= crit1 then
        uppertail = uppertail + 1
      end if
      goto loop1
    end if
    
''computation done, print results   
label Findings
'' cls  ***********************************************
? 
? "               PERMUTATION TEST"
? "      Group:      1               2" 
? using "Sample Size:   ####            ####";m,n
? using "Sample Sums: #######.##      #######.##"; crit1, total-crit1
? using "Number of Sums >= Group 1 Sum: ##### out of ######### sums."; uppertail, nperm
? using "Upper Tail Probability = #.######"; uppertail/nperm

end



