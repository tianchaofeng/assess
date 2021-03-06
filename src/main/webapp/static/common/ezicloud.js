/*!
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 *
 * 通用公共方法
 * @author Starsoft
 * @version 2014-4-29
 */
$(document).ready(function() {
	try {
		// 链接去掉虚框
		$("a").bind("focus", function() {
			if (this.blur) {
				this.blur()
			};
		});
		//所有下拉框使用select2
		$("select").select2({
			language: "zh-CN"
		});
	} catch (e) {
		// blank
	}
	// 判断整数value是否等于0 
	jQuery.validator.addMethod("isIntEqZero", function(value, element) {
		value = parseInt(value);
		return this.optional(element) || value == 0;
	}, "整数必须为0");

	// 判断整数value是否大于0
	jQuery.validator.addMethod("isIntGtZero", function(value, element) {
		value = parseInt(value);
		return this.optional(element) || value > 0;
	}, "整数必须大于0");

	// 判断整数value是否大于或等于0
	jQuery.validator.addMethod("isIntGteZero", function(value, element) {
		value = parseInt(value);
		return this.optional(element) || value >= 0;
	}, "整数必须大于或等于0");

	// 判断整数value是否不等于0 
	jQuery.validator.addMethod("isIntNEqZero", function(value, element) {
		value = parseInt(value);
		return this.optional(element) || value != 0;
	}, "整数必须不等于0");

	// 判断整数value是否小于0 
	jQuery.validator.addMethod("isIntLtZero", function(value, element) {
		value = parseInt(value);
		return this.optional(element) || value < 0;
	}, "整数必须小于0");

	// 判断整数value是否小于或等于0 
	jQuery.validator.addMethod("isIntLteZero", function(value, element) {
		value = parseInt(value);
		return this.optional(element) || value <= 0;
	}, "整数必须小于或等于0");

	// 判断浮点数value是否等于0 
	jQuery.validator.addMethod("isFloatEqZero", function(value, element) {
		value = parseFloat(value);
		return this.optional(element) || value == 0;
	}, "浮点数必须为0");

	// 判断浮点数value是否大于0
	jQuery.validator.addMethod("isFloatGtZero", function(value, element) {
		value = parseFloat(value);
		return this.optional(element) || value > 0;
	}, "浮点数必须大于0");

	// 判断浮点数value是否大于或等于0
	jQuery.validator.addMethod("isFloatGteZero", function(value, element) {
		value = parseFloat(value);
		return this.optional(element) || value >= 0;
	}, "浮点数必须大于或等于0");

	// 判断浮点数value是否不等于0 
	jQuery.validator.addMethod("isFloatNEqZero", function(value, element) {
		value = parseFloat(value);
		return this.optional(element) || value != 0;
	}, "浮点数必须不等于0");

	// 判断浮点数value是否小于0 
	jQuery.validator.addMethod("isFloatLtZero", function(value, element) {
		value = parseFloat(value);
		return this.optional(element) || value < 0;
	}, "浮点数必须小于0");

	// 判断浮点数value是否小于或等于0 
	jQuery.validator.addMethod("isFloatLteZero", function(value, element) {
		value = parseFloat(value);
		return this.optional(element) || value <= 0;
	}, "浮点数必须小于或等于0");

	// 判断浮点型  
	jQuery.validator.addMethod("isFloat", function(value, element) {
		return this.optional(element) || /^[-\+]?\d+(\.\d+)?$/.test(value);
	}, "只能包含数字、小数点等字符");

	// 匹配integer
	jQuery.validator.addMethod("isInteger", function(value, element) {
		return this.optional(element) || (/^[-\+]?\d+$/.test(value) && parseInt(value) >= 0);
	}, "匹配integer");

	// 判断数值类型，包括整数和浮点数
	jQuery.validator.addMethod("isNumber", function(value, element) {
		return this.optional(element) || /^[-\+]?\d+$/.test(value) || /^[-\+]?\d+(\.\d+)?$/.test(value);
	}, "匹配数值类型，包括整数和浮点数");

	// 只能输入[0-9]数字
	jQuery.validator.addMethod("isDigits", function(value, element) {
		return this.optional(element) || /^\d+$/.test(value);
	}, "只能输入0-9数字");

	// 判断中文字符 
	jQuery.validator.addMethod("isChinese", function(value, element) {
		return this.optional(element) || /^[\u0391-\uFFE5]+$/.test(value);
	}, "只能包含中文字符。");

	// 判断英文字符 
	jQuery.validator.addMethod("isEnglish", function(value, element) {
		return this.optional(element) || /^[A-Za-z]+$/.test(value);
	}, "只能包含英文字符。");

	// 手机号码验证    
	jQuery.validator.addMethod("isMobile", function(value, element) {
		var length = value.length;
		return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(value));
	}, "请正确填写您的手机号码。");

	// 电话号码验证    
	jQuery.validator.addMethod("isPhone", function(value, element) {
		var tel = /^(\d{3,4}-?)?\d{7,9}$/g;
		return this.optional(element) || (tel.test(value));
	}, "请正确填写您的电话号码。");

	// 联系电话(手机/电话皆可)验证   
	jQuery.validator.addMethod("isTel", function(value, element) {
		var length = value.length;
		var mobile = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
		var tel = /^(\d{3,4}-?)?\d{7,9}$/g;
		return this.optional(element) || tel.test(value) || (length == 11 && mobile.test(value));
	}, "请正确填写您的联系方式");

	// 匹配qq      
	jQuery.validator.addMethod("isQq", function(value, element) {
		return this.optional(element) || /^[1-9]\d{4,12}$/;
	}, "匹配QQ");

	// 邮政编码验证    
	jQuery.validator.addMethod("isZipCode", function(value, element) {
		var zip = /^[0-9]{6}$/;
		return this.optional(element) || (zip.test(value));
	}, "请正确填写您的邮政编码。");

	// 匹配密码，以字母开头，长度在6-12之间，只能包含字符、数字和下划线。      
	jQuery.validator.addMethod("isPwd", function(value, element) {
		return this.optional(element) || /^[a-zA-Z]\\w{6,12}$/.test(value);
	}, "以字母开头，长度在6-12之间，只能包含字符、数字和下划线。");

	// 身份证号码验证
	jQuery.validator.addMethod("isIdCardNo", function(value, element) {
		//var idCard = /^(\d{6})()?(\d{4})(\d{2})(\d{2})(\d{3})(\w)$/;   
		return this.optional(element) || isIdCardNo(value);
	}, "请输入正确的身份证号码。");

	// IP地址验证   
	jQuery.validator.addMethod("ip", function(value, element) {
		return this.optional(element) || /^(([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))\.)(([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))\.){2}([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))$/.test(value);
	}, "请填写正确的IP地址。");

	// 字符验证，只能包含中文、英文、数字、下划线等字符。    
	jQuery.validator.addMethod("stringCheck", function(value, element) {
		return this.optional(element) || /^[a-zA-Z0-9\u4e00-\u9fa5-_]+$/.test(value);
	}, "只能包含中文、英文、数字、下划线等字符");

	// 匹配english  
	jQuery.validator.addMethod("isEnglish", function(value, element) {
		return this.optional(element) || /^[A-Za-z]+$/.test(value);
	}, "匹配english");

	// 匹配汉字  
	jQuery.validator.addMethod("isChinese", function(value, element) {
		return this.optional(element) || /^[\u4e00-\u9fa5]+$/.test(value);
	}, "匹配汉字");

	// 匹配中文(包括汉字和字符) 
	jQuery.validator.addMethod("isChineseChar", function(value, element) {
		return this.optional(element) || /^[\u0391-\uFFE5]+$/.test(value);
	}, "匹配中文(包括汉字和字符) ");

	// 判断是否为合法字符(a-zA-Z0-9-_)
	jQuery.validator.addMethod("isRightfulString", function(value, element) {
		return this.optional(element) || /^[A-Za-z0-9_-]+$/.test(value);
	}, "判断是否为合法字符(a-zA-Z0-9-_)");

	// 判断是否包含中英文特殊字符，除英文"-_"字符外
	jQuery.validator.addMethod("isContainsSpecialChar", function(value, element) {
		var reg = RegExp(/[(\ )(\`)(\~)(\!)(\@)(\#)(\$)(\%)(\^)(\&)(\*)(\()(\))(\+)(\=)(\|)(\{)(\})(\')(\:)(\;)(\')(',)(\[)(\])(\.)(\<)(\>)(\/)(\?)(\~)(\！)(\@)(\#)(\￥)(\%)(\…)(\&)(\*)(\（)(\）)(\—)(\+)(\|)(\{)(\})(\【)(\】)(\‘)(\；)(\：)(\”)(\“)(\’)(\。)(\，)(\、)(\？)]+/);
		return this.optional(element) || !reg.test(value);
	}, "含有中英文特殊字符");
	
	//年龄
	jQuery.validator.addMethod("age", function(value, element) {
		 var tel = /^([2-6]\d)|70$/;
		 return this.optional(element) || (tel.test(value));
		 }, "请正确填写您年龄");
	//您的教学年限
	jQuery.validator.addMethod("ageLimit", function(value, element) {
		 var tel =  /^[1-9]{1}\d{2,}$/;
		 return this.optional(element) || (tel.test(value));
		 }, "请正确填写您的教学年限");
	
});

//身份证号码的验证规则

function isIdCardNo(num) {
	var len = num.length,
		re;
	if (len == 15) re = new RegExp(/^(\d{6})()?(\d{2})(\d{2})(\d{2})(\d{2})(\w)$/);
	else if (len == 18) re = new RegExp(/^(\d{6})()?(\d{4})(\d{2})(\d{2})(\d{3})(\w)$/);
	else {
		return false;
	}
	var a = num.match(re);
	if (a != null) {
		if (len == 15) {
			var D = new Date("19" + a[3] + "/" + a[4] + "/" + a[5]);
			var B = D.getYear() == a[3] && (D.getMonth() + 1) == a[4] && D.getDate() == a[5];
		} else {
			var D = new Date(a[3] + "/" + a[4] + "/" + a[5]);
			var B = D.getFullYear() == a[3] && (D.getMonth() + 1) == a[4] && D.getDate() == a[5];
		}
		if (!B) {
			return false;
		}
	}
	if (!re.test(num)) {
		// alert("身份证最后一位只能是数字和字母。");
		return false;
	}
	return true;
}

// 引入js和css文件

function include(id, path, file) {
	if (document.getElementById(id) == null) {
		var files = typeof file == "string" ? [file] : file;
		for (var i = 0; i < files.length; i++) {
			var name = files[i].replace(/^\s|\s$/g, "");
			var att = name.split('.');
			var ext = att[att.length - 1].toLowerCase();
			var isCSS = ext == "css";
			var tag = isCSS ? "link" : "script";
			var attr = isCSS ? " type='text/css' rel='stylesheet' " : " type='text/javascript' ";
			var link = (isCSS ? "href" : "src") + "='" + path + name + "'";
			document.write("<" + tag + (i == 0 ? " id=" + id : "") + attr + link + "></" + tag + ">");
		}
	}
}

// 获取URL地址参数

function getQueryString(name, url) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
	if (!url || url == "") {
		url = window.location.search;
	} else {
		url = url.substring(url.indexOf("?"));
	}
	r = url.substr(1).match(reg)
	if (r != null) return unescape(r[2]);
	return null;
}

//获取字典标签

function getDictLabel(data, value, defaultValue) {
	for (var i = 0; i < data.length; i++) {
		var row = data[i];
		if (row.value == value) {
			return row.label;
		}
	}
	return defaultValue;
}

// 打开一个窗体

function windowOpen(url, name, width, height) {
	var top = parseInt((window.screen.height - height) / 2, 10),
		left = parseInt((window.screen.width - width) / 2, 10),
		options = "location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes," + "resizable=yes,scrollbars=yes," + "width=" + width + ",height=" + height + ",top=" + top + ",left=" + left;
	window.open(url, name, options);
}

// 恢复提示框显示

function resetTip() {
	top.$.jBox.tip.mess = null;
}

// 关闭提示框

function closeTip() {
	top.$.jBox.closeTip();
}

//显示提示框

function showTip(mess, type, timeout, lazytime) {
	resetTip();
	setTimeout(function() {
		top.$.jBox.tip(mess, (type == undefined || type == '' ? 'info' : type), {
			opacity: 0,
			timeout: timeout == undefined ? 2000 : timeout
		});
	}, lazytime == undefined ? 500 : lazytime);
}

// 显示加载框

function loading(mess) {
	if (mess == undefined || mess == "") {
		mess = "正在提交，请稍等...";
	}
	resetTip();
	top.$.jBox.tip(mess, 'loading', {
		opacity: 0
	});
}

// 关闭提示框

function closeLoading() {
	// 恢复提示框显示
	resetTip();
	// 关闭提示框
	closeTip();
}

// 警告对话框

function alertx(mess, closed) {
	top.$.jBox.info(mess, '提示', {
		closed: function() {
			if (typeof closed == 'function') {
				closed();
			}
		}
	});
	top.$('.jbox-body .jbox-icon').css('top', '55px');
}

// 确认对话框

function confirmx(mess, href, closed) {
	top.$.jBox.confirm(mess, '系统提示', function(v, h, f) {
		if (v == 'ok') {
			if (typeof href == 'function') {
				href();
			} else {
				resetTip(); //loading();
				location = href;
			}
		}
	}, {
		buttonsFocus: 1,
		closed: function() {
			if (typeof closed == 'function') {
				closed();
			}
		}
	});
	top.$('.jbox-body .jbox-icon').css('top', '55px');
	return false;
}

// 提示输入对话框

function promptx(title, lable, href, closed) {
	top.$.jBox("<div class='form-search' style='padding:20px;text-align:center;'>" + lable + "：<input type='text' id='txt' name='txt'/></div>", {
		title: title,
		submit: function(v, h, f) {
			if (f.txt == '') {
				top.$.jBox.tip("请输入" + lable + "。", 'error');
				return false;
			}
			if (typeof href == 'function') {
				href();
			} else {
				resetTip(); //loading();
				location = href + encodeURIComponent(f.txt);
			}
		},
		closed: function() {
			if (typeof closed == 'function') {
				closed();
			}
		}
	});
	return false;
}

// 添加TAB页面

function addTabPage(title, url, closeable, $this, refresh) {
	top.$.fn.jerichoTab.addTab({
		tabFirer: $this,
		title: title,
		closeable: closeable == undefined,
		data: {
			dataType: 'iframe',
			dataLink: url
		}
	}).loadData(refresh != undefined);
}

// cookie操作

function cookie(name, value, options) {
	if (typeof value != 'undefined') { // name and value given, set cookie
		options = options || {};
		if (value === null) {
			value = '';
			options.expires = -1;
		}
		var expires = '';
		if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
			var date;
			if (typeof options.expires == 'number') {
				date = new Date();
				date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
			} else {
				date = options.expires;
			}
			expires = '; expires=' + date.toUTCString(); // use expires attribute, max-age is not supported by IE
		}
		var path = options.path ? '; path=' + options.path : '';
		var domain = options.domain ? '; domain=' + options.domain : '';
		var secure = options.secure ? '; secure' : '';
		document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
	} else { // only name given, get cookie
		var cookieValue = null;
		if (document.cookie && document.cookie != '') {
			var cookies = document.cookie.split(';');
			for (var i = 0; i < cookies.length; i++) {
				var cookie = jQuery.trim(cookies[i]);
				// Does this cookie string begin with the name we want?
				if (cookie.substring(0, name.length + 1) == (name + '=')) {
					cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
					break;
				}
			}
		}
		return cookieValue;
	}
}

// 数值前补零

function pad(num, n) {
	var len = num.toString().length;
	while (len < n) {
		num = "0" + num;
		len++;
	}
	return num;
}

// 转换为日期

function strToDate(date) {
	return new Date(date.replace(/-/g, "/"));
}

// 日期加减

function addDate(date, dadd) {
	date = date.valueOf();
	date = date + dadd * 24 * 60 * 60 * 1000;
	return new Date(date);
}

//截取字符串，区别汉字和英文

function abbr(name, maxLength) {
	if (!maxLength) {
		maxLength = 20;
	}
	if (name == null || name.length < 1) {
		return "";
	}
	var w = 0; //字符串长度，一个汉字长度为2   
	var s = 0; //汉字个数   
	var p = false; //判断字符串当前循环的前一个字符是否为汉字   
	var b = false; //判断字符串当前循环的字符是否为汉字   
	var nameSub;
	for (var i = 0; i < name.length; i++) {
		if (i > 1 && b == false) {
			p = false;
		}
		if (i > 1 && b == true) {
			p = true;
		}
		var c = name.charCodeAt(i);
		//单字节加1   
		if ((c >= 0x0001 && c <= 0x007e) || (0xff60 <= c && c <= 0xff9f)) {
			w++;
			b = false;
		} else {
			w += 2;
			s++;
			b = true;
		}
		if (w > maxLength && i <= name.length - 1) {
			if (b == true && p == true) {
				nameSub = name.substring(0, i - 2) + "...";
			}
			if (b == false && p == false) {
				nameSub = name.substring(0, i - 3) + "...";
			}
			if (b == true && p == false) {
				nameSub = name.substring(0, i - 2) + "...";
			}
			if (p == true) {
				nameSub = name.substring(0, i - 2) + "...";
			}
			break;
		}
	}
	if (w <= maxLength) {
		return name;
	}
	return nameSub;
}