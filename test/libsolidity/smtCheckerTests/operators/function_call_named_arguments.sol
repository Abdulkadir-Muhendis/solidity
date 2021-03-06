pragma experimental SMTChecker;
library L {
	function l(uint x, uint y) internal pure returns (uint) {
		return x + y;
	}
}

contract C {
	function f(uint u, uint s, bool b) internal pure returns (uint z) {
		if (b)
			z = u;
		else
			z = s;
	}

	using L for uint;

	function call() public pure {
		uint a = 2;
		uint b = a.l({y: 3});
		assert(b == 5);
		b = L.l({x: 3, y: 3});
		assert(b == 6);
		b = f({b: true, u: 1, s: 2});
		assert(b == 1);
		b = f({b: false, u: 1, s: 2});
		// Fails, should be 2.
		assert(b == 6);
	}
}
// ----
// Warning 8364: (360-361): Assertion checker does not yet implement type type(library L)
// Warning 6328: (507-521): CHC: Assertion violation happens here.
// Warning 8364: (360-361): Assertion checker does not yet implement type type(library L)
