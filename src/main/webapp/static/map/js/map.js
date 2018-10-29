define("map/js/suggest", function(require, t) {
	return function(e, a, n) {
		String.trim || (String.prototype.trim = function() {
			for (var t = this, t = t.replace(/^\s\s*/, ""), e = /\s/, a = t.length; e.test(t.charAt(--a)););
			return t.slice(0, a + 1)
		}), String.replaceTpl || (String.prototype.replaceTpl = function(t) {
			return this.replace(/#\{([^}]*)\}/gm, function(e, a) {
				return e = t[a.trim()]
			})
		}), String.htmlEncode || (String.prototype.htmlEncode = function() {
			return String(this).replace(/\x26/g, "&amp;").replace(/\x3c/g, "&lt;").replace(/\x3E/g, "&gt;").replace(/\x22/g, "&quot;").replace(/\x27/g, "&#39;").replace(/\xA9/g, "&copy;")
		});
		var i = " ",
			o = null,
			r = /<[^>]+>/g,
			l = document.documentElement.classList !== n,
			s = /\w/.test("İ"),
			c = s && !e.XMLHttpRequest,
			u = a.documentMode && 9 === a.documentMode,
			d = function(t) {
				if (t) {
					var e, a = t.split("."),
						n = a.length,
						i = window,
						o = 0;
					if (n > 1) for (; n - 1 > o; o++) e = a[o], i = 0 === o && i[e] ? i[e] : e in i ? i[e] : i[e] = {};
					return i
				}
			},
			m = l ?
		function(t, e) {
			return t.classList.contains(e)
		} : function(t, e) {
			return -1 < (i + t.className + i).indexOf(i + e + i)
		}, f = l ?
		function(t, e) {
			t.classList.add(e)
		} : function(t, e) {
			m(t, e) || (t.className += (t.className ? i : "") + e)
		}, p = l ?
		function(t, e) {
			t.classList.remove(e)
		} : function(t, e) {
			if (m(t, e)) {
				var a = new RegExp("(\\s|^)" + e + "(\\s|$)");
				t.className = t.className.replace(a, i)
			}
		}, h = a.addEventListener ?
		function(t, e, a) {
			t.addEventListener(e, a, !1)
		} : function(t, e, a) {
			t.attachEvent("on" + e, a)
		}, g = function(t, a, n) {
			h(t, a, function(t) {
				t = t || e.event;
				var a = t.srcElement || t.target;
				n.call(a, t)
			})
		}, b = s ?
		function(t, e) {
			return e = e.replace(/\-(\w)/g, function(t, e) {
				return e.toUpperCase()
			}), t.currentStyle[e]
		} : function(t, e) {
			return a.defaultView.getComputedStyle(t, null).getPropertyValue(e)
		}, _ = function(t, e) {
			if (!(this instanceof _)) return new _(t, e);
			var i = this;
			i.el = t + "" === t ? a.getElementById(t) : t, i.el && (i.o = {
				classNameWrap: e.classNameWrap || "sug-wrap",
				classNameQuery: e.classNameQuery,
				classNameQueryNull: e.classNameQueryNull,
				classNameSelect: e.classNameSelect || "sug-select",
				classNameClose: e.classNameClose || "sug-close",
				classNameShim: e.classNameShim || "sug-shim",
				locAbs: e.locAbs || !1,
				pressDelay: e.pressDelay === n ? 3 : e.pressDelay,
				autoFocus: e.autoFocus || !1,
				delay: e.delay || 200,
				n: e.n || 10,
				t: e.t || !0,
				autoCompleteData: e.autoCompleteData || !1,
				url: e.url || !1,
				charset: e.charset,
				callbackFn: e.callbackFn || !1,
				callbackName: e.callbackName || !1,
				callbackDataKey: e.callbackDataKey || !1,
				callbackDataNum: e.callbackDataNum || !1,
				requestQuery: e.requestQuery || !1,
				requestParas: e.requestParas || {},
				noSubmit: e.noSubmit || !1,
				onSelect: e.onSelect,
				onSearchDirect: e.onSearchDirect,
				onCheckForm: e.onCheckForm,
				onKeySelect: e.onKeySelect,
				onMouseSelect: e.onMouseSelect,
				onShow: e.onShow,
				onHide: e.onHide,
				onFill: e.onFill,
				onRequest: e.onRequest,
				onSucess: e.onSucess,
				onError: e.onError,
				onQueryChange: e.onQueryChange,
				onKeyEsc: e.onKeyEsc,
				customUrl: e.customUrl || !1,
				templ: e.templ || !1,
				autoCache: e.autoCache || !1
			}, i.wrap = i.el.parentNode, i.init())
		}, v = _.prototype;
		v.init = function() {
			var t = this,
				e = t.o;
			if (t.layoutInit(), t.reset(), t.inputHandle(), e.autoFocus && setTimeout(function() {
				t.el.focus()
			}, 16), !e.autoCompleteData) {
				var a = e.callbackFn,
					n = d(a, !0),
					i = a.split("."),
					o = i.pop();
				t.callback = function(e) {
					e = e || {};
					var n = arguments.callee;
					t = a && n.repeat ? n.context || t : t, t.o.onSucess && t.o.onSucess.call(t);
					var i = t.o.callbackDataKey || t.o.callbackDataNum,
						o = i ? e[i] : e;
					return o && o.length ? (t.fill(e, t.q), t.show(), void(t.o.autoCache && (t.cache[t.q] = e))) : (t.hide(1), void(t.isHide = !1))
				}, n[o] ? n[o].repeat = !0 : a && (n[o] = t.callback)
			}
		}, v.reset = function(t) {
			var e, a = this;
			for (e in t) a.o[e] = t[e];
			a.cache = {}, a.q = "", a.s = o, a.i = -1, a.val = "", a.inputTimer(), a.isHide = !1, a.hide(1)
		}, v.layoutInit = function() {
			var t = this,
				e = t.o,
				n = e.locAbs ? a.body : t.wrap,
				i = t.sugWrap = a.createElement("div");
			if (t.el.setAttribute("autocomplete", "off"), c) {
				var o = t.shim = i.appendChild(a.createElement("iframe"));
				o.src = "about:blank", f(o, e.classNameShim), o.frameBorder = 0, o.scrolling = "no", t.content = i.appendChild(i.cloneNode(null))
			} else t.content = i;
			f(i, e.classNameWrap), !e.locAbs && "static" === b(n, "position") && (n.style.position = "relative"), n.appendChild(i)
		}, v.show = function() {
			this.sugWrap.style.display = "", this.o.onShow && this.o.onShow.call(this)
		}, v.hide = function(t) {
			var e = this;
			e.sugWrap.style.display = "none", e.q = e.el.value, 2 != t && (e.s = o, e.i = -1), 1 == t && e.fill(), e.o.onHide && e.o.onHide.call(e)
		}, v.holdFocus = function(t, a) {
			a.preventDefault ? a.preventDefault() : t.onbeforedeactivate = function() {
				e.event.returnValue = !1, t.onbeforedeactivate = null
			}
		}, v.inputTimer = function(t) {
			var e, a = this,
				n = a.el,
				i = a.t;
			if (t) {
				if (i || !a.o.autoCompleteData && !a.o.url) return;
				a.t = setInterval(function() {
					return e = n.value, e.trim() ? (e !== a.q ? a.updata(e) : a.val = e, void(a.o.onQueryChange && a.o.onQueryChange.call(a, !! e.trim()))) : (a.hide(1), a.q = e, void(a.o.onQueryChange && a.o.onQueryChange.call(a)))
				}, a.o.delay)
			} else i && clearInterval(a.t), a.t = 0
		}, v.getIndex = function(t, e) {
			for (var a = e.length; a--;) if (e[a] === t) return a;
			return -1
		}, v.matchEl = function(t, e, a) {
			for (; t !== e;) {
				if (a.call(t)) return t;
				t = t.parentNode
			}
			return o
		}, v.submitForm = function() {
			var t = this.el.form;
			t.onsubmit ? t.onsubmit() : (this.o.onCheckForm && this.o.onCheckForm(t), t.submit())
		}, v.keydownMove = function(t) {
			var e = this,
				a = e.sugWrap.getElementsByTagName("OL")[0];
			if (a) {
				if (e.isHide) return void(e.isHide = !1);
				var i, l = a.getElementsByTagName("LI"),
					s = l.length,
					c = e.el,
					u = e.s,
					d = e.o,
					m = d.classNameSelect,
					h = e.q || "";
				u && (p(u, m), e.i = e.getIndex(u, l), e.s = o), e.i === n && (e.index = -1), -1 !== e.i && p(l[e.i], m), 40 === t ? e.i++ : 38 === t && e.i--, -2 === e.i ? e.i = s - 1 : e.i === s ? (c.value = h, e.i = -1) : -1 === e.i && (c.value = h), -1 !== e.i && e.i !== s ? (i = l[e.i], f(i, m), d.onKeySelect && d.onKeySelect.call(e, i), !d.autoCompleteData && (c.value = i.getAttribute("q").replace(r, "")), e.s = i) : (40 === t || 38 === t) && d.onKeySelect && d.onKeySelect.call(e, l[0], !0)
			}
		}, v.inputHandle = function() {
			var t, e = this,
				a = e.o,
				n = e.el,
				i = (n.form, e.sugWrap),
				o = a.classNameSelect,
				l = a.autoCompleteData,
				c = 0;
			n.onkeypress = function(a) {
				a = a || window.event, t = a.keyCode;
				var n = e.s ? e.s.getElementsByTagName("a")[0] : null,
					i = "";
				13 === t && n && (i = n.getAttribute("href"), e.el.blur(), window.open(i), a.preventDefault ? a.preventDefault() : a.returnValue = !1)
			}, n.onkeydown = function(o) {
				if (o = o || window.event, t = o.keyCode, 27 === t) return e.hide(2), i.getElementsByTagName("ol")[0] && (e.isHide = !0), !l && (n.value = e.q), e.inputTimer(), e.o.onKeyEsc && e.o.onKeyEsc.call(e), !1;
				if (t > 32 && 41 > t) n.value || "none" !== i.style.display ? (40 === t || 38 === t) && (a.pressDelay && 0 !== c++ ? c === a.pressDelay && (c = 0) : (e.isHide && e.show(), e.keydownMove(t), e.inputTimer()), !s && o.preventDefault()) : n.blur();
				else if (13 === t) {
					if (e.inputTimer(), e.hide(2), a.onSelect && a.onSelect.call(e), e.s && m(e.s, "sug-url") && a.onSearchDirect && a.onSearchDirect(e.s, n.value, e.val), l) return n.value = e.s ? e.s.getAttribute("q").replace(r, "") : "", e.o.onFill && e.o.onFill.call(e), !1;
					if (a.noSubmit) return !1
				} else {
					if (t > 8 && 19 > t) return void(9 !== t && e.holdFocus(n, o));
					e.inputTimer(1)
				}
			}, h(n, "keyup", function() {
				c = 0
			}), h(n, "blur", function() {
				e.hide(2), i.getElementsByTagName("ol")[0] && (e.isHide = !0), e.inputTimer()
			}), g(i, "mouseover", function() {
				var t = e.matchEl(this, i, function() {
					return "LI" === this.tagName
				});
				t && (e.s && p(e.s, o), f(t, o), e.s = t)
			}), g(i, "mouseout", function() {
				var t = e.matchEl(this, i, function() {
					return "LI" === this.tagName
				});
				"LI" === this.tagName && this !== t && p(t, o)
			}), h(i, "mousedown", function(t) {
				e.inputTimer(), e.holdFocus(n, t)
			}), g(i, "mouseup", function(t) {
				var o, l = i.getElementsByTagName("OL")[0];
				if (!(!l || t.which && t.which > 2 || t.button && 1 !== t.button && 4 !== t.button) && (m(this, a.classNameClose) && e.hide(), o = e.matchEl(this, i, function() {
					return "LI" === this.tagName
				}))) {
					if (n.value = o.getAttribute("q").replace(r, ""), e.hide(), e.inputTimer(), a.onSelect && a.onSelect.call(e, o), e.i = e.getIndex(o, l.getElementsByTagName("LI")), e.o.onFill && e.o.onFill.call(e), m(o, "sug-url")) return a.onSearchDirect && a.onSearchDirect(o, n.value, e.val), !0;
					a.onMouseSelect && a.onMouseSelect.call(e, o), !a.autoCompleteData && !a.noSubmit && e.submitForm()
				}
			})
		}, v.fill = function(t, e) {
			var a = this,
				i = a.content;
			if (arguments.length < 2) return void(i.innerHTML = "");
			var o = a.o,
				r = o.templ,
				l = o.classNameQueryNull,
				s = o.classNameQuery;
			this.content.innerHTML = r ? r.call(a, t, e) : function() {
				t = t[o.callbackDataKey || o.callbackDataNum] || [];
				var a, i = 0,
					r = Math.min(t.length, o.n),
					c = [];
				for (e = e.trim(); r > i; i++) a = t[i], a !== n && c.push('<li q="' + a + '"' + (l && a.indexOf(e) > -1 ? "" : " class=" + l) + ">" + (s ? a.replace(e, '<span class="' + s + '">' + e + "</span>") : a) + "</li>");
				return "<ol>" + c.join("") + "</ol>"
			}()
		}, v.updata = function(t) {
			var e = this,
				a = e.o.autoCompleteData || e.cache[t];
			if (e.q = t, e.i = -1, e.isHide = !1, a !== n) {
				if (e.o.autoCompleteData && !a.length) return;
				return e.fill(a, t), void e.show()
			}
			e.request(t)
		}, v.request = function(t) {
			var e, i, r = this,
				l = r.o,
				c = l.callbackFn,
				m = l.callbackName,
				f = l.onSucess,
				p = l.onError,
				h = l.onRequest,
				g = r.callback,
				b = encodeURIComponent,
				_ = l.url,
				v = l.customUrl,
				y = l.requestParas,
				S = [];
			if (c) {
				var C = d(c),
					x = c.split(".").pop();
				C[x] = r.callback, C[x].repeat && (C[x].context = r)
			} else m && (i = r.script, i.readyState ? i.onreadystatechange = function() {
				("loaded" == i.readyState || "complete" == i.readyState) && (i.onreadystatechange = o, f && f.call(r), g(m))
			} : i.onload = function() {
				f && f.call(r), g(m)
			});
			if (p && (r.script.onerror = function() {
				p.call(r)
			}), !r.script || !s || u) {
				var $ = a.getElementsByTagName("script")[0];
				i = a.createElement("script"), i.type = "text/javascript", i.async = !0, r.script ? $.parentNode.replaceChild(i, r.script) : $.parentNode.insertBefore(i, $), r.script = i
			}
			h && h.call(this), y = function() {
				for (e in y)(i = y[e]) !== n && S.push(b(e) + "=" + b(y[e]));
				return l.t && S.push(b("t") + "=" + b(+new Date)), S.join("&")
			}(), r.script.charset = l.charset ? l.charset : "", r.script.src = v && v.call(r, y) || _ + "?" + l.requestQuery + "=" + encodeURIComponent(t) + "&" + y, r.val = t
		}, t = _
	}(window, document), t
}), define("map/js/scroll", function(require, t) {
	!
	function(t, e, a, n) {
		if (a) {
			var i = "WebKitCSSMatrix" in t && "m11" in new WebKitCSSMatrix,
				o = function(t, e) {
					var n = this;
					n.$el = t, n.el = t[0], n.$parent = n.$el.parent(), n.state = {}, n.args = a.extend({
						wheelSpeed: 20,
						pressDelay: 200,
						watch: 200,
						dir: "",
						autoHide: !0,
						activateClass: "mod-scroll--activate",
						customClass: "",
						preventDefaultWheel: !1,
						controller: {
							barX: "bar-x",
							barY: "bar-y",
							thumbX: "thumb-x",
							thumbY: "thumb-y"
						}
					}, e), n.init()
				},
				r = o.prototype;
			r.init = function() {
				var t = this,
					i = t.$el,
					o = t.$parent,
					r = t.$wrap = a("<div>");
				a.map(t.args.controller, function(e, n) {
					r.append(t.state["$" + n] = a('<div class="mod-scroll_' + e + '"></div>'))
				}), t.updateState(), t.initLayout(), "static" === o.css("position") && o.css({
					position: "relative"
				}), t.state.autoHide && (r.css({
					display: "none"
				}), o.on("mouseenter", function() {
					r.css({
						display: "block"
					})
				}).on("mouseleave", function() {
					!t.state.draging && r.css({
						display: "none"
					})
				})), o.css({
					overflow: "hidden"
				}).append(r).on(e.onmousewheel !== n ? "mousewheel" : "DOMMouseScroll", function(e) {
					t.wheelHandle.call(i, e, t)
				}), r.addClass("mod-scroll " + t.args.customClass).on("mousedown", function(e) {
					e.preventDefault(), t.mouseHandle.call(e.target, e, t)
				}), 0 != t.args.watch && (t.resizeTimer = setInterval(function() {
					t.detectLayout() && t.resizeHandle.call(t)
				}, t.args.watch)), t.args.onInit && t.args.onInit.call(t)
			}, r.updateState = function() {
				var n = this,
					i = n.$el,
					o = n.$parent,
					r = a.extend(n.state, {
						dir: function(a, i) {
							return n.args.dir = a.currentStyle ? a.currentStyle[i] : function() {
								var n = "";
								return n = t && t.getComputedStyle(a, null) ? t.getComputedStyle(a, null).getPropertyValue(i) : e.documentElement.dir, n || "ltr"
							}(), "ltr" === n.args.dir
						}(n.el, "direction"),
						autoHide: 1 == n.args.autoHide,
						H: o.height(),
						h: i.outerHeight(),
						W: o.width(),
						w: i.outerWidth(),
						x: n.state.x || 0,
						y: n.state.y || 0
					}),
					l = function(t, e) {
						return Math.floor(Math.min(Math.pow(t, 2) / e, t))
					};
				n.state = a.extend(r, {
					_x: Math.max(r.w - r.W, 0),
					_y: Math.max(r.h - r.H, 0),
					_w: l(r.W, r.w),
					_h: l(r.H, r.h)
				})
			}, r.initLayout = function() {
				var t = this,
					e = t.state,
					a = (t.$el, t.$parent, t.$wrap, {}),
					n = e.W < e.w,
					i = e.H < e.h;
				a[e.dir ? "right" : "left"] = 0, a.display = i ? "block" : "none", e.$barY.css(a), e.$thumbY.css(a).css({
					height: e._h + "px"
				}), a = {}, a[e.dir ? "left" : "right"] = 0, a.display = n ? "block" : "none", e.$barX.css(a), e.$thumbX.css(a).css({
					width: e._w + "px"
				})
			}, r.moveThumb = function(t) {
				var e = this,
					a = e.state;
				e.scrollTo(a.$thumbX, {
					x: Math.floor(-a.x * a.W / a.w),
					y: 0
				}, t), e.scrollTo(a.$thumbY, {
					x: 0,
					y: Math.floor(-a.y * a.H / a.h)
				}, t)
			}, r.resizeHandle = function() {
				var t = this;
				t.state;
				t.updateState(), t.moveThumb(), t.initLayout()
			}, r.selectable = function(t, e) {
				return e || a("body").css("user-select", t ? "none" : "text").attr("unselectable", t ? "on" : "off")[t ? "on" : "off"]("selectstart.scroll", !1)
			}, r.mouseHandle = function(t, n) {
				var i, o = a(this),
					r = n.state,
					l = "x",
					s = r.w,
					c = r.W,
					u = {
						x: 0,
						y: 0
					},
					d = r.$thumbX,
					m = !1,
					f = 0,
					p = function() {
						var e;
						r[l] = n.fixPos(r[l] + c * (("y" === l ? t.pageY - o.offset().top > Math.max(parseFloat(r.$thumbY.css("marginTop")), r.$thumbY.position().top) : t.pageX - o.offset().left > Math.max(parseFloat(r.$thumbX.css("marginLeft")), r.$thumbX.position().left)) ? -1 : 1), l), n.scrollTo(n.$el, {
							x: r.x,
							y: r.y
						}), u[l] = Math.floor(-r[l] * c / s), n.scrollTo(d, u), e = ("x" === l ? t.pageX - o.offset().left : t.pageY - o.offset().top) - u[l], e = e > 0 ? e > ("x" === l ? r._w : r._h) : 0 > e, n.args.onScroll && n.args.onScroll.call(n, t), e || (m = !1, f = 1, n.$wrap.removeClass(n.args.activateClass), n.args.onEndPress && n.args.onEndPress.call(n)), m && setTimeout(function() {
							m && p()
						}, n.args.pressDelay)
					};
				(this === r.$thumbY[0] || this === r.$barY[0]) && (l = "y", s = r.h, c = r.H, d = r.$thumbY), this === r.$thumbX[0] || this === r.$thumbY[0] ? (i = {
					x: t.pageX,
					y: t.pageY,
					h: Math.max(parseFloat(o.css("marginTop")), o.position().top),
					w: Math.max(parseFloat(o.css("marginLeft")), o.position().left)
				}, r.dir || (i.w = i.w - r._w), r.draging = !0, a(e).on("mousemove.scroll", function(t) {
					r[l] = n.fixPos(-s * ("y" === l ? i.h + t.pageY - i.y : i.w + t.pageX - i.x) / c, l), n.$wrap.addClass(n.args.activateClass), n.selectable(1), n.args.onStartDrag && n.args.onStartDrag.call(n), n.scrollTo(n.$el, {
						x: r.x,
						y: r.y
					}), u[l] = Math.floor(-r[l] * c / s), u[l] = Math.min(u[l], c - ("y" == l ? r._h : r._w)), n.scrollTo(d, u), n.args.onScroll && n.args.onScroll.call(n, t)
				})) : (this === r.$barX[0] || this === r.$barY[0]) && (m = !0, n.$wrap.addClass(n.args.activateClass), n.args.onStartPress && n.args.onStartPress.call(n), p()), a(e).on("mouseup.scroll", function() {
					a(this).off("mousemove.scroll").off("mouseup.scroll"), !f && n.args.onEndPress && n.args.onEndPress.call(n), m = !1, r.draging = !1, n.$wrap.removeClass(n.args.activateClass), n.selectable(0), n.resizeHandle(), n.args.onEndDrag && n.args.onEndDrag.call(n)
				})
			}, r.wheelHandle = function(t, e) {
				var n = (e.state, a(e.el), function(a) {
					var n = e.getDelta(t),
						i = e.args.wheelDir;
					return i && (n[i] = n["x" === i ? "y" : "x"], n["x" === i ? "y" : "x"] = 0), e.state[a] + n[a] * e.args.wheelSpeed
				}),
					i = n("x"),
					o = n("y"),
					r = e.fixPos(i, "x"),
					l = e.fixPos(o, "y"),
					s = !i && l === e.state.y || !o && r === e.state.x || r > i || l > o;
				!s && t.stopPropagation(), !(!e.args.preventDefaultWheel && s) && t.preventDefault(), e.scrollTo(e.$el, {
					x: r,
					y: l
				}), e.state.x = r, e.state.y = l, e.moveThumb(), e.args.onWheel && e.args.onWheel.call(e, t), e.args.onScroll && e.args.onScroll.call(e, t)
			}, r.fixPos = function(t, e) {
				var a = Math.min,
					n = Math.max,
					i = -this.state["_" + e];
				return this.state.dir || "x" !== e || (a = Math.max, n = Math.min, i = -i), Math.floor(n(a(t, 0), i))
			}, r.detectLayout = function() {
				var t = this,
					e = t.state;
				return !(e.h === t.$el.outerHeight() && e.w === t.$el.outerWidth() && e.H === t.$parent.height() && e.W === t.$parent.width())
			}, r.scrollTo = i ?
			function(t, e) {
				t.css({
					transform: "translate3d(" + e.x + "px," + e.y + "px, 0)"
				})
			} : function(t, e, a) {
				(isNaN(e.x) || !isFinite(e.x)) && (e.x = 0), (isNaN(e.y) || !isFinite(e.y)) && (e.y = 0);
				var n = this.state.dir ? e.y + "px auto auto " + e.x + "px" : e.y + "px " + -e.x + "px auto auto";
				a ? t.animate({
					margin: n
				}, a, "swing") : t[0].style.margin = n
			}, r.goTo = function(t, e, n) {
				var i = this;
				return i.updateState(), a.each(t, function(t, e) {
					i.state[t] = i.fixPos(e, t)
				}), e ? (i.$parent.addClass("mod-scroll--animate"), setTimeout(function() {
					i.$parent.removeClass("mod-scroll--animate"), n && n()
				}, 1e3)) : n && n(), i.moveThumb(e), i.initLayout(), i.scrollTo(i.$el, {
					x: i.state.x,
					y: i.state.y
				}, e), i
			}, r.getDelta = function(t) {
				t = t.originalEvent || t;
				var e = {
					delta: 0,
					x: 0,
					y: 0
				};
				return e.delta = t.wheelDelta !== n ? t.wheelDelta / 120 : -(t.detail || 0) / 3, t.axis ? e[t.axis === t.HORIZONTAL_AXIS ? "x" : "y"] = e.delta : t.wheelDeltaX !== n ? (e.x = t.wheelDeltaX / 120, e.y = t.wheelDeltaY / 120) : e.y = e.delta, e
			}, r.destroy = function() {
				var t = this;
				t.resizeTimer && clearInterval(t.resizeTimer)
			}, a.fn.extend({
				scrollable: function(t) {
					return new o(this, t)
				}
			})
		}
	}(window, document, $)
}), define("map/js/msg", function(require, t) {
	var e = $({});
	return t = e
}), define("map/js/mapView", function(require, t) {
	function e(t, e, n) {
		g.push({
			func: t,
			selfConf: e,
			context: n
		}), 1 === g.length && a()
	}
	function a() {
		for (var t = null, e = 0, a = g.length; a > e; e++) t = g[e], t.context ? t.func.call(context, {
			map: f,
			$map: p
		}, t.selfConf) : t.func({
			map: f,
			$map: p
		}, t.selfConf);
		g.length = 0
	}
	function n() {
		function t() {
			m.trigger("firstInit"), setTimeout(function() {
				f.removeEventListener("tilesloaded", t)
			}, 0)
		}
		m.on("update", function(t, e) {
			setTimeout(function() {
				m.trigger("update_" + g_conf.curChannel, e), setTimeout(function() {
					_ && m.trigger("update_around", {
						cur: _
					})
				}, 100)
			}, 150)
		}), f.addEventListener("tilesloaded", t), f.addEventListener("zoomend", function() {
			clearTimeout(c), c = setTimeout(function() {
				b && m.trigger("update", {
					channel: "zoom"
				}), b = !0
			}, 50)
		}), f.addEventListener("dragend", function() {
			clearTimeout(u), u = setTimeout(function() {
				m.trigger("update", {
					channel: "drag"
				}), setTimeout(function() {
					_ && m.trigger("update_around", {
						cur: _
					})
				}, 50)
			}, 50)
		}), m.on("bubble_click", function(t, e) {
			var a = $(e);
			a.attr("data-disabled") || (a.hasClass("bubble-3") || $(".bubble").hide(), m.trigger("click_" + g_conf.curChannel, {
				longitude: a.attr("data-longitude"),
				latitude: a.attr("data-latitude"),
				id: a.attr("data-id"),
				isSchool: "1" === a.attr("data-imSchool") ? !0 : !1
			}), d && d.length && (d.removeClass("clicked"), d.parent().removeClass("label-clicked")), d = a, d.addClass("clicked"), d.parent().addClass("label-clicked"))
		}), -1 === navigator.userAgent.search("iPad") && $(document.body).on("click", ".bubble", function() {
			m.trigger("bubble_click", $(this))
		}), m.on("update_around_value", function(t, e) {
			_ = e.cur || ""
		})
	}
	function i() {
		return f.getZoom()
	}
	function o(t, e, a) {
		f.centerAndZoom(new BMap.Point(t, e), a)
	}
	function r() {
		f.centerAndZoom(g_conf.cityName, 12)
	}
	function l() {
		var t = f.getBounds(),
			e = t.getSouthWest(),
			a = t.getNorthEast();
		return {
			min_longitude: e.lng,
			max_longitude: a.lng,
			min_latitude: e.lat,
			max_latitude: a.lat
		}
	}
	function s(t) {
		var e = "global_callback" + +new Date;
		h[e] = function() {
			setTimeout(function() {
				f = new BMap.Map(g_conf.mapWrapper, {
					enableMapClick: !1,
					minZoom: 11
				}), f.enableScrollWheelZoom(), f.disableInertialDragging(), f.centerAndZoom(g_conf.cityName, 12), m.one("firstInit", function() {
					a(), f.addControl(new BMap.ScaleControl({
						anchor: BMAP_ANCHOR_BOTTOM_RIGHT,
						offset: new BMap.Size(20, 20)
					}))
				}), n()
			}, 20)
		}, h[e]()
	}
	var c, u, d, m = require("map/js/msg"),
		f = null,
		p = null,
		h = window,
		g = [],
		b = !1,
		_ = "";
	return m.on("dragStatus", function(t, e) {
		g_conf.ignoreSearch = e
	}), g.push({
		func: function() {
			p = $("#" + g_conf.mapWrapper)
		},
		selfConf: null,
		context: null
	}), t = {
		init: s,
		addCb: e,
		centerAndZoom: o,
		resetMap: r,
		getZoom: i,
		getMap: function() {
			return f
		},
		getBounds: l
	}
}), define("map/js/panelView", function(require, t) {
	function e() {
		var t = "<li>+</li><li>-</li>";
		s.html(t).show()
	}
	function a(t) {
		var e = s.find("li");
		e.eq(0).on("click", function() {
			t.map.zoomIn()
		}), e.eq(1).on("click", function() {
			t.map.zoomOut()
		})
	}
	function n() {
		var t = "";
		$.each(m, function(e, a) {
			t += $.replaceTpl(d.boolCheck, a)
		}), t += d.multiSelect, t += d.dragControlTpl, c.html(t).show(), function() {
			var t = c.find(".li-item-around"),
				e = "";
			$.each(f, function(t, a) {
				a.isFirst = 0 === t ? " clicked" : "", e += $.replaceTpl(d.multiSelectItem, a)
			}), t.append($.replaceTpl(u, {
				content: e
			})), setTimeout(function() {
				$.inArray(g_conf.cityId, ["350200"]) > -1 && c.find('li[data-value="store"]').hide()
			}, 100)
		}()
	}
	function i() {
		var t = c.find(".li-item-around"),
			e = t.find(".drop-list"),
			a = t.find(".drop-i"),
			n = t.find("span"),
			i = n.html(),
			o = null,
			r = c.find(".li-filter");
		t.on("mouseenter", function() {
			e.show(), a.addClass("drop-open")
		}).on("mouseleave", function() {
			e.hide(), a.removeClass("drop-open")
		}).on("click", ".item", function() {
			var r = $(this),
				s = $.trim(r.attr("data-value")) || "",
				c = t.attr("data-value") || "";
			c != s && (t.attr("data-value", s), s ? n.html(r.html()) : n.html(i), l.trigger("update_around_value", {
				cur: s
			}), l.trigger("update_around", {
				channel: "useless",
				prev: c,
				cur: s
			}), o = o || t.find(".item").eq(0), o.removeClass("clicked"), r.addClass("clicked"), o = r), e.hide(), a.removeClass("drop-open")
		}), -1 === navigator.userAgent.search("iPad") && e.children("ol").scrollable(), c.on("click", ".li-filter", function() {
			var t = $(this),
				e = [],
				a = "";
			t.hasClass("li-disabled") || (t.attr("data-value", t.hasClass("li-checked") ? "" : t.attr("data-val")), t.toggleClass("li-checked"), r.each(function(t, n) {
				a = $(this).attr("data-value"), a && e.push(a)
			}), g_conf.filterMapSideCtrl = e.join("&"), l.trigger("update", {
				channel: "filter",
				cur: g_conf.filterMapSideCtrl
			}))
		}), c.find(".li-drag-ctrl").on("click", function() {
			var t = $(this);
			l.trigger("dragStatus", !t.hasClass("li-checked")), t.toggleClass("li-checked"), g_conf.searchConf && setTimeout(function() {
				l.trigger("update", {
					channel: "code",
					typ: "dragSwitch"
				})
			}, 20)
		}), l.on("mapSideCtrlChange", function() {
			r.each(function(t, e) {
				$(this).removeClass("li-disabled")
			}), "Station" === g_conf.curChannel ? r.filter(function() {
				return $(this).attr("data-val").search("subway") > -1
			}).addClass("li-disabled") : "School" === g_conf.curChannel && r.filter(function() {
				return $(this).attr("data-val").search("school") > -1
			}).addClass("li-disabled")
		}), l.on("resetIgnoreSearch", function() {
			c.find(".li-drag-ctrl").removeClass("li-checked"), l.trigger("dragStatus", !1)
		}), l.on("resetFilter", function() {
			r.each(function() {
				var t = $(this);
				t.removeClass("li-checked"), t.attr("data-value", ""), g_conf.filterMapSideCtrl = ""
			}), t.find(".item-default").trigger("click")
		})
	}
	function o(t) {
		var e = $("#" + g_conf.houseListId),
			a = $("#" + g_conf.mapCtrlId),
			n = !0,
			i = e.outerWidth() + a.outerWidth();
		$("#" + g_conf.mapResizeId).on("click", function() {
			(n = !n) ? (e.show(), a.show()) : (e.hide(), a.hide()), t.$map.css("margin-left", n ? i : 0), $(this)[(n ? "remove" : "add") + "Class"]("close"), setTimeout(function() {
				l.trigger("update", {
					channel: "resize"
				})
			}, 200)
		})
	}
	function r(t) {
		e(), n(), a(t), i(), o(t)
	}
	require("map/js/scroll");
	var l = require("map/js/msg"),
		s = $("#" + g_conf.mapZoomPanelId),
		c = $("#" + g_conf.mapSidePanelId),
		u = '<div class="drop-list"><ol>#{content}</ol></div>',
		d = {
			boolCheck: '<li class="li-item li-filter" data-val="#{name}"><i class="i-check"></i>#{title}</li>',
			multiSelect: '<li class="li-item li-item-around" data-type="mapAround"><span>周边</span><i class="drop-i"></i></li>',
			multiSelectItem: '<li data-value="#{value}" class="item-#{extraClass} item#{isFirst}"><i></i>#{title}</li>',
			dragControlTpl: '<li class="li-item li-drag-ctrl"><i class="i-check"></i>拖动地图时重新搜索</li>'
		},
		m = [{
			name: "is_subway=1",
			title: "近地铁"
		}, {
			name: "is_school=1",
			title: "学区房"
		}, {
			name: "is_two_five=1",
			title: "满五唯一/满两年"
		}],
		f = [],
		p = {
			"无": "default",
			"银行": "bank",
			"公交": "bus",
			"地铁": "station",
			"教育": "education",
			"医院": "hospital",
			"休闲": "fun",
			"购物": "shop",
			"健身": "sport",
			"美食": "eat",
			"链家": "store"
		};
	return $.each(["无", "链家", "银行", "公交", "地铁", "教育", "医院", "休闲", "购物", "健身", "美食"], function(t, e) {
		f.push({
			value: 0 === t ? "" : "链家" == e ? "store" : e,
			title: e,
			extraClass: p[e]
		})
	}), t = {
		init: r
	}
}), define("map/js/model", function(require, t) {
	function e(t) {
		var e = "&",
			a = g_conf.searchConf;
		return a && !g_conf.ignoreSearch && ("area" === a.module && (e += "other" === a.type ? "q=" + encodeURIComponent(a.text) : a.type + "_id=" + a.id), "subway" === a.module, "school" === a.module && (e += a.type + "_id=" + a.id)), e
	}
	function a(t) {
		var e = this;
		$.each(["bubble", "card", "house"], function(a, n) {
			e[n + "Url"] = {
				path: t[n + "Path"],
				params: t[n + "ParamArray"]
			}
		})
	}
	var n = {},
		i = 6e5;
	return a.prototype = {
		bubbleAjax: null,
		cardAjax: null,
		houseAjax: null,
		ajax: function(t, a, o, r) {
			var l, s = this,
				c = r || s[t + "Url"].path + "?" + s.formatParams(a, s[t + "Url"].params);
			c += c.search(/\?/) > -1 ? "" : "?", c += g_conf.filterMapSideCtrl ? "&" + g_conf.filterMapSideCtrl : "", c += g_conf.filterSearchSideCtrl ? "&" + g_conf.filterSearchSideCtrl : "", c += e(t), c += "&city_id=" + g_conf.cityId, n[c] && +new Date - n[c].timeStamp > i && (n[c] = null), n[c] ? (this[t + "Ajax"] = $.Deferred()).resolve(n[c].data) : this[t + "Ajax"] = $.ajax({
				url: c,
				dataType: "jsonp",
				jsonp: "callback"
			}), l = this[t + "Ajax"], l.cbFunc = o, l.done(function(t) {
				n[c] || (n[c] = {
					data: t,
					timeStamp: +new Date
				}), !g_conf.allSchoolMsg && c.search(g_conf.urlPath.mapSearch.SchoolSchool) > -1 && t && t.data && t.data.length && (g_conf.allSchoolMsg = t.data), l.cbFunc && l.cbFunc(t)
			})
		},
		getBubbles: function(t, e, a) {
			this.ajax("bubble", t, e, a)
		},
		formatParams: function(t, e) {
			var a = {};
			return $.each(e, function(e, n) {
				a[n] = t[n]
			}), $.param(a)
		},
		getCards: function(t, e, a) {
			this.ajax("card", t, e, a)
		},
		getHouseList: function(t, e, a) {
			this.ajax("house", t, e, a)
		}
	}, t = a
}), define("map/js/bubble", function(require, t) {
	var e = require("map/js/mapView"),
		a = require("map/js/msg"),
		n = {
			1: '<div class=\'#{extraClass} bubble\' data-longitude="#{longitude}" data-latitude="#{latitude}" data-id="#{id}"><p>#{name}</p><p>#{price}万</p><p><span>#{house_count}</span>套</p></div>',
			4: '<div class=\'bubble-4 bubble\' data-disabled="1" data-longitude="#{longitude}" data-latitude="#{latitude}" data-id="#{id}" title="#{name}"><span class=\'bubble-4_tri\'></span><p class=\'bubble-4_tip\' title=\'#{sugName}\'>#{sugName}</p></div>',
			2: '<div class="bubble-2 bubble" data-longitude="#{longitude}" data-latitude="#{latitude}" data-id="#{id}"><p class="name" title="#{name}">#{name}</p><p class="num">#{price}</p><p class="count">#{house_count}套</p></div>',
			21: '<div class="bubble-2 bubble bubble-21" data-longitude="#{longitude}" data-latitude="#{latitude}" data-id="#{id}"><p class="name" title="#{name}">#{name}</p><p class="count">#{house_count}套</p></div>',
			3: '<p class="bubble-3 bubble" data-longitude="#{longitude}" data-latitude="#{latitude}" data-id="#{id}" data-msg="#{otherResource}" data-station="#{subway_station_id}" data-schoolid="#{school_id}"><i class="num">&nbsp;#{price}&nbsp;</i><span class="name"><i class="name-des"><a href="/xiaoqu/#{id}/" target="_blank" #{other_ctrl}>#{name}&nbsp;&nbsp;#{house_count}套</a></i></span><i class="arrow-up"><i class="arrow"></i><i></p>',
			5: '<div class="bubble-2 bubble-5 bubble" data-longitude="#{longitude}" data-latitude="#{latitude}" data-id="#{id}"><p class="name" title="#{name}">#{name}</p><p class="num">#{price}</p><p><span class="count">#{house_count}</span>套</p></div>',
			6: '<div class="bubble-2 bubble-5 bubble-6 bubble" data-longitude="#{longitude}" data-latitude="#{latitude}" data-id="#{id}"><p class="name" title="#{name}">#{name}</p><p class="count">#{school_count}所小学</p></div>',
			7: '<div class="bubble-2 bubble bubble-7" data-imSchool="1" data-longitude="#{longitude}" data-latitude="#{latitude}" data-id="#{id}"><p class="name" title="#{name}">#{name}</p><p class="count">#{house_count}套</p><p class="num">#{min_price_total}万起</p></div>',
			8: "<div class='bubble-4 bubble bubble-8' data-imSchool=\"1\" data-longitude=\"#{longitude}\" data-latitude=\"#{latitude}\" data-id=\"#{id}\"><span class='bubble-4_tri'></span><p class='bubble-4_tip' title='#{name}'>#{name}</p></div>",
			9: '<div class="bubble-2 bubble bubble-9" data-longitude="#{longitude}" data-latitude="#{latitude}" data-id="#{id}"><p class="name" title="#{name}">#{name}</p><p class="num">#{price}</p><p class="count">#{house_count}套</p></div>',
			10: "<div class='bubble-4 bubble bubble-8 bubble-10' data-disabled=\"1\" data-longitude=\"#{longitude}\" data-latitude=\"#{latitude}\" data-id=\"#{id}\"><span class='bubble-4_tri'></span><p class='bubble-4_tip' title='#{name}'>#{name}</p></div>"
		},
		i = {
			4: {
				color: "#333333",
				borderWidth: "0",
				padding: "0",
				zIndex: "2",
				backgroundColor: "transparent",
				fontFamily: '"Hiragino Sans GB", "Microsoft Yahei UI", "Microsoft Yahei", "微软雅黑", "Segoe UI", Tahoma, "宋体b8bf53", SimSun, sans-serif'
			},
			1: {
				color: "#fff",
				backgroundColor: "rgba(0, 162, 130, 0.8)",
				height: "69px",
				lineHeight: "23px",
				width: "69px",
				textAlign: "center",
				borderWidth: "0",
				zIndex: "2",
				whiteSpace: "normal",
				fontFamily: '"Hiragino Sans GB", "Microsoft Yahei UI", "Microsoft Yahei", "微软雅黑", "Segoe UI", Tahoma, "宋体b8bf53", SimSun, sans-serif'
			},
			3: {
				color: "#fff",
				borderWidth: "0",
				padding: "0",
				zIndex: "2",
				backgroundColor: "transparent",
				textAlign: "center",
				fontFamily: '"Hiragino Sans GB", "Microsoft Yahei UI", "Microsoft Yahei", "微软雅黑", "Segoe UI", Tahoma, "宋体b8bf53", SimSun, sans-serif'
			},
			2: {
				color: "#fff",
				borderWidth: "0",
				padding: "0",
				zIndex: "2",
				backgroundColor: "transparent",
				textAlign: "center",
				fontFamily: '"Hiragino Sans GB", "Microsoft Yahei UI", "Microsoft Yahei", "微软雅黑", "Segoe UI", Tahoma, "宋体b8bf53", SimSun, sans-serif'
			},
			21: {
				color: "#fff",
				borderWidth: "0",
				padding: "0",
				zIndex: "2",
				backgroundColor: "transparent",
				textAlign: "center",
				fontFamily: '"Hiragino Sans GB", "Microsoft Yahei UI", "Microsoft Yahei", "微软雅黑", "Segoe UI", Tahoma, "宋体b8bf53", SimSun, sans-serif'
			},
			5: {
				color: "#fff",
				borderWidth: "0",
				padding: "0",
				zIndex: "2",
				cursor: "pointer",
				backgroundColor: "transparent",
				textAlign: "center",
				fontFamily: '"Hiragino Sans GB", "Microsoft Yahei UI", "Microsoft Yahei", "微软雅黑", "Segoe UI", Tahoma, "宋体b8bf53", SimSun, sans-serif'
			},
			6: {
				color: "#fff",
				borderWidth: "0",
				padding: "0",
				zIndex: "2",
				backgroundColor: "transparent",
				textAlign: "center",
				fontFamily: '"Hiragino Sans GB", "Microsoft Yahei UI", "Microsoft Yahei", "微软雅黑", "Segoe UI", Tahoma, "宋体b8bf53", SimSun, sans-serif'
			},
			7: {
				color: "#fff",
				borderWidth: "0",
				padding: "0",
				zIndex: "2",
				backgroundColor: "transparent",
				textAlign: "center",
				fontFamily: '"Hiragino Sans GB", "Microsoft Yahei UI", "Microsoft Yahei", "微软雅黑", "Segoe UI", Tahoma, "宋体b8bf53", SimSun, sans-serif'
			},
			8: {
				color: "#333333",
				borderWidth: "0",
				padding: "0",
				zIndex: "2",
				backgroundColor: "transparent",
				fontFamily: '"Hiragino Sans GB", "Microsoft Yahei UI", "Microsoft Yahei", "微软雅黑", "Segoe UI", Tahoma, "宋体b8bf53", SimSun, sans-serif'
			},
			9: {
				color: "#fff",
				borderWidth: "0",
				padding: "0",
				zIndex: "2",
				backgroundColor: "transparent",
				textAlign: "center",
				fontFamily: '"Hiragino Sans GB", "Microsoft Yahei UI", "Microsoft Yahei", "微软雅黑", "Segoe UI", Tahoma, "宋体b8bf53", SimSun, sans-serif'
			},
			10: {
				color: "#333333",
				borderWidth: "0",
				padding: "0",
				zIndex: "2",
				backgroundColor: "transparent",
				fontFamily: '"Hiragino Sans GB", "Microsoft Yahei UI", "Microsoft Yahei", "微软雅黑", "Segoe UI", Tahoma, "宋体b8bf53", SimSun, sans-serif'
			}
		},
		o = {
			4: function() {
				return new BMap.Size(-28, -28)
			},
			1: function() {
				return new BMap.Size(-48, -48)
			},
			3: function() {
				return new BMap.Size(-28, -36)
			},
			2: function() {
				return new BMap.Size(-42, -42)
			},
			21: function() {
				return new BMap.Size(-42, -42)
			},
			5: function() {
				return new BMap.Size(-48, -48)
			},
			6: function() {
				return new BMap.Size(-48, -48)
			},
			7: function() {
				return new BMap.Size(-42, -42)
			},
			8: function() {
				return new BMap.Size(-28, -28)
			},
			9: function() {
				return new BMap.Size(-40, -40)
			},
			10: function() {
				return new BMap.Size(-28, -28)
			}
		},
		r = {
			tpl: '<p class="line-msg">#{steamMsg}</p>',
			inlineTpl: '<i class="name-other">&nbsp;&nbsp;#{steamMsg}</i>',
			styles: {
				color: "#fffefe",
				borderWidth: "0",
				padding: "0",
				zIndex: "2",
				backgroundColor: "transparent",
				textAlign: "center"
			},
			offset: function() {
				return new BMap.Size(-54, -15)
			}
		},
		l = [],
		s = null,
		c = {
			_render: function(t) {
				e.getMap().addOverlay(t)
			},
			clear: function(t) {
				for (var e = null; e = l.shift();) c._remove(e);
				t && s && (c._remove(s), s = null)
			},
			_fixNumber: function(t) {
				return t = t && (parseFloat(t) / 1e4).toFixed(1) || "", t = "0.0" === t ? "" : t
			},
			_remove: function(t) {
				e.getMap().removeOverlay(t)
			},
			_create: function(t) {
				var e;
				return e = new BMap.Label($.replaceTpl(n[t.bubbleLevel], t), {
					position: new BMap.Point(t.longitude, t.latitude),
					offset: o[t.bubbleLevel]()
				}), t.isCenterBubble || (e.addEventListener("mouseover", function() {
					this.setStyle({
						zIndex: "4"
					})
				}), e.addEventListener("mouseout", function() {
					this.setStyle({
						zIndex: "2"
					})
				}), navigator.userAgent.search("iPad") > -1 && e.addEventListener("click", function(t) {
					var e;
					try {
						e = $(this.K).children(".bubble")
					} catch (n) {}
					e && e.length && a.trigger("bubble_click", e)
				})), e.setStyle(i[t.bubbleLevel]), t.isCenterBubble ? s = e : l.push(e), e
			},
			add: function(t) {
				for (var e = 0, a = t.length; a > e; e++) t[e].longitude && t[e].latitude && (t[e].price = c._fixNumber(t[e].avg_unit_price) || c._fixNumber(t[e].bs_avg_unit_price), t[e].price = t[e].price ? t[e].price + "万" : "", t[e].id = t[e].id || "", t[e].duration ? t[e].otherResource = "通勤时间" + Math.ceil(t[e].duration / 60) + "分钟" : t[e].otherResource = "", t[e].other_ctrl = $.inArray(g_conf.cityId, ["350200", "430100", "420100", "440300", "500000", "370101"]) > -1 ? 'onclick="return false" style="text-decoration: none;cursor:default"' : "", c._render(c._create(t[e])))
			},
			hasCenterPoint: function() {
				return !!s
			},
			getCenter: function() {
				return s
			},
			drawLine: function(t, a, n, i) {
				var o = new BMap.Polygon([new BMap.Point(t.lng, t.lat), new BMap.Point(a.lng, a.lat)], {
					strokeColor: "#e4393c",
					strokeWeight: 2,
					strokeOpacity: 1,
					strokeStyle: "solid",
					enableClicking: !1
				}),
					l = new BMap.Label($.replaceTpl(r.tpl, {
						steamMsg: n
					}), {
						position: new BMap.Point(((t.lng + a.lng) / 2).toFixed(6), ((t.lat + a.lat) / 2).toFixed(6)),
						offset: r.offset()
					});
				return l.setStyle(r.styles), function(t) {
					setTimeout(function() {
						t.setStyle({
							zIndex: "2"
						})
					}, 50)
				}(l), e.getMap().addOverlay(o), e.getMap().addOverlay(l), i.find(".name-other").length || i.find(".name-des").append($.replaceTpl(r.inlineTpl, {
					steamMsg: n
				})), {
					label: l,
					line: o
				}
			},
			clearLine: function(t) {
				e.getMap().removeOverlay(t.label), e.getMap().removeOverlay(t.line)
			}
		};
	return t = {
		clear: c.clear,
		add: c.add,
		hasCenter: c.hasCenterPoint,
		getCenter: c.getCenter,
		drawLine: c.drawLine,
		clearLine: c.clearLine
	}
}), define("map/js/house", function(require, t) {
	function e(t, e) {
		var a = !1;
		return $.each(e, function(e, n) {
			return n === t ? (a = !0, !1) : void 0
		}), a
	}
	function a(t, a, n) {
		var i = [];
		return $.each(t, function(t, n) {
			e(n, a) && i.push(n)
		}), n ? i.splice(0, n) : i
	}
	function n(t) {
		return $.each(t, function(t, e) {
			var n = "",
				i = e.tags && e.tags.split(",") || [],
				o = [];
			e.subway_station && o.push("subway_station"), e.school && o.push("school"), o = o.concat(a(S, i)), $.each(o, function(t, a) {
				var i = C[a].hoverTitle;
				i = i && e[a] ? "subway_station" === i ? $.replaceTpl(x.subwayItem, e[i]) : e.school.school_name : "", n += $.replaceTpl(x.roomTagItem, {
					tagClass: C[a].tagClass,
					title: C[a].title,
					tagTitle: i
				})
			}), e.tagsContent = n, e.house_area_origin = e.house_area, e.house_area = Math.floor(e.house_area), e.community_names = e.community_name, e.duration ? (e.wtf_any = e.duration, e.replace_com = "通勤时间" + Math.ceil(e.duration / 60) + "分钟") : (e.wtf_any = "", e.replace_com = e.community_name), "school" === e.curFuckType && (e.community_names = e.school && e.school.school_name || "", e.replace_com = e.community_name), e.title || (e.title = e.community_name + "&nbsp;" + e.frame_bedroom_num + "室" + e.frame_hall_num + "厅"), e.tips = "", "1" == e.is_new_house_source && (e.tips += y[0]), "1" == e.is_price_decrease && (e.tips += y[1]), e.list_picture_url = (e.list_picture_url || v).replace("280x210", "116x116"), e.defaultImgSrc = v
		}), t
	}
	function i(t, e) {
		var a = "";
		return t.length ? (t = n(t), $.each(t, function(t, e) {
			a += $.replaceTpl(x.roomListItem, e)
		}), a) : e ? "" : x.noDataItem
	}
	function o() {
		h.on("mouseenter", "a", function() {
			var t = $(".bubble[data-id='" + $(this).attr("data-community") + "']");
			t.parent().css({
				zIndex: 3
			}), t.addClass("hovered")
		}).on("mouseleave", "a", function() {
			var t = $(".bubble[data-id='" + $(this).attr("data-community") + "']");
			t.parent().css({
				zIndex: 2
			}), t.removeClass("hovered")
		})
	}
	function r() {
		if (-1 === navigator.userAgent.search("iPad")) d = h.scrollable({
			onWheel: function() {},
			onScroll: function() {
				if (this.state.y == -this.state._y) {
					if (b >= 200 || b >= _) return;
					clearTimeout(m), m = setTimeout(function() {
						f.trigger("update_house_add_" + g_conf.curChannel, {
							offset: b
						})
					}, 100)
				}
				0 == this.state.y
			},
			onEndPress: function() {},
			onEndDrag: function() {}
		});
		else {
			var t = $(window),
				e = h.get(0),
				a = h.parent();
			a.on("scroll", function() {
				e.getBoundingClientRect().bottom - 100 > (innerHeight || t.height()) || b >= 200 || b >= _ || (clearTimeout(m), m = setTimeout(function() {
					f.trigger("update_house_add_" + g_conf.curChannel, {
						offset: b
					})
				}, 80))
			}), d = {
				goTo: function(t) {
					a.scrollTop(t.y || 0)
				}
			}
		}
		o()
	}
	function l() {
		d && d.goTo({
			y: 0
		})
	}
	function s(t) {
		b = 1, _ = Math.ceil((t.data.total_count || 0) / 10), g.html(t.data.total_count || 0), h.html(i(t.data.list)), l()
	}
	function c(t, e) {
		h.append(i(t.data.list, !0)), b = e + 1
	}
	function u() {
		g.html(0), h.html(i([]))
	}
	require("map/js/scroll");
	var d, m, f = require("map/js/msg"),
		p = $("#" + g_conf.houseListId),
		h = p.find(".r-content"),
		g = p.find(".r-hd_i"),
		b = 1,
		_ = 0,
		v = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAJIAAAB0CAMAAABZuJsjAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAC1QTFRF8/Pz/Pz8/v7++Pj48vLy9PT0+/v7/f39+vr6+fn59vb29fX19/f3////8fHxhavVGQAAArZJREFUeNrs14FypCAMBmACgQAB3/9xL7C663btneu0N72bn5k6LhL8BAzWueWnFQcSSCCBBBJIIIEEEkgggQQSSCCBBBJIIIEEEkgggQQSSP8AKSo3jnWcMrM2x3yK1ELdTjWELYZrC60+9xBrCPXeAYegf4hJvSTveyJ1REm6/ZUzpN5lO829365zkT6K5Ed7Tf6pKvZefh/DkkptkoNy9aGEkEuWMyR7iu20rN3H0bn3g+BzCfNa6LNu3FM3UrjVv8bkGeOSJGmUKdrsabL6Vss1UrR+qUUXW5qPPafXTrK6WK3Kx1eSO4hZVBzlLPYQ3HJK3mniayS6Tck2NjTiDFLvVfRKOohZOPVM1TWvS0xj0oqvyyVStfFYdlV0WzF1t+LqR9JRjNVKpFCoU3TZiqTO10g26Y9WNiHWPfv1JmtV+kg6iBlNyFHjYGPjig1S10SXSCyPCsPQ6H69/VpoLpU96ShmTvcYGhmjRBSqZ+7tCsnJbg4epLZPN8LPpKOYOUz2rmm0jMnRItzh/b+JxJ+QLm4oL2vpqcNzpKOYryTZG6Xvkg5i5sRlCnZIOpJ7sqTWrpHU3mF+k2Q/hF9ItYutajtYNHlL77R/S95JlfbIFB+v1xnSjNGnGCsy2nk7z75aJvB5Sf4cScIsbiPx2BNSmZXFnyMtLzEjm42EPlrVHmxnpGJ3OEMqfS31vu1y7rvye9JxjCyuRWuolpF8jEJqJMk2XGdIbA81d/BB2nKwFpq14wLNjXhHynMQ9MYMn8RU2/Oc7XxpHMTFPicunxqlUTkLL7y7zO5eRpO42504rqsn3todxszkaN+V1kaV508Lc/HbPnSrbabvJJ+/8O09FrN3P4qUPYUv6gr/x4EEEkgggQQSSCCBBBJIIIEEEkgggQQSSCCBBBJIIIH035B+CTAAK+x5objF6rEAAAAASUVORK5CYII=",
		y = ['<span class="item-tip_new">新</span>', '<span class="item-tip_decrease">降价</span>'],
		S = ["is_sales_tax", "is_two_five", "is_quick_acting", "is_restriction"],
		C = {
			subway_station: {
				tagClass: "subway",
				title: "地铁",
				hoverTitle: "subway_station"
			},
			school: {
				tagClass: "school",
				title: "学区",
				hoverTitle: "school_name"
			},
			is_sales_tax: {
				tagClass: "taxfree",
				title: "满五唯一"
			},
			is_two_five: {
				tagClass: "five",
				title: "房本满两年"
			},
			is_quick_acting: {
				tagClass: "unique",
				title: "独家"
			},
			is_restriction: {
				tagClass: "restriction",
				title: "不限购"
			}
		},
		x = {
			roomListItem: '<li class="list-item"><a href="/ershoufang/#{house_code}.html" target="_blank" title="#{title}" data-community="#{community_id}"><div class="item-aside"><img src="#{list_picture_url}" onerror="this.src=\'#{defaultImgSrc}\'"><div class="item-btm"><span class="item-img-icon"><i class="i-icon-arrow"></i><i class="i-icon-dot"></i></span><span>#{house_picture_count}</span></div></div><div class="item-main"><p class="item-tle">#{title}#{tips}</p><p class="item-des"><span>#{frame_bedroom_num}室#{frame_hall_num}厅</span><span data-origin="#{house_area_origin}">#{house_area}平米</span><span>#{frame_orientation}</span><span class="item-side">#{price_total}<span>万</span></span></p><p class="item-community"><span class="item-replace-com" data-origin="#{wtf_any}">#{replace_com}</span><span class="item-exact-com">#{community_names}</span></p><p class="item-tag-wrap">#{tagsContent}</p></div></a></li>',
			roomTagItem: '<span class="item-tag-#{tagClass} item-extra" title="#{tagTitle}">#{title}</span>',
			noDataItem: '<li class="list-item-remind">呣..没有找到相关内容~</li>',
			subwayItem: "距离#{line_name}#{station_name}站#{distance_value}米"
		};
	return t = {
		add: c,
		render: s,
		init: r,
		scrollTop: l,
		clear: u
	}
}), define("map/js/card", function(require, t) {
	function e(t, e, a) {
		t.type = e, t.childType = a || "";
		var n;
		return t.other_ctrl = $.inArray(g_conf.cityId, ["350200", "430100", "420100", "440300", "500000", "370101"]) > -1 ? 'onclick="return false" style="text-decoration: none;cursor:default"' : "", null !== t.month_radio && void 0 !== t.month_radio ? (n = parseFloat(t.month_radio) || 0, t.trend = 0 > n ? "down" : "up", t.trendChar = 0 > n ? "&darr;" : "&uarr;", t.monthRadio = Math.abs(n), t.forceStyle = 0 == n ? "display: none" : "") : (t.trend = "up", t.trendChar = "&uarr;", t.monthRadio = "-/-", t.forceStyle = "display: none"), t.avgUnitPrice = Math.floor(parseFloat(t.avg_unit_price || t.bs_avg_unit_price || 0)), t
	}
	var a = require("map/js/msg"),
		n = $("#" + g_conf.houseListId),
		i = n.find(".r-hd3-content"),
		o = n.find(".r-hd3"),
		r = {
			0: '<ol class="i-card i-card-1"><li class="i-card-name">#{city_name}</li><li class="i-card-price"><span>#{avgUnitPrice}</span>元/m²</li><li>共#{district_count}个#{childType}</li><li class="i-card-radio">#{type}均价，同比上月<i class="i-card-#{trend}" style="#{forceStyle}">#{trendChar}</i>#{monthRadio}%</span></li></ol>',
			1: '<ol class="i-card i-card-1"><li class="i-card-name">#{district_name}</li><li class="i-card-price"><span>#{avgUnitPrice}</span>元/m²</li><li>共#{bizcircle_count}个#{childType}</li><li class="i-card-radio">#{type}均价，同比上月<i class="i-card-#{trend}" style="#{forceStyle}">#{trendChar}</i>#{monthRadio}%</span></li></ol>',
			2: '<ol class="i-card i-card-2"><li class="i-card-name" title="#{bizcircle_name}">#{bizcircle_name}</li><li class="i-card-price"><span>#{avgUnitPrice}</span>元/m²</li><li>#{district_name}</li><li class="i-card-radio">#{type}均价，同比上月<i class="i-card-#{trend}" style="#{forceStyle}">#{trendChar}</i>#{monthRadio}%</span></li></ol>',
			3: '<ol class="i-card i-card-3"><li class="i-card-name"><a href="/xiaoqu/#{community_id}/" target="_blank" title="#{community_name}" #{other_ctrl}>#{community_name}</a></li><li class="i-card-price"><span>#{avgUnitPrice}</span>元/m²</li><li>#{district_name}&nbsp;#{bizcircle_name}</li><li class="i-card-radio">#{type}均价，同比上月<i class="i-card-#{trend}" style="#{forceStyle}">#{trendChar}</i>#{monthRadio}%</span></li></ol>',
			4: '<ol class="i-card i-card-4"><li class="i-card-name">#{district_name}</li><li class="i-card-price"><span>#{avgUnitPrice}</span>元/m²</li><li>共#{school_count}#{childType}</li><li class="i-card-radio">#{type}均价，同比上月<i class="i-card-#{trend}" style="#{forceStyle}">#{trendChar}</i>#{monthRadio}%</span></li></ol>',
			5: '<ol class="i-card i-card-5"><li class="i-card-name"><a target="_blank" href="/xuequfang/#{school_id}.html">#{school_name}</a></li><li class="i-card-price"><span>#{min_price_total}</span>万起</li><li>共#{school_related_community_count}#{childType}</li><li class="i-card-radio">#{type}均价，同比上月<i class="i-card-#{trend}" style="#{forceStyle}">#{trendChar}</i>#{monthRadio}%</span></li></ol>'
		},
		l = {
			render: function(t, a, n, o) {
				t = e(t, n, o), i.html($.replaceTpl(r[a], t))
			}
		};
	return $.each(["show", "hide"], function(t, e) {
		l[e] = function(t) {
			o[e](), a.trigger("houseContentHeightChange")
		}
	}), t = l
}), define("map/js/steam", function(require, t) {
	function e(t) {
		$.each(["bubble", "card", "house"], function(e, a) {
			W[a + "Url"] = {
				path: z[t][a + "Path"],
				params: z[t][a + "ParamArray"]
			}
		})
	}
	function a() {
		var t = y.getBounds(),
			e = {
				longitude: T,
				latitude: M,
				mode: k,
				range: j,
				min_longitude: t.min_longitude,
				max_longitude: t.max_longitude,
				min_latitude: t.min_latitude,
				max_latitude: t.max_latitude
			};
		return e
	}
	function n(t) {
		var e = [],
			a = y.getBounds(),
			n = {
				min_longitude: parseFloat(a.min_longitude),
				max_longitude: parseFloat(a.max_longitude),
				min_latitude: parseFloat(a.min_latitude),
				max_latitude: parseFloat(a.max_latitude)
			};
		return $.each(t, function(t, a) {
			var i = parseFloat(a.longitude),
				o = parseFloat(a.latitude);
			i <= n.max_longitude && i >= n.min_longitude && o <= n.max_latitude && o >= n.min_latitude && e.push(a)
		}), e
	}
	function i(t) {
		var e = y.getZoom() < 16 ? "21" : "3";
		return t = t && t.data || [], t = n(t || []), $.each(t, function(t, a) {
			a.bubbleLevel = e
		}), t
	}
	function o(t, e) {
		var a, n = "undefined" != typeof e,
			i = [];
		W.houseAjax && (W.houseAjax.cbFunc = null, W.houseAjax = null), $.each(t, function(t, e) {
			i.push(e.id)
		}), a = {
			ids: i.join(","),
			limit_offset: 10 * (e || 0),
			limit_count: 10,
			mode: k,
			range: j,
			longitude: T,
			latitude: M,
			sort: g_conf.houseListSortCtrl
		}, t.length ? W.getHouseList(a, function(t) {
			r(t, n, e)
		}) : r({
			data: {
				total_count: 0,
				list: []
			}
		}, n, e)
	}
	function r(t, e, a) {
		e ? v.add(t, a) : v.render(t)
	}
	function l(t) {
		_.clear(), _.add(t)
	}
	function s(t, e) {
		W.cardAjax && (W.cardAjax.cbFunc = null, W.cardAjax = null);
		var a = {
			id: t.id
		};
		W.getCards(a, function(t) {
			c(t, e)
		})
	}
	function c(t, e) {
		S.render(t.data, e, "2" === e ? "商圈" : "小区"), S.show()
	}
	function u(t, a) {
		e(y.getZoom() < 16 ? "bizcycle" : "community"), W.bubbleAjax && (W.bubbleAjax.cbFunc = null, W.bubbleAjax = null), W.getBubbles(t, function(t) {
			t = i(t), I = t, o(t), l(t)
		})
	}
	function d(t) {
		var e = ['<li data-longitude="#{longitude}" data-latitude="#{latitude}"', ' data-origin="#{q}" data-id="#{id}" q="#{text}">#{formatText}</li>'].join("");
		C(t[0], {
			classNameWrap: "sug-search",
			classNameQuery: "sug-query",
			classNameSelect: "sug-select",
			delay: 200,
			n: 10,
			autoFocus: !1,
			requestQuery: "q",
			requestParas: {
				callback: "steamSug2015",
				city_id: g_conf.cityId
			},
			url: w + x.steamSug,
			callbackFn: "steamSug2015",
			callbackDataKey: "data",
			noSubmit: !0,
			onMouseSelect: function(e) {
				e && (t.attr("data-longitude", $(e).attr("data-longitude")), t.attr("data-latitude", $(e).attr("data-latitude")), t.attr("data-q", $(e).attr("q")))
			},
			onSelect: function(t) {},
			onKeySelect: function(e) {
				e && (t.attr("data-longitude", $(e).attr("data-longitude")), t.attr("data-latitude", $(e).attr("data-latitude")), t.attr("data-q", $(e).attr("q")))
			},
			onRequest: function() {
				t.attr("data-longitude", ""), t.attr("data-latitude", ""), t.attr("data-q", "")
			},
			onFill: function() {},
			templ: function(a, n) {
				for (var i = a.data || [], o = [], r = 0, l = i.length; l > r; r++) i[r].q = n, i[r].formatText = i[r].text.replace(n, '<span class="sug-query">' + n + "</span>"), o.push($.replaceTpl(e, i[r]));
				return l && (t.attr("data-longitude", i[0].longitude), t.attr("data-latitude", i[0].latitude), t.attr("data-q", i[0].text)), "<ol>" + o.join("") + "</ol>"
			}
		})
	}
	function m() {
		E.one("init", function() {
			$(this).html('<p class="m-top">通勤找房可以为您找到符合上班往返时间需求的房源</p><div class="m-main"><input type="text" class="steam-input" autocomplete="off" placeholder="请输入工作地或附近地标类建筑，如昆泰大厦" data-longitude="" data-latitude="" data-q=""><ol><li class="li" data-type="steamWay"><span>选择通勤方式</span><i class="drop-i"></i></li><li class="li" data-type="steamTime"><span>选择通勤时间</span><i class="drop-i"></i></li></ol><button>开始查找</button></div><div class="m-btm"><span></span><p class="m-btm-tle">什么是通勤？如何使用通勤找房？</p><p>通勤，是指从家往返工作地点的过程。</p><p>如您的工作地在昆泰大厦，您每天上班的交通方式是自驾，期望到达工作地的时间是30分钟，那么在地图上为您推荐的就是自驾到昆泰大厦30分钟内的房源。</p></div>'), function() {
				var t = E.find(".li");
				t.one("mouseenter", function() {
					var t = $(this),
						e = t.attr("data-type"),
						a = "";
					U[e] && ($.each(U[e], function(t, e) {
						a += $.replaceTpl(D, e)
					}), t.append($.replaceTpl(q, {
						content: a
					})))
				}), t.each(function(t, e) {
					var a = $(this),
						n = a.find(".drop-list"),
						i = a.find(".drop-i"),
						o = a.find("span"),
						r = o.html(),
						l = null;
					a.on("click", ".item", function() {
						var t = $(this),
							e = $.trim(t.attr("data-value")) || "",
							s = a.attr("data-value") || "";
						s != e && (a.attr("data-value", e), e ? o.html(t.html()) : o.html(r), l && l.removeClass("clicked"), t.addClass("clicked"), l = t), n.length || (n = a.find(".drop-list")), n.hide(), i.removeClass("drop-open")
					}).on("mouseenter", function() {
						n.length || (n = a.find(".drop-list")), n.show(), i.addClass("drop-open")
					}).on("mouseleave", function() {
						n.length || (n = a.find(".drop-list")), n.hide(), i.removeClass("drop-open")
					})
				})
			}();
			var t = E.find(".steam-input"),
				e = E.find(".li"),
				a = e.eq(0),
				n = e.eq(1);
			d(t), $.fixPlaceholder && $.fixPlaceholder(t);
			var i = a.children("span"),
				o = n.children("span"),
				r = E.find("button");
			r.on("click", function() {
				var e, r = $.trim(t.val()),
					l = t.attr("data-longitude"),
					s = t.attr("data-latitude"),
					c = t.attr("data-q"),
					u = $.trim(a.attr("data-value") || ""),
					d = $.trim(n.attr("data-value") || "");
				return P = c, A = r, T = l, M = s, k = u, j = d, r && l && s ? u ? d ? (E.hide(), L.show(), e = {
					mode: u,
					range: d,
					name: r,
					sugName: c,
					longitude: l,
					latitude: s,
					wayVal: $.trim(i.html()),
					timeVal: $.trim(o.html())
				}, "undefined" != typeof UT && UT.send({
					modId: "mapSteamSearch",
					position: "success",
					type: "click",
					sort: r,
					q: r
				}), B.html($.replaceTpl(H, e)), B.show(), b.trigger("houseContentHeightChange"), void b.trigger("steamUpdate", e)) : ("undefined" != typeof UT && UT.send({
					modId: "mapSteamSearch",
					position: "error-time",
					type: "click",
					sort: r,
					q: r
				}), n.addClass("i-remind"), void setTimeout(function() {
					n.removeClass("i-remind")
				}, 1e3)) : ("undefined" != typeof UT && UT.send({
					modId: "mapSteamSearch",
					position: "error-way",
					type: "click",
					sort: r,
					q: r
				}), a.addClass("i-remind"), void setTimeout(function() {
					a.removeClass("i-remind")
				}, 1e3)) : ("undefined" != typeof UT && UT.send({
					modId: "mapSteamSearch",
					position: "error-" + (r ? "coord" : "value"),
					type: "click",
					sort: r,
					q: r
				}), t.addClass("i-remind"), t.focus(), void setTimeout(function() {
					t.removeClass("i-remind"), t.focus()
				}, 1e3))
			})
		}), b.on("steamUpdate", function(t, e) {
			var a = y.getZoom();
			y.centerAndZoom(e.longitude, e.latitude, 16), _.clear(!0), e.bubbleLevel = 4, e.isCenterBubble = !0, _.add([e]), 16 === a && (e.channel = "steamSearch", b.trigger("update", e))
		}), b.on("update_Steam", function(t, e) {
			_.hasCenter() && (u(a(), e), y.isClickEvent ? y.isClickEvent = !1 : S.hide())
		}), b.on("click_Steam", function(t, a) {
			var n = y.getZoom();
			y.isClickEvent = !0;
			var i = 16 > n ? "bizcycle" : "community";
			e(i), 16 > n ? y.centerAndZoom(a.longitude, a.latitude, 16) : (I = [a], o(I), y.isClickEvent = !1), s(a, 16 > n ? "2" : "3")
		}), b.on("update_house_add_Steam", function(t, e) {
			o(I, e.offset)
		}), b.on("update_house_sort_Steam", function(t) {
			o(I)
		}), B.on("click", ".i-btn-return", function() {
			E.show(), L.hide()
		}), $(document.body).on("mouseenter", ".bubble-3", function() {
			var t, e = $(this),
				a = _.getCenter();
			"Steam" === g_conf.curChannel && !e.attr("data-disabled") && a && (t = a.getPosition(), h && _.clearLine(h) && (h = null), h = _.drawLine({
				lng: parseFloat(e.attr("data-longitude")),
				lat: parseFloat(e.attr("data-latitude"))
			}, t, e.attr("data-msg") || "", e))
		}).on("mouseleave", ".bubble-3", function() {
			var t = $(this);
			"Steam" !== g_conf.curChannel || t.attr("data-disabled") || h && _.clearLine(h) && (h = null)
		})
	}
	function f() {
		E.trigger("init"), L.hide(), E.show(), _.clear(!0), N.hide(), P = "", A = "", T = "", M = "", k = "", j = "", I = []
	}
	function p() {
		m()
	}
	var h, g = require("map/js/model"),
		b = require("map/js/msg"),
		_ = require("map/js/bubble"),
		v = require("map/js/house"),
		y = require("map/js/mapView"),
		S = require("map/js/card"),
		C = require("map/js/suggest"),
		x = g_conf.urlPath,
		w = x.basePath,
		P = "",
		A = "",
		T = "",
		M = "",
		k = "",
		j = "",
		I = [],
		F = $("#" + g_conf.houseListId),
		L = F.find(".r-list"),
		E = F.find(".r-ctrl"),
		B = F.find(".r-top"),
		N = F.find(".r-station_guide"),
		q = '<ol class="drop-list">#{content}</ol>',
		D = '<li data-value="#{value}" class="item">#{title}</li>',
		H = '<span class="i-top-remind">当前条件：</span>#{name}/#{wayVal}/#{timeVal}以内<span class="i-btn-return">修改条件</span>',
		U = {
			steamWay: [{
				value: "walk",
				title: "步行"
			}, {
				value: "driving",
				title: "自驾"
			}],
			steamTime: [{
				value: "15m",
				title: "15分钟"
			}, {
				value: "30m",
				title: "30分钟"
			}, {
				value: "60m",
				title: "60分钟"
			}]
		},
		z = {
			community: {
				bubblePath: w + x.mapSearch.SteamCommunity,
				bubbleParamArray: ["longitude", "latitude", "mode", "range", "min_longitude", "max_longitude", "min_latitude", "max_latitude"],
				cardPath: w + x.cardSearch.SteamCommunity,
				cardParamArray: ["id"],
				housePath: w + x.houseList.SteamCommunity,
				houseParamArray: ["ids", "limit_offset", "limit_count", "longitude", "latitude", "mode", "range", "sort"]
			},
			bizcycle: {
				bubblePath: w + x.mapSearch.SteamBizcycle,
				bubbleParamArray: ["longitude", "latitude", "mode", "range", "min_longitude", "max_longitude", "min_latitude", "max_latitude"],
				cardPath: w + x.cardSearch.SteamBizcycle,
				cardParamArray: ["id"],
				housePath: w + x.houseList.SteamBizcycle,
				houseParamArray: ["ids", "limit_offset", "limit_count", "longitude", "latitude", "mode", "range", "sort"]
			}
		},
		W = new g({
			bubblePath: z.community.bubblePath,
			bubbleParamArray: z.community.bubbleParamArray,
			cardPath: z.community.bubblePath,
			cardParamArray: z.community.bubbleParamArray,
			housePath: z.community.bubblePath,
			houseParamArray: z.community.bubblePath
		});
	return W.init = p, W.reset = f, t = W
}), define("map/js/area", function(require, t) {
	function e(t) {
		$.each(["bubble", "card", "house"], function(e, a) {
			E[a + "Url"] = {
				path: F[t][a + "Path"],
				params: F[t][a + "ParamArray"]
			}
		})
	}
	function a() {
		var t = C.getBounds(),
			e = {
				min_longitude: t.min_longitude,
				max_longitude: t.max_longitude,
				min_latitude: t.min_latitude,
				max_latitude: t.max_latitude
			};
		return e
	}
	function n(t) {
		return 13 >= t ? "district" : t >= 16 ? "community" : "bizcycle"
	}
	function i(t) {
		return 13 >= t ? "5" : t >= 16 ? "3" : "2"
	}
	function o(t) {
		return t >= 16 ? "3" : t >= 14 ? "2" : "1"
	}
	function r(t) {
		return 14 > t ? 14 : 16 > t ? 16 : void 0
	}
	function l(t) {
		var e = [],
			a = C.getBounds(),
			n = {
				min_longitude: parseFloat(a.min_longitude),
				max_longitude: parseFloat(a.max_longitude),
				min_latitude: parseFloat(a.min_latitude),
				max_latitude: parseFloat(a.max_latitude)
			};
		return $.each(t, function(t, a) {
			var i = parseFloat(a.longitude),
				o = parseFloat(a.latitude);
			i <= n.max_longitude && i >= n.min_longitude && o <= n.max_latitude && o >= n.min_latitude && e.push(a)
		}), e
	}
	function s(t) {
		var e = i(C.getZoom());
		return t = t && t.data || [], t = l(t || []), $.each(t, function(t, a) {
			a.bubbleLevel = e
		}), t
	}
	function c(t, e) {
		var a, n = "undefined" != typeof e,
			i = [];
		E.houseAjax && (E.houseAjax.cbFunc = null, E.houseAjax = null), $.each(t, function(t, e) {
			i.push(e.id)
		}), a = {
			ids: i.join(","),
			limit_offset: 10 * (e || 0),
			limit_count: 10,
			sort: g_conf.houseListSortCtrl
		}, t.length ? E.getHouseList(a, function(t) {
			u(t, n, e)
		}) : u({
			data: {
				total_count: 0,
				list: []
			}
		}, n, e)
	}
	function u(t, e, a) {
		e ? S.add(t, a) : S.render(t)
	}
	function d(t) {
		y.clear(), y.add(t)
	}
	function m(t, e, a) {
		E.cardAjax && (E.cardAjax.cbFunc = null, E.cardAjax = null);
		var n = {
			id: t.id
		};
		E.getCards(n, function(t) {
			f(t, e)
		}, a)
	}
	function f(t, e) {
		x.render(t.data, e, L[e][0], L[e][1]), x.show()
	}
	function p(t, a) {
		e(n(C.getZoom())), E.bubbleAjax && (E.bubbleAjax.cbFunc = null, E.bubbleAjax = null), E.getBubbles(t, function(t) {
			t = s(t), A = t, c(t), d(t)
		})
	}
	function h() {
		v.on("update_Area", function(t, e) {
			p(a(), e), C.isClickEvent ? C.isClickEvent = !1 : x.hide()
		}), v.on("click_Area", function(t, a) {
			var i = C.getZoom();
			C.isClickEvent = !0;
			var l = n(i);
			e(l), 16 > i ? C.centerAndZoom(a.longitude, a.latitude, r(i)) : (A = [a], c(A), C.isClickEvent = !1), m(a, o(i))
		}), v.on("update_house_add_Area", function(t, e) {
			c(A, e.offset)
		}), v.on("update_house_sort_Area", function(t) {
			c(A)
		})
	}
	function g(t) {
		if (M.show(), k.hide(), j.hide(), I.hide(), v.trigger("houseContentHeightChange"), y.clear(!0), A = [], t) {
			var a = g_conf.searchConf;
			if (a) {
				var i = a.longitude,
					r = a.latitude,
					l = a.type,
					s = B[l],
					c = s === C.getZoom();
				C.isClickEvent = !0, e(n(s)), i && r ? (a.id && ("" + a.id).split(",").length > 1 ? C.isClickEvent = !1 : m(a, o(s)), C.centerAndZoom(i, r, s)) : (C.isClickEvent = !1, C.resetMap()), c && v.trigger("update_Area", {
					channel: "code"
				})
			}
		} else C.isClickEvent = !0, m({
			id: g_conf.cityId
		}, "0", P + w.cardSearch.AreaCity + "?id=" + g_conf.cityId), 12 == C.getZoom() && v.trigger("update")
	}
	function b() {
		h()
	}
	var _ = require("map/js/model"),
		v = require("map/js/msg"),
		y = require("map/js/bubble"),
		S = require("map/js/house"),
		C = require("map/js/mapView"),
		x = require("map/js/card"),
		w = g_conf.urlPath,
		P = w.basePath,
		A = [],
		T = $("#" + g_conf.houseListId),
		M = T.find(".r-list"),
		k = T.find(".r-ctrl"),
		j = T.find(".r-top"),
		I = T.find(".r-station_guide"),
		F = {
			community: {
				bubblePath: P + w.mapSearch.AreaCommunity,
				bubbleParamArray: ["min_longitude", "max_longitude", "min_latitude", "max_latitude"],
				cardPath: P + w.cardSearch.AreaCommunity,
				cardParamArray: ["id"],
				housePath: P + w.houseList.AreaCommunity,
				houseParamArray: ["ids", "limit_offset", "limit_count", "sort"]
			},
			bizcycle: {
				bubblePath: P + w.mapSearch.AreaBizcycle,
				bubbleParamArray: [],
				cardPath: P + w.cardSearch.AreaBizcycle,
				cardParamArray: ["id"],
				housePath: P + w.houseList.AreaBizcycle,
				houseParamArray: ["ids", "limit_offset", "limit_count", "sort"]
			},
			district: {
				bubblePath: P + w.mapSearch.AreaDistrict,
				bubbleParamArray: [],
				cardPath: P + w.cardSearch.AreaDistrict,
				cardParamArray: ["id"],
				housePath: P + w.houseList.AreaDistrict,
				houseParamArray: ["ids", "limit_offset", "limit_count", "sort"]
			}
		},
		L = {
			2: ["商圈"],
			3: ["小区"],
			1: ["区域", "商圈"],
			0: ["城市", "区域"]
		},
		E = new _({
			bubblePath: F.community.bubblePath,
			bubbleParamArray: F.community.bubbleParamArray,
			cardPath: F.community.bubblePath,
			cardParamArray: F.community.bubbleParamArray,
			housePath: F.community.bubblePath,
			houseParamArray: F.community.bubblePath
		}),
		B = {
			district: 12,
			bizcircle: 14,
			community: 16,
			other: 12
		};
	return E.init = b, E.reset = g, t = E
}), define("map/js/school", function(require, t) {
	function e(t) {
		$.each(["bubble", "card", "house"], function(e, a) {
			H[a + "Url"] = {
				path: q[t][a + "Path"],
				params: q[t][a + "ParamArray"]
			}
		})
	}
	function a() {
		var t = A.getBounds(),
			e = {
				min_longitude: t.min_longitude,
				max_longitude: t.max_longitude,
				min_latitude: t.min_latitude,
				max_latitude: t.max_latitude
			};
		return e
	}
	function n(t) {
		return 13 >= t ? "district" : t >= 16 ? "community" : "school"
	}
	function i(t) {
		return 13 >= t ? "6" : t >= 16 ? "3" : "7"
	}
	function o(t) {
		return t >= 16 ? "3" : t >= 14 ? "5" : "4"
	}
	function r(t) {
		return 14 > t ? 14 : 16 > t ? 16 : void 0
	}
	function l(t) {
		var e = [],
			a = A.getBounds(),
			n = {
				min_longitude: parseFloat(a.min_longitude),
				max_longitude: parseFloat(a.max_longitude),
				min_latitude: parseFloat(a.min_latitude),
				max_latitude: parseFloat(a.max_latitude)
			};
		return $.each(t, function(t, a) {
			var i = parseFloat(a.longitude),
				o = parseFloat(a.latitude);
			i <= n.max_longitude && i >= n.min_longitude && o <= n.max_latitude && o >= n.min_latitude && e.push(a)
		}), e
	}
	function s(t) {
		var e = i(A.getZoom());
		if (t = t && t.data || [], t = l(t || []), $.each(t, function(t, a) {
			a.bubbleLevel = e
		}), "3" === e && g_conf.allSchoolMsg) {
			var a = l(g_conf.allSchoolMsg);
			$.each(a, function(e, a) {
				a.isExactSchool = !0, a.bubbleLevel = "8", t.push(a)
			})
		} else $.each(t, function(t, e) {
			e.isExactSchool = !1
		});
		return t
	}
	function c(t, e) {
		var a, n = "undefined" != typeof e,
			i = [];
		H.houseAjax && (H.houseAjax.cbFunc = null, H.houseAjax = null), $.each(t, function(t, e) {
			!e.isExactSchool && i.push(e.id)
		}), a = {
			ids: i.join(","),
			limit_offset: 10 * (e || 0),
			limit_count: 10,
			sort: g_conf.houseListSortCtrl
		}, t.length ? H.getHouseList(a, function(t) {
			u(t, n, e)
		}) : u({
			data: {
				total_count: 0,
				list: []
			}
		}, n, e)
	}
	function u(t, e, a) {
		$.each(t.data.list, function(t, e) {
			e.curFuckType = "school"
		}), e ? P.add(t, a) : P.render(t)
	}
	function d(t) {
		w.clear(), w.add(t)
	}
	function m(t, a, n) {
		H.cardAjax && (H.cardAjax.cbFunc = null, H.cardAjax = null);
		var i = {
			id: t.id
		};
		t.isSchool && e("school"), H.getCards(i, function(t) {
			f(t, a)
		}, n), t.isSchool && e("community")
	}
	function f(t, e) {
		T.render(t.data, e, D[e][0], D[e][1]), T.show()
	}
	function p(t) {
		var e = [],
			a = I && I.id;
		return a ? ($.each(t, function(t, n) {
			(n.school_id == a || n.isExactSchool) && e.push(n)
		}), I = null) : e = t, e
	}
	function h(t, a) {
		e(n(A.getZoom())), H.bubbleAjax && (H.bubbleAjax.cbFunc = null, H.bubbleAjax = null), H.getBubbles(t, function(t) {
			t = s(t), t = p(t), j = t, c(t), d(t)
		})
	}
	function g() {
		x.on("update_School", function(t, e) {
			A.getZoom();
			h(a(), e), A.isClickEvent ? A.isClickEvent = !1 : T.hide()
		}), x.on("click_School", function(t, a) {
			var i = A.getZoom(),
				l = a.isSchool;
			A.isClickEvent = !0;
			var s = n(i);
			e(s), I = l ? {
				lng: a.longitude,
				lat: a.latitude,
				id: a.id
			} : null, 16 > i ? A.centerAndZoom(a.longitude, a.latitude, r(i)) : l ? (A.getMap().setCenter(new BMap.Point(a.longitude, a.latitude)), x.trigger("update_School", {
				channel: "clickSchool"
			})) : (j = [a], c(j), A.isClickEvent = !1), m(a, l ? "5" : o(i))
		}), x.on("update_house_add_School", function(t, e) {
			c(j, e.offset)
		}), x.on("update_house_sort_School", function(t) {
			c(j)
		}), $(document.body).on("mouseenter", ".bubble-3", function() {
			var t, e = $(this);
			if ("School" === g_conf.curChannel) {
				var a, n = {
					lng: parseFloat(e.attr("data-longitude")),
					lat: parseFloat(e.attr("data-latitude"))
				};
				if (t = _(e.attr("data-schoolid")), S && w.clearLine(S) && (S = null), !t) return;
				a = {
					lng: parseFloat(t.longitude),
					lat: parseFloat(t.latitude)
				}, S = w.drawLine(n, a, "距" + t.name + b(n, a) + "公里", e)
			}
		}).on("mouseleave", ".bubble-3", function() {
			$(this);
			"School" === g_conf.curChannel && S && w.clearLine(S) && (S = null)
		})
	}
	function b(t, e) {
		return (A.getMap().getDistance(new BMap.Point(t.lng, t.lat), new BMap.Point(e.lng, e.lat)) / 1e3).toFixed(1)
	}
	function _(t) {
		var e;
		return g_conf.allSchoolMsg ? ($.each(g_conf.allSchoolMsg, function(a, n) {
			return n.id == t ? (e = n, !1) : void 0
		}), e) : e
	}
	function v(t) {
		if (L.show(), E.hide(), B.hide(), N.hide(), x.trigger("houseContentHeightChange"), w.clear(!0), j = [], t) {
			var a = g_conf.searchConf;
			if (a) {
				var i = a.longitude,
					r = a.latitude,
					l = a.type,
					s = U[l],
					c = s === A.getZoom();
				A.isClickEvent = !0, e(n(s)), i && r ? (m(a, o(s)), A.centerAndZoom(i, r, s)) : (A.isClickEvent = !1, A.resetMap()), c && x.trigger("update_School", {
					channel: "code"
				})
			}
		} else 12 == A.getZoom() && x.trigger("update")
	}
	function y() {
		g()
	}
	var S, C = require("map/js/model"),
		x = require("map/js/msg"),
		w = require("map/js/bubble"),
		P = require("map/js/house"),
		A = require("map/js/mapView"),
		T = require("map/js/card"),
		M = g_conf.urlPath,
		k = M.basePath,
		j = [],
		I = null,
		F = $("#" + g_conf.houseListId),
		L = F.find(".r-list"),
		E = F.find(".r-ctrl"),
		B = F.find(".r-top"),
		N = F.find(".r-station_guide"),
		q = {
			community: {
				bubblePath: k + M.mapSearch.SchoolCommunity,
				bubbleParamArray: ["min_longitude", "max_longitude", "min_latitude", "max_latitude"],
				cardPath: k + M.cardSearch.SchoolCommunity,
				cardParamArray: ["id"],
				housePath: k + M.houseList.SchoolCommunity,
				houseParamArray: ["ids", "limit_offset", "limit_count", "sort"]
			},
			school: {
				bubblePath: k + M.mapSearch.SchoolSchool,
				bubbleParamArray: [],
				cardPath: k + M.cardSearch.SchoolSchool,
				cardParamArray: ["id"],
				housePath: k + M.houseList.SchoolSchool,
				houseParamArray: ["ids", "limit_offset", "limit_count", "sort"]
			},
			district: {
				bubblePath: k + M.mapSearch.SchoolDistrict,
				bubbleParamArray: [],
				cardPath: k + M.cardSearch.SchoolDistrict,
				cardParamArray: ["id"],
				housePath: k + M.houseList.SchoolDistrict,
				houseParamArray: ["ids", "limit_offset", "limit_count", "sort"]
			}
		},
		D = {
			3: ["小区"],
			4: ["区域", "所优质小学"],
			5: ["学区", "个划片小区"]
		},
		H = new C({
			bubblePath: q.community.bubblePath,
			bubbleParamArray: q.community.bubbleParamArray,
			cardPath: q.community.bubblePath,
			cardParamArray: q.community.bubbleParamArray,
			housePath: q.community.bubblePath,
			houseParamArray: q.community.bubblePath
		}),
		U = {
			school: 14
		};
	return H.init = y, H.reset = v, t = H
}), define("map/js/station", function(require, t) {
	function e(t) {
		$.each(["bubble", "card", "house"], function(e, a) {
			K[a + "Url"] = {
				path: R[t][a + "Path"],
				params: R[t][a + "ParamArray"]
			}
		})
	}
	function a() {
		var t = L.getBounds(),
			e = {
				min_longitude: t.min_longitude,
				max_longitude: t.max_longitude,
				min_latitude: t.min_latitude,
				max_latitude: t.max_latitude,
				line_id: T
			};
		return e
	}
	function n(t) {
		return t >= 16 ? "community" : "station"
	}
	function i(t) {
		return t >= 16 ? "3" : "9"
	}
	function o(t) {
		return t >= 16 ? "3" : t >= 14 ? "2" : "1"
	}
	function r(t) {
		return 16 > t ? 16 : void 0
	}
	function l(t) {
		var e = [],
			a = L.getBounds(),
			n = {
				min_longitude: parseFloat(a.min_longitude),
				max_longitude: parseFloat(a.max_longitude),
				min_latitude: parseFloat(a.min_latitude),
				max_latitude: parseFloat(a.max_latitude)
			};
		return $.each(t, function(t, a) {
			var i = parseFloat(a.longitude),
				o = parseFloat(a.latitude);
			i <= n.max_longitude && i >= n.min_longitude && o <= n.max_latitude && o >= n.min_latitude && e.push(a)
		}), e
	}
	function s(t) {
		var e = i(L.getZoom());
		if (t = t && t.data || [], t = l(t || []), $.each(t, function(t, a) {
			a.bubbleLevel = e
		}), "3" === e && g_conf.allStationMsg && T) {
			var a = l(_(T).station);
			$.each(a, function(e, a) {
				a.isExactStation = !0, a.bubbleLevel = "10", t.push(a)
			})
		} else $.each(t, function(t, e) {
			e.isExactStation = !1
		});
		return t
	}
	function c(t, e) {
		var a, n = "undefined" != typeof e,
			i = [];
		K.houseAjax && (K.houseAjax.cbFunc = null, K.houseAjax = null), $.each(t, function(t, e) {
			!e.isExactStation && i.push(e.id)
		}), a = {
			ids: i.join(","),
			limit_offset: 10 * (e || 0),
			limit_count: 10,
			sort: g_conf.houseListSortCtrl,
			id: g_conf.cityId
		}, t.length ? K.getHouseList(a, function(t) {
			u(t, n, e)
		}) : u({
			data: {
				total_count: 0,
				list: []
			}
		}, n, e)
	}
	function u(t, e, a) {
		$.each(t.data.list, function(t, e) {
			e.curFuckType = "station"
		}), e ? F.add(t, a) : F.render(t)
	}
	function d(t) {
		I.clear(), I.add(t)
	}
	function m(t, e, a) {
		K.cardAjax && (K.cardAjax.cbFunc = null, K.cardAjax = null);
		var n = {
			id: t.id
		};
		K.getCards(n, function(t) {
			f(t, e)
		}, a)
	}
	function f(t, e) {
		E.render(t.data, e, Q[e][0], Q[e][1]), E.show()
	}
	function p(t, a) {
		e(n(L.getZoom())), K.bubbleAjax && (K.bubbleAjax.cbFunc = null, K.bubbleAjax = null), K.getBubbles(t, function(t) {
			t = s(t), q = t, c(t), d(t)
		})
	}
	function h() {
		j.on("update_Station", function(t, n) {
			!z && T ? (p(a(), n), L.isClickEvent ? L.isClickEvent = !1 : E.hide()) : n && "filter" === n.channel && (e("defaults"), q = [0], c(q))
		}), j.on("click_Station", function(t, a) {
			var i = L.getZoom();
			L.isClickEvent = !0;
			var l = n(i);
			e(l), a.imSpecial ? L.centerAndZoom(a.longitude, a.latitude, 16) : 16 > i ? L.centerAndZoom(a.longitude, a.latitude, r(i)) : (q = [a], c(q), L.isClickEvent = !1, m(a, o(i)))
		}), j.on("update_house_add_Station", function(t, e) {
			c(q, e.offset)
		}), j.on("update_house_sort_Station", function(t) {
			c(q)
		}), $(document.body).on("mouseenter", ".bubble-3", function() {
			var t, e = $(this);
			if ("Station" === g_conf.curChannel) {
				var a, n = {
					lng: parseFloat(e.attr("data-longitude")),
					lat: parseFloat(e.attr("data-latitude"))
				};
				if (t = b(e.attr("data-station"), T), A && I.clearLine(A) && (A = null), !t) return;
				a = {
					lng: parseFloat(t.longitude),
					lat: parseFloat(t.latitude)
				}, A = I.drawLine(n, a, "距" + t.name + g(n, a) + "公里", e)
			}
		}).on("mouseleave", ".bubble-3", function() {
			$(this);
			"Station" === g_conf.curChannel && A && I.clearLine(A) && (A = null)
		}), Z.on("mouseenter", ".subway-select", function() {
			S(), setTimeout(function() {
				U && U.show()
			}, 0)
		}).on("mouseleave", ".subway-select", function() {
			U && U.hide()
		}), Z.on("click", ".subway-trigger", function() {
			var t = $(this);
			"station" === t.attr("data-type") ? (T = t.attr("data-parentid"), M = t.attr("data-id")) : (T = t.attr("data-id"), M = ""), C(_(T).name, {
				curLineId: T,
				curStationId: M,
				lat: t.attr("data-latitude"),
				lng: t.attr("data-longitude")
			}), H = H || Z.find(".subway-res"), H.html(t.html()), U.hide(), E.hide()
		});
		var t, i;
		J.on("click", ".subway-trigger", function() {
			var e = $(this);
			"station" === e.attr("data-type") ? (T = e.attr("data-parentid"), M = e.attr("data-id")) : (T = e.attr("data-id"), M = ""), t && t.hide(), t = null, i && i.removeClass("line-item_hover"), i = null, x(!0, {
				curLineId: T,
				curStationId: M,
				lat: e.attr("data-latitude"),
				lng: e.attr("data-longitude"),
				tle: e.attr("title")
			})
		}), J.on("mouseenter", ".line-item", function() {
			t && t.hide(), (t = J.find(".station-id-" + $(this).attr("data-id"))).show(), i && i.removeClass("line-item_hover"), (i = $(this)).addClass("line-item_hover")
		}).on("mouseleave", ".subway-list", function() {
			t && t.hide(), t = null, i && i.removeClass("line-item_hover"), i = null
		});
		var l, s = $(window);
		s.on("resize", function() {
			l && clearTimeout(l), l = setTimeout(function() {
				j.trigger("stationSelectHeightChange")
			}, 16)
		}), j.on("stationSelectHeightChange", function() {
			if (D) {
				var t = D.offset().top;
				t && D.height(s.height() - t)
			}
		})
	}
	function g(t, e) {
		return (L.getMap().getDistance(new BMap.Point(t.lng, t.lat), new BMap.Point(e.lng, e.lat)) / 1e3).toFixed(1)
	}
	function b(t, e) {
		var a;
		return g_conf.allStationMsg ? ($.each(g_conf.allStationMsg, function(n, i) {
			return e && i.id != e || ($.each(i.station, function(e, n) {
				return n.id == t ? (a = n, !1) : void 0
			}), !a) ? void 0 : !1
		}), a) : a
	}
	function _(t) {
		var e = {};
		return g_conf.allStationMsg ? ($.each(g_conf.allStationMsg, function(a, n) {
			return n.id == t ? (e = n, !1) : void 0
		}), e) : e
	}
	function v(t) {
		var e = '<div class="subway-msg">选择地铁线/地铁站：<span class="subway-res">#{res}</span><div class="subway-select"><i></i>选择地铁</div></div>';
		t ? g_conf.searchConf && ("subway_station" === g_conf.searchConf.type ? (M = g_conf.searchConf.id, T = b(M).lineId) : "subway_line" === g_conf.searchConf.type && (T = g_conf.searchConf.id, M = "")) : (T = "", M = ""), Z.html($.replaceTpl(e, {
			res: t || "无"
		})), H = Z.find(".subway-res"), Z.show()
	}
	function y(t, e) {
		var a = '<div class="subway-list"><div class="subway-list-inner"><ol>',
			n = '<li class="line-item" data-id="#{id}"><span class="item-line subway-trigger" data-id="#{id}" data-type="line" title="#{name}">#{name}' + (t || "") + "</span>#{content}</li>",
			i = '<li class="station-item"><span class="item-station subway-trigger" data-id="#{id}" data-type="station" data-parentid="#{fatherId}" title="#{name}" data-latitude="#{latitude}" data-longitude="#{longitude}">#{name}</span></li>',
			o = g_conf.allStationMsg.length,
			r = Math.max(9, o - 1),
			l = "";
		return $.each(g_conf.allStationMsg, function(t, o) {
			var s = '<div class="station-wrapper' + (e ? " station-id-" + o.id : "") + '"><ol class="station-list">',
				c = o.station.length;
			$.each(o.station, function(t, e) {
				e.fatherId = o.id, s += $.replaceTpl(i, e), e.fatherId = void 0, t % r === r - 1 && t !== c - 1 && (s += '</ol><ol class="station-list">')
			}), s += "</ol></div>", l += s, o.content = e ? "" : s, a += $.replaceTpl(n, o), o.content = void 0
		}), a += "</ol></div>" + (e ? l : "") + "</div>"
	}
	function S() {
		!Z.find(".subway-list").length && g_conf.allStationMsg && (Z.find(".subway-select").append(y()), U = Z.find(".subway-list"))
	}
	function C(t, e) {
		g_conf.curLineMap && (g_conf.curLineMap.clearResults(), g_conf.curLineMap = null), z = !0, g_conf.curLineMap = new BMap.BusLineSearch(L.getMap(), {
			renderOptions: {
				map: L.getMap()
			},
			onPolylinesSet: function() {},
			onGetBusListComplete: function(t) {
				if (t) {
					var n = t.getBusListItem(0);
					g_conf.curLineMap.getBusLine(n), setTimeout(function() {
						z = !1, e && e.curStationId && j.trigger("click_Station", {
							latitude: e.lat,
							longitude: e.lng,
							imSpecial: !0
						}), p(a())
					}, 1e3)
				}
			}
		}), setTimeout(function() {
			g_conf.curLineMap.getBusList("地铁" + t), g_conf.curLineMap.setMarkersSetCallback(function(t) {
				setTimeout(function() {
					var e = L.getMap();
					$.each(t, function(t, a) {
						e.removeOverlay(a)
					})
				}, 200)
			})
		}, 10)
	}
	function x(t, a) {
		if (O.show(), Y.hide(), Z.hide(), E.hide(), v(t && (a && a.tle || g_conf.searchConf && g_conf.searchConf.text)), j.trigger("houseContentHeightChange"), I.clear(!0), q = [], t) if (a) J.hide(), e(n(V[a.curStationId ? "subway_station" : "subway_line"])), C(_(a.curLineId).name, a);
		else {
			var i = g_conf.searchConf;
			if (J.hide(), i) {
				var o, r, l, s = i.type,
					c = V[s];
				"subway_station" === s ? (r = i.id, o = b(M).lineId) : "subway_line" === s && (o = i.id), r && (l = b(r, o)), e(n(c)), C(_(o).name, {
					curLineId: o,
					curStationId: r,
					lat: l && l.latitude,
					lng: l && l.longitude
				})
			}
		} else O.hide(), J.show(), j.trigger("stationSelectHeightChange")
	}
	function w() {
		h(), $.ajax({
			url: N + B.subwayIndex,
			dataType: "jsonp",
			data: {
				city_id: g_conf.cityId
			},
			jsonp: "callback"
		}).done(function(t) {
			t = t && t.data || null;
			var e, a, n, i = [],
				o = {};
			if ($.each(["46537781", "43144829", "46537784"], function(t, e) {
				o[e] = !0
			}), t) {
				for (e in t) if (t.hasOwnProperty(e)) {
					if (a = t[e], o[a.id]) continue;
					i.push(a), a.station = [];
					for (n in a.stations) a.stations.hasOwnProperty(n) && a.stations[n].longitude && a.stations[n].latitude && (a.stations[n].lineId = a.id, a.station.push(a.stations[n]));
					a.station.sort(function(t, e) {
						var a = parseInt(t.order_no, 10) - parseInt(e.order_no, 10);
						if (isNaN(a)) {
							var n;
							return n = isNaN(parseInt(t.order_no, 10)) ? isNaN(parseInt(e.order_no, 10)) ? 0 : 1 : -1
						}
						return a > 0 ? 1 : 0 > a ? -1 : 0
					})
				}
				i.sort(function(t, e) {
					var a = parseInt(t.sorting_order, 10) - parseInt(e.sorting_order, 10);
					if (isNaN(a)) {
						var n;
						return n = isNaN(parseInt(t.sorting_order, 10)) ? isNaN(parseInt(e.sorting_order, 10)) ? 0 : 1 : -1
					}
					return a > 0 ? 1 : 0 > a ? -1 : 0
				}), g_conf.allStationMsg = i, P()
			}
		})
	}
	function P() {
		var t = '<p class="r-header">请选择地铁线路<span class="strong">全市共#{num}条线路</span></p>';
		$.ajax({
			url: N + B.subwayLineInfo,
			dataType: "jsonp",
			data: {
				city_id: g_conf.cityId
			},
			jsonp: "callback"
		}).done(function(e) {
			e = e && e.data || {}, $.each(g_conf.allStationMsg, function(t, a) {
				a.house_count = e[a.id] && e[a.id].house_count || 0
			}), J.html($.replaceTpl(t, {
				num: g_conf.allStationMsg.length
			}) + y('<span class="item-count">#{house_count}套<span class="item-marker">&gt;</span></span>', !0)), D = J.find(".subway-list")
		})
	}
	var A, T, M, k = require("map/js/model"),
		j = require("map/js/msg"),
		I = require("map/js/bubble"),
		F = require("map/js/house"),
		L = require("map/js/mapView"),
		E = require("map/js/card"),
		B = g_conf.urlPath,
		N = B.basePath,
		q = [];
	g_conf.curLineMap = null;
	var D, H, U, z = !1,
		W = $("#" + g_conf.houseListId),
		O = W.find(".r-list"),
		Y = W.find(".r-ctrl"),
		Z = W.find(".r-top"),
		J = W.find(".r-station_guide"),
		R = {
			community: {
				bubblePath: N + B.mapSearch.StationCommunity,
				bubbleParamArray: ["min_longitude", "max_longitude", "min_latitude", "max_latitude", "line_id"],
				cardPath: N + B.cardSearch.StationCommunity,
				cardParamArray: ["id"],
				housePath: N + B.houseList.StationCommunity,
				houseParamArray: ["ids", "limit_offset", "limit_count", "sort"]
			},
			station: {
				bubblePath: N + B.mapSearch.StationStation,
				bubbleParamArray: ["line_id"],
				cardPath: "",
				cardParamArray: [],
				housePath: N + B.houseList.StationStation,
				houseParamArray: ["ids", "limit_offset", "limit_count", "sort"]
			},
			defaults: {
				bubblePath: "",
				bubbleParamArray: [],
				cardPath: "",
				cardParamArray: [],
				housePath: N + B.houseList.StationDefault,
				houseParamArray: ["id", "limit_offset", "limit_count", "sort"]
			}
		},
		Q = {
			2: ["商圈"],
			3: ["小区"],
			1: ["区域", "商圈"],
			0: ["城市", "区域"]
		},
		K = new k({
			bubblePath: R.community.bubblePath,
			bubbleParamArray: R.community.bubbleParamArray,
			cardPath: R.community.bubblePath,
			cardParamArray: R.community.bubbleParamArray,
			housePath: R.community.bubblePath,
			houseParamArray: R.community.bubblePath
		}),
		V = {
			subway_station: 16,
			subway_line: 12
		};
	return K.init = w, K.reset = x, t = K
}), define("map/js/sidebar", function(require, t) {
	var e = require("map/js/mapView"),
		a = require("map/js/steam"),
		n = require("map/js/area"),
		i = require("map/js/school"),
		o = require("map/js/station"),
		r = require("map/js/msg"),
		l = $("#" + g_conf.sidebarId),
		s = l.find(".ctrl"),
		c = s.find("li").eq(0),
		u = l.find(".slide-bg"),
		d = l.find(".r-hd2"),
		m = d.find("li"),
		f = m.eq(0),
		p = d.find(".s-new"),
		h = d.find(".s-station"),
		g = l.find(".r-container"),
		b = $(window),
		_ = $(".r-hd_i_school").parent().get(0),
		v = {
			bindEvent: function() {
				d.on("click", "li", function() {
					var t = $(this);
					t.hasClass("on") ? (t.hasClass("s-area") || t.hasClass("s-price")) && (t.hasClass("s-desc") ? t.attr("data-type", t.attr("data-val2")) : t.attr("data-type", t.attr("data-val1")), t.toggleClass("s-desc"), g_conf.houseListSortCtrl = t.attr("data-type"), r.trigger("update_house_sort_" + g_conf.curChannel)) : (f.removeClass("on"), t.addClass("on"), (f.hasClass("s-area") || f.hasClass("s-price")) && (f.hasClass("s-desc") || (f.attr("data-type", f.attr("data-val1")), f.addClass("s-desc"))), f = t, g_conf.houseListSortCtrl = t.attr("data-type"), r.trigger("update_house_sort_" + g_conf.curChannel))
				})
			},
			reset: function(t) {
				$.each(m, function(t, e) {
					var a = $(this);
					a.removeClass("on"), (a.hasClass("s-area") || a.hasClass("s-price")) && (a.hasClass("s-desc") || (a.attr("data-type", a.attr("data-val1")), a.addClass("s-desc")))
				}), t ? (h.show(), p.hide()) : (h.hide(), p.show()), f = m.eq(0), f.addClass("on"), g_conf.houseListSortCtrl = ""
			}
		},
		y = {
			switchTab: function(t, a, n) {
				var i = t.attr("data-type");
				_.className = "r-hd_" + i, a || (g_conf.searchConf = null), "undefined" != typeof UT && UT.send({
					modId: "mapSwitchTab",
					position: t.hasClass("on"),
					sort: i.toLowerCase(),
					type: "other"
				}), !a && t.hasClass("on") || (c.removeClass("on"), t.addClass("on"), c = t), u.css({
					top: t.attr("data-top") + "px"
				}), g_conf.curChannel = i, n || r.trigger("resetIgnoreSearch"), r.trigger("mapSideCtrlChange"), v.reset(), g_conf.curLineMap && (g_conf.curLineMap.clearResults(), g_conf.curLineMap = null), (!a || n) && e.resetMap(), setTimeout(function() {
					y["reset" + i](n ? !1 : a)
				}, 70)
			},
			bindEvent: function() {
				var t;
				s.on("click", "li", function() {
					y.switchTab($(this))
				}).on("mouseenter", "li", function() {
					u.css({
						top: $(this).attr("data-top") + "px"
					})
				}), s.find("ol").on("mouseleave", function() {
					u.css({
						top: c.attr("data-top") + "px"
					})
				}), b.on("resize", function() {
					t && clearTimeout(t), t = setTimeout(function() {
						r.trigger("houseContentHeightChange")
					}, 16)
				}), r.on("houseContentHeightChange", function() {
					var t = g.offset().top;
					t && g.height(b.height() - t)
				})
			},
			resetArea: function(t) {
				n.reset(t)
			},
			resetStation: function(t) {
				o.reset(t)
			},
			resetSchool: function(t) {
				i.reset(t)
			},
			resetSteam: function(t) {
				a.reset(t)
			},
			init: function() {
				var t = $.queryToJson(location.search.split("?")[1], 1);
				y.bindEvent(), $.trim(t.q || "") || ("steam" === t.bar ? y.switchTab(s.find("li[data-type='Steam']")) : y.resetArea()), v.bindEvent(), s.find("li").each(function(t, e) {
					var a = $(this);
					a.attr("data-top", a.attr("data-ave") * t)
				})
			}
		};
	return t = y
}), define("map/js/search", function(require, exports) {
	function bindEachFilter(t) {
		return t.each(function(t, e) {
			var a = $(this),
				n = a.find(".drop-list"),
				i = a.find(".drop-i"),
				o = a.find("span"),
				r = o.html(),
				l = null;
			a.on("click", ".item", function(t) {
				var e = $(this),
					s = $.trim(e.attr("data-value")) || "",
					c = a.attr("data-value") || "",
					u = [],
					d = "";
				c != s && (a.attr("data-value", s), s ? o.html(e.html()) : o.html(r), $liFilter.each(function(t, e) {
					d = $(this).attr("data-value"), d && u.push(d)
				}), g_conf.filterSearchSideCtrl = u.join("&"), eventEmitter.trigger("update", {
					channel: "filter",
					cur: g_conf.filterSearchSideCtrl
				}), l = l || a.find(".item").eq(0), l.removeClass("clicked"), e.addClass("clicked"), l = e), n.length || (n = a.find(".drop-list")), n.hide(), i.removeClass("drop-open")
			}).on("mouseenter", "p", function(t) {
				t.stopPropagation()
			}).on("mouseenter", function() {
				n.length || (n = a.find(".drop-list")), n.show(), i.addClass("drop-open")
			}).on("mouseleave", function() {
				n.length || (n = a.find(".drop-list")), n.hide(), i.removeClass("drop-open")
			}).on("resetFilter", function() {
				l && l.removeClass("clicked"), (l = a.find(".item").eq(0)).addClass("clicked"), a.attr("data-value", ""), o.html(r), g_conf.filterSearchSideCtrl = ""
			})
		}), eventEmitter.on("resetFilter", function() {
			t.each(function() {
				$(this).trigger("resetFilter")
			})
		}), t
	}
	function bindFilterEvent() {
		var t = $aside.find(".li"),
			e = $aside.find(".li-other");
		t.one("mouseenter", function() {
			var t = $(this),
				e = t.attr("data-type"),
				a = "";
			tplConf[e] && ($.each(tplConf[e], function(t, e) {
				e.isFirst = 0 === t ? " clicked" : "", a += $.replaceTpl(tpl, e)
			}), t.append($.replaceTpl(g_tpl, {
				content: a
			})))
		}), function() {
			var t = e,
				a = t.children(".li-mixin"),
				n = t.children(".drop-i");
			t.children("span");
			!
			function(t) {
				var e = "";
				$.each(moreWrapConf, function(t, a) {
					e += $.replaceTpl(moreTpl, a)
				}), t.append($.replaceTpl(more_g_tpl, {
					content: e
				})), $liFilter = $aside.find(".li-filter"), bindEachFilter(t.find(".li").one("mouseenter", function() {
					var t = $(this),
						e = t.attr("data-type"),
						a = "";
					moreConf[e] && ($.each(moreConf[e], function(t, e) {
						e.isFirst = 0 === t ? " clicked" : "", a += $.replaceTpl(tpl, e)
					}), t.append($.replaceTpl(g_tpl, {
						content: a
					})))
				}))
			}(t), t.on("mouseenter", function() {
				a.length || (a = t.children(".li-mixin")), a.show(), n.addClass("drop-open")
			}).on("mouseleave", function() {
				a.length || (a = t.children(".li-mixin")), a.hide(), n.removeClass("drop-open")
			})
		}(), bindEachFilter(t), $aside.find(".li-btn").on("click", function() {
			eventEmitter.trigger("resetFilter"), setTimeout(function() {
				sidebar.switchTab($sideCtrl.find("." + g_conf.curChannel.toLowerCase()), !0, !0)
			}, 200)
		})
	}
	function bindSearchEvent() {
		suggest($input[0], {
			classNameWrap: "sug-search",
			classNameQuery: "sug-query",
			classNameSelect: "sug-select",
			delay: 300,
			n: 10,
			autoFocus: !1,
			requestQuery: "q",
			requestParas: {
				callback: "SearchSug2015",
				city_id: g_conf.cityId
			},
			url: basePath + urlPath.searchSug,
			callbackFn: "SearchSug2015",
			callbackDataKey: "data",
			noSubmit: !0,
			autoCache: !0,
			onMouseSelect: function(t) {
				t && $input.attr("data-json", t.getAttribute("data-json")), eventEmitter.trigger("submit_input", {
					channel: "mouse"
				})
			},
			onSucess: function() {
				$input.attr("data-json", "")
			},
			onSelect: function(t) {
				t || eventEmitter.trigger("submit_input", {
					channel: "enter"
				})
			},
			onKeySelect: function(t, e) {
				t && !e ? $input.attr("data-json", t.getAttribute("data-json")) : $input.attr("data-json", "")
			},
			templ: function(t, e) {
				for (var a = t.data || [], n = [], i = 0, o = a.length; o > i; i++) a[i].q = e, a[i].formatText = a[i].text.replace(e, '<span class="sug-query">' + e + "</span>"), a[i].jsonStr = $.toJSON(a[i]), n.push($.replaceTpl(sugTpl, a[i]));
				return "<ol>" + n.join("") + "</ol>"
			}
		}), $button.on("click", function(t) {
			eventEmitter.trigger("submit_input", {
				channel: "button"
			})
		}), eventEmitter.on("submit_input", function(t, e) {
			var a, n = $input.attr("data-json"),
				i = $.trim($input.val());
			i && i != $input.attr("placeholder") ? getInputMsg(n, i, dispatchDirective) : sidebar.switchTab($sideCtrl.find("." + g_conf.curChannel.toLowerCase())), a = i != $input.attr("placeholder") ? i : "", "undefined" != typeof UT && UT.send({
				modId: "mapSearch",
				position: e && e.channel,
				sort: a,
				q: a,
				type: "click"
			})
		}), eventEmitter.on("resetFilter", function() {
			$input.attr("data-json", ""), $input.val(""), g_conf.searchConf = null
		})
	}
	function getInputMsg(t, e, a) {
		var n;
		inputDefer && (inputDefer.func = null, inputDefer = null), t ? (inputDefer = $.Deferred()).resolve($.parseJSON(t)) : inputDefer = $.ajax({
			url: basePath + urlPath.searchIndex,
			data: {
				q: e,
				city_id: g_conf.cityId
			},
			dataType: "jsonp",
			jsonp: "callback"
		}), n = inputDefer, n.func = a, n.done(function(t) {
			n.func && n.func(t)
		})
	}
	function dispatchDirective(t) {
		t.data && (t = t.data, t.words && (t.words = null), t.text = t.text || $.trim($input.val())), g_conf.searchConf = t, sidebar.switchTab($sideCtrl.find("." + (sugTypeMap[t.module] || "area")), !0)
	}
	function checkQuery() {
		var t = $.trim($.queryToJson(location.search.split("?")[1], 1).q || "");
		t && ($input.val(t), $button.trigger("click"))
	}
	function init() {
		bindSearchEvent(), bindFilterEvent(), setTimeout(checkQuery, 2e3)
	}
	var eventEmitter = require("map/js/msg"),
		suggest = require("map/js/suggest"),
		sidebar = require("map/js/sidebar");
	!
	function($) {
		"use strict";
		var escape = /["\\\x00-\x1f\x7f-\x9f]/g,
			meta = {
				"\b": "\\b",
				"	": "\\t",
				"\n": "\\n",
				"\f": "\\f",
				"\r": "\\r",
				'"': '\\"',
				"\\": "\\\\"
			},
			hasOwn = Object.prototype.hasOwnProperty;
		$.toJSON = "object" == typeof JSON && JSON.stringify ? JSON.stringify : function(t) {
			if (null === t) return "null";
			var e, a, n, i, o = $.type(t);
			if ("undefined" === o) return void 0;
			if ("number" === o || "boolean" === o) return String(t);
			if ("string" === o) return $.quoteString(t);
			if ("function" == typeof t.toJSON) return $.toJSON(t.toJSON());
			if ("date" === o) {
				var r = t.getUTCMonth() + 1,
					l = t.getUTCDate(),
					s = t.getUTCFullYear(),
					c = t.getUTCHours(),
					u = t.getUTCMinutes(),
					d = t.getUTCSeconds(),
					m = t.getUTCMilliseconds();
				return 10 > r && (r = "0" + r), 10 > l && (l = "0" + l), 10 > c && (c = "0" + c), 10 > u && (u = "0" + u), 10 > d && (d = "0" + d), 100 > m && (m = "0" + m), 10 > m && (m = "0" + m), '"' + s + "-" + r + "-" + l + "T" + c + ":" + u + ":" + d + "." + m + 'Z"'
			}
			if (e = [], $.isArray(t)) {
				for (a = 0; a < t.length; a++) e.push($.toJSON(t[a]) || "null");
				return "[" + e.join(",") + "]"
			}
			if ("object" == typeof t) {
				for (a in t) if (hasOwn.call(t, a)) {
					if (o = typeof a, "number" === o) n = '"' + a + '"';
					else {
						if ("string" !== o) continue;
						n = $.quoteString(a)
					}
					o = typeof t[a], "function" !== o && "undefined" !== o && (i = $.toJSON(t[a]), e.push(n + ":" + i))
				}
				return "{" + e.join(",") + "}"
			}
		}, $.evalJSON = "object" == typeof JSON && JSON.parse ? JSON.parse : function(str) {
			return eval("(" + str + ")")
		}, $.secureEvalJSON = "object" == typeof JSON && JSON.parse ? JSON.parse : function(str) {
			var filtered = str.replace(/\\["\\\/bfnrtu]/g, "@").replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, "]").replace(/(?:^|:|,)(?:\s*\[)+/g, "");
			if (/^[\],:{}\s]*$/.test(filtered)) return eval("(" + str + ")");
			throw new SyntaxError("Error parsing JSON, source is not valid.")
		}, $.quoteString = function(t) {
			return t.match(escape) ? '"' + t.replace(escape, function(t) {
				var e = meta[t];
				return "string" == typeof e ? e : (e = t.charCodeAt(), "\\u00" + Math.floor(e / 16).toString(16) + (e % 16).toString(16))
			}) + '"' : '"' + t + '"'
		}
	}(jQuery);
	var $search = $("#search"),
		$aside = $search.find(".aside"),
		$input = $("#searchInput"),
		$button = $search.find(".btn"),
		$sideCtrl = $("#" + g_conf.mapCtrlId),
		$liFilter = $aside.find(".li-filter"),
		urlPath = g_conf.urlPath,
		basePath = urlPath.basePath,
		inputDefer = null,
		sugTypeMap = {
			area: "area",
			subway: "station",
			school: "school"
		},
		g_tpl = '<ol class="drop-list">#{content}</ol>',
		more_g_tpl = '<ol class="li-mixin">#{content}</ol>',
		tpl = '<li data-value="#{value}" class="item#{isFirst}">#{title}</li>',
		moreTpl = '<li class="li li-filter" data-type="#{types}"><p>#{value}</p><span>#{title}</span><i class="drop-i"></i></li>',
		sugTpl = "<li data-json='#{jsonStr}' data-origin='#{q}' q='#{text}'>#{formatText}<span class='sug-tip'>约#{count}套在售</span></li>",
		tplConf = {
			sellPrice: [{
				value: "",
				title: "不限"
			}, {
				value: "min_price=&max_price=100",
				title: "100万以下"
			}, {
				value: "min_price=100&max_price=150",
				title: "100-150万"
			}, {
				value: "min_price=150&max_price=200",
				title: "150-200万"
			}, {
				value: "min_price=200&max_price=250",
				title: "200-250万"
			}, {
				value: "min_price=250&max_price=300",
				title: "250-300万"
			}, {
				value: "min_price=300&max_price=500",
				title: "300-500万"
			}, {
				value: "min_price=500&max_price=1000",
				title: "500-1000万"
			}, {
				value: "min_price=1000&max_price=",
				title: "1000万以上"
			}],
			roomArea: [{
				value: "",
				title: "不限"
			}, {
				value: "min_area=&max_area=50",
				title: "50平以下"
			}, {
				value: "min_area=50&max_area=70",
				title: "50-70平"
			}, {
				value: "min_area=70&max_area=90",
				title: "70-90平"
			}, {
				value: "min_area=90&max_area=110",
				title: "90-110平"
			}, {
				value: "min_area=110&max_area=130",
				title: "110-130平"
			}, {
				value: "min_area=130&max_area=150",
				title: "130-150平"
			}, {
				value: "min_area=150&max_area=200",
				title: "150-200平"
			}, {
				value: "min_area=200&max_area=",
				title: "200平以上"
			}],
			roomType: [{
				value: "",
				title: "不限"
			}, {
				value: "room_count=1",
				title: "一室"
			}, {
				value: "room_count=2",
				title: "二室"
			}, {
				value: "room_count=3",
				title: "三室"
			}, {
				value: "room_count=4",
				title: "四室"
			}, {
				value: "room_count=5",
				title: "五室"
			}, {
				value: "room_count=6",
				title: "五室以上"
			}]
		},
		moreConf = {
			direction: [{
				value: "",
				title: "不限"
			}, {
				value: "orientation=east",
				title: "朝东"
			}, {
				value: "orientation=south",
				title: "朝南"
			}, {
				value: "orientation=west",
				title: "朝西"
			}, {
				value: "orientation=north",
				title: "朝北"
			}, {
				value: "orientation=south_north",
				title: "南北"
			}],
			roomAge: [{
				value: "",
				title: "不限"
			}, {
				value: "min_house_year=&max_house_year=5",
				title: "5年以内"
			}, {
				value: "min_house_year=&max_house_year=10",
				title: "10年以内"
			}, {
				value: "min_house_year=10&max_house_year=20",
				title: "10-20年"
			}, {
				value: "min_house_year=20&max_house_year=",
				title: "20年以上"
			}],
			roomFloor: [{
				value: "",
				title: "不限"
			}, {
				value: "floor_level=1",
				title: "低楼层"
			}, {
				value: "floor_level=2",
				title: "中楼层"
			}, {
				value: "floor_level=3",
				title: "高楼层"
			}],
			roomTag: [{
				value: "",
				title: "不限"
			}, {
				value: "is_quick_acting=1",
				title: "独家"
			}, {
				value: "is_new_house_source=1",
				title: "新上"
			}, {
				value: "is_restriction=1",
				title: "不限购"
			}]
		},
		moreWrapConf = [{
			types: "direction",
			title: "不限",
			value: "朝向"
		}, {
			types: "roomAge",
			title: "不限",
			value: "楼龄"
		}, {
			types: "roomFloor",
			title: "不限",
			value: "楼层"
		}, {
			types: "roomTag",
			title: "不限",
			value: "其他"
		}];
	return exports = {
		init: init
	}
}), define("map/js/around", function(require, t) {
	function e() {
		i(), n()
	}
	function a(t, e) {
		var a = [],
			n = {
				min_longitude: parseFloat(t.min_longitude),
				max_longitude: parseFloat(t.max_longitude),
				min_latitude: parseFloat(t.min_latitude),
				max_latitude: parseFloat(t.max_latitude)
			};
		return e -= 1, $.each(p, function(t, i) {
			var o = Math.max(parseFloat(i.longitude), parseFloat(i.latitude)),
				r = Math.min(parseFloat(i.longitude), parseFloat(i.latitude));
			return i.longitude = o, i.latitude = r, o <= n.max_longitude && o >= n.min_longitude && r <= n.max_latitude && r >= n.min_latitude && a.push(i), a.length >= e ? !1 : void 0
		}), a
	}
	function n() {
		$.ajax({
			url: g_conf.urlPath.basePath + g_conf.urlPath.aroundStore,
			data: {
				city_id: g_conf.cityId
			},
			dataType: "jsonp",
			jsonp: "callback"
		}).done(function(t) {
			p = t && t.data
		})
	}
	function i() {
		h.on("update_around", function(t, e) {
			return e.cur ? void s(e.cur) : void r()
		}), h.one("create_localsearch", function() {
			var t = g.getMap(),
				e = {
					onSearchComplete: function(t) {
						f.getStatus() == BMAP_STATUS_SUCCESS && (r(), o(t))
					},
					pageCapacity: v
				};
			f = new BMap.LocalSearch(t, e)
		})
	}
	function o(t) {
		for (var e, a = [], n = t.keyword, i = 0, o = 0; o < t.getCurrentNumPois(); o++) a.push(t.getPoi(o));
		for (e = Math.min(a.length, v); e > i;) a[i].extraClass = C[n] || "", c(d(a[i])), i++
	}
	function r() {
		for (var t; t = b.shift();) u(t)
	}
	function l(t) {
		var e;
		r(), p && (e = a(t, v), $.each(e, function(t, e) {
			var a = [e.name || ""];
			e.address && a.push(e.address), e.telephone && a.push(e.telephone), c(d({
				extraClass: C[_] || "",
				title: a.join("&#10;"),
				point: {
					lng: e.longitude,
					lat: e.latitude
				}
			}))
		}))
	}
	function s(t) {
		var e = g.getBounds();
		t === _ ? l(e) : (h.trigger("create_localsearch"), f.searchInBounds(t, new BMap.Bounds(new BMap.Point(e.min_longitude, e.min_latitude), new BMap.Point(e.max_longitude, e.max_latitude))))
	}
	function c(t) {
		g.getMap().addOverlay(t)
	}
	function u(t) {
		g.getMap().removeOverlay(t)
	}
	function d(t) {
		var e;
		return e = new BMap.Label($.replaceTpl(S, t), {
			position: new BMap.Point(t.point.lng, t.point.lat),
			offset: m()
		}), e.setStyle(y), e.addEventListener("mouseover", function() {
			this.setStyle({
				zIndex: "4"
			})
		}), e.addEventListener("mouseout", function() {
			this.setStyle({
				zIndex: "1"
			})
		}), b.push(e), e
	}
	function m() {
		return new BMap.Size(-10, -30)
	}
	var f, p, h = require("map/js/msg"),
		g = require("map/js/mapView"),
		b = [],
		_ = "store",
		v = 25,
		y = {
			color: "#000",
			borderWidth: "0",
			padding: "0",
			zIndex: "1",
			backgroundColor: "transparent",
			textAlign: "center"
		},
		S = '<div class="bubble-around bubble-around-#{extraClass}" title="#{title}"><i class="i-cycle"></i><i class="i-arrow"></i></div>',
		C = {
			"银行": "bank",
			"公交": "bus",
			"地铁": "station",
			"教育": "education",
			"医院": "hospital",
			"休闲": "fun",
			"购物": "shop",
			"健身": "sport",
			"美食": "eat",
			store: "store"
		};
	return t = {
		init: e
	}
}), define("map/js/map", function(require, t) {
	var e = {
		370200: 1,
		370101: 1
	};
	return t.init = function() {
		var t = require("map/js/mapView"),
			a = require("map/js/panelView"),
			n = require("map/js/search"),
			i = require("map/js/sidebar"),
			o = require("map/js/steam"),
			r = require("map/js/area"),
			l = require("map/js/school"),
			s = require("map/js/station"),
			c = require("map/js/house"),
			u = require("map/js/around");
		n.init(), t.addCb(a.init), t.addCb(r.init), t.addCb(o.init), t.addCb(l.init), !e[g_conf.cityId] && t.addCb(s.init), t.addCb(c.init), t.addCb(i.init), t.addCb(u.init), t.init()
	}, t
});