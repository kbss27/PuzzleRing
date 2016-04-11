(function(t) {
	var e = typeof self == "object" && self.self == self && self
			|| typeof global == "object" && global.global == global && global;
	if (typeof define === "function" && define.amd) {
		define([ "underscore", "jquery", "exports" ], function(i, r, s) {
			e.Backbone = t(e, s, i, r)
		})
	} else if (typeof exports !== "undefined") {
		var i = require("underscore"), r;
		try {
			r = require("jquery")
		} catch (s) {
		}
		t(e, exports, i, r)
	} else {
		e.Backbone = t(e, {}, e._, e.jQuery || e.Zepto || e.ender || e.$)
	}
})
		(function(t, e, i, r) {
			var s = t.Backbone;
			var n = [].slice;
			e.VERSION = "1.2.1";
			e.$ = r;
			e.noConflict = function() {
				t.Backbone = s;
				return this
			};
			e.emulateHTTP = false;
			e.emulateJSON = false;
			var a = function(t, e, r) {
				switch (t) {
				case 1:
					return function() {
						return i[e](this[r])
					};
				case 2:
					return function(t) {
						return i[e](this[r], t)
					};
				case 3:
					return function(t, s) {
						return i[e](this[r], t, s)
					};
				case 4:
					return function(t, s, n) {
						return i[e](this[r], t, s, n)
					};
				default:
					return function() {
						var t = n.call(arguments);
						t.unshift(this[r]);
						return i[e].apply(i, t)
					}
				}
			};
			var o = function(t, e, r) {
				i.each(e, function(e, s) {
					if (i[s])
						t.prototype[s] = a(e, s, r)
				})
			};
			var h = e.Events = {};
			var u = /\s+/;
			var l = function(t, e, r, s, n) {
				var a = 0, o;
				if (r && typeof r === "object") {
					if (s !== void 0 && "context" in n && n.context === void 0)
						n.context = s;
					for (o = i.keys(r); a < o.length; a++) {
						e = t(e, o[a], r[o[a]], n)
					}
				} else if (r && u.test(r)) {
					for (o = r.split(u); a < o.length; a++) {
						e = t(e, o[a], s, n)
					}
				} else {
					e = t(e, r, s, n)
				}
				return e
			};
			h.on = function(t, e, i) {
				return c(this, t, e, i)
			};
			var c = function(t, e, i, r, s) {
				t._events = l(f, t._events || {}, e, i, {
					context : r,
					ctx : t,
					listening : s
				});
				if (s) {
					var n = t._listeners || (t._listeners = {});
					n[s.id] = s
				}
				return t
			};
			h.listenTo = function(t, e, r) {
				if (!t)
					return this;
				var s = t._listenId || (t._listenId = i.uniqueId("l"));
				var n = this._listeningTo || (this._listeningTo = {});
				var a = n[s];
				if (!a) {
					var o = this._listenId
							|| (this._listenId = i.uniqueId("l"));
					a = n[s] = {
						obj : t,
						objId : s,
						id : o,
						listeningTo : n,
						count : 0
					}
				}
				c(t, e, r, this, a);
				return this
			};
			var f = function(t, e, i, r) {
				if (i) {
					var s = t[e] || (t[e] = []);
					var n = r.context, a = r.ctx, o = r.listening;
					if (o)
						o.count++;
					s.push({
						callback : i,
						context : n,
						ctx : n || a,
						listening : o
					})
				}
				return t
			};
			h.off = function(t, e, i) {
				if (!this._events)
					return this;
				this._events = l(d, this._events, t, e, {
					context : i,
					listeners : this._listeners
				});
				return this
			};
			h.stopListening = function(t, e, r) {
				var s = this._listeningTo;
				if (!s)
					return this;
				var n = t ? [ t._listenId ] : i.keys(s);
				for (var a = 0; a < n.length; a++) {
					var o = s[n[a]];
					if (!o)
						break;
					o.obj.off(e, r, this)
				}
				if (i.isEmpty(s))
					this._listeningTo = void 0;
				return this
			};
			var d = function(t, e, r, s) {
				if (!t)
					return;
				var n = 0, a;
				var o = s.context, h = s.listeners;
				if (!e && !r && !o) {
					var u = i.keys(h);
					for (; n < u.length; n++) {
						a = h[u[n]];
						delete h[a.id];
						delete a.listeningTo[a.objId]
					}
					return
				}
				var l = e ? [ e ] : i.keys(t);
				for (; n < l.length; n++) {
					e = l[n];
					var c = t[e];
					if (!c)
						break;
					var f = [];
					for (var d = 0; d < c.length; d++) {
						var v = c[d];
						if (r && r !== v.callback && r !== v.callback._callback
								|| o && o !== v.context) {
							f.push(v)
						} else {
							a = v.listening;
							if (a && --a.count === 0) {
								delete h[a.id];
								delete a.listeningTo[a.objId]
							}
						}
					}
					if (f.length) {
						t[e] = f
					} else {
						delete t[e]
					}
				}
				if (i.size(t))
					return t
			};
			h.once = function(t, e, r) {
				var s = l(v, {}, t, e, i.bind(this.off, this));
				return this.on(s, void 0, r)
			};
			h.listenToOnce = function(t, e, r) {
				var s = l(v, {}, e, r, i.bind(this.stopListening, this, t));
				return this.listenTo(t, s)
			};
			var v = function(t, e, r, s) {
				if (r) {
					var n = t[e] = i.once(function() {
						s(e, n);
						r.apply(this, arguments)
					});
					n._callback = r
				}
				return t
			};
			h.trigger = function(t) {
				if (!this._events)
					return this;
				var e = Math.max(0, arguments.length - 1);
				var i = Array(e);
				for (var r = 0; r < e; r++)
					i[r] = arguments[r + 1];
				l(g, this._events, t, void 0, i);
				return this
			};
			var g = function(t, e, i, r) {
				if (t) {
					var s = t[e];
					var n = t.all;
					if (s && n)
						n = n.slice();
					if (s)
						p(s, r);
					if (n)
						p(n, [ e ].concat(r))
				}
				return t
			};
			var p = function(t, e) {
				var i, r = -1, s = t.length, n = e[0], a = e[1], o = e[2];
				switch (e.length) {
				case 0:
					while (++r < s)
						(i = t[r]).callback.call(i.ctx);
					return;
				case 1:
					while (++r < s)
						(i = t[r]).callback.call(i.ctx, n);
					return;
				case 2:
					while (++r < s)
						(i = t[r]).callback.call(i.ctx, n, a);
					return;
				case 3:
					while (++r < s)
						(i = t[r]).callback.call(i.ctx, n, a, o);
					return;
				default:
					while (++r < s)
						(i = t[r]).callback.apply(i.ctx, e);
					return
				}
			};
			h.bind = h.on;
			h.unbind = h.off;
			i.extend(e, h);
			var m = e.Model = function(t, e) {
				var r = t || {};
				e || (e = {});
				this.cid = i.uniqueId(this.cidPrefix);
				this.attributes = {};
				if (e.collection)
					this.collection = e.collection;
				if (e.parse)
					r = this.parse(r, e) || {};
				r = i.defaults({}, r, i.result(this, "defaults"));
				this.set(r, e);
				this.changed = {};
				this.initialize.apply(this, arguments)
			};
			i.extend(m.prototype, h, {
				changed : null,
				validationError : null,
				idAttribute : "id",
				cidPrefix : "c",
				initialize : function() {
				},
				toJSON : function(t) {
					return i.clone(this.attributes)
				},
				sync : function() {
					return e.sync.apply(this, arguments)
				},
				get : function(t) {
					return this.attributes[t]
				},
				escape : function(t) {
					return i.escape(this.get(t))
				},
				has : function(t) {
					return this.get(t) != null
				},
				matches : function(t) {
					return !!i.iteratee(t, this)(this.attributes)
				},
				set : function(t, e, r) {
					if (t == null)
						return this;
					var s;
					if (typeof t === "object") {
						s = t;
						r = e
					} else {
						(s = {})[t] = e
					}
					r || (r = {});
					if (!this._validate(s, r))
						return false;
					var n = r.unset;
					var a = r.silent;
					var o = [];
					var h = this._changing;
					this._changing = true;
					if (!h) {
						this._previousAttributes = i.clone(this.attributes);
						this.changed = {}
					}
					var u = this.attributes;
					var l = this.changed;
					var c = this._previousAttributes;
					if (this.idAttribute in s)
						this.id = s[this.idAttribute];
					for ( var f in s) {
						e = s[f];
						if (!i.isEqual(u[f], e))
							o.push(f);
						if (!i.isEqual(c[f], e)) {
							l[f] = e
						} else {
							delete l[f]
						}
						n ? delete u[f] : u[f] = e
					}
					if (!a) {
						if (o.length)
							this._pending = r;
						for (var d = 0; d < o.length; d++) {
							this.trigger("change:" + o[d], this, u[o[d]], r)
						}
					}
					if (h)
						return this;
					if (!a) {
						while (this._pending) {
							r = this._pending;
							this._pending = false;
							this.trigger("change", this, r)
						}
					}
					this._pending = false;
					this._changing = false;
					return this
				},
				unset : function(t, e) {
					return this.set(t, void 0, i.extend({}, e, {
						unset : true
					}))
				},
				clear : function(t) {
					var e = {};
					for ( var r in this.attributes)
						e[r] = void 0;
					return this.set(e, i.extend({}, t, {
						unset : true
					}))
				},
				hasChanged : function(t) {
					if (t == null)
						return !i.isEmpty(this.changed);
					return i.has(this.changed, t)
				},
				changedAttributes : function(t) {
					if (!t)
						return this.hasChanged() ? i.clone(this.changed)
								: false;
					var e = this._changing ? this._previousAttributes
							: this.attributes;
					var r = {};
					for ( var s in t) {
						var n = t[s];
						if (i.isEqual(e[s], n))
							continue;
						r[s] = n
					}
					return i.size(r) ? r : false
				},
				previous : function(t) {
					if (t == null || !this._previousAttributes)
						return null;
					return this._previousAttributes[t]
				},
				previousAttributes : function() {
					return i.clone(this._previousAttributes)
				},
				fetch : function(t) {
					t = i.extend({
						parse : true
					}, t);
					var e = this;
					var r = t.success;
					t.success = function(i) {
						var s = t.parse ? e.parse(i, t) : i;
						if (!e.set(s, t))
							return false;
						if (r)
							r.call(t.context, e, i, t);
						e.trigger("sync", e, i, t)
					};
					q(this, t);
					return this.sync("read", this, t)
				},
				save : function(t, e, r) {
					var s;
					if (t == null || typeof t === "object") {
						s = t;
						r = e
					} else {
						(s = {})[t] = e
					}
					r = i.extend({
						validate : true,
						parse : true
					}, r);
					var n = r.wait;
					if (s && !n) {
						if (!this.set(s, r))
							return false
					} else {
						if (!this._validate(s, r))
							return false
					}
					var a = this;
					var o = r.success;
					var h = this.attributes;
					r.success = function(t) {
						a.attributes = h;
						var e = r.parse ? a.parse(t, r) : t;
						if (n)
							e = i.extend({}, s, e);
						if (e && !a.set(e, r))
							return false;
						if (o)
							o.call(r.context, a, t, r);
						a.trigger("sync", a, t, r)
					};
					q(this, r);
					if (s && n)
						this.attributes = i.extend({}, h, s);
					var u = this.isNew() ? "create" : r.patch ? "patch"
							: "update";
					if (u === "patch" && !r.attrs)
						r.attrs = s;
					var l = this.sync(u, this, r);
					this.attributes = h;
					return l
				},
				destroy : function(t) {
					t = t ? i.clone(t) : {};
					var e = this;
					var r = t.success;
					var s = t.wait;
					var n = function() {
						e.stopListening();
						e.trigger("destroy", e, e.collection, t)
					};
					t.success = function(i) {
						if (s)
							n();
						if (r)
							r.call(t.context, e, i, t);
						if (!e.isNew())
							e.trigger("sync", e, i, t)
					};
					var a = false;
					if (this.isNew()) {
						i.defer(t.success)
					} else {
						q(this, t);
						a = this.sync("delete", this, t)
					}
					if (!s)
						n();
					return a
				},
				url : function() {
					var t = i.result(this, "urlRoot")
							|| i.result(this.collection, "url") || M();
					if (this.isNew())
						return t;
					var e = this.get(this.idAttribute);
					return t.replace(/[^\/]$/, "$&/") + encodeURIComponent(e)
				},
				parse : function(t, e) {
					return t
				},
				clone : function() {
					return new this.constructor(this.attributes)
				},
				isNew : function() {
					return !this.has(this.idAttribute)
				},
				isValid : function(t) {
					return this._validate({}, i.defaults({
						validate : true
					}, t))
				},
				_validate : function(t, e) {
					if (!e.validate || !this.validate)
						return true;
					t = i.extend({}, this.attributes, t);
					var r = this.validationError = this.validate(t, e) || null;
					if (!r)
						return true;
					this.trigger("invalid", this, r, i.extend(e, {
						validationError : r
					}));
					return false
				}
			});
			var _ = {
				keys : 1,
				values : 1,
				pairs : 1,
				invert : 1,
				pick : 0,
				omit : 0,
				chain : 1,
				isEmpty : 1
			};
			o(m, _, "attributes");
			var y = e.Collection = function(t, e) {
				e || (e = {});
				if (e.model)
					this.model = e.model;
				if (e.comparator !== void 0)
					this.comparator = e.comparator;
				this._reset();
				this.initialize.apply(this, arguments);
				if (t)
					this.reset(t, i.extend({
						silent : true
					}, e))
			};
			var b = {
				add : true,
				remove : true,
				merge : true
			};
			var x = {
				add : true,
				remove : false
			};
			i.extend(y.prototype, h, {
				model : m,
				initialize : function() {
				},
				toJSON : function(t) {
					return this.map(function(e) {
						return e.toJSON(t)
					})
				},
				sync : function() {
					return e.sync.apply(this, arguments)
				},
				add : function(t, e) {
					return this.set(t, i.extend({
						merge : false
					}, e, x))
				},
				remove : function(t, e) {
					e = i.extend({}, e);
					var r = !i.isArray(t);
					t = r ? [ t ] : i.clone(t);
					var s = this._removeModels(t, e);
					if (!e.silent && s)
						this.trigger("update", this, e);
					return r ? s[0] : s
				},
				set : function(t, e) {
					e = i.defaults({}, e, b);
					if (e.parse && !this._isModel(t))
						t = this.parse(t, e);
					var r = !i.isArray(t);
					t = r ? t ? [ t ] : [] : t.slice();
					var s, n, a, o, h;
					var u = e.at;
					if (u != null)
						u = +u;
					if (u < 0)
						u += this.length + 1;
					var l = this.comparator && u == null && e.sort !== false;
					var c = i.isString(this.comparator) ? this.comparator
							: null;
					var f = [], d = [], v = {};
					var g = e.add, p = e.merge, m = e.remove;
					var _ = !l && g && m ? [] : false;
					var y = false;
					for (var x = 0; x < t.length; x++) {
						a = t[x];
						if (o = this.get(a)) {
							if (m)
								v[o.cid] = true;
							if (p && a !== o) {
								a = this._isModel(a) ? a.attributes : a;
								if (e.parse)
									a = o.parse(a, e);
								o.set(a, e);
								if (l && !h && o.hasChanged(c))
									h = true
							}
							t[x] = o
						} else if (g) {
							n = t[x] = this._prepareModel(a, e);
							if (!n)
								continue;
							f.push(n);
							this._addReference(n, e)
						}
						n = o || n;
						if (!n)
							continue;
						s = this.modelId(n.attributes);
						if (_ && (n.isNew() || !v[s])) {
							_.push(n);
							y = y || !this.models[x]
									|| n.cid !== this.models[x].cid
						}
						v[s] = true
					}
					if (m) {
						for (var x = 0; x < this.length; x++) {
							if (!v[(n = this.models[x]).cid])
								d.push(n)
						}
						if (d.length)
							this._removeModels(d, e)
					}
					if (f.length || y) {
						if (l)
							h = true;
						this.length += f.length;
						if (u != null) {
							for (var x = 0; x < f.length; x++) {
								this.models.splice(u + x, 0, f[x])
							}
						} else {
							if (_)
								this.models.length = 0;
							var w = _ || f;
							for (var x = 0; x < w.length; x++) {
								this.models.push(w[x])
							}
						}
					}
					if (h)
						this.sort({
							silent : true
						});
					if (!e.silent) {
						var E = u != null ? i.clone(e) : e;
						for (var x = 0; x < f.length; x++) {
							if (u != null)
								E.index = u + x;
							(n = f[x]).trigger("add", n, this, E)
						}
						if (h || y)
							this.trigger("sort", this, e);
						if (f.length || d.length)
							this.trigger("update", this, e)
					}
					return r ? t[0] : t
				},
				reset : function(t, e) {
					e = e ? i.clone(e) : {};
					for (var r = 0; r < this.models.length; r++) {
						this._removeReference(this.models[r], e)
					}
					e.previousModels = this.models;
					this._reset();
					t = this.add(t, i.extend({
						silent : true
					}, e));
					if (!e.silent)
						this.trigger("reset", this, e);
					return t
				},
				push : function(t, e) {
					return this.add(t, i.extend({
						at : this.length
					}, e))
				},
				pop : function(t) {
					var e = this.at(this.length - 1);
					return this.remove(e, t)
				},
				unshift : function(t, e) {
					return this.add(t, i.extend({
						at : 0
					}, e))
				},
				shift : function(t) {
					var e = this.at(0);
					return this.remove(e, t)
				},
				slice : function() {
					return n.apply(this.models, arguments)
				},
				get : function(t) {
					if (t == null)
						return void 0;
					var e = this.modelId(this._isModel(t) ? t.attributes : t);
					return this._byId[t] || this._byId[e] || this._byId[t.cid]
				},
				at : function(t) {
					if (t < 0)
						t += this.length;
					return this.models[t]
				},
				where : function(t, e) {
					var r = i.matches(t);
					return this[e ? "find" : "filter"](function(t) {
						return r(t.attributes)
					})
				},
				findWhere : function(t) {
					return this.where(t, true)
				},
				sort : function(t) {
					if (!this.comparator)
						throw new Error(
								"Cannot sort a set without a comparator");
					t || (t = {});
					if (i.isString(this.comparator)
							|| this.comparator.length === 1) {
						this.models = this.sortBy(this.comparator, this)
					} else {
						this.models.sort(i.bind(this.comparator, this))
					}
					if (!t.silent)
						this.trigger("sort", this, t);
					return this
				},
				pluck : function(t) {
					return i.invoke(this.models, "get", t)
				},
				fetch : function(t) {
					t = i.extend({
						parse : true
					}, t);
					var e = t.success;
					var r = this;
					t.success = function(i) {
						var s = t.reset ? "reset" : "set";
						r[s](i, t);
						if (e)
							e.call(t.context, r, i, t);
						r.trigger("sync", r, i, t)
					};
					q(this, t);
					return this.sync("read", this, t)
				},
				create : function(t, e) {
					e = e ? i.clone(e) : {};
					var r = e.wait;
					t = this._prepareModel(t, e);
					if (!t)
						return false;
					if (!r)
						this.add(t, e);
					var s = this;
					var n = e.success;
					e.success = function(t, e, i) {
						if (r)
							s.add(t, i);
						if (n)
							n.call(i.context, t, e, i)
					};
					t.save(null, e);
					return t
				},
				parse : function(t, e) {
					return t
				},
				clone : function() {
					return new this.constructor(this.models, {
						model : this.model,
						comparator : this.comparator
					})
				},
				modelId : function(t) {
					return t[this.model.prototype.idAttribute || "id"]
				},
				_reset : function() {
					this.length = 0;
					this.models = [];
					this._byId = {}
				},
				_prepareModel : function(t, e) {
					if (this._isModel(t)) {
						if (!t.collection)
							t.collection = this;
						return t
					}
					e = e ? i.clone(e) : {};
					e.collection = this;
					var r = new this.model(t, e);
					if (!r.validationError)
						return r;
					this.trigger("invalid", this, r.validationError, e);
					return false
				},
				_removeModels : function(t, e) {
					var i = [];
					for (var r = 0; r < t.length; r++) {
						var s = this.get(t[r]);
						if (!s)
							continue;
						var n = this.indexOf(s);
						this.models.splice(n, 1);
						this.length--;
						if (!e.silent) {
							e.index = n;
							s.trigger("remove", s, this, e)
						}
						i.push(s);
						this._removeReference(s, e)
					}
					return i.length ? i : false
				},
				_isModel : function(t) {
					return t instanceof m
				},
				_addReference : function(t, e) {
					this._byId[t.cid] = t;
					var i = this.modelId(t.attributes);
					if (i != null)
						this._byId[i] = t;
					t.on("all", this._onModelEvent, this)
				},
				_removeReference : function(t, e) {
					delete this._byId[t.cid];
					var i = this.modelId(t.attributes);
					if (i != null)
						delete this._byId[i];
					if (this === t.collection)
						delete t.collection;
					t.off("all", this._onModelEvent, this)
				},
				_onModelEvent : function(t, e, i, r) {
					if ((t === "add" || t === "remove") && i !== this)
						return;
					if (t === "destroy")
						this.remove(e, r);
					if (t === "change") {
						var s = this.modelId(e.previousAttributes());
						var n = this.modelId(e.attributes);
						if (s !== n) {
							if (s != null)
								delete this._byId[s];
							if (n != null)
								this._byId[n] = e
						}
					}
					this.trigger.apply(this, arguments)
				}
			});
			var w = {
				forEach : 3,
				each : 3,
				map : 3,
				collect : 3,
				reduce : 4,
				foldl : 4,
				inject : 4,
				reduceRight : 4,
				foldr : 4,
				find : 3,
				detect : 3,
				filter : 3,
				select : 3,
				reject : 3,
				every : 3,
				all : 3,
				some : 3,
				any : 3,
				include : 2,
				contains : 2,
				invoke : 0,
				max : 3,
				min : 3,
				toArray : 1,
				size : 1,
				first : 3,
				head : 3,
				take : 3,
				initial : 3,
				rest : 3,
				tail : 3,
				drop : 3,
				last : 3,
				without : 0,
				difference : 0,
				indexOf : 3,
				shuffle : 1,
				lastIndexOf : 3,
				isEmpty : 1,
				chain : 1,
				sample : 3,
				partition : 3
			};
			o(y, w, "models");
			var E = [ "groupBy", "countBy", "sortBy", "indexBy" ];
			i.each(E, function(t) {
				if (!i[t])
					return;
				y.prototype[t] = function(e, r) {
					var s = i.isFunction(e) ? e : function(t) {
						return t.get(e)
					};
					return i[t](this.models, s, r)
				}
			});
			var k = e.View = function(t) {
				this.cid = i.uniqueId("view");
				i.extend(this, i.pick(t, I));
				this._ensureElement();
				this.initialize.apply(this, arguments)
			};
			var S = /^(\S+)\s*(.*)$/;
			var I = [ "model", "collection", "el", "id", "attributes",
					"className", "tagName", "events" ];
			i.extend(k.prototype, h, {
				tagName : "div",
				$ : function(t) {
					return this.$el.find(t)
				},
				initialize : function() {
				},
				render : function() {
					return this
				},
				remove : function() {
					this._removeElement();
					this.stopListening();
					return this
				},
				_removeElement : function() {
					this.$el.remove()
				},
				setElement : function(t) {
					this.undelegateEvents();
					this._setElement(t);
					this.delegateEvents();
					return this
				},
				_setElement : function(t) {
					this.$el = t instanceof e.$ ? t : e.$(t);
					this.el = this.$el[0]
				},
				delegateEvents : function(t) {
					t || (t = i.result(this, "events"));
					if (!t)
						return this;
					this.undelegateEvents();
					for ( var e in t) {
						var r = t[e];
						if (!i.isFunction(r))
							r = this[r];
						if (!r)
							continue;
						var s = e.match(S);
						this.delegate(s[1], s[2], i.bind(r, this))
					}
					return this
				},
				delegate : function(t, e, i) {
					this.$el.on(t + ".delegateEvents" + this.cid, e, i);
					return this
				},
				undelegateEvents : function() {
					if (this.$el)
						this.$el.off(".delegateEvents" + this.cid);
					return this
				},
				undelegate : function(t, e, i) {
					this.$el.off(t + ".delegateEvents" + this.cid, e, i);
					return this
				},
				_createElement : function(t) {
					return document.createElement(t)
				},
				_ensureElement : function() {
					if (!this.el) {
						var t = i.extend({}, i.result(this, "attributes"));
						if (this.id)
							t.id = i.result(this, "id");
						if (this.className)
							t["class"] = i.result(this, "className");
						this.setElement(this._createElement(i.result(this,
								"tagName")));
						this._setAttributes(t)
					} else {
						this.setElement(i.result(this, "el"))
					}
				},
				_setAttributes : function(t) {
					this.$el.attr(t)
				}
			});
			e.sync = function(t, r, s) {
				var n = T[t];
				i.defaults(s || (s = {}), {
					emulateHTTP : e.emulateHTTP,
					emulateJSON : e.emulateJSON
				});
				var a = {
					type : n,
					dataType : "json"
				};
				if (!s.url) {
					a.url = i.result(r, "url") || M()
				}
				if (s.data == null && r
						&& (t === "create" || t === "update" || t === "patch")) {
					a.contentType = "application/json";
					a.data = JSON.stringify(s.attrs || r.toJSON(s))
				}
				if (s.emulateJSON) {
					a.contentType = "application/x-www-form-urlencoded";
					a.data = a.data ? {
						model : a.data
					} : {}
				}
				if (s.emulateHTTP
						&& (n === "PUT" || n === "DELETE" || n === "PATCH")) {
					a.type = "POST";
					if (s.emulateJSON)
						a.data._method = n;
					var o = s.beforeSend;
					s.beforeSend = function(t) {
						t.setRequestHeader("X-HTTP-Method-Override", n);
						if (o)
							return o.apply(this, arguments)
					}
				}
				if (a.type !== "GET" && !s.emulateJSON) {
					a.processData = false
				}
				var h = s.error;
				s.error = function(t, e, i) {
					s.textStatus = e;
					s.errorThrown = i;
					if (h)
						h.call(s.context, t, e, i)
				};
				var u = s.xhr = e.ajax(i.extend(a, s));
				r.trigger("request", r, u, s);
				return u
			};
			var T = {
				create : "POST",
				update : "PUT",
				patch : "PATCH",
				"delete" : "DELETE",
				read : "GET"
			};
			e.ajax = function() {
				return e.$.ajax.apply(e.$, arguments)
			};
			var P = e.Router = function(t) {
				t || (t = {});
				if (t.routes)
					this.routes = t.routes;
				this._bindRoutes();
				this.initialize.apply(this, arguments)
			};
			var H = /\((.*?)\)/g;
			var $ = /(\(\?)?:\w+/g;
			var A = /\*\w+/g;
			var C = /[\-{}\[\]+?.,\\\^$|#\s]/g;
			i.extend(P.prototype, h, {
				initialize : function() {
				},
				route : function(t, r, s) {
					if (!i.isRegExp(t))
						t = this._routeToRegExp(t);
					if (i.isFunction(r)) {
						s = r;
						r = ""
					}
					if (!s)
						s = this[r];
					var n = this;
					e.history.route(t, function(i) {
						var a = n._extractParameters(t, i);
						if (n.execute(s, a, r) !== false) {
							n.trigger.apply(n, [ "route:" + r ].concat(a));
							n.trigger("route", r, a);
							e.history.trigger("route", n, r, a)
						}
					});
					return this
				},
				execute : function(t, e, i) {
					if (t)
						t.apply(this, e)
				},
				navigate : function(t, i) {
					e.history.navigate(t, i);
					return this
				},
				_bindRoutes : function() {
					if (!this.routes)
						return;
					this.routes = i.result(this, "routes");
					var t, e = i.keys(this.routes);
					while ((t = e.pop()) != null) {
						this.route(t, this.routes[t])
					}
				},
				_routeToRegExp : function(t) {
					t = t.replace(C, "\\$&").replace(H, "(?:$1)?").replace($,
							function(t, e) {
								return e ? t : "([^/?]+)"
							}).replace(A, "([^?]*?)");
					return new RegExp("^" + t + "(?:\\?([\\s\\S]*))?$")
				},
				_extractParameters : function(t, e) {
					var r = t.exec(e).slice(1);
					return i.map(r, function(t, e) {
						if (e === r.length - 1)
							return t || null;
						return t ? decodeURIComponent(t) : null
					})
				}
			});
			var N = e.History = function() {
				this.handlers = [];
				i.bindAll(this, "checkUrl");
				if (typeof window !== "undefined") {
					this.location = window.location;
					this.history = window.history
				}
			};
			var R = /^[#\/]|\s+$/g;
			var j = /^\/+|\/+$/g;
			var O = /#.*$/;
			N.started = false;
			i
					.extend(
							N.prototype,
							h,
							{
								interval : 50,
								atRoot : function() {
									var t = this.location.pathname.replace(
											/[^\/]$/, "$&/");
									return t === this.root && !this.getSearch()
								},
								matchRoot : function() {
									var t = this
											.decodeFragment(this.location.pathname);
									var e = t.slice(0, this.root.length - 1)
											+ "/";
									return e === this.root
								},
								decodeFragment : function(t) {
									return decodeURI(t.replace(/%25/g, "%2525"))
								},
								getSearch : function() {
									var t = this.location.href.replace(/#.*/,
											"").match(/\?.+/);
									return t ? t[0] : ""
								},
								getHash : function(t) {
									var e = (t || this).location.href
											.match(/#(.*)$/);
									return e ? e[1] : ""
								},
								getPath : function() {
									var t = this.decodeFragment(
											this.location.pathname
													+ this.getSearch()).slice(
											this.root.length - 1);
									return t.charAt(0) === "/" ? t.slice(1) : t
								},
								getFragment : function(t) {
									if (t == null) {
										if (this._usePushState
												|| !this._wantsHashChange) {
											t = this.getPath()
										} else {
											t = this.getHash()
										}
									}
									return t.replace(R, "")
								},
								start : function(t) {
									if (N.started)
										throw new Error(
												"Backbone.history has already been started");
									N.started = true;
									this.options = i.extend({
										root : "/"
									}, this.options, t);
									this.root = this.options.root;
									this._wantsHashChange = this.options.hashChange !== false;
									this._hasHashChange = "onhashchange" in window;
									this._useHashChange = this._wantsHashChange
											&& this._hasHashChange;
									this._wantsPushState = !!this.options.pushState;
									this._hasPushState = !!(this.history && this.history.pushState);
									this._usePushState = this._wantsPushState
											&& this._hasPushState;
									this.fragment = this.getFragment();
									this.root = ("/" + this.root + "/")
											.replace(j, "/");
									if (this._wantsHashChange
											&& this._wantsPushState) {
										if (!this._hasPushState
												&& !this.atRoot()) {
											var e = this.root.slice(0, -1)
													|| "/";
											this.location.replace(e + "#"
													+ this.getPath());
											return true
										} else if (this._hasPushState
												&& this.atRoot()) {
											this.navigate(this.getHash(), {
												replace : true
											})
										}
									}
									if (!this._hasHashChange
											&& this._wantsHashChange
											&& !this._usePushState) {
										this.iframe = document
												.createElement("iframe");
										this.iframe.src = "javascript:0";
										this.iframe.style.display = "none";
										this.iframe.tabIndex = -1;
										var r = document.body;
										var s = r.insertBefore(this.iframe,
												r.firstChild).contentWindow;
										s.document.open();
										s.document.close();
										s.location.hash = "#" + this.fragment
									}
									var n = window.addEventListener
											|| function(t, e) {
												return attachEvent("on" + t, e)
											};
									if (this._usePushState) {
										n("popstate", this.checkUrl, false)
									} else if (this._useHashChange
											&& !this.iframe) {
										n("hashchange", this.checkUrl, false)
									} else if (this._wantsHashChange) {
										this._checkUrlInterval = setInterval(
												this.checkUrl, this.interval)
									}
									if (!this.options.silent)
										return this.loadUrl()
								},
								stop : function() {
									var t = window.removeEventListener
											|| function(t, e) {
												return detachEvent("on" + t, e)
											};
									if (this._usePushState) {
										t("popstate", this.checkUrl, false)
									} else if (this._useHashChange
											&& !this.iframe) {
										t("hashchange", this.checkUrl, false)
									}
									if (this.iframe) {
										document.body.removeChild(this.iframe);
										this.iframe = null
									}
									if (this._checkUrlInterval)
										clearInterval(this._checkUrlInterval);
									N.started = false
								},
								route : function(t, e) {
									this.handlers.unshift({
										route : t,
										callback : e
									})
								},
								checkUrl : function(t) {
									var e = this.getFragment();
									if (e === this.fragment && this.iframe) {
										e = this
												.getHash(this.iframe.contentWindow)
									}
									if (e === this.fragment)
										return false;
									if (this.iframe)
										this.navigate(e);
									this.loadUrl()
								},
								loadUrl : function(t) {
									if (!this.matchRoot())
										return false;
									t = this.fragment = this.getFragment(t);
									return i.any(this.handlers, function(e) {
										if (e.route.test(t)) {
											e.callback(t);
											return true
										}
									})
								},
								navigate : function(t, e) {
									if (!N.started)
										return false;
									if (!e || e === true)
										e = {
											trigger : !!e
										};
									t = this.getFragment(t || "");
									var i = this.root;
									if (t === "" || t.charAt(0) === "?") {
										i = i.slice(0, -1) || "/"
									}
									var r = i + t;
									t = this.decodeFragment(t.replace(O, ""));
									if (this.fragment === t)
										return;
									this.fragment = t;
									if (this._usePushState) {
										this.history[e.replace ? "replaceState"
												: "pushState"]({},
												document.title, r)
									} else if (this._wantsHashChange) {
										this._updateHash(this.location, t,
												e.replace);
										if (this.iframe
												&& t !== this
														.getHash(this.iframe.contentWindow)) {
											var s = this.iframe.contentWindow;
											if (!e.replace) {
												s.document.open();
												s.document.close()
											}
											this._updateHash(s.location, t,
													e.replace)
										}
									} else {
										return this.location.assign(r)
									}
									if (e.trigger)
										return this.loadUrl(t)
								},
								_updateHash : function(t, e, i) {
									if (i) {
										var r = t.href.replace(
												/(javascript:|#).*$/, "");
										t.replace(r + "#" + e)
									} else {
										t.hash = "#" + e
									}
								}
							});
			e.history = new N;
			var U = function(t, e) {
				var r = this;
				var s;
				if (t && i.has(t, "constructor")) {
					s = t.constructor
				} else {
					s = function() {
						return r.apply(this, arguments)
					}
				}
				i.extend(s, r, e);
				var n = function() {
					this.constructor = s
				};
				n.prototype = r.prototype;
				s.prototype = new n;
				if (t)
					i.extend(s.prototype, t);
				s.__super__ = r.prototype;
				return s
			};
			m.extend = y.extend = P.extend = k.extend = N.extend = U;
			var M = function() {
				throw new Error(
						'A "url" property or function must be specified')
			};
			var q = function(t, e) {
				var i = e.error;
				e.error = function(r) {
					if (i)
						i.call(e.context, t, r, e);
					t.trigger("error", t, r, e)
				}
			};
			return e
		});
//# sourceMappingURL=backbone-min.map