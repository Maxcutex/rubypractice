class CeaserCipher

    def initialize 
        @stringConvert = ('a'..'z').to_a
    end

    def convertString(inputString,shift_factor)
        arr = inputString.split("")
        arr_result = Array.new 
        newval = ""
        arr.each {
            |item|
            if not @stringConvert.include?(item)
                arr_result.push(item)
            else 
                if item == 'c'
                    newval = 'z'
                elsif item == 'b'
                    newval = 'y'
                elsif item == 'a'
                    newval == 'x'
                else
                 newval =  (item.ord - shift_factor).chr
                end 
                arr_result.push(newval)
            end

        }
        return arr_result
    end 

end