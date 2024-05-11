EscalarProduct
- scalar product
- inner product 


aux[n] collects the pairwise multiplication of elements in both ioput arrays.
lc is a collector var, which basically returns the sum of elements in aux array.

out is constrained to lc, therefore, the circuit verifies that the sum of pairwise mul - inner product - of 2 arrays is correct. 


Decoder 
- returns a bitmask where the 1 is at the inp, if inp is less than w. 

if inp == i, store 1 into out[i]. else store 0.
constraint out[i] to be either 0 or inp == i.

lc sums all the elements in out. 
success is constrained to be either 0 or 1.

therefore, lc should have a max value of 1.

this means the out is essentially the binary representation of some figure [0,0,1,0],
 where there can only be a single 1.


If success/lc is 0, the implication is that inp is larger than the array, since i never takes its value.

decoder() returns a bitmask where the 1 is at the inp, if inp is less than w. 


Multiplexer()


ep is an array of EscalarProduct components.
since ep is of dimension wIn, it has wIn elements of EscalarProduct.

this is setup in the first for loop; where we just load up the components into the array.
we have not yet passed in the inputs for each EscalarProduct.

in the second for loop, we pass in inputs for EscalarProduct.

each element in ep[wIn], is EscalarProduct, and therefore takes in 2 array params, in1[] and in2[]
For ep[j] => EscalarProduct(in1[], in2[])
- in1[k]: assigning the 1st array to be inp[][]
- 


STACK

A stack is a LIFO (Last In, First Out) structure, allowing only top-element operations, whereas an array offers indexed access to its elements,
stack has operrations like: push, pop, and peek

zk cirucit as a stack
- must be fixed size. cos circuits are fixed size
- need a stack pointer. pointer points at the next empty slot; tells you where to put the next item. in the stack.
- pointer increments upwards from 0,1,2...
- 

How do we prove that we have pushed something onto stack?
- signals are immutable. 
- cannot overwrite the initial value of a element in the stack
- cannot say S1 was previoisly 0 and now is 2, cos I pushed 2 onto the stack.

If you are mimicking something stateful, then you need to have a signal for every value the variable took on in the course of the operation.
So if you want to model what happens to a stack over the course of 3 operations, then I need 4 variables. 1 for the initial value, and the rest for each stae operation.

Constraints for SP
- sp must increment by 1: e.g. sp_2 = sp_1 + 1
- new SP cannot exceed max stack size: sp_2 <= 8  [assuming stakc of size 8]

Constraints for state transitions
1) prev. values below SP are unchanged.
-- create checks for the entire stack size, but disable everything above the pointer, by using masking
-- e.g: s_0 ==== s_0` { introduce fn sigma. sigma can be 1 or 0. if 0 it shutsdown the check }  
> use circomlib tempplate for sigma, decoder?

2) old sp location was updated with value [use quinn selector: multiplexer]
-- new stack is the input
-- old stack pointer is the sel/dec.inp
