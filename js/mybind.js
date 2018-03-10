
Function.prototype.myBind = function(context){
	var fn = this;
	var bindArgs = Array.prototype.slice.call(arguments, 1);
	return function () {
		var callArgs = Array.prototype.slice.apply(arguments);
		return fn.apply(context, bindArgs.concat(callArgs));
	}
};
