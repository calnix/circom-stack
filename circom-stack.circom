pragma circom 2.1.6;

include "node_modules/circomlib/circuits/comparators.circom";
include "node_modules/circomlib/circuits/multiplexer.circom";

/*
    verifies stack update by ensuring pointer was updated correctly
    and stack was updated correctly.

    stack max height/depth/number of elements as defined by `height`
*/
template StackEquality(height) {
    signal input previous_state[height];
    signal input old_pointer;
    
    signal input current_state[height];
    signal input current_pointer;

    // constraints for pointer
    // 1. pointer must be incremented by 1 
    current_pointer <== old_pointer + 1;

    // 2. latest pointer cannot exceed height
    signal isLessThan;
    isLessThan <== LessThan(252)([current_pointer, height]);
    isLessThan === 1;

    //Constraints for state transitions
    // 1. check that all values below the old_pointer remain unchanged.
    signal areTheKidsEqual[old_pointer];
    var summation = 0;
    for(var i = 0; i < old_pointer; i++) {
        
        // if equal, 1 is stored in areTheKidsEqual[i]
        areTheKidsEqual[i] <== IsEqual()([current_state[i], previous_state[i]]);
        summation = summation + areTheKidsEqual[i];
    }
    
    // summation must be equal to (old_pointer + 1) if all elements line up
    // verify the equality and contraint it to 1 to ensure tt they are indeed equal.
    signal areAllPriorElementsEqual;
    areAllPriorElementsEqual <== IsEqual()([summation, old_pointer + 1]);
    areAllPriorElementsEqual === 1s;    
    
    // 2. old pointer location was updated with value [use quinn selector: multiplexer]


}