#!/usr/bin/python3
# Symbol Table Implementation

from copy import deepcopy


base_table = None

# Types
class type:
	def __init__(this, name, isbasic, isarray, ispointer, width, elem_type, length):
		this.name = name
		this.isbasic = isbasic
		this.isarray = isarray
		this.ispointer = ispointer
		this.width = width
		this.elem_type = elem_type
		this.length = length
	
	def type_name(this):
		if this.isbasic:
			return this.name
		elif this.isarray:
			return "array of " + this.elem_type.type_name() + ", length " + str(this.length)

class table:
	def __init__(this, prev = None):
		this.hash = {}
		this.width = 0
		this.parent = prev
		this.children = []

	def insert_variable(this, var_type, identifier):
		this.hash[identifier] = {}
		this.hash[identifier]['type'] = var_type
		this.hash[identifier]['category'] = 'variable'

	def insert_temp(this, var_type, identifier):
		if identifier not in this.hash:		
			this.hash[identifier] = {}
			this.hash[identifier]['type'] = var_type
			this.hash[identifier]['category'] = 'temporary'
			return True	
		else:
			return False

	def insert_array(this, var_type, identifier):
		this.hash[identifier] = {}
		this.hash[identifier]['type'] = var_type
		this.hash[identifier]['category'] = 'array'


	# def lookup(this, identifier, table):
	# 	if table == None:
	# 		return None
	# 	v = table.lookup_in_this(identifier)
	# 	if v == None:
	# 		lookup(this, identifier, table.parent)

		

	def insert_function(this, method_name, return_type, param_types, param_num):
		if method_name not in this.hash:
			this.hash[method_name] = {}
			this.hash[method_name]['type'] = return_type
			this.hash[method_name]['category'] = 'function'
			this.hash[method_name]['arg_num'] = param_num
			this.hash[method_name]['arg_types'] = param_types
		

	def lookup_in_this(this, identifier):
		if identifier in this.hash:
			return this.hash[identifier]
		else:
			return None

	def print_symbol_table(this):
		print("")
		for key in this.hash:
			print("NAME: ", key)
			for k in this.hash[key]:
				if k == 'type' and not isinstance(this.hash[key][k], str):
					print(k, ': ', this.hash[key][k].type_name())
				elif k == 'arg_types':
					types = []
					for t in this.hash[key][k]:
						if not isinstance(t, str):
							types.append(t.type_name())
						else:
							types.append(t)
					print(k, ': ', types)
				else:
					print(k, ': ', this.hash[key][k])
			print("")


# A wrapper around the table class to maintain different scopes
class environ:
	def __init__(this):
		this.curr_table = table(None)
		# global temp_count
		# global label_count
		global base_table
		base_table = this.curr_table
		this.label_count = 0
		this.temp_count = 0

	def maketemp(this, temp_type, table):
		success = False
		while not success:
			name = "t"+str(this.temp_count)
			this.temp_count += 1
			success = table.insert_temp(temp_type, name)
		return name


	# Labels
	def newlabel(this):
		label = "L"+str(this.label_count)
		this.label_count += 1
		return label

	def begin_scope(this):
		new_table = table(this.curr_table)
		this.curr_table.children.append(new_table)
		this.curr_table = new_table
		return this.curr_table

	def end_scope(this):
		this.curr_table = this.curr_table.parent

	def insert_variable(this, var_type, identifier):
		this.curr_table.insert_variable(var_type, identifier)

	def insert_temp(this, var_type, identifier):
		this.curr_table.insert_temp(var_type, identifier)

	def insert_array(this, var_type, identifier):
		this.curr_table.insert_array(var_type, identifier)

	def lookup(this, identifier, table):
		if table != None:
			v = table.lookup_in_this(identifier)
			if v == None:
				return this.lookup(identifier, table.parent)
			return v
		else:
			return None

		
	def insert_function(this, method_name, return_type, param_types, param_num):
		this.curr_table.insert_function(method_name, return_type, param_types, param_num)
		
	def lookup_in_this(this, identifier):
		this.curr_table.lookup_in_this(identifier)

	def print_symbol_table(this, t):
		t.print_symbol_table()
		print("----------------")
		for c in t.children:
			this.print_symbol_table(c)
		 




