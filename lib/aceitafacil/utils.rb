module Aceitafacil
    class Utils
        def self.format_number(number)
            return sprintf("%0.02f", number.to_f).gsub(".", "").to_i
        end
    end
end