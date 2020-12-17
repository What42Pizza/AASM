# AASM
### Advanced Assembly
### V0.1.1

<br />
<br />
<br />

This is supposed to be an advanced assembly language, and it comes in three levels, ranging from low level to high level. Though the execution is very low-level-like, the data stored in variables would be loosely-typed, so very high- level. Variables can hold integers, floats, booleans, strings, tables, functions / code blocks, or null. Tables will also be called arrays when they only contain a complete set of integer keys.

<br />
<br />
<br />
<br />
<br />

## Level 1:

- the keyword "function" acts as a label
- push and pop are for the stack and they're used for functions
- calling a function (as in "Factorial()") is just a JSR to that label
- return just returns from a sub-routine, after pushing a value (or multiple values) to the stack

<br />

```
function Factorial:
	var Num = pop;
	
	if not (Num > 1) jump to 'else';
		push Num - 1;
		Factorial();
		return Num * pop;
	#else:
		return 1;
	// end
	
// end
```

<br />
<br />
<br />

## Level 2:

- there are now code blocks
- Factorial is now a variable instead of a label
- you call use functions in mathematical expressions, and they evaluate to the last value pushed to the stack

<br />

```
function Factorial {
	var Num = pop;
	
	if (Num > 1) {
		push Num - 1;
		return Num * Factorial();
	}; else {
		return 1;
	};
	
};
```

<br />
<br />
<br />

## Level 3:

- functions now have arguments
- code blocks automatically have semicolons added

<br />

```
function Factorial (Num) {
	
	if (Num > 1) {
		return Num * Factorial (Num - 1);
	} else {
		return 1;
	}
	
}
```

<br />
<br />
<br />
<br />
<br />

Started: 11/28/20

Last updated: 12/17/20
