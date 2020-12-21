# Factorial function after processing:

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

## Level 1:

<br />
<br />
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
<br />
<br />

### Initial cleaning:

```
funation Factorial:
var Num = pop;
if not (Num > 1) jump to (else);
push Num - 1;
Factorial();
return Num * pop;
#else:
return 1;
```

<br />
<br />
<br />

### Split each statement into its own line (no changes for this example)

<br />
<br />
<br />

### Redo certain parts:

```
var 0_Factorial_F = function; // This just sets Factorial to a label
var Num = pop;
if not (Num > 1) jump to (else);
push Num - 1;
0_Factorial_F();
return Num * pop;
var 0_else_0 = function; // This also sets 'else' as a function (aka label)
return 1;
```

<br />
<br />
<br />

### Split each line into tokens:

```

var
0_Factorial_F
=
function
;

var
Num
=
pop
;

if
not
(
Num
>
1
)
jump
to
(
else
)
;

push
Num
-
1
;

0_Factorial_F
(
)
;

return
Num
*
pop
;

var
0_else_0
=
function
;

return
1
;
```

<br />
<br />
<br />

### Reassemble evaluator tokens:

```

var
0_Factorial_F
=
function
;

var
Num
=
pop
;

if
not
(
Num > 1
)
jump
to
(
else
)
;

push
Num - 1
;

0_Factorial_F
(
)
;

return
Num * pop
;

var
0_else_0
=
function
;

return
1
;
```

<br />
<br />
<br />

### Insert get_return-s:

```

var
0_Factorial_F
=
function
;

get-return
pop
;

var
Num
=
V1
;

if
not
(
Num > 1
)
jump
to
(
else
)
;

push
Num - 1
;

0_Factorial_F
(
)
;

get_return
pop
;

return
Num * V1
;

var
0_else_0
=
function
;

return
1
;
```

<br />
<br />
<br />

### Rework label vars:

```

var
0_Factorial_F
=
function 2 // point to line 2
;

var
0_else_0
=
function 9
;

// line 2

get-return
pop
;

var
Num
=
V1
;

if
not
(
Num > 1
)
jump
to
(
else
)
;

push
Num - 1
;

0_Factorial_F
(
)
;

get_return
pop
;

return
Num * V1
;

// line 9

return
1
;
```

<br />
<br />
<br />

### Arrange into instructions:

```
V
0_Factorial_F // Define Factorial and else to be labels to lines 2 and 9
function 2
V
0_else_0
function 9
GR
1 // This defines the number of functions to call; only pop is called so this is 1
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
0_Factorial_F
GR
1
pop // This is a function, but it doesn't just have to be the name of the function. For instance, if you had "return ExampTable.ExampFunction();", this would have GR; 1; ExampleTable.ExampleFunction; R; V1;
R
Num * V1
R
1
```

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

## Level 2:

<br />
<br />
<br />

### Original function:

```
function Factorial {
	var Num = pop;
	
	if (Num > 1) {
		push Num - 1;
		Factorial();
		return Num * pop;
	}; else {
		return 1;
	};
	
};
```

<br />
<br />
<br />

### After initial cleaning:

```
function Factorial {
var Num = pop;
if (Num > 1) {
push Num - 1;
Factorial();
return Num * pop;
};
else {
return 1;
};
};
```

<br />
<br />
<br />

### Split into tokens:

```
function
Factorial
{
var
Num
=
pop
;
if
(
Num
>
1
)
{
push
Num
-
1
;
Factorial
(
)
;
return
Num
*
pop
;
}
;
else
{
return
1
;
}
;
}
;
```

<br />
<br />
<br />

### Redo certain parts:

```
var
Factorial // This is the only thing that's changed
=
function
{
var
Num
=
pop
;
if
(
Num
>
1
)
{
push
Num
-
1
;
Factorial
(
)
;
return
Num
*
pop
;
}
;
else
{
return
1
;
}
;
}
;
```

<br />
<br />
<br />

### Arrange into blocks:

```
block MAIN:

var
Factorial
=
B0 // B[num here] is evulated as a function that points to a certain block
;



block 0:

var
Num
=
pop
;
if
(
Num
>
1
)
B1
;
else
B2
;



block 1:

push
Num
-
1
;
Factorial
(
)
;
return
Num
*
pop
;



block 2:

return
1
;
```

<br />
<br />
<br />

### Reassemble evaluator tokens:

```
block MAIN:

var
Factorial
=
B0
;



block 0:

var
Num
=
pop
;
if
(
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
Factorial
(
)
;
return
Num * pop
;



block 2:

return
1
;
```

<br />
<br />
<br />

### Insert get_return-s:

```
block MAIN:

var
Factorial
=
B0
;



block 0:

get_return
pop
;
var
Num
=
V1
;
if
(
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
Factorial
(
)
;
get-return
pop
;
return
Num * V1
;



block 2:

return
1
;
```

<br />
<br />
<br />

### Arrange into instructions:

```
block MAIN:

V
Factorial
Block 0



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
C
Factorial
GR
1
pop
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
<br />
<br />
<br />
<br />
<br />

## Level 3:

<br />
<br />
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
<br />
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
<br />
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
<br />
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