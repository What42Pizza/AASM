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
V
Num
pop
BN
Num > 1
0_else_0
P
Num - 1
C
Factorial
R
Num * pop
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
BLOCK_0
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
```

<br />

### Arranged into instructions:

```
block MAIN:

V
Factorial
BLOCK_0



block 0:

V
Num
pop
I
Num > 1
BLOCK_1
E
BLOCK_2



block 1:

P
Num - 1
R
Num * Factorial()



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
BLOCK_0
;



block 0:

function (
Num
)
if (
Num > 1
)
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
```

<br />

### Arranged into instructions:

```
block MAIN:

V
Factorial
BLOCK_0



block 0:

F(
Num
)
I
Num > 1
BLOCK_1
E
BLOCK_2



block 1:
R
Num * Factorial (Num - 1)



block 2:
R
1
```