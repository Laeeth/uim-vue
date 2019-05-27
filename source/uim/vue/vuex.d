﻿module uim.vue.vuex;

import uim.vue;

class DVuex {
	this() {}
	this(string name) { this(); _name = name; }

	@private string[string] _name;
	@property O name(this O)(string[string] newName) { _name = newName; return cast(O)this; }
	@property string[string] name() { return _name; }

	@private string[string] _state;
	@property O state(this O)(string[string] newState) { _state = newState; return cast(O)this; }
	@property string[string] state() { return _state; }
	O state(this O)(string name, int value) { return this.state(name, to!string(value)); } 
	O state(this O)(string name, Json value) { return this.state(name, value.toString); } 
	O state(this O)(string name, string[] values) {
		return this.state(name, "["~values.join(",")~"]"); 
	} 
	O state(this O)(string name, Json[] values) {
		string[] results;
		foreach(value; values) { results ~= value.toString; }
		return this.state(name, results); 
	} 

	@private string[string] _getters;
	@property O getters(this O)(string[string] newGetters) { _getters = newGetters; return cast(O)this; }
	@property string[string] getters() { return _getters; }

	@private string[string] _mutations;
	@property O mutations(this O)(string[string] newMutations) { _mutations = newMutations; return cast(O)this; }
	@property string[string] mutations() { return _mutations; }
	
	@private string[string] _actions;
	@property O actions(this O)(string[string] newActions) { _actions = newActions; return cast(O)this; }
	@property string[string] actions() { return _actions; }

	@private string[string] _modules;
	@property O modules(this O)(string[string] newModules) { _modules = newModules; return cast(O)this; }
	@property string[string] modules() { return _modules; }

	bool opEquals(string txt) { return toString == txt; }

	override string toString() {
		string result;
		string[] inner;
		
		if (name) result ~= "const "~name~" = ";
		result ~= "new Vuex.Store({";
		
		if (!_state.empty) inner ~= "state:{"~_state.toJS(true)~"}";
		if (!_getters.empty) inner ~= "getters:{"~_getters.toJS(true)~"}";
		if (!_mutations.empty) inner ~= "mutations:{"~_mutations.toJS(true)~"}";
		if (!_actions.empty) inner ~= "actions:{"~_actions.toJS(true)~"}";
		if (!_modules.empty) inner ~= "modules:{"~_modules.toJS(true)~"}";
		
		return result~inner.join(",")~"});";
	}
}
auto Vuex() { return new DVuex(); }
auto Vuex(string name) { return new DVuex(name); }

unittest {
	auto vuex = Vuex;
	assert(vuex.name("store") == "const store = new Vuex.Store({});");
	assert(vuex.state("today", "'2019-04-22'") == "const store = new Vuex.Store({state:{today:'2019-04-22'}});");
	assert(vuex.state("user", "'uim'") == "const store = new Vuex.Store({state:{today:'2019-04-22',user:'uim'}});");

	assert(Vuex("store").state("today", "'2019-04-22'").state("user", "'uim'") == "const store = new Vuex.Store({state:{today:'2019-04-22',user:'uim'}});");

	vuex = Vuex("store");
	assert(vuex.actions("go", "function(){}") == "const store = new Vuex.Store({actions:{go:function(){}}});");
}
