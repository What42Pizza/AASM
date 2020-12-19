# Factorial function after processing:

<br />
<br />
<br />
<br />
<br />

## Level 1:

<br />

### Original function:

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

### After initial cleaning:

```
#Factorial_F:
var Num = pop;
if not (Num > 1) jump to '0_else_0';
push Num - 1;
Factorial(); // adds "_F" when searching for the label
return Num * pop;
#0_else_0:
return 1;
```

<br />

### Split into tokens:

```
[Factorial_F points to here; no labels are left in the tokens]
var
Num
=
pop
;
if not (
Num > 1
) jump to '
0_else_0
'
;
push
Num - 1 // These are kept as the same token so that the interpreter can more easily send it to the evaluator
;
Factorial
()
;
return
Num * pop
;
[0_else_0 points to here]
return
1
;
```

<br />

### Arranged into instructions:

```
[Factorial_F points to here; no labels are left in the tokens]
GR
1
pop
V
Num
V1 // V[num here] is an internal constant that points to the previous GR. This makes it so the evaluator doesn't have to call the interpreter, and the interpreter's ExecuteCode function isn't recursive
BN
Num > 1
0_else_0
P
Num - 1
C
Factorial
GR
1
pop // This is a function, but it doesn't just have to be the name of the function. For instance, if you had "return ExampTable.ExampFunction();", this would have GR; 1; ExampleTable.ExampleFunction; R; V1;
R
Num * V1
[0_else_0 points to here]
R
1
```

<br />
<br />
<br />
<br />
<br />

## Level 2:

<br />

### Original function:

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

### After initial cleaning:

```
var Factorial = function {
var Num = pop;
if (Num > 1) {
push Num - 1;
return Num * Factorial();
};
else {
return 1;
};
};
```

<br />

### Split into tokens:

```
block MAIN:

var
Factorial
=
B0 // B[num here] is an internal constant pointing to a code block
;



block 0:

var
Num
=
pop
;
if (
Num > 1
)
B1
;
else
B2
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
```

<br />

### Arranged into instructions:

```
block MAIN:

V
Factorial
B0



block 0:

GR
1
pop
V
Num
V1
I
Num > 1
B1
E
B2



block 1:

P
Num - 1
GR
1
Factorial
R
Num * V1



block 2:

R
1
```

<br />
<br />
<br />
<br />
<br />

## Level 3:

<br />

### Original function:

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

### After initial cleaning:

```
var Factorial = function (Num) {
if (Num > 1) {
return Num * Factorial (Num - 1);
};
else {
return 1;
};
};
```

<br />

### Split into tokens:

```
block MAIN:

var
Factorial
=
B0
;



block 0:

function (
Num
)
if (
Num > 1
)
B1
;
else
B2
;



block 1:
return
Num * Factorial (Num - 1)
;



block 2:
return
1
;
```

<br />

### Arranged into instructions:

```
block MAIN:

V
Factorial
B0



block 0:

F(
Num
)
I
Num > 1
B1
E
B2



block 1:
GR
1
Factorial
Num - 1 // Args for Factorial
R
Num * V1



block 2:
R
1
```