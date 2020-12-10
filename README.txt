Started: 11/28/20
Last updated: 12/10/20



This is supposed to be an advanced assembly language, and it comes in three levels, ranging from low level to high
level. Though the execution is very low-level-like, the data stored in variables would be loosely-types, so very high-
level. Variables can hold integers, floats, booleans, strings, tables, functions / code blocks, enviroments, or null.
Tables will also be called arrays when they only contain a complete set of integer keys.





Level 1:

the keyword "function" acts as a label
push and pop are for the stack and they're used for functions
calling a function (as in "Factorial()") is just a JSR to that label
return just returns from a sub-routine, after pushing a value (or multiple values) to the stack



function Factorial:
	var Num = pop;
	
	if not Num > 1 jump to 'else';
		push Num - 1;
		Factorial();
		return Num * pop;
	#else:
		return 1;
	// end
	
// end








Level 2:

there are now code blocks
Factorial is now a variable instead of a label
you call use functions in mathematical expressions, and they evaluate to the last value pushed to the stack



function Factorial {
	var Num = pop;
	
	if Num > 1 {
		push Num - 1;
		return Num * Factorial();
	}; else {
		return 1;
	};
	
};








Level 3:

functions now have arguments
code blocks automatically have semicolons added



function Factorial (Num) {
	
	if Num > 1 {
		return Num * Factorial (Num - 1);
	} else {
		return 1;
	}
	
}










Factorial function after processing:



Level 1:

#Factorial_F:
var Num = pop;
if Num <= 1 jump to '0_else_0';
push Num - 1;
Factorial(); // adds "_F" when searching for the label
return Num * pop;
#0_else_0:
return 1;



Level 2:

var Factorial = function {
var Num = pop;
if Num > 1 {
push Num - 1;
return Num * Factorial();
};
else {
return 1;
};
};



Level 3:

var Factorial = function (Num) {
if Num > 1 {
return Num * Factorial (Num - 1);
};
else {
return 1;
};
};










Tokens:



Level 1:

#
Factorial_F
var
Num
=
pop
;
if
Num <= 1
jumpto
'0_else_0'
;
push
Num - 1
;
Factorial
()
;
return
Num * pop
;
#0_else_0
return
1
;










Level 2:



block MAIN:

var
Factorial
=
BLOCK_0
;



block 0:

var
Num
=
pop
;
if
Num > 1
BLOCK_1
;
else
BLOCK_2
;



block 1:

push
Num - 1
;
return
Num * Factorial()
;



block 2:

return
1
;










Level 3:



block MAIN:

var
Factorial
=
BLOCK_0
;



block 0:

function
(
Num
)
if
Num > 1
BLOCK_1
;
else
BLOCK_2
;



block 1:
return
Num * Factorial (Num - 1)
;



block 2:
return
1
;