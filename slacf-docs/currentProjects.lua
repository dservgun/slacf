--- Utility functions
--- Lua wiki..how to import lua libraries?
function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end


-- Global variable.
columns = {" ", "Asphalt", "Diesel", "VaporRemed", "Est. Fuel Oil Output" }

function defaultRecord()
  FOWARecord = {
  inputWeight = 45
  , inputWeightUnit = "Kg"
  , inputDiesel = 3.785
  , inputVaporRemed = 7.57
  , inputUnit = "Liters"
  , outputFuelOil = 40.82
  , ouputUnit = "Liters"
  }
  return FOWARecord
end


-- Input weight in kg
function getFOWARecord(anInputWeight)
  def = defaultRecord()
  defRatio = anInputWeight / def.inputWeight
  def.inputDiesel = def.inputDiesel * defRatio
  def.inputVaporRemed = def.inputVaporRemed * defRatio
  def.inputWeight = anInputWeight
  def.outputFuelOil = def.outputFuelOil * defRatio
  return def
end

function fowaHeader() 
  columnLength = #columns
  for j = 1, columnLength do
    if j < columnLength then
      tex.print (string.format('\\textbf{%s}' , columns[j]))
      tex.print (' & ')
    else
      tex.print (string.format('\\textbf{%s}', columns[j]))
      tex.print ('\\\\\\hline')
    end
  end
end

function litersToGallons(inLiters)
  return (inLiters / 3.785)
end

function gallonsToLiters(inGallons)
  return (inGallons * 3.785)
end

function lbsToKgs(inLbs)
  return (inLbs / 2.205)
end

function kgsTolbs(inKgs)
  return (inKgs * 2.205)
end

function fowaFooter()
  tex.print (string.format ('(Units)'))
  tex.print (' & ')
  tex.print ('(in Kgs.)')
  tex.print (' & ')
  tex.print ('(in Liters)')
  tex.print (' & ')
  tex.print ('(in Liters)')
  tex.print (' & ')
  tex.print ('(in Liters)')
  tex.print (' \\\\ ')

end

function fowaFooterInLbs()
  tex.print (string.format ('(Units)'))
  tex.print (' & ')
  tex.print ('(in Lbs.)')
  tex.print (' & ')
  tex.print ('(in Gals)')
  tex.print (' & ')
  tex.print ('(in Gals)')
  tex.print (' & ')
  tex.print ('(in Gals)')
  tex.print (' \\\\ ')

end



function fowaRowInLbs(rowIndex, anInputWeight)
  
  fowaRowRecord = getFOWARecord(lbsToKgs(anInputWeight))
  tex.print (string.format ('%d', rowIndex))
  tex.print (' & ')
  tex.print (comma_value(string.format ('%.2f', anInputWeight)))
  tex.print (' & ')
  tex.print (comma_value(string.format ('%.2f', litersToGallons(fowaRowRecord.inputDiesel))))
  tex.print (' & ')
  tex.print (comma_value(string.format ('%.2f', litersToGallons(fowaRowRecord.inputVaporRemed))))
  tex.print (' & ')
  tex.print (comma_value(string.format ('%.2f', litersToGallons(fowaRowRecord.outputFuelOil))))
  tex.print (' \\\\ ')
end

function fowaRow(rowIndex, anInputWeight) 
  fowaRowRecord = getFOWARecord(anInputWeight)
  tex.print (string.format ('%d', rowIndex))
  tex.print (' & ')
  tex.print (comma_value(string.format ('%.2f', fowaRowRecord.inputWeight)))
  tex.print (' & ')
  tex.print (comma_value(string.format ('%.2f', fowaRowRecord.inputDiesel)))
  tex.print (' & ')
  tex.print (comma_value(string.format ('%.2f', fowaRowRecord.inputVaporRemed)))
  tex.print (' & ')
  tex.print (comma_value(string.format ('%.2f', fowaRowRecord.outputFuelOil)))
  tex.print (' \\\\ ')
end
  

function fowaTable()
  fowaHeader()
  estimates = {45, 453.9, 1000.0, 10000.0, 25000.00, 50000.0, 100000.0}
  for j = 1, #estimates do
    fowaRow(j, estimates[j])
  end
  tex.print('\\\\\\hline')
  fowaFooter()
end

function fowaTableLbs()
  fowaHeader()
  estimates = {100, 1000, 10000.0, 25000.0, 50000.0, 100000.0}
  for j = 1, #estimates do
    fowaRowInLbs(j, estimates[j])
  end
  tex.print('\\\\\\hline')
  fowaFooterInLbs()
end

function ustHeader() 
  print("Inside ustheader")
  local columns = {"Tank"}
  local columnLength = #columns
  for j = 1, columnLength do
    if j < columnLength then
      tex.print (string.format('\\textbf{%s}' , columns[j]))
      tex.print (' & ')
    else
      tex.print (string.format('\\textbf{%s}', columns[j]))
      tex.print ('\\\\\\hline')
    end
  end

end

function ustRows()
  print ("Inside ustrows")
  local ustTable = {}
  ustTable["8000 gallon UST"] = 2
  ustTable["3000 gallon leaded gasoline"] = 2
  ustTable["2000 gallon leaded gasoline UST"] = 1
  ustTable["1000 gallon kerosene UST"] = 1
  for i, n in pairs(ustTable) do
    tex.print(string.format("\\textbf{%d x %s}", n, i))
    tex.print (' & ')
    tex.print('\\\\\\hline')
  end

end

function ustTables(ignoreMe)
  print "inside usttables"
  ustHeader()
  ustRows()
end