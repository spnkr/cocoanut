module RapidMotion
	module Inspect
	  module_function
		def snoop(instr_var_name)
			instr_var_name = instr_var_name.to_s
			instr_var_name = "@#{instr_var_name}" if instr_var_name.index("@").nil?
			v = nil
			root_view.childViewControllers.each{|cvc|
				lv = cvc.instance_variable_get(instr_var_name)
				v = lv unless lv.nil?
				break if !v.nil?
			}
			v
		end
	end
end