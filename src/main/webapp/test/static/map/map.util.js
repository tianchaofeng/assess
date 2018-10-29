/*
 * 
 */
function MarkerManager(map) {
    this._markers = {};
    this._map = map;
    this._mname = 'all';
}
MarkerManager.prototype.addMarker = function(marker, type) {
    type = type || this._mname;
    if (!this._markers[type]) {
        this._markers[type] = [];
    }
    this._markers[type].push(marker);
    // this._map.centerAndZoom();
    this._map.addOverlay(marker);
};
MarkerManager.prototype.clearMarkers = function(type) {
    type = type || this._mname;
    if (typeof (this._markers[type]) != 'undefined') {
        while (this._markers[type].length > 0) {
            this._map.removeOverlay(this._markers[type].shift());
        }
    }
};
MarkerManager.prototype.getMarkerTotal = function(type) {
    type = type || this._mname;
    if (typeof (this._markers[type]) != 'undefined') {
        return this._markers[type].length;
    } else {
        return 0;
    }
};
// ���ӵ��Զ��帲����
function ComplexCustomOverlay(point, text, mouseoverText){
  this._point = point;
  this._text  = text;
  this._overText = mouseoverText;
}
ComplexCustomOverlay.prototype = new BMap.Overlay();
ComplexCustomOverlay.prototype.initialize = function(map){
	// ����map����ʵ��
	this._map = map;
	// ����divԪ�أ���Ϊ�Զ��帲��������� 
	// var div = this._div = document.createElement("div");
	var div = document.createElement("div");  
	div.style.position = "absolute";
	
	// div.style.zIndex =this._zIndex; 
	// div.setAttribute("id",that._projcode+"_container"); 
	 
	div.style.zIndex = BMap.Overlay.getZIndex(this._point.lat);
	// div.style.backgroundColor = "#EE5D5B";
	// div.style.border = "1px solid #BC3B3A";
	// div.style.color = "white";
	// div.style.height = "18px";
	// div.style.padding = "2px";
	// div.style.lineHeight = "18px";
	// div.style.whiteSpace = "nowrap";
	// div.style.MozUserSelect = "none";
	// div.style.fontSize = "12px"
	// var span = this._span = document.createElement("span");
	// div.appendChild(span);
	// span.appendChild(document.createTextNode(this._text)); 

	// ���Ը��ݲ�������Ԫ�����   
	div.innerHTML = this._text;	
	// var that = this;

	// var arrow = this._arrow = document.createElement("div");
	// arrow.style.background = "url(http://map.baidu.com/fwmap/upload/r/map/fwmap/static/house/images/label.png) no-repeat";
	// arrow.style.position = "absolute";
	// arrow.style.width = "11px";
	// arrow.style.height = "10px";
	// arrow.style.top = "22px";
	// arrow.style.left = "10px";
	// arrow.style.overflow = "hidden";
	// div.appendChild(arrow);
 
/* 	div.onmouseover = function(){
		$(this).find("div").first().removeClass().addClass("qp02");
		// $(this).find("span").first().css('display','inline');
		this.style.zIndex =100;
		// this.style.backgroundColor = "#6BADCA";
		// this.style.borderColor = "#0000ff";
		// this.getElementsByTagName("span")[0].innerHTML = that._overText;
		// arrow.style.backgroundPosition = "0px -20px";
	} */

/* 	div.onmouseout = function(){
		$(this).find("div").first().removeClass().addClass("qp01");
		// $(this).find("span").first().css('display','none');
		this.style.zIndex =-1;
		// this.style.backgroundColor = "#EE5D5B";
		// this.style.borderColor = "#BC3B3A";
		// this.getElementsByTagName("span")[0].innerHTML = that._text;
		// arrow.style.backgroundPosition = "0px 0px";
	} */

	// div.onclick = function(){	
	// }
	
	// ��div��ӵ������������� 
	map.getPanes().markerPane.appendChild(div); 
	// HLUtil.map._map.getPanes().labelPane.appendChild(div);
	// ����divʵ��  
	this._div = div;
	return div;
}
ComplexCustomOverlay.prototype.draw = function(){
	var map = this._map;
	var pixel = map.pointToOverlayPixel(this._point);
	// this._div.style.left = pixel.x - parseInt(this._arrow.style.left) + "px";
	// this._div.style.left = pixel.x - 12   + "px"; 
	// this._div.style.top  = pixel.y - 30 + "px";
}
ComplexCustomOverlay.prototype.addEventListener = function(event,fun){
	// console.log(this._div);
	// this._div['on'+event] = fun;
	// var _event = 'on'+event;
	this._div['on'+event] = fun;
}
/*****************************�����Զ��帲����Ĺ��캯��**********************************/
function SquareOverlay(center,length,html,zIndex,purpose,projcode,px,py,projname,address,addresslong){
	this._center = center; 
	this._length = length;
	this._html = html;
	this._zIndex = zIndex;
	this._purpose = purpose;
	this._projcode = projcode;
	this._px = px;
	this._py = py;
	this._projname = projname;
	this._address = address;
	this._addresslong = addresslong;
 }
// �̳�API��BMap.Overlay
SquareOverlay.prototype = new BMap.Overlay(); 
// ʵ�ֳ�ʼ������
SquareOverlay.prototype.initialize = function(map){
	// ����map����ʵ��
	this._map = map;
	var that = this;   
	// ����divԪ�أ���Ϊ�Զ��帲��������� 
	var div = document.createElement("div");   
	div.style.position = "absolute";
	div.style.zIndex =this._zIndex; 
	div.setAttribute("id",that._projcode+"_container"); 
	// ���Ը��ݲ�������Ԫ�����   
	div.innerHTML = this._html;
	// ��div��ӵ������������� 
	map.getPanes().markerPane.appendChild(div); 
	// ����divʵ��  
	this._div = div;
	return div;
} 
// ʵ�ֻ��Ʒ���
SquareOverlay.prototype.draw = function(){
// ���ݵ�������ת��Ϊ�������꣬�����ø�����  
var position = this._map.pointToOverlayPixel(this._center);
	this._div.style.left = position.x - 12   + "px"; 
	this._div.style.top = position.y - 30  + "px"; 
}
SquareOverlay.prototype.show = function()
{   
	if (this._div){   
	this._div.style.display = "";   }  
} 
SquareOverlay.prototype.hide = function()
{   
	if (this._div){    
	this._div.style.display = "none";   }  
}
SquareOverlay.prototype.changehtml = function(html){  
	if (this._div){   
		this._div.innerHTML= html; 
	}
}
SquareOverlay.prototype.addEventListener = function(event,fun){ 
	this._div['on'+event] = fun;
}
/*
 * ��ͼ�ӿ���
 */
var MapApi = function() {
    //��ʼ������
    var arg = arguments;
    var lng = 116.404, 
		lat = 39.915, 
		cont = 'map', 
		zoom = 12;
    for (var i = 0; i < arg.length; i++) {
        if (0 == i)
            cont = arg[0];
        else if (1 == i)
            lat = arg[1];
        else if (2 == i)
            lng = arg[2];
        else if (3 == i)
            zoom = arg[3];
    }
	// console.log(arg);
    this.citycenter = new BMap.Point(lng, lat); //��λ���ĵ�
	
    var mapOptions = {
        enableMapClick: !1,
        minZoom: 11,
        // maxZoom: 19
    };
    var map = new BMap.Map(cont, mapOptions);
	
	//��ͼ�¼����ú���
	map.enableScrollWheelZoom(true);// ��������������
	map.disableInertialDragging();
	map.enableDragging(); 			//���õ�ͼ��ק�¼���Ĭ������(�ɲ�д
	map.enableDoubleClickZoom(); 	//�������˫���Ŵ�Ĭ������(�ɲ�д)
	map.enableKeyboard(); 			//���ü����������Ҽ��ƶ���ͼ
	map.setDraggingCursor('hand');	//������ק��ͼʱ�����ָ����ʽΪ����
	
	//��ͼ�ؼ���Ӻ���
    this._control = [
        new BMap.NavigationControl({
            anchor: BMAP_ANCHOR_TOP_RIGHT
        }), //���ƽ�����ſؼ�
        new BMap.ScaleControl({
			anchor: BMAP_ANCHOR_BOTTOM_RIGHT,
			offset: new BMap.Size(20, 20)
		}), //��ӱ����߿ؼ�
        new BMap.OverviewMapControl() //������Ե�ͼ�ؼ�
    ];
    for (var i = 0; i < this._control.length; i++) {
        map.addControl(this._control[i]);
    }
	
	map.centerAndZoom(this.citycenter, zoom);
	// map.centerAndZoom("�ൺ", zoom);
    // map.setCurrentCity("����");          // ���õ�ͼ��ʾ�ĳ��� �����Ǳ������õ�
    
    window.map = map; //��map�����洢��ȫ��
    this._map = map;
    this._markerManager = new MarkerManager(this._map);
	this._busLine = null;
    this._infobox = null;
    this._choked = false;
};
//���¶�λ��ͼ���ĵ㣨string:�ؼ��ֶ�λ;object:��γ�ȶ�λ��
MapApi.prototype.resetCenter = function(data) {
    if (typeof (data) == 'string') {
        this._map.centerAndZoom(data);
    } else if (typeof (data) == 'object') {
        if (!data.lng || !data.lat)
            return;
        var zoom = data.zoom || this._map.getZoom();
        this._map.centerAndZoom(new BMap.Point(data.lng, data.lat), zoom);
    }
};
//��λ����ͼĿ�����ĵ�
MapApi.prototype.setCenter = function(lng, lat, zoom) {
    if (!lng || !lat)
        return;
    var zoom = zoom || this._map.getZoom();
    this._map.centerAndZoom(new BMap.Point(lng, lat), zoom);//�ؽ���ͼ����
    this.setZoom(zoom);
    this.panTo(lng, lat);//������ʽ�ƶ�
};
//��ȡ��������
MapApi.prototype.getCenter = function() {
    return this._map.getCenter();
};
//���÷Ŵ󼶱�
MapApi.prototype.setZoom = function(zoom) {
    this._map.setZoom(parseInt(zoom));
};
//��ȡ�Ŵ󼶱�
MapApi.prototype.getZoom = function() {
    return this._map.getZoom();
};
//����ƫ������
MapApi.prototype.panBy = function(posX, posY) {
    this._map.panBy(posX, posY);
};
MapApi.prototype.getMap = function(){
	return this._map;
}

// Conditions = {
	// "district":{
		// "text":["����","����","����","����","����","����","��̨","ʯ��ɽ","��ƽ","ͨ��","˳��","����","����","ƽ��","��ɽ","��ͷ��","����","����","�ܱ�"],
		// "value":["207","208","209","210","211","212","213","214","215","216","217","218","219","220","221","222","223","224","225"],
		// "coid2":{
			// "207":{
				// "value":["399","400","401","402","403","404","405","406","407","408","409","410","411","412","413","414","415","416","417","418","419","420","421","422","423","424","425","426","427","428","429","430","431","432","433","434","435","436","437","438","439","440","441","442"],
				// "text":["������","������ѧ","˫����","�йش�","��̫ƽׯ","κ����","������","�����","ѧԺ·","������","������","����ׯ","֪��·","������","�ϵ�","Բ��԰","�ʼҿ�","ũ��","ĵ��԰","������","������","�����","����","������","���","С����","��ɽ","������","������","����ׯ","�ú�԰","��ׯ","�ļ���","��Ȫ·","�����","����","�廪԰","��Ȫ��","������","����ׯ","������","����·","���ͳ�","����·"]
				// },
			// "208":{"value":["345","346","347","348","349","350","351","352","353","354","355","356","357","358","359","360","361","362","363","364","365","366","367","368","369","370","371","372","373","374","375","376","377","378","379","380","381","382","383","384","385","386","387","388","389","390","391","392","393","394","395","396","397","398"],"text":["�Ž��","��ɯ","��չ","����","��ó","��Ԫ��","����","ʮ�ﱤ","������ׯ","����","���˴�","������԰","������","��ɳ̲","����ׯ","��ׯ","˫��","�˼�԰","������","����","���Ӻ�","��ҩ��","��ͷ","ʮ�����","��ɽ��","������","���˴�СӪ","С����","����","�׶�����","ʯ��Ӫ","���","����","����Ӫ","���ҵ�","����·","����","�߱���","����ׯ","����","CBD","������","��Ӫ","����ƥ�˹�԰","�ǰ�","��Է","������","����·","˫��","���ֹ�","��¶԰","�Ļ�","��������","ý���"]},
			// "209":{"value":["278","279","280","281","282","283","284","285","286","287","288","289","290"],"text":["������","���п�","����ʮ��","��ֱ��","������","Ӻ�͹�","��ƽ��","������","������","����","������","����","�𱦽�"]},"210":{"value":["481","482","483","484","485","486","487","488","489","490","491","492","493","494","495","496","497","498","499","500","501"],"text":["������","������","����","ľ�ص�","��ʤ��","�����","��̳","���ڽ�","���̿�","��ˮ̶","չ��·","������","ʲɲ��","��԰","����ׯ","��¥���","�ذ���","��ʿ·","С��","�½ֿ�","��ֱ��"]},"211":{"value":["502","503","504","505","506","507","508","509","510"],"text":["������","������","����¥","��̳","��������","������","��̶��","ǰ��","������"]},"212":{"value":["511","512","513","514","515","516","517","518","519","520","521","522","523"],"text":["������","�㰲��","��Ȼͤ","������","��ֽ��","������","ţ��","������","��դ��","������","���԰","��ũ̳","�׹�·"]},"213":{"value":["443","444","445","446","447","448","449","450","451","452","453","454","455","456","457","458","459","460","461","462","463","464","465","466","467","468","469","470","471","472","473","474","475","476","477","478","479","480"],"text":["��ׯ","����԰","������","����","����վ","����","ľ��԰","�Թ���","��ұ�","����Ҥ","�˻�Ӫ","������","�����","����","�����","�Ƽ�԰��","¬����","����","��԰","����","����ׯ","��ȪӪ","�Ұ���","����","�ѻ���","������","������","�Ƹ�","����","����","��̨������","���ߵ�","�·���","̫ƽ��","����ׯ","�����","������","�μ�ׯ"]},"214":{"value":["524","525","526","527","528","529","530","531","532","533","534","535","536","537"],"text":["�Ϲų�","ƻ��԰","�˽�","³��","��ׯ","ģʽ��","�˱�ɽ","�ų�","�˴�","ʯ��ɽ","����","��ɽ","�߾�","�𶥽�"]},
			// "215":{"value":["538","539","540","541","542","543","544","545","546","547","548"],"text":["��ˮ��","С��ɽ","������","��ͨԷ","���߼�","��Ӫ","ɳ��","�Ͽ�","������","��ƽ�س�","����"]},"216":{"value":["549","550","551","552","553","554","555","556","557","558","559","560","561","562","563","564","565"],"text":["����԰","��԰","ͨ�ݱ�Է","�ٺ���","�»����","�»���","��԰","����","����","��ׯ","�˺Ӵ��","���Ļ�԰","�����","����ׯ","ºԷ","�����","�ſ���"]},"217":{"value":["570","571","572","573","574","575","576","577"],"text":["���ܺ�","˳���","�ո۹�ҵ��","����","��˳����·","����","���������","��ɳ��"]},"218":{"value":["566","567","568","569"],"text":["������","�ƴ�","��ׯ","�ɹ�"]},"219":{"value":["3061","579"],"text":["","����"]},"220":{"value":["600"],"text":["ƽ��"]},"221":{"value":["580","581","582","583","584","585","586","587","588","589","590","591"],"text":["��","������","����","�й�","�ܿڵ�","��ɽ�ǹ�","��ɽ","�ƴ�","������","�����","����","̫ƽׯ"]},"222":{"value":["592","593","594","595","596","597","598"],"text":["����","˫��","������","���ҵ�","��̲","������","����"]},"223":{"value":["601","602"],"text":["�˴���","��ɽӪ"]},"224":{"value":[""],"text":[""]},"225":{"value":["603","604","605","606"],"text":["�ོ","���","�̰�","����"]}
			// }
		// },
	// "price":{
		// "text":["50������","50-80��","80-100��","100-120��","120-150��","150-200��","200-300��","300������"],
		// "value":["170","171","172","173","174","175","176","177"]
	// },
	// "area":{
		// "text":["50ƽ����","50-70ƽ��","70-90ƽ��","90-130ƽ��","130-150ƽ��","150-200ƽ��","200-300ƽ��","300ƽ������"],
		// "value":["185","186","187","188","189","190","191","192"]
	// },
	// "fangling":{
		// "text":["2������","2-5��","5-10��","10������"],
		// "value":["3033","3034","3042","3043"]
	// },"cx":{"text":["��","��","��","��","����","����","����","����","�ϱ�","����"],"value":["1","2","3","4","5","6","7","8","9","10"]},
	// "zxcd":{"text":["ë��","����װ��","�е�װ��","�ߵ�װ��","����װ��"],"value":["1","2","3","4","5"]},
	// "fwjg":{"text":["ƽ��","��ʽ","Ծ��","���","����"],"value":["1","2","3","4","5"]},
	// "shi":{"text":["0��","1��","2��","3��","4��"],"value":["100","1","2","3","4"]},
	// "ting":{"text":["0��","1��","2��","3��","4��","5��"],"value":["100","1","2","3","4","5"]},
	// "chu":{"text":["1��","2��","3��","4��","5��","0��"],"value":["1","2","3","4","5","100"]},
	// "wei":{"text":["1��","2��","3��","4��","5��","0��"],"value":["1","2","3","4","5","100"]},
	// "fwpt":{"text":["����","��","�Ҿ�","���ߵ���","��ˮ��","�����","�绰","��ˮ��","���ӻ�","�յ�","ϴ�»�","����","ú��","ů��","����","��Ȼ��"],
	// "value":["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"]}};
// Conditions['publisher'] = {'text':['����','������'],'value':[1,2]};

var projectMarkers=[],//С��Markers
 districtMarkers =[],//����Markers
 districtAreaInfo=[],//����������Ϣ����
 districtAreaMarkers=[];//��������Marker
 
/**
 * ������
 */
var HLUtil = {
    map: null,
    firstLoad: true,
    clearLocation: {
        district: false,
        subway: false,
        keyword: false
    },
	mapStatu : 'area',
	only_around:false,//�Ƿ�ֻ��ʾ�ܱ�
	condition : {
		zoom: null,
		center: null, //����:this.condition.center.lng γ��:this.condition.center.lat
		x: null,
		y: null,
		bounds: null,
		sw: null, //���Ͻ�(���½�) ����:sw.lng//γ��:sw.lat
		ne: null, //������(���Ͻ�) ����:ne.lng//γ��:ne.lat
		searchType: '', //��������[Ĭ��,���ַ�,�ⷿ]
		searchData: '' //ִ������,���������Ͳ�Ϊ��ʱ��Ч
	},
	// ����
	area : {id: '',name: ''},
	// ���
	district : {id: '',name: ''},
	community:{
		id: '', //��ǰС��ID
		x: '',
		y: '',
		data: '', //��ǰС����json��ʽ��Ϣ
		key: '', //��ǰС���ı��������ؼ���
		index: 0,
		keys: new Array(),
		localSearchResult: null,
		infoList: null
	},
	zoom:{
		community:15,
		district :14
		// community:16,
		// district :14
	},
	demo:{
		cont : 'map',
		lng : 116.404, 
		lat : 39.915,
		initZoom : 11
	},
	//��ʼ��
    init: function(mapInfo) {
		var _this = this;
		
        //��ͼ���ֽ������
        _this.changescreenWandH();
		//��̬�����������߱仯����ʼ�������ֿ��
		$(window).resize(function () {
			_this.changescreenWandH();
		});
		
		var mapInfo = $.extend(_this.demo,mapInfo);
		_this.map = new MapApi('map',mapInfo.lat,mapInfo.lng,mapInfo.initZoom);

		// ֹͣ��ק��ͼʱ������
		_this.map.getMap().addEventListener("dragend",function(e){
			_this.dragendEvent(_this);
        });
		// zoomend ��ͼ�������ż������ʱ�����������¼���
		_this.map.getMap().addEventListener("zoomend",function(){
			// _this.dragendEvent(_this);
			_this.zoomendEvent(_this);
		});
		// moveend ��ͼ�ƶ�����ʱ�������¼���
		
		switch(mapInfo.maptype){			
            case 'chuzu':
				_this.InitChuzuConditions();
				// _this.getDistrictsPoint();
			break;
            case 'newhouse':
				_this.InitNewhouseConditions();
				// _this.getDistrictsPoint();
			break;
			default:				
				//ģ���ʼ��
				_this.InitChushouConditions();
				// �������ַ�����ͼ�� 1264
				// _this.getDistrictsPoint();
			break;
		}
		
		$("#apf_id_10_map_search").on('click',function(){
			var q = $("#apf_id_10_map_keywords").val();
			var form_url = $(this).attr("data-action");
			searchHouseInfo.q = escape(q);
			_this.resetCondition();
			_this.showHouseData();
			// window.open(encodeURI(form_url + "&q" + q)); 
			// window.location.href = form_url+'&q='+q;
		});
		$(".list_ac").on("click",function(){
			windows.location.href=mapInfo.list_url;
		})
		$(window).on("one",function(){
			_this.zoomendEvent(_this);
			$(this).unbind("one")
		}).trigger("one");
		// 
		
    },
	dragendEvent:function(api){
		var _this = api;
		// map.clearOverlays();
		_this.resetCondition();
		// _this.loadPyData();
		this.switchOperate();
	},
	zoomendEvent:function(api){
		this.switchOperate();
	},
	/**
     * ���ݵ�ǰ��ͼ���ż���ѡ����ز�ͬ������
     * @returns {undefined}
     */
    switchOperate:function() {
		var _this = this;
		var _zoom = _this.map.getMap().getZoom();
		// if(_zoom>=16){
		if(_zoom>=_this.zoom.community){
			_this.mapStatu= 'community';
            // _5i5jmap.operate.loadList = false;
		}else if(_zoom >= _this.zoom.district) {
		// }else if(_zoom >= 12) {
            autoSearchMaker = '';
            autoSearchVal = '';
            // _5i5jmap.condition.searchType='all';
            _this.mapStatu = 'district';
        } else {
            autoSearchMaker = '';
            autoSearchVal = '';
            // _5i5jmap.condition.searchType='all';
            _this.mapStatu = 'area';
        }
		// console.log(_zoom);
		// console.log(_this.mapStatu);
		switch(_this.mapStatu){
			// case 'list'://��ʹΪС���б�״̬
                // changeToList();
                // break;
            // case 'city'://
                // changeToCity();
                // break;
            case 'area'://
                // console.log('changeToArea');
				_this.changeToArea();
                break;
            case 'district'://
                _this.changeToDistrict();
                break;
            case 'community'://
                _this.changeToCommunity();
                break;
            // default:
                // break;
		}
	},
	changeToArea:function(){
		var _this = this;
		_this.map._map.clearOverlays(); //�����ͼ�����б�ע
        _this.mapStatu = 'area';
        // _5i5jmap.operate.loadList = false;
        // loadArea();
		searchHouseInfo.district  = 0;
		searchInfo.district  	  = '';
		searchHouseInfo.district2 = 0;
		searchInfo.district2 	  = '';
		searchHouseInfo.borough_id= 0;
		searchInfo.borough_id	  = '';
		_this.getDistrictsPoint();
	},
	changeToDistrict:function(){
		var _this = this;
        _this.mapStatu = 'district';
		_this.map._map.clearOverlays();
		searchHouseInfo.district2 = 0;
		searchInfo.district2 	  = '';
		searchHouseInfo.borough_id= 0;
		searchInfo.borough_id	  = '';
        // _5i5jmap.operate.loadList = false;
        // loadDistrict();
		_this.getPlatePoint();
	},
	changeToCommunity:function(){
		var _this = this;
        _this.mapStatu = 'community';
		_this.map._map.clearOverlays();
		searchHouseInfo.borough_id= 0;
		searchInfo.borough_id	  = '';
       _this.getHousePoint();
	},
	/**
	 * ���õ�ͼ��Ϣ
		
		sw: null, //���Ͻ�(���½�) ����:sw.lng//γ��:sw.lat
		ne: null, //������(���Ͻ�) ����:ne.lng//γ��:ne.lat
	 */
	resetCondition:function(){
		//console.log('���õ�ͼ��Ϣ');
		var _bmap = this.map.getMap();
		this.condition.zoom   = _bmap.getZoom();
        this.condition.center = _bmap.getCenter(); //���ĵ�
        this.condition.x = this.condition.center.lng;
        this.condition.y = this.condition.center.lat;
        this.condition.bounds = _bmap.getBounds(); //��������
		// ���Ͻǵ�
        this.condition.sw = this.condition.bounds.getSouthWest(); //����:sw.lng//γ��:sw.lat
        this.condition.ne = this.condition.bounds.getNorthEast();
	},
	/**
	 * ���ط�Դ����
		
		type: ��ͼ���� sale rent newhouse
	 */
	loadPyData:function(){
		var _this=this;
		var	url = MapApiUrl+'?op=HousePoint&type='+mapInfo.maptype;
		var data = {};
		var bs = _this.map.getMap().getBounds();   //��ȡ��������
		var bssw = bs.getSouthWest();   //�����������½�
		var bsne = bs.getNorthEast();   //�����������Ͻ�
        data = {
			type: mapInfo.maptype,
			module_id: mapInfo.module_id,
			type_id: searchHouseInfo.type_id,
			cityarea_id : searchHouseInfo.district,
			cityarea2_id: searchHouseInfo.district2,
			area : escape(searchHouseInfo.area),
			price: escape(searchHouseInfo.price),
			pageno: escape(searchHouseInfo.pageIndex),
			q: searchHouseInfo.q,
			borough_id: searchHouseInfo.borough_id,
			zoom: _this.condition.zoom,
            // sw: _this.condition.sw,
            // ne: _this.condition.ne
            sw: bssw,
            ne: bsne
		}
		console.log("loadPyData data->");
		console.log(data);
		// console.log(data.sw);
		// console.log(data.ne);
		$.ajax({
			type:'get',
			async:false,
			cache:false,
			url:url,
			data:data,
			dataType:'json',
			success: function(data){
				if (data.project  && data.project.projcode) {
					var html = "";
					var project = data.project;
					html += '<div class="map-cszinfo"><ul><li><a class="blue f14b" target="_blank" href="' +project.projurl+ '" id="aProjectName" title="' + project.projname + '">' + (project.projname.length>12 ? project.projname.substring(0, 12) + "..." : project.projname) + '</a><span id="spnPriceOut"><span class="pl40">���ۣ�</span><strong class="org02">' + project.price + '</strong>Ԫ/' + (mapInfo.maptype == 'chushou' ? "ƽ��" : "��") + '</span></li><li class="addr" title="' + project.address + '">' + (project.address.length > 25 ? (project.address.substring(0, 25) + "...") : project.address) + '</li><li id="p_housecount"><span class="fys">����<span class="red">' + data.allcount + '</span>�׷�Դ</span></li></ul></div><div class="clear"></div>';
					$("#div_ProjInfo").show().html(html);
				}else{
					$("#div_ProjInfo").hide();
				}
				if (data.house && 0!=_this.count(data.house)) {
					var list = data.house;
					var html = '';
					// console.log(list);
					switch(mapInfo.maptype){
						case 'newhouse':	//����
							for (var i = 0; i < _this.count(list); i++) {
							(function (x) {//�ؼ�
								var title=list[i].title,
									houseurl=list[i].houseurl,
									projname=list[i].projname,
									projcode=list[i].projcode,
									address =list[i].address,
								// addresslong=list[i].addresslong,
									lat=list[i].lat,
									lng=list[i].lng;
								var infoWindowHtml='';
									infoWindowHtml+="<div>";
									infoWindowHtml+="<h4 style='margin:0 0 5px 0;padding:0.2em 0;font-size:14px;'><a href='"+list[i].houseurl+"' target='_blank'><span style='color:#F60'>"+title+"</span></a></h4>";
									infoWindowHtml+="<a href='"+list[i].houseurl+"' target='_blank'>";
									infoWindowHtml+="<img style='float:right;margin:4px' id='imgDemo' src='"+list[i].houseimg+"' border='0' width='139' height='104' title='"+title+"'/>";
									infoWindowHtml+="</a>";
									infoWindowHtml+="<p style='margin:0;line-height:1.5;font-size:12px;'>�ο����ۣ�"+list[i].price+"Ԫ/ƽ</p>";
									infoWindowHtml+="<p style='margin:0;line-height:1.5;font-size:12px;'>��Ŀ���ƣ�"+projname+"</p>"; 
									infoWindowHtml+="<p style='margin:0;line-height:1.5;font-size:12px;'>�����ַ��"+address+"</p>";
									// infoWindowHtml+="<p style='margin:0;line-height:2.5;font-size:12px;'><a href='"+houseurl+"' target='_blank'><img src='"+list[i].houseimg+"' border='0' style='margin:5px 0px' /></a></p>";
									infoWindowHtml+="</div>";
								var pointHtml ='';			
									pointHtml ='<div class="qp01 map_pop_sublocation" projcode="'+projcode+'" projname="'+projname+'">'; 
									pointHtml+='<a class="noatag"><div class="s1"><em>'+ projname +'<span style="display:none;"></span></em></div></a>';
									pointHtml+='</div>';
								var point = new BMap.Point(lng,lat);
								// var mySquare = new SquareOverlay(point,100,pointHtml,1,'',projcode,'','','','','');
								var mySquare = new BMap.Marker(point);
								var index = 1;
								// var _iw = _this.createInfoWindow(i,list);
								// ������Ϣ���ڶ���
								var infoWindow = new BMap.InfoWindow(infoWindowHtml,{width:350,enableMessage:false});
								mySquare.addEventListener("click", function(){
									this.openInfoWindow(infoWindow);
									//ͼƬ��������ػ�infowindow
									document.getElementById('imgDemo').onload = function (){
										infoWindow.redraw();   //��ֹ�����ٽ�����ͼƬδ����ʱ�����ɵ���Ϣ��߶ȱ�ͼƬ���ܸ߶�С������ͼƬ���ֱ�����
									}
								});						
								_this.map.getMap().addOverlay(mySquare);

								html+='<li id="list_'+list[i].houseid+'" class="estate-mod clearfix">';
								html+='<a href='+list[i].houseurl+'>';
								html+='<div class="news-img">'+'<img src="'+list[i].houseimg+'" width="95" height="70" alt="">'+'</div>';
								html+='<div class="news-text">';
								html+='<div class="news-hd clearfix">'+'<h3 class="title" title="">'+list[i].title+'</h3>'+'</div>';
								html+='<div class="news-con clearfix">';
								html+='<div class="detail">';
								html+='<p class="house-type">'+list[i].phone+''+'</p>';
								html+='</div>';
								html+='<div class="mod2">';
								html+='<span class="brough_name gray">'+list[i].projname+'</em></span>';
								html+='<span class="aver-price"><em class="num">'+list[i].price+'</em>Ԫ/ƽ</span>';
								html+='</div>';
								html+='</div>';
								html+='</div>';
								html+='</a>';
								html+='</li>';	
							})(i);
							}						
							break;
						default:	//����	
							for (var i = 0; i < _this.count(list); i++) {
							(function (x) {//�ؼ�							
								var title=list[i].title,
									houseurl=list[i].houseurl,
									proid=list[i].proid,
									projname=list[i].projname,
									projcode=list[i].projcode,
									address =list[i].address,
									house_num =list[i].house_num,
									lat=list[i].lat,
									lng=list[i].lng;
									houselst = list[i].houselst;
								var infoWindowHtml='';
									infoWindowHtml+="<div>";
									infoWindowHtml+="<h4 style='margin:0 0 5px 0;padding:0.2em 0;font-size:14px;'><a href='"+houseurl+"' target='_blank'><span style='color:#F60'>"+title+"</span></a></h4>";
									infoWindowHtml+="<a href='"+houseurl+"' target='_blank'>";
									infoWindowHtml+="<img style='float:right;margin:4px' id='imgDemo' src='"+list[i].houseimg+"' border='0' width='139' height='104' title='"+title+"'/>";
									infoWindowHtml+="</a>";
									infoWindowHtml+="<p style='margin:0;line-height:1.5;font-size:12px;'>�ο����ۣ�"+list[i].price+list[i].price_unit+"</p>";
									infoWindowHtml+="<p style='margin:0;line-height:1.5;font-size:12px;'>��Ŀ���ƣ�"+projname+"</p>"; 
									infoWindowHtml+="<p style='margin:0;line-height:1.5;font-size:12px;'>�����ַ��"+address+"</p>";
									// infoWindowHtml+="<p style='margin:0;line-height:2.5;font-size:12px;'><a href='"+houseurl+"' target='_blank'><img src='"+list[i].houseimg+"' border='0' style='margin:5px 0px' /></a></p>";
									infoWindowHtml+="</div>";
								var pointHtml ='';			
									// pointHtml ='<div class="qp01 map_pop_sublocation" projcode="'+projcode+'" projname="'+projname+'">'; 
									// pointHtml+='<a class="noatag"><div class="s1"><em>'+ projname +'<span style="display:inline;">'+house_num+'</span>��</em></div></a>';
									// pointHtml+='</div>';
									pointHtml+='<div class="bubble-3 bubble" data-longitude="'+lng+'"  data-latitude="'+lat+'" data-id="'+projcode+'" projcode="'+projcode+'" projname="'+projname+'" data-msg="" data-station="43142370" data-schoolid="4000001020">';
									pointHtml+='<div class="bu1">';
									// pointHtml+='<i class="num">&nbsp;'+projname+'&nbsp;</i><i class="name-des" style="display:none;">'+house_num+'��</i>';
									pointHtml+='<i class="num">&nbsp;'+projname+'&nbsp;</i><i class="name-des" style="display:none;">'+house_num+'��</i>';
									pointHtml+='</div>';
									pointHtml+='<i class="arrow-up"><i class="arrow"></i></i>';
									pointHtml+='</div>';
									pointHtml+='</div>';
						
								var point = new BMap.Point(lng,lat);
								var mySquare = new SquareOverlay(point,100,pointHtml,1,'',projcode,'','','','','');
								// var mySquare = new BMap.Marker(point);
								_this.map.getMap().addOverlay(mySquare);
								var overrideMouseOut=function (){
									if(!$(this).find("div").first().hasClass("clicked")){
										// $(this).find("div").first().removeClass().addClass("qp01");
										$(this).find(".name-des").first().css('display','none');
										this.style.zIndex =-1;
									}
								};
								var overrideMouseOver=function (){
									// $(this).find("div").first().removeClass().addClass("qp02");
									$(this).find(".name-des").first().css('display','inline-block');
									this.style.zIndex =100;
								};
								var overrideClick = function(){
									var districtname = $(this).find("div").first().attr('projname');
									var district     = $(this).find("div").first().attr('projcode');
									// console.log(district);
									$(".bubble-3").removeClass("clicked");
									$(".bubble-3 .name-des").css('display','none');
									
									$(this).find("div").first().addClass("clicked");
									$(this).find(".name-des").first().css('display','inline-block');
									// $(this).css('background','red');
									searchHouseInfo.project = district;
									searchInfo.project = districtname;
									_this.showHouseData();
								}
								mySquare.addEventListener('click',overrideClick);
								mySquare.addEventListener('mouseover',overrideMouseOver);
								mySquare.addEventListener('mouseout', overrideMouseOut);
								/* // ������Ϣ���ڶ���
								var infoWindow = new BMap.InfoWindow(infoWindowHtml,{width:350,enableMessage:false});
								mySquare.addEventListener("click", function(){
									this.openInfoWindow(infoWindow);
									//ͼƬ��������ػ�infowindow
									document.getElementById('imgDemo').onload = function (){
										infoWindow.redraw();   //��ֹ�����ٽ�����ͼƬδ����ʱ�����ɵ���Ϣ��߶ȱ�ͼƬ���ܸ߶�С������ͼƬ���ֱ�����
									}
								}); */
							})(i);
							}
							var houselst = data.houselst;
							// console.log(data.houselst);
							for (var h = 0; h < _this.count(houselst); h++) {
								// console.log(h);
								var h_houseid  = houselst[h].houseid,
									h_houseurl = houselst[h].houseurl,
									h_title    = houselst[h].title,
									h_typecname = houselst[h].typecname,
									h_buildarea = houselst[h].buildarea,
									h_projname = houselst[h].projname,
									h_price = houselst[h].price,
									h_houseimg = houselst[h].houseimg;
								html+='<li id="list_'+h_houseid+'" class="estate-mod clearfix" >';
								html+='<a href='+h_houseurl+'>';
								html+='<div class="news-img">'+'<img src="'+h_houseimg+'" width="95" height="70" alt="">'+'</div>';
								html+='<div class="news-text">';
								html+='<div class="news-hd clearfix">'+'<h3 class="title" title="">'+h_title+'</h3>'+'</div>';
								html+='<div class="news-con clearfix">';
								html+='<div class="detail">';
								html+='<p class="house-type">'+houselst[h].room+houselst[h].hall+h_buildarea+'ƽ����'+'</p>';
								html+='</div>';
								html+='<div class="mod2">';
								html+='<span class="brough_name gray">'+h_projname+'</em></span>';
								html+='<span class="aver-price"><em class="num">'+h_price+'</em>Ԫ/��</span>';
								html+='</div>';
								html+='</div>';
								html+='</div>';
								html+='</a>';
								html+='</li>';
							}
							break;
					}
					$("#divProjectHouse").html(html); 
				}else {
					_this.changeConditionTipsDiv();
					var noresultdiv = '<div class="mt10 "><ul class="nohouselist"><li><strong>��Ǹ��δ�ҵ���ط�Դ</strong></li><li>��������</li><li>������׼ȷ��С��������Ȧ</li><li>������ȥ��ĳЩ������������</li></ul></div>'
					$("#divProjectHouse").html(noresultdiv);
					$("#fanye_P").hide();
				}
				// console.log('data->');
				// console.log(data);
				// console.log('data.allcount->'+data.allcount);
				if (data.allcount) {
					$("#spnHouseCount").html(data.allcount);
					$("#bottomcountDiv").show();
					$("#p_housecount").show();
				} else {
					$("#spnHouseCount").html("0");
					$("#bottomcountDiv").hide();
					$("#p_housecount").hide();
				}
				_this.loadPageBar();
			}
		});
	},//��ͼ���ֽ������
	changescreenWandH:function(){
		//��̬�ж��Ҳ��ͼ�ĸ߶�
		// var windowH =  document.body.scrollHeight;
		var windowH =  $(window).height();
		var headerH = $('.head_top').height()+$('.head_nav').height();
		var headerH = 100;
		var height = ((windowH-headerH)>100) ? windowH-headerH : 300;
		$('#map').css('height',height+'px');
		$('.list_con').css('height',(height-$('.r-hd').height())+'px');
		$('#apf_id_1_filter').css('height',(height-10)+'px');
        $('#apf_id_1_filter .ctrl').css('height',(height-4)+'px');
	},
	//���۳�ʼɸѡ����
	InitChushouConditions:function(){
		var _this = this;
		if(Conditions.district) _this.InitDistrictControl();
		// if(Conditions.district) _this.InitShangquanControl();
		if(Conditions.area)  _this.InitAreaControl();
		if(Conditions.price) _this.InitPriceControl();
		if(Conditions.model) _this.InitModelControl();
		// _this.InitTopNav();
    },
	//�����ʼɸѡ����
	InitChuzuConditions:function(){
		var _this = this;
		if(Conditions.district) _this.InitDistrictControl();
		// if(Conditions.district) _this.InitShangquanControl();
		if(Conditions.area)  _this.InitAreaControl();
		if(Conditions.price) _this.InitPriceControl();
		// _this.InitTopNav();
    },
	//���̳�ʼɸѡ����
	InitNewhouseConditions:function(){
		var _this = this;
		if(Conditions.district) _this.InitDistrictControl();
		// if(Conditions.district) _this.InitShangquanControl();
		// if(Conditions.area)  _this.InitAreaControl();
		if(Conditions.price) _this.InitPriceControl();
		// _this.InitTopNav();
    },
	InitTopNav:function(){
		var _this=this;
		$("#ctrlMap a").on("click",function(){
			var type=$(this).attr("data-type");
			mapInfo.maptype = type;
			$("#ctrlMap li").removeClass("on")
			$(this).parent().addClass("on")
			
			$("#search_cond_select_div").html('');
			_this.switchOperate();
			if(type=='chuzu'){
				_this.InitChuzuConditions();
			}else if(type=='newhouse'){
				_this.InitNewhouseConditions();
			}else{
				_this.InitChushouConditions();
			}
			
		})
	},
	//�����ؼ�
	InitDistrictControl:function(){
		var _this = this;
		var content = Conditions.district;
		var ddText = '',
			ddValue = '';
		// $("#search_cond_select_div").append('<div class="selectqx" id="districtControl"><div id="divDistrict" class="select_box"><div id="spnDistrictTitle" District="" class="tag_select" style="cursor: pointer;" onmouseover="this.className=\'tag_select_open\'" onmouseout="this.className=\'tag_select\'">����</div></div>');
		var flag = document.getElementById('divDistrict');
		if(flag == null){
			$("#districtControl").after('<div id="divDistrict" class="select_box f"><div id="spnShangquanTitle" shangquan="" class="tag_select" style="cursor: pointer;" onmouseover="this.className=\'tag_select_open\'" onmouseout="this.className=\'tag_select\'">���</div><ul id="ulShangquan" class="tag_options" style="position: absolute; z-index: 999;display:none;"></ul></div>');
			var container = $("#divDistrict");
		}else{
			var container = $("#divDistrict");
			container.html('');
			var label = $('<div id="spnDistrictTitle" District="" class="tag_select" style="cursor: pointer;" onmouseover="this.className=\'tag_select_open\'" onmouseout="this.className=\'tag_select\'">����</div><ul id="ulDistrict" class="tag_options" style="position: absolute; z-index: 999;display:none;"></ul>');
			container.append(label);
		}
		var ul = $("#ulDistrict");
		var contentLength = _this.count(content.text);		
		for(var i = 0; i < contentLength; i++){
			ddText  = content.text[i];
			ddValue = content.value[i];
			ul.append('<li style="cursor: pointer;" class="open" onmouseover="this.className=\'open_hover\'" onmouseout="this.className=\'open\'"><a selecttype="district" district="'+ddValue+'" style="color:#0055BB;text-decoration:none">' + ddText + '</a></dt>');
		}
		
		//�����Ĵ�������
        ul.find("li").bind("click", function () {
			var district = $(this).find("a").attr("district");
			if(searchHouseInfo.district!=district){
				searchInfo.district 	  = $(this).find("a").html();
				searchHouseInfo.district  = district;
				searchHouseInfo.district2 = 0;
				searchInfo.district2 	  = '';
				searchHouseInfo.keyword   = '';
				searchInfo.keyword 		  = '';
				searchHouseInfo.borough_id= '';
				searchInfo.borough_id 	  = '';
				searchHouseInfo.pageIndex = 1;
				searchHouseInfo.projpageindex = 1;
								
				Conditions.shangquan = Conditions.district.coid2[searchHouseInfo.district];
				//��Ȧ�ؼ�
				// _this.InitShangquanControl(); 
				$("#spnDistrictTitle").html(searchInfo.district).attr("district",searchHouseInfo.district);	
				//ɸѡ������ʾ
				// _this.changeConditionTipsDiv();
				//���house��Ϣ�б�
				// _this.showHouseData();
				// _this.changeToDistrict();
				// _this.resetCondition();
				// _this.getPlatePoint();
				// _this.loadPyData();
				
				_this.changeConditionTipsDiv();//ɸѡ������ʾ
				_this.removeDistrictMarkers(); //�Ƴ�������ʾ
				_this.getDistrictAreaInfo(_this.zoom.district);   //����������ʾ setZoom(14);
				_this.getPlatePoint();
            }
		});
		
		//����Ч��
		container.append(ul)
		.bind("click", function () {
            if ($("#ulDistrict").css("display") == 'none') {
				$("#ulDistrict").show();}else{$("#ulDistrict").hide();
			}
        }).bind("mouseenter", function () {
            $("#spnDistrictTitle").removeClass().addClass("tag_select_open");
            $("#ulDistrict").show();
        }).bind("mouseleave", function () {
            $("#spnDistrictTitle").removeClass().addClass("tag_select");
            $("#ulDistrict").hide();
        });
	},
	//��Ȧ�ؼ�
	InitShangquanControl:function(){
		var _this=this;
		var content = Conditions.shangquan;
		var ddText = '',
			ddValue = '';
		var flag = document.getElementById('divShangquan');
		if(flag == null){
			$("#districtControl").after('<div id="divShangquan" class="select_box f"><div id="spnShangquanTitle" shangquan="" class="tag_select" style="cursor: pointer;" onmouseover="this.className=\'tag_select_open\'" onmouseout="this.className=\'tag_select\'">���</div><ul id="ulShangquan" class="tag_options" style="position: absolute; z-index: 999;display:none;"></ul></div>');
			var container = $("#divShangquan");
		}else{
			var container = $("#divShangquan");
			container.html('');
			var label = $('<div id="spnShangquanTitle" District="" class="tag_select" style="cursor: pointer;" onmouseover="this.className=\'tag_select_open\'" onmouseout="this.className=\'tag_select\'">����</div><ul id="ulShangquan" class="tag_options" style="position: absolute; z-index: 999;display:none;"></ul>');
			container.append(label);
		}
		// var container = $("#divShangquan");
		var ul = $("#ulShangquan");
		var contentLength = _this.count(content.text);
		var ulhtml = '';	
		for(var i = 0; i < contentLength; i++){
			ddText = content.text[i];
			ddValue = content.value[i];
			ulhtml += '<li style="cursor: pointer;" class="open" onmouseover="this.className=\'open_hover\'" onmouseout="this.className=\'open\'"><a selecttype="shangquan" shangquan="'+ddValue+'" style="color:#0055BB;text-decoration:none">' + ddText + '</a></li>';
		}
		ul.html(ulhtml);
		//�����Ĵ�������
        ul.find("li").bind("click", function () {
            var district2 = $(this).find("a").attr("shangquan");
            if(searchHouseInfo.district2 != district2){
				searchInfo.district2      = $(this).find("a").html();
				searchHouseInfo.district2 = district2;
				$("#spnShangquanTitle").html(searchInfo.district2).attr("shangquan",searchHouseInfo.district2);	
				_this.changeConditionTipsDiv();              
				
				// _this.showHouseData();
				// _this.resetCondition();
				// _this.loadPyData();
				
				_this.changeConditionTipsDiv();//ɸѡ������ʾ
				_this.removeDistrictMarkers(); //�Ƴ�������ʾ
				_this.getDistrictAreaInfo(_this.zoom.community);   //����������ʾ
				_this.map._map.clearOverlays();
				_this.getHousePoint();
            }
        });
        //����Ч��
		container.append(ul).bind("click", function () {
            if ($("#ulShangquan").css("display") == 'none') {$("#ulShangquan").show();}else{$("#ulShangquan").hide();}
        }).bind("mouseenter", function () {
            $("#spnShangquanTitle").removeClass().addClass("tag_select_open");
            $("#ulShangquan").show();
        }).bind("mouseleave", function () {
            $("#spnShangquanTitle").removeClass().addClass("tag_select");
            $("#ulShangquan").hide();
        }); 
	},
	// ����ؼ�
	InitAreaControl:function(){
		var _this=this;
		var content = Conditions.area;			
		$("#search_cond_select_div").append('<div class="selectqx f"><div id="divArea" class="select_box"><div id="spnAreaTitle" area="" class="tag_select" style="cursor: pointer;" onmouseover="this.className=\'tag_select_open\'" onmouseout="this.className=\'tag_select\'">���</div></div>');
		var container = $("#divArea");
		var ddText = '',
			ddValue = '';
		var ul = $('<ul id="ulArea" class="tag_options" style="position: absolute; z-index: 999;display:none;"></ul>');
		var contentLength = _this.count(content.text);
		for (var i = 0; i < contentLength; i++) {
			var ddText = content.text[i];
			var ddValue = content.value[i];    
				ul.append('<li style="cursor: pointer;" class="open" onmouseover="this.className=\'open_hover\'" onmouseout="this.className=\'open\'"><a selecttype="area" area="' + ddValue + '" style="color:#0055BB;text-decoration:none">' + ddText + '</a></dt>');
		}
		//�����Ĵ�������		
		ul.find("li").bind("click", function () {
			var area = $(this).find("a").attr("area")
			if(searchHouseInfo.area != area){
				searchInfo.area = $(this).find("a").html();
				searchHouseInfo.area = area;
				$("#spnAreaTitle").html(searchInfo.area).attr("area",searchHouseInfo.area);
				_this.changeConditionTipsDiv();
				// _this.showHouseData();
				
				_this.resetCondition();
				_this.showHouseData();
			}
		});
		//����Ч��
	   container.append(ul).bind("click", function () {
			if ($("#ulArea").css("display") == 'none') {
				$("#ulArea").show();
			} else {
				$("#ulArea").hide();
			}
		}).bind("mouseenter", function () {
			$("#spnAreaTitle").removeClass().addClass("tag_select_open");
			$("#ulArea").show();
		}).bind("mouseleave", function () {
			$("#spnAreaTitle").removeClass().addClass("tag_select");
			$("#ulArea").hide();
		});
	},
	// �۸�ؼ�
	InitPriceControl:function(){
		var _this = this;
		var content = Conditions.price;		
		var ddText = '',
			ddValue = '';
		$("#search_cond_select_div").append('<div class="selectqx"><div id="divPrice" class="select_box f"><div id="spnPriceTitle" price="" class="tag_select" style="cursor: pointer;" onmouseover="this.className=\'tag_select_open\'" onmouseout="this.className=\'tag_select\'">�۸�</div></div>');
        var container = $("#divPrice");
        var ul = $('<ul id="ulPrice" class="tag_options" style="position: absolute; z-index: 999;display:none;"></ul>');
        // console.log("�۸�ؼ� InitPriceControl->");
        // console.log(content);
		var contentLength = _this.count(content.text);
        for (var i = 0; i < contentLength; i++) {
        		ddText  = content.text[i];
				ddValue = content.value[i];
                ul.append('<li style="cursor: pointer;" class="open" onmouseover="this.className=\'open_hover\'" onmouseout="this.className=\'open\'"><a selecttype="price" price="'+ddValue+'" style="color:#0055BB;text-decoration:none">' + ddText + '</a></dt>');
        }
		//�����Ĵ�������
        ul.find("li").bind("click", function () {
            var price = $(this).find("a").attr("price");
            if(searchHouseInfo.price!=price){
    			searchInfo.price      = $(this).find("a").html();			
    			searchHouseInfo.price = price;
                $("#spnPriceTitle").html(searchInfo.price).attr("price",searchHouseInfo.price);
                _this.changeConditionTipsDiv();
    			// _this.showHouseData();
				_this.resetCondition();
				_this.showHouseData();
            }
        });
		//����Ч��
        container.append(ul).bind("click", function () {
            if ($("#ulPrice").css("display") == 'none') {$("#ulPrice").show();}else{$("#ulPrice").hide();}
        }).bind("mouseenter", function () {
            $("#spnPriceTitle").removeClass().addClass("tag_select_open");
            $("#ulPrice").show();
        }).bind("mouseleave", function () {
            $("#spnPriceTitle").removeClass().addClass("tag_select");
            $("#ulPrice").hide();
        });
	},
	// ���Ϳؼ�
	InitModelControl:function(){
		var _this = this;
		var content = Conditions.model;		
		var ddText = '',
			ddValue = '';
		$("#search_cond_select_div").append('<div class="selectqx"><div id="divModel" class="select_box f"><div id="spnModelTitle" model="" class="tag_select" style="cursor: pointer;" onmouseover="this.className=\'tag_select_open\'" onmouseout="this.className=\'tag_select\'">����</div></div>');
        var container = $("#divModel");
        var ul = $('<ul id="ulModel" class="tag_options" style="position: absolute; z-index: 999;display:none;"></ul>');
        // console.log('���Ϳؼ� InitModelControl->');
        // console.log(content);
		var contentLength = _this.count(content.text);
        for (var i = 0; i < contentLength; i++) {
        		ddText  = content.text[i];
				ddValue = content.value[i];
                ul.append('<li style="cursor: pointer;" class="open" onmouseover="this.className=\'open_hover\'" onmouseout="this.className=\'open\'"><a selecttype="model" data-value="'+ddValue+'" model="'+ddValue+'" style="color:#0055BB;text-decoration:none">' + ddText + '</a></dt>');
        }
		var $ul  = $("#ulModel");
		var $spn = $("#spnModelTitle");
		//�����Ĵ�������
        ul.find("li").bind("click", function () {
            var model = $(this).find("a").attr("data-value");
            if(searchHouseInfo.model!=model){
    			searchInfo.model      = $(this).find("a").html();			
    			searchHouseInfo.model = model;
                $spn.html(searchInfo.model).attr("data-value",searchHouseInfo.model);
                _this.changeConditionTipsDiv();
    			// _this.showHouseData();
				_this.resetCondition();
				_this.showHouseData();
            }
        });
		var $ul  = $("#ulModel");
		//����Ч��
        container.append(ul).bind("click", function () {
            if ( $ul.css("display") == 'none') {$ul.show();}else{$ul.hide();}
        }).bind("mouseenter", function () {
           $spn.removeClass().addClass("tag_select_open");
            $("#ulModel").show();
        }).bind("mouseleave", function () {
           $spn.removeClass().addClass("tag_select");
           $("#ulModel").hide();
        });
	},
	//ɸѡ������ʾ
	changeConditionTipsDiv:function(){
		var _this=this;
		var conditionDivShow = false;
		var html = "";
		$("#conditionDiv_tip").empty();
		//keyword
		if (searchHouseInfo.keyword != "") {
			$('#keyword').val(searchHouseInfo.keyword);
		} else {
			$('#keyword').val('');
		}
		//����
		if (searchHouseInfo.district != undefined && searchHouseInfo.district != "") {
			html = '<a class="xzjg" name="cleardistrict">' + searchInfo.district + '</a>';
			$("#conditionDiv_tip").append(html);
			conditionDivShow = true;
			$('a[name="cleardistrict"]').bind("click", function () {
				_this.map.getMap().centerAndZoom(new BMap.Point(mapInfo.lng, mapInfo.lat), mapInfo.initZoom);
				searchInfo.district      = "";
				searchHouseInfo.district = "";
				_this.changeConditionTipsDiv();
				_this.hideSingleDistrictMarker();//���ص�������
				_this.removeProjectMarkers();	 //ȥ��С����ʾ
				_this.getDistrictsPoint();		 //������ʾ
			   
			});
		} else {
			$("#spnDistrictTitle").html("����");
		}
/* 		//��Ȧ
		if (searchHouseInfo.shangquan != undefined && searchHouseInfo.shangquan != "") {
			html = '<a class="xzjg" name="clearshangquan">' + searchInfo.shangquan + '</a>';
			$("#conditionDiv_tip").append(html);
			conditionDivShow = true;
			$('a[name="clearshangquan"]').bind("click", function () {
				searchInfo.shangquan = "";
				searchHouseInfo.shangquan = "";
				changeConditionTipsDiv();
				getProjectPoint();
				showProjectData(0,10);
			});
		} else {
			$("#spnShangquanTitle").html("��Ȧ");
		} */
		//С��
		if (searchHouseInfo.projcode != undefined && searchHouseInfo.projcode != "") {
			html = '<a class="xzjg" name="clearprojcode">' + searchInfo.projcode + '</a>';
			$("#conditionDiv_tip").append(html);
			conditionDivShow = true;
			$('a[name="clearprojcode"]').bind("click", function () {
				_this.map.getMap().centerAndZoom(new BMap.Point(mapInfo.lng, mapInfo.lat), mapInfo.initZoom);
				searchInfo.projcode = "";
				searchHouseInfo.projcode = "";
				searchHouseInfo.keyword = "";
				_this.removeProjectMarkers();//ȥ��С����ʾ
				_this.changeConditionTipsDiv();
				_this.getDistrictsPoint();	//������ʾ
			});
		} else {
		   if(!searchHouseInfo.district && !districtAreaMarkers.length){
			   _this.hideSingleDistrictMarker();
		   }
		}
		//���
		if (searchHouseInfo.area != undefined && searchHouseInfo.area != "") {
			html = '<a class="xzjg" name="cleararea">' + searchInfo.area + '</a>';
			$("#conditionDiv_tip").append(html);
			conditionDivShow = true;
			$('a[name="cleararea"]').bind("click", function () {
				searchInfo.area = "";
				searchHouseInfo.area = "";
				_this.changeConditionTipsDiv();
				_this.showHouseData();
			});
		} else {
			$("#spnAreaTitle").html("���");
		}		
	},
	/**
	 * ���house��Ϣ�б�
	 *
	 * borough_id С��id
	 */
	showHouseData:function(){
		var _this=this;
		var bounds = _this.map.getMap().getBounds();
		var sw = bounds.getSouthWest();
		var ne = bounds.getNorthEast();
		var data = {};
		var bs = _this.map.getMap().getBounds();   //��ȡ��������
		var bssw = bs.getSouthWest();   //�����������½�
		var bsne = bs.getNorthEast();   //�����������Ͻ�
        data = {
			type: mapInfo.maptype,
			module_id: mapInfo.module_id,
			type_id: searchHouseInfo.type_id,
			cityarea_id : searchHouseInfo.district,
			cityarea2_id: searchHouseInfo.district2,
			area  : escape(searchHouseInfo.area),
			price : escape(searchHouseInfo.price),
			model : escape(searchHouseInfo.model),
			pageno: escape(searchHouseInfo.pageIndex),
			q: escape(searchHouseInfo.q),
			borough_id: searchHouseInfo.borough_id,
			zoom: _this.condition.zoom,
            // sw: _this.condition.sw,
            // ne: _this.condition.ne
            sw: bssw,
            ne: bsne
		}
		console.log(searchHouseInfo);
		console.log(data);
		var url = MapApiUrl + '?op=HouseData';
		$.ajax({
			type:'get',
			async:false,
			cache:false,
			url:url,
			data:data,
			dataType:'json',
			success: function(data){
				if (data.project  && data.project.projcode) {
					var html = "";
					var project = data.project;
					html += '<div class="map-cszinfo"><ul><li><a class="blue f14b" target="_blank" href="' +project.projurl+ '" id="aProjectName" title="' + project.projname + '">' + (project.projname.length>12 ? project.projname.substring(0, 12) + "..." : project.projname) + '</a><span id="spnPriceOut"><span class="pl40">���ۣ�</span><strong class="org02">' + project.price + '</strong>Ԫ/' + (mapInfo.maptype == 'chushou' ? "ƽ��" : "��") + '</span></li><li class="addr" title="' + project.address + '">' + (project.address.length > 25 ? (project.address.substring(0, 25) + "...") : project.address) + '</li><li id="p_housecount"><span class="fys">����<span class="red">' + data.allcount + '</span>�׷�Դ</span></li></ul></div><div class="clear"></div>';
					$("#div_ProjInfo").show().html(html);
				}else{
					$("#div_ProjInfo").hide();
				}
				// if (data.house && 0!=data.house.length) {
				if (data.house && 0!=_this.count(data.house)) {
					var list = data.house;
					var html = '';
					console.log(list);
					switch(mapInfo.maptype){
						case 'chushou':	//���ַ�	
							for (var i = 0; i < _this.count(list); i++) {
								// html += '<div class="list02"><a href="' + list[i].houseurl + '" target="_blank"><img src="' + list[i].houseimg + '" width="90" height="68" alt="'+list[i].title+'" class="floatl"/></a><ul><li class="fontwy"><a href="' + list[i].houseurl + '" target="_blank" title="' + list[i].title + '">' + list[i].shorttitle + '</a></li><li class="gray6" title="' + list[i].projname + '">' + list[i].projname + '<span class="xg">/</span>' + list[i].room + list[i].hall + '</li><li class="numli fontwy"><span class="numspan">'+ (list[i].buildarea==0 ? '' : '<strong class="fb16 gray3 fontwy">'+list[i].buildarea+'</strong>ƽ��' ) + '</span><span class="org02 pl15 fontwy">'+(list[i].price == 0 ? '' : '<strong class="fb16">' + list[i].price + '</strong>Ԫ/��' )+'</span></li></ul></div>';
								// html += '<div class="list02"><a href="'  + '" target="_blank"><img src="' + list[i].houseimg + '" width="90" height="68" alt="'+list[i].title+'" class="floatl"/></a><ul><li class="fontwy"><a href="' + list[i].houseurl + '" target="_blank" title="' + list[i].title + '">' + list[i].shorttitle + '</a></li><li class="gray6" title="' + list[i].projname + '">' + list[i].projname + '<span class="xg">/</span>' + list[i].room + list[i].hall + '</li><li class="numli fontwy"><span class="numspan">'+ (list[i].buildarea==0 ? '' : '<strong class="fb16 gray3 fontwy">'+list[i].buildarea+'</strong>ƽ��' ) + '</span><span class="org02 pl15 fontwy">'+(list[i].price == 0 ? '' : '<strong class="fb16">' + list[i].price + '</strong>Ԫ/��' )+'</span></li></ul></div>';
								
								html+='<li id="list_'+list[i].houseid+'" class="estate-mod clearfix">';
								html+='<a href='+list[i].houseurl+'>';
								html+='<div class="news-img">'+'<img src="'+list[i].houseimg+'" width="95" height="70" alt="">'+'</div>';
								html+='<div class="news-text">';
								html+='<div class="news-hd clearfix">'+'<h3 class="title" title="">'+list[i].title+'</h3>'+'</div>';
								html+='<div class="news-con clearfix">';
								html+='<div class="detail">';
								html+='<p class="house-type">'+list[i].room+list[i].hall+'&nbsp;'+list[i].buildarea+'ƽ����'+'</p>';
								html+='</div>';
								html+='<div class="mod2">';
								html+='<span class="brough_name gray">'+list[i].projname+'</em></span>';
								html+='<span class="aver-price"><em class="num">'+list[i].price+'</em>��Ԫ</span>';
								html+='</div>';
								html+='</div>';
								html+='</div>';
								html+='</a>';
								html+='</li>';
							}
							break;
						case 'chuzu':	//���ⷿ	
							for (var i = 0; i < _this.count(list); i++) {
								// html += '<div class="list02"><a href="' + list[i].houseurl + '" target="_blank"><img src="' + list[i].houseimg + '" width="90" height="68" alt="'+list[i].title+'" class="floatl"/></a><ul><li class="fontwy"><a href="' + list[i].houseurl + '" target="_blank" title="' + list[i].title + '">' + list[i].shorttitle + '</a></li><li class="gray6" title="' + list[i].projname + '">' + list[i].projname + '<span class="xg">/</span>' + list[i].room + list[i].hall + '</li><li class="numli fontwy"><span class="numspan">'+ (list[i].buildarea==0 ? '' : '<strong class="fb16 gray3 fontwy">'+list[i].buildarea+'</strong>ƽ��' ) + '</span><span class="org02 pl15 fontwy">'+(list[i].price == 0 ? '' : '<strong class="fb16">' + list[i].price + '</strong>Ԫ/��' )+'</span></li></ul></div>';
								// html += '<div class="list02"><a href="'  + '" target="_blank"><img src="' + list[i].houseimg + '" width="90" height="68" alt="'+list[i].title+'" class="floatl"/></a><ul><li class="fontwy"><a href="' + list[i].houseurl + '" target="_blank" title="' + list[i].title + '">' + list[i].shorttitle + '</a></li><li class="gray6" title="' + list[i].projname + '">' + list[i].projname + '<span class="xg">/</span>' + list[i].room + list[i].hall + '</li><li class="numli fontwy"><span class="numspan">'+ (list[i].buildarea==0 ? '' : '<strong class="fb16 gray3 fontwy">'+list[i].buildarea+'</strong>ƽ��' ) + '</span><span class="org02 pl15 fontwy">'+(list[i].price == 0 ? '' : '<strong class="fb16">' + list[i].price + '</strong>Ԫ/��' )+'</span></li></ul></div>';
								
								html+='<li id="list_'+list[i].houseid+'" class="estate-mod clearfix">';
								html+='<a href='+list[i].houseurl+'>';
								html+='<div class="news-img">'+'<img src="'+list[i].houseimg+'" width="95" height="70" alt="">'+'</div>';
								html+='<div class="news-text">';
								html+='<div class="news-hd clearfix">'+'<h3 class="title" title="">'+list[i].title+'</h3>'+'</div>';
								html+='<div class="news-con clearfix">';
								html+='<div class="detail">';
								html+='<p class="house-type">'+list[i].room+list[i].hall+'&nbsp;'+list[i].buildarea+'ƽ����'+'</p>';
								html+='</div>';
								html+='<div class="mod2">';
								html+='<span class="brough_name gray">'+list[i].projname+'</em></span>';
								html+='<span class="aver-price"><em class="num">'+list[i].price+'</em>Ԫ/��</span>';
								html+='</div>';
								html+='</div>';
								html+='</div>';
								html+='</a>';
								html+='</li>';
							}
							break;
						case 'newhouse':	//����
							for (var i = 0; i < _this.count(list); i++) {
								html+='<li id="list_'+list[i].houseid+'" class="estate-mod clearfix">';
								html+='<a href='+list[i].houseurl+'>';
								html+='<div class="news-img">'+'<img src="'+list[i].houseimg+'" width="95" height="70" alt="">'+'</div>';
								html+='<div class="news-text">';
								html+='<div class="news-hd clearfix">'+'<h3 class="title" title="">'+list[i].title+'</h3>'+'</div>';
								html+='<div class="news-con clearfix">';
								html+='<div class="detail">';
								html+='<p class="house-type">'+list[i].phone+''+'</p>';
								html+='</div>';
								html+='<div class="mod2">';
								html+='<span class="brough_name gray">'+list[i].projname+'</em></span>';
								html+='<span class="aver-price"><em class="num">'+list[i].price+'</em>'+list[i].price_unit+'</span>';
								html+='</div>';
								html+='</div>';
								html+='</div>';
								html+='</a>';
								html+='</li>';	
							}						
							break;
					}
					$("#divProjectHouse").html(html); 
					// console.log(html);
				}else {
					_this.changeConditionTipsDiv();
					var noresultdiv = '<div class="mt10 "><ul class="nohouselist"><li><strong>��Ǹ��δ�ҵ���ط�Դ</strong></li><li>��������</li><li>������׼ȷ��С��������Ȧ</li><li>������ȥ��ĳЩ������������</li></ul></div>'
					$("#divProjectHouse").html(noresultdiv);
					$("#fanye_P").hide();
				}
				if (data.allcount) {
					$("#spnHouseCount").html(data.allcount);
					$("#bottomcountDiv").show();
					$("#p_housecount").show();
				} else {
					$("#spnHouseCount").html("0");
					$("#bottomcountDiv").hide();
					$("#p_housecount").hide();
				}
				_this.loadPageBar();
			}
			// changeConditionTipsDiv();
			// changeListShow();
		})
/* 		$.getJSON(url, function (data) {
			if (data.project  && data.project.projcode) {
				var html = "";
				var project = data.project;
				html += '<div class="map-cszinfo"><ul><li><a class="blue f14b" target="_blank" href="' +project.projurl+ '" id="aProjectName" title="' + project.projname + '">' + (project.projname.length>12 ? project.projname.substring(0, 12) + "..." : project.projname) + '</a><span id="spnPriceOut"><span class="pl40">���ۣ�</span><strong class="org02">' + project.price + '</strong>Ԫ/' + (mapInfo.maptype == 'chushou' ? "ƽ��" : "��") + '</span></li><li class="addr" title="' + project.address + '">' + (project.address.length > 25 ? (project.address.substring(0, 25) + "...") : project.address) + '</li><li id="p_housecount"><span class="fys">����<span class="red">' + data.allcount + '</span>�׷�Դ</span></li></ul></div><div class="clear"></div>';
				$("#div_ProjInfo").show().html(html);
			}else{
				$("#div_ProjInfo").hide();
			}
			// if (data.house && 0!=data.house.length) {
			if (data.house && 0!=_this.count(data.house)) {
				var list = data.house;
				var html = '';
				console.log(list);
				switch(mapInfo.maptype){
					case 'chushou':	//���ַ�	
						for (var i = 0; i < _this.count(list); i++) {
							// html += '<div class="list02"><a href="' + list[i].houseurl + '" target="_blank"><img src="' + list[i].houseimg + '" width="90" height="68" alt="'+list[i].title+'" class="floatl"/></a><ul><li class="fontwy"><a href="' + list[i].houseurl + '" target="_blank" title="' + list[i].title + '">' + list[i].shorttitle + '</a></li><li class="gray6" title="' + list[i].projname + '">' + list[i].projname + '<span class="xg">/</span>' + list[i].room + list[i].hall + '</li><li class="numli fontwy"><span class="numspan">'+ (list[i].buildarea==0 ? '' : '<strong class="fb16 gray3 fontwy">'+list[i].buildarea+'</strong>ƽ��' ) + '</span><span class="org02 pl15 fontwy">'+(list[i].price == 0 ? '' : '<strong class="fb16">' + list[i].price + '</strong>Ԫ/��' )+'</span></li></ul></div>';
							// html += '<div class="list02"><a href="'  + '" target="_blank"><img src="' + list[i].houseimg + '" width="90" height="68" alt="'+list[i].title+'" class="floatl"/></a><ul><li class="fontwy"><a href="' + list[i].houseurl + '" target="_blank" title="' + list[i].title + '">' + list[i].shorttitle + '</a></li><li class="gray6" title="' + list[i].projname + '">' + list[i].projname + '<span class="xg">/</span>' + list[i].room + list[i].hall + '</li><li class="numli fontwy"><span class="numspan">'+ (list[i].buildarea==0 ? '' : '<strong class="fb16 gray3 fontwy">'+list[i].buildarea+'</strong>ƽ��' ) + '</span><span class="org02 pl15 fontwy">'+(list[i].price == 0 ? '' : '<strong class="fb16">' + list[i].price + '</strong>Ԫ/��' )+'</span></li></ul></div>';
							
							html+='<li id="list_'+list[i].houseid+'" class="estate-mod clearfix">';
							html+='<a href='+list[i].houseurl+'>';
							html+='<div class="news-img">'+'<img src="'+list[i].houseimg+'" width="95" height="70" alt="">'+'</div>';
							html+='<div class="news-text">';
							html+='<div class="news-hd clearfix">'+'<h3 class="title" title="">'+list[i].title+'</h3>'+'</div>';
							html+='<div class="news-con clearfix">';
							html+='<div class="detail">';
							html+='<p class="house-type">'+list[i].room+list[i].hall+'&nbsp;'+list[i].buildarea+'ƽ����'+'</p>';
							html+='</div>';
							html+='<div class="mod2">';
							html+='<span class="brough_name gray">'+list[i].projname+'</em></span>';
							html+='<span class="aver-price"><em class="num">'+list[i].price+'</em>��Ԫ</span>';
							html+='</div>';
							html+='</div>';
							html+='</div>';
							html+='</a>';
							html+='</li>';
						}
						break;
					case 'chuzu':	//���ⷿ	
						for (var i = 0; i < _this.count(list); i++) {
							// html += '<div class="list02"><a href="' + list[i].houseurl + '" target="_blank"><img src="' + list[i].houseimg + '" width="90" height="68" alt="'+list[i].title+'" class="floatl"/></a><ul><li class="fontwy"><a href="' + list[i].houseurl + '" target="_blank" title="' + list[i].title + '">' + list[i].shorttitle + '</a></li><li class="gray6" title="' + list[i].projname + '">' + list[i].projname + '<span class="xg">/</span>' + list[i].room + list[i].hall + '</li><li class="numli fontwy"><span class="numspan">'+ (list[i].buildarea==0 ? '' : '<strong class="fb16 gray3 fontwy">'+list[i].buildarea+'</strong>ƽ��' ) + '</span><span class="org02 pl15 fontwy">'+(list[i].price == 0 ? '' : '<strong class="fb16">' + list[i].price + '</strong>Ԫ/��' )+'</span></li></ul></div>';
							// html += '<div class="list02"><a href="'  + '" target="_blank"><img src="' + list[i].houseimg + '" width="90" height="68" alt="'+list[i].title+'" class="floatl"/></a><ul><li class="fontwy"><a href="' + list[i].houseurl + '" target="_blank" title="' + list[i].title + '">' + list[i].shorttitle + '</a></li><li class="gray6" title="' + list[i].projname + '">' + list[i].projname + '<span class="xg">/</span>' + list[i].room + list[i].hall + '</li><li class="numli fontwy"><span class="numspan">'+ (list[i].buildarea==0 ? '' : '<strong class="fb16 gray3 fontwy">'+list[i].buildarea+'</strong>ƽ��' ) + '</span><span class="org02 pl15 fontwy">'+(list[i].price == 0 ? '' : '<strong class="fb16">' + list[i].price + '</strong>Ԫ/��' )+'</span></li></ul></div>';
							
							html+='<li id="list_'+list[i].houseid+'" class="estate-mod clearfix">';
							html+='<a href='+list[i].houseurl+'>';
							html+='<div class="news-img">'+'<img src="'+list[i].houseimg+'" width="95" height="70" alt="">'+'</div>';
							html+='<div class="news-text">';
							html+='<div class="news-hd clearfix">'+'<h3 class="title" title="">'+list[i].title+'</h3>'+'</div>';
							html+='<div class="news-con clearfix">';
							html+='<div class="detail">';
							html+='<p class="house-type">'+list[i].room+list[i].hall+'&nbsp;'+list[i].buildarea+'ƽ����'+'</p>';
							html+='</div>';
							html+='<div class="mod2">';
							html+='<span class="brough_name gray">'+list[i].projname+'</em></span>';
							html+='<span class="aver-price"><em class="num">'+list[i].price+'</em>Ԫ/��</span>';
							html+='</div>';
							html+='</div>';
							html+='</div>';
							html+='</a>';
							html+='</li>';
						}
						break;
					case 'newhouse':	//����
						for (var i = 0; i < _this.count(list); i++) {
							html+='<li id="list_'+list[i].houseid+'" class="estate-mod clearfix">';
							html+='<a href='+list[i].houseurl+'>';
							html+='<div class="news-img">'+'<img src="'+list[i].houseimg+'" width="95" height="70" alt="">'+'</div>';
							html+='<div class="news-text">';
							html+='<div class="news-hd clearfix">'+'<h3 class="title" title="">'+list[i].title+'</h3>'+'</div>';
							html+='<div class="news-con clearfix">';
							html+='<div class="detail">';
							html+='<p class="house-type">'+list[i].phone+''+'</p>';
							html+='</div>';
							html+='<div class="mod2">';
							html+='<span class="brough_name gray">'+list[i].projname+'</em></span>';
							html+='<span class="aver-price"><em class="num">'+list[i].price+'</em>Ԫ/ƽ</span>';
							html+='</div>';
							html+='</div>';
							html+='</div>';
							html+='</a>';
							html+='</li>';	
						}						
						break;
				}
				$("#divProjectHouse").html(html); 
				// console.log(html);
			}else {
				_this.changeConditionTipsDiv();
				var noresultdiv = '<div class="mt10 "><ul class="nohouselist"><li><strong>��Ǹ��δ�ҵ���ط�Դ</strong></li><li>��������</li><li>������׼ȷ��С��������Ȧ</li><li>������ȥ��ĳЩ������������</li></ul></div>'
				$("#divProjectHouse").html(noresultdiv);
				$("#fanye_P").hide();
			}
			if (data.allcount) {
				$("#spnHouseCount").html(data.allcount);
				$("#bottomcountDiv").show();
				$("#p_housecount").show();
			} else {
				$("#spnHouseCount").html("0");
				$("#bottomcountDiv").hide();
				$("#p_housecount").hide();
			}
			_this.loadPageBar();
		});
		 */
		// changeConditionTipsDiv();
		// changeListShow();
	},
	//��Դ�б��ҳ
	loadPageBar:function(){
		var _this=this;
		$("#fanye_P").empty();
		var projcode = searchHouseInfo.projcode;
		var pIndex = searchHouseInfo.pageIndex;
		// var pageSize = 5;
		var pageSize = 30;
		var html = '';
		var pIntCount = parseInt($("#spnHouseCount").text());
		// alert(pIntCount);
		var pageCount = (pIntCount > 0 && pIntCount >= pageSize) ? parseInt(Math.ceil(pIntCount / pageSize)) : 1;
		if (pageCount > 1) {
			if (pIndex == 1) {
				html = '&lt;&nbsp;��һҳ&nbsp;1&nbsp;<a href="#" aPage="2">2</a> <a href="#" aPage="3">3</a> <a href="#" aPage="4">4</a> <a href="#" aPage="5">5</a> <a href="#" id="aHousePageNext">��һҳ &gt;</a>';
			}
			else if (pIndex == 2 && pIndex == pageCount) {
				html = '<a href="#" id="aHousePagePre">&lt; ��һҳ</a> <a href="#" aPage="1">1</a> <a href="#" aPage="2">2</a>&nbsp;��һҳ&nbsp;&gt;';
			}
			else if (pIndex == 2) {
				html = '<a href="#" id="aHousePagePre">&lt; ��һҳ</a> <a href="#" aPage="1">1</a>&nbsp;2&nbsp;<a href="#" aPage="3">3</a> <a href="#" aPage="4">4</a> <a href="#" aPage="5">5</a> <a href="#" id="aHousePageNext">��һҳ &gt;</a>';
			}
			else if (pIndex == 3 && pIndex == pageCount) {
				html = '<a href="#" id="aHousePagePre">&lt; ��һҳ</a> <a href="#" aPage="1">1</a> <a href="#" aPage="2">2</a>&nbsp;3&nbsp;��һҳ&nbsp;&gt;';
			}
			else if (pIndex == 4 && pIndex == pageCount) {
				html = '<a href="#" id="aHousePagePre">&lt; ��һҳ</a> <a href="#" aPage="1">1</a> <a href="#" aPage="2">2</a> <a href="#" aPage="3">3</a>&nbsp;4&nbsp;��һҳ&nbsp;&gt;';
			}
			else if (pIndex == pageCount) {
				html = '<a href="#" id="aHousePagePre">&lt; ��һҳ</a> <a href="#" aPage="' + (pageCount - 4) + '">' + (pageCount - 4) + '</a> <a href="#" aPage="' + (pageCount - 3) + '">' + (pageCount - 3) + '</a> <a href="#" aPage="' + (pageCount - 2) + '">' + (pageCount - 2) + '</a> <a href="#" aPage="' + (pageCount - 1) + '">' + (pageCount - 1) + '</a>&nbsp;' + pageCount + '&nbsp;��һҳ&nbsp;&gt;';
			} else {
				html = '<a href="#" id="aHousePagePre">&lt; ��һҳ</a> <a href="#" aPage="' + (pIndex - 2) + '">' + (pIndex - 2) + '</a> <a href="#" aPage="' + (pIndex - 1) + '">' + (pIndex - 1) + '</a> ' + pIndex + ' <a href="#" aPage="' + (parseInt(pIndex) + 1) + '">' + (parseInt(pIndex) + 1) + '</a> <a href="#" aPage="' + (pIndex + 2) + '">' + (parseInt(pIndex) + 2) + '</a> <a href="#" id="aHousePageNext">��һҳ &gt;</a>';
			}
			$("#fanye_P").append(html).find("a").css({ "cursor": "pointer" });
			$("#aHousePageNext").bind("click", function () {
				searchHouseInfo.pageIndex = parseInt(searchHouseInfo.pageIndex) + 1;
				_this.showHouseData();
				$("#resultcontainer").scrollTop(0);
			});
			$("#aHousePagePre").bind("click", function () {
				searchHouseInfo.pageIndex = parseInt(searchHouseInfo.pageIndex) - 1;
				_this.showHouseData();
				$("#resultcontainer").scrollTop(0);
			});
			$("#fanye_P").find("a[aPage]").bind("click", function () {
				searchHouseInfo.pageIndex = $(this).text();
				_this.showHouseData();
				$("#resultcontainer").scrollTop(0);
			}).each(function () {
				if ($(this).text() > pageCount) {
					$(this).hide();
				}
			});
			$("#fanye_P").show();
		} else {
			html = '&nbsp;';
			$("#fanye_P").hide();
		}
		_this.changescreenWandH();
	},
	/**
     * ��������
     * ������ɺ�,�ƶ���������,���ŵ�һ������,����������¼� div map_pop_location
     * @returns {undefined}
     */
	getDistrictsPoint:function(){
		var _this=this;
		console.log('��������');
        var url = MapApiUrl + '?op=DistrictPoint&type='+mapInfo.maptype+'&module_id='+escape(mapInfo.module_id)+'&type_id='+escape(searchHouseInfo.type_id);
		data = {
            // t: house_type,
            // dataType: 'area',
            // s_p:s_price,
            // s_a:s_area,
            // s_r:s_room,
            // s_t:s_tag,
            zoom: _this.map.getMap().getZoom()
        };
		$.ajax({
			url: url,
            type: 'GET',
            data: data,
            dataType: 'json',
			beforeSend:function(XMLHttpRequest){
                _this.addMapLoading(); //��ͼ������
            },
			success: function(data) {
				if(data && 0<data.length){
					for(var i=0;i<data.length;i++){
						(function (x) {//�ؼ�
							var propCount = (data[i].propCount!=null) ? data[i].propCount : 0;
							// var html='<div class="qp01" district="'+project[i].index+'" districtname="'+project[i].name+'"><a class="noatag"><div class="s1"><em>'+ project[i].name +'<span>|'+project[i].count+'��</span></em></div></a></div>'; 
							// <div class="bubble-2 bubble-5 bubble" data-longitude="116.42447152994" data-latitude="39.918645498892" data-id="23008614"><p class="name" title="����">����</p><p class="num">5.4��</p><p><span class="count">3850</span>��</p></div>
							if(mapInfo.maptype=='newhouse'){
								var html = '<div class="bubble-2 bubble bubble-5" data-longitude="'+data[i].lng+'" data-latitude="'+data[i].lat+'" data-id="'+data[i].id+'" data-name="'+data[i].areaName+'">'+'<p class="name" title="'+data[i].areaName+'">'+data[i].areaName+'</p><p class="count">'+propCount+'��</p>';+'</div>';
							}else{
								var html = '<div class="bubble-2 bubble bubble-5" data-longitude="'+data[i].lng+'" data-latitude="'+data[i].lat+'" data-id="'+data[i].id+'" data-name="'+data[i].areaName+'">'+'<p class="name" title="'+data[i].areaName+'">'+data[i].areaName+'</p><p class="count">'+propCount+'��</p>';+'</div>';
							}
							var point = new BMap.Point(data[i].lng, data[i].lat);
							// var mySquare = new ComplexCustomOverlay(point,html,html);
							var mySquare = new SquareOverlay(point, 100,html,1,"","",data[i].lng,data[i].lat,data[i].areaName,"","");
							var fn = function(){
								var districtname=$(this).find("div").first().attr("data-name");
								var district    =$(this).find("div").first().attr("data-id");
								$("#spnDistrictTitle").html(districtname).attr("district",district);
								searchHouseInfo.district  = district;
								searchInfo.district 	  = districtname;
								searchHouseInfo.district2 = 0;
								searchInfo.district2 	  = '';
								searchHouseInfo.keyword   = '';
								searchInfo.keyword 		  = '';
								searchHouseInfo.borough_id= '';
								searchInfo.borough_id 	  = '';
								searchHouseInfo.pageIndex = 1;
								searchHouseInfo.projpageindex = 1;
								
								_this.changeConditionTipsDiv();//ɸѡ������ʾ
								_this.removeDistrictMarkers(); //�Ƴ�������ʾ
								_this.getDistrictAreaInfo(_this.zoom.district);   //����������ʾ setZoom(14);
								_this.getPlatePoint();
								// _this.getHousePoint();
							}
							_this.map.getMap().addOverlay(mySquare);
							mySquare.addEventListener('click',fn);
							districtMarkers.push(mySquare);
						})(i);
					}//end for
					_this.showHouseData();//��ʼ��չʾ���House��Ϣ�б�
					// _this.resetCondition();
					// _this.loadPyData();
				}	
			},
            complete:function(XMLHttpRequest) {
                _this.removeMapLoading(); //�Ƴ���ͼ������
            },
            error: function() {
                //alert('����δ�ҵ���Դ��������ѡ��');
            }
		});
	},
	/**
     * ���ذ��
     * ������ɺ�,�ƶ���������,���marker �� ���ŵ�һ������,����������¼� div map_pop_sublocation
     * @returns {undefined}
     */
	getPlatePoint:function(){
		var _this  = this;
		var bounds = _this.map.getMap().getBounds();
		var sw = bounds.getSouthWest();
		var ne = bounds.getNorthEast();
		// removeProjectMarkers();
		data = {
            // t: house_type,
            // dataType: 'district',
            // s_p:s_price,
            // s_a:s_area,
            // s_r:s_room,
            // s_t:s_tag,
            cityarea_id: searchHouseInfo.district,
            sw: sw,
            ne: ne,
            zoom: _this.map.getMap().getZoom()
        };
		var url = MapApiUrl + '?op=PlatePointData&type='+mapInfo.maptype+'&cityarea_id='+escape(searchHouseInfo.district)+'&cityarea2_id='+escape(searchHouseInfo.district2);
		$.ajax({
			url:url,
			type: 'GET',
            data: data,
            dataType: 'json',
            beforeSend:function(XMLHttpRequest){
                _this.addMapLoading(); //��ͼ������
            },
			success: function(data){
				if(data.project){
					var project=data.project;
					var length = _this.count(project);
					for(var i=0;i<length;i++){
						var leftClass="maskleft",
							rightClass="maskright",
							leftHover="left_hover",
							rightHover="right_hover";                
							var projcode=project[i].projcode,
								projname=project[i].projname,
								housecount=project[i].housecount,
								purpose=project[i].purpose,
								address=project[i].address,
								addresslong=project[i].addresslong,
								px=project[i].px,
								py=project[i].py; 
							var html='';
							var unit = '��';
							// html='<div class="qp01" projcode="'+projcode+'" projname="'+projname+'"><a class="noatag"><div class="s1"><em>'+ projname +'<span style="display:none;">|'+housecount+'��</span></em></div></a></div>'; 
							// <div class="bubble-2 bubble" data-longitude="116.38849875096" data-latitude="39.97536113474" data-id="611100601"><p class="name" title="���">���</p><p class="num">6.2��</p><p class="count">552��</p></div>
							if(mapInfo.maptype=='newhouse'){
								var unit = '��';
							}
							html = '<div class="bubble-2 bubble" data-longitude="'+px+'" data-latitude="'+py+'" data-id="'+projcode+'">'+'<p class="name" title="'+projname+'">'+projname+'</p><p class="count">'+housecount+unit+'</p>'+'</div>';
							var point = new BMap.Point(px,py);
							var mySquare = new SquareOverlay(point,100,html,1,purpose,projcode,px,py,projname,address,addresslong);
							_this.map.getMap().addOverlay(mySquare);
							// console.log(_this.map.getMap().getZoom());
							var overrideMouseOut=function (){
								 $(this).find("div").first().removeClass().addClass("qp01");
								 $(this).find("span").first().css('display','none');
								 this.style.zIndex =-1;
							};
							var overrideMouseOver=function (){
								 $(this).find("div").first().removeClass().addClass("qp02");
								 $(this).find("span").first().css('display','inline');
								 this.style.zIndex =100;
							};
							var overrideClick = function(){
								var districtname=$(this).find("div").first().attr("data-name");
								var district    =$(this).find("div").first().attr("data-id");
								searchHouseInfo.district2 = district;
								searchInfo.district2 	  = districtname;
								_this.changeConditionTipsDiv();//ɸѡ������ʾ
								_this.removeDistrictMarkers(); //�Ƴ�������ʾ
								_this.getDistrictAreaInfo(_this.zoom.community);   //����������ʾ
								_this.map._map.clearOverlays();
								_this.getHousePoint();
							}
							$('#div_ProjInfo').mouseover(function(){
								$("#"+searchHouseInfo.projcode+"_container").css('z-index','100').find("div").first().removeClass().addClass("qp02");
							}).mouseout(function(){
								$("#"+searchHouseInfo.projcode+"_container").css('z-index','-1').find("div").first().removeClass().addClass("qp01");
							});
							// mySquare.addEventListener("mouseover", overrideMouseOver);
							// mySquare.addEventListener("mouseout", overrideMouseOut);
							mySquare.addEventListener("click", overrideClick);
							projectMarkers.push(mySquare);
					}		
					_this.showHouseData();//��ʼ��չʾ���House��Ϣ�б�
					// setMoreProjStatus(data.allcount);//����100��С��
					
					// _this.resetCondition();
					// _this.loadPyData();
				}
			},
            complete:function(XMLHttpRequest) {
                _this.removeMapLoading(); //�Ƴ���ͼ������
            },
            error: function() {
                //alert('����δ�ҵ���Դ��������ѡ��');
            }
		});
	},
	/**
     * ����С��
     * ������ɺ�,�ƶ���������,���marker �� ���ŵ�һ������,����������¼� div map_pop_sublocation
     * @returns {undefined}
     */
	getHousePoint:function(){
		console.log('����С��');
		var _this  = this;
		var bounds = _this.map.getMap().getBounds();
		var sw = bounds.getSouthWest();
		var ne = bounds.getNorthEast();
		data = {
            type: mapInfo.maptype,
            cityarea_id: escape(searchHouseInfo.district),
            cityarea2_id: escape(searchHouseInfo.district2),
            sw: sw,
            ne: ne,
            zoom: _this.map.getMap().getZoom()
        };
		var url = MapApiUrl + '?op=CommunityPointData';
		// $.getJSON(url,function(data){
		$.ajax({
			url:url,
			type: 'GET',
            data: data,
            dataType: 'json',
            beforeSend:function(XMLHttpRequest){
                _this.addMapLoading(); //��ͼ������
            },
			success: function(data){
				if(data.project){
					var project=data.project;
					var length = _this.count(project);
					for(var i=0;i<length;i++){
						(function (x) {//�ؼ�
							var leftClass="maskleft",
								rightClass="maskright",
								leftHover="left_hover",
								rightHover="right_hover";                
							var projcode=project[i].projcode,
								projname=project[i].projname,
								housecount=project[x].housecount,
								purpose=project[i].purpose,address=project[i].address,
								addresslong=project[i].addresslong,
								px=project[i].px,
								py=project[i].py; 
							var html='';			
							// html='<div class="qp01" projcode="'+projcode+'" projname="'+projname+'"><a class="noatag"><div class="s1"><em>'+ projname +'<span style="display:none;">|'+housecount+'��</span></em></div></a></div>'; 
							// html='<div class="bubble-3 bubble" data-longitude="116.330345" projcode="'+projcode+'" projname="'+projname+'" data-latitude="39.984336" data-id="'+projcode+'" data-msg="" data-station="43142370" data-schoolid="4000001020"><div class="bu1"><i class="num">&nbsp;'+projname+'&nbsp;</i><i class="name-des" style="display:none;">'+housecount+'��</i></div><i class="arrow-up"><i class="arrow"></i></i></div>';
							// console.log("mapInfo->");
							// console.log(mapInfo);
							if(mapInfo.maptype=='newhouse'){
								html ='<div class="bubble-3 bubble" data-longitude="'+project[i].px+'" data-latitude="'+project[i].py+'" projcode="'+project[i].projcode+'" projname="'+projname+'"  data-id="'+projcode+'" data-msg="" data-station="43142370" data-schoolid="4000001020">';
								html+='<div class="bu1"><i class="num">&nbsp;'+projname+'</i><i class="name-des" style="display:;">'+project[i].price+project[i].price_unit+'</i></div><i class="arrow-up"><i class="arrow"></i></i>';
								html+='</div>';
							}else{
								html ='<div class="bubble-3 bubble" data-longitude="'+project[i].px+'" data-latitude="'+project[i].py+'" projcode="'+project[i].projcode+'" projname="'+projname+'"  data-id="'+projcode+'" data-msg="" data-station="43142370" data-schoolid="4000001020">';
								html+='<div class="bu1"><i class="num">&nbsp;'+housecount+'��&nbsp;</i><i class="name-des" style="display:none;">'+projname+'</i></div><i class="arrow-up"><i class="arrow"></i></i>';
								html+='</div>';
							}
							// console.log(housecount+'->'+projname);
							var point = new BMap.Point(px,py);
							var mySquare = new SquareOverlay(point,100,html,1,purpose,projcode,px,py,projname,address,addresslong);
							_this.map.getMap().addOverlay(mySquare);

						
							if(mapInfo.maptype=='newhouse'){
								var overrideMouseOut=function (){
									this.style.zIndex =-1;
								};
								var overrideMouseOver=function (){
									this.style.zIndex =100;
								};
								var overrideClick = function(){
									
								}
							}else{
								var overrideMouseOut=function (){
									// alert($(this).find("div").first().hasClass('clicked'));
									// if($(this).find("div").first().hasClass('clicked')!=true){
										$(this).find(".name-des").first().css('display','none');
										this.style.zIndex =-1;
									// }
									// $(".bubble-3").find(".name-des").first().css('display','none');
									// $(".bubble-3").style.zIndex =-1;
								};
								var overrideMouseOver=function (){
									 $(this).find(".name-des").first().css('display','inline-block');
									 this.style.zIndex =100;
								};
								var overrideClick = function(){
									$(".bubble-3").removeClass("label-clicked");
									$(".bubble-3").removeClass("clicked");
									// $(".bubble-3").find(".name-des").first().css('display','none');
									
									$(this).find("div").first().addClass("label-clicked");
									$(this).find("div").first().addClass("clicked");
									$(this).find(".name-des").first().css('display','inline-block');
									
									searchInfo.borough_id     = $(this).find("div").first().attr('projcode');
									searchHouseInfo.borough_id= $(this).find("div").first().attr('projcode');
									searchHouseInfo.district = '';
									searchInfo.district 	 = '';
									searchHouseInfo.district2= '';
									searchInfo.district2 	 = '';
									// _this.hideSingleDistrictMarker();
									_this.changeConditionTipsDiv();
									searchHouseInfo.pageIndex = 1;
									_this.showHouseData();
								}
							}
							var overrideClick = function(){
								$(".bubble-3").removeClass("label-clicked");
								$(".bubble-3").removeClass("clicked");
								// $(".bubble-3").find(".name-des").first().css('display','none');
								
								$(this).find("div").first().addClass("label-clicked");
								$(this).find("div").first().addClass("clicked");
								$(this).find(".name-des").first().css('display','inline-block');
								
								searchInfo.borough_id     = $(this).find("div").first().attr('projcode');
								searchHouseInfo.borough_id= $(this).find("div").first().attr('projcode');
								searchHouseInfo.district = '';
								searchInfo.district 	 = '';
								searchHouseInfo.district2= '';
								searchInfo.district2 	 = '';
								// _this.hideSingleDistrictMarker();
								_this.changeConditionTipsDiv();
								searchHouseInfo.pageIndex = 1;
								_this.showHouseData();
							}
							$('#div_ProjInfo').mouseover(function(){
								$("#"+searchHouseInfo.projcode+"_container").css('z-index','100').find("div").first().removeClass().addClass("qp02");
							}).mouseout(function(){
								$("#"+searchHouseInfo.projcode+"_container").css('z-index','-1').find("div").first().removeClass().addClass("qp01");
							});
							mySquare.addEventListener("mouseover", overrideMouseOver);
							mySquare.addEventListener("mouseout", overrideMouseOut);
							mySquare.addEventListener("click", overrideClick);
							projectMarkers.push(mySquare);
						})(i);
					}//end for
					_this.showHouseData();//��ʼ��չʾ���House��Ϣ�б�
					// setMoreProjStatus(data.allcount);//����100��С��
				
					// _this.resetCondition();
					// _this.loadPyData();
				}else{
					_this.showHouseData();
				}
			},
			complete:function(XMLHttpRequest) {
                _this.removeMapLoading(); //�Ƴ���ͼ������
            },
            error: function() {
                //alert('����δ�ҵ���Դ��������ѡ��');
            }
		});
	
	},
	// �Ƴ�ȫ��������ʾ
	removeDistrictMarkers:function(){
		var _this=this;
		for(var i=0;i<_this.count(districtMarkers);i++){_this.map.getMap().removeOverlay(districtMarkers[i]);}
		districtMarkers=[];
	},
	/**
	 * ����������ʾ	����������ѡ�к�,��ȡ�������ʶMarke
	 */
	getDistrictAreaInfo:function(zoom){
		var _this=this;
		var isrun = false;
		var	url   = MapApiUrl+'?op=CityPoint&type='+mapInfo.maptype;
		//�Ƴ�����Marker
		_this.hideDistrictAreaMarker();
		if(searchHouseInfo.district2){
			url +=  '&cityarea_id='+escape(searchHouseInfo.district)+'&cityarea2_id='+escape(searchHouseInfo.district2);
			isrun = true;
		// }else if(searchHouseInfo.district2){
		}else{
			url +=  '&cityarea_id='+escape(searchHouseInfo.district);
			isrun = true;
		}
		if(isrun==true){
			$.ajax({
				type:'get',
				async:false,
				cache:false,
				url:url,
				dataType:'json',
				beforeSend:function(XMLHttpRequest){
					_this.addMapLoading(); //��ͼ������
				},
				success: function(data){
					if(data.point){
						districtAreaInfo = data.point;
						console.log(districtAreaInfo);
						// _this.showSingleDistrictMarker();
						if(_this.count(districtAreaInfo)>0){
							var html = '<div class="mapFinddingCanvasLabelStyle11"><table cellpadding=0 cellspacing=0 border=0><tr><td class="s1" >&nbsp;</td><td class="s2" ><img src="'+ImagesUrl+'/map/icon004.gif" alt="" />'+districtAreaInfo.name+'</td><td class="s3">&nbsp;&nbsp;</td><td class="s4"></td></tr><tr><td colspan="3" class="s5"></td></tr></table></div>';
							// var center=new BMap.Point(districtAreaInfo[0].px,districtAreaInfo[0].py);
							// singleDistrictMarker(center,html);
							
							var point = new BMap.Point(districtAreaInfo.lng,districtAreaInfo.lat);

							_this.map._map.setZoom(zoom);
							// ����ͼ�����ĵ����Ϊ�����ĵ㡣
							_this.map._map.panTo(new BMap.Point(districtAreaInfo.lng,districtAreaInfo.lat));
							// _this.map._map.panTo(point);
							// _this.map._map.centerAndZoom(point,14);
							// _this.map.setCenter.panTo(districtAreaInfo[0].lng,districtAreaInfo[0].lat,14);
							// ���ĵ�ƫ�ƶ������أ�width,height��Ϊ��ͼdiv��ߵ�1/2;�������������
							// _this.map._map.panBy(320, 225);
							
							// var mySquare = new ComplexCustomOverlay(point,html,html);
							var mySquare = new SquareOverlay(point, 100,html,1,"","",districtAreaInfo.lng,districtAreaInfo.lat,districtAreaInfo.areaName,"","");
							_this.map.getMap().addOverlay(mySquare);
							districtAreaMarkers.push(mySquare);
						}
					}
				},
				complete:function(XMLHttpRequest) {
					_this.removeMapLoading(); //�Ƴ���ͼ������
				},
				error: function() {
					alert('����δ�ҵ���Դ��������ѡ��');
				}
			});
		}
	},
	/**
     * ��ͼ��Դ��������ʾ
     */
	addMapLoading:function(){
		var htm='<div class="loadingsty"><div class="location_indicator"></div><div class="content_loadinfo">Ŭ��������...</div></div>';
        $('#t_L').html(htm);
        $('#t_L').show();
	},
	/**
     * �Ƴ���ͼ��������ʾ
     */
	removeMapLoading:function(){
		$('#t_L').css('display', 'none');
        $('#t_L').empty();
	},
	//�Ƴ�����Marker
	hideDistrictAreaMarker:function(){
		this.map._map.clearOverlays();
		// for(var i=0;i<districtMarkers.length;i++){map.removeOverlay(districtMarkers[i]);}
		// districtMarkers=[];	
	},
	//��ʾ��������Marker
	showSingleDistrictMarker:function(){
		var _this=this;
		// console.log(_this);
		_this.hideSingleDistrictMarker();
		console.log(districtAreaInfo);
		if(districtAreaInfo.length>0){
			var html = '<div class="mapFinddingCanvasLabelStyle11"><table cellpadding=0 cellspacing=0 border=0><tr><td class="s1" >&nbsp;</td><td class="s2" ><img src="'+tplurl+'newmap/images/icon004.gif" alt="" />'+districtAreaInfo[0].name+'</td><td class="s3">&nbsp;&nbsp;</td><td class="s4"></td></tr><tr><td colspan="3" class="s5"></td></tr></table></div>';
			// var center=new BMap.Point(districtAreaInfo[0].px,districtAreaInfo[0].py);
			// singleDistrictMarker(center,html);
			
			var point = new BMap.Point(districtAreaInfo[0].lng,districtAreaInfo[0].lat);
			var mySquare = new ComplexCustomOverlay(point,html,html);
			_this.map.getMap().addOverlay(mySquare);
			districtAreaMarkers.push(mySquare);	
		}
	},
	//�Ƴ���������
	hideSingleDistrictMarker:function(){
		var _this=this;
		for(var i=0;i<districtAreaMarkers.length;i++){_this.map.getMap().removeOverlay(districtAreaMarkers[i]);}
		districtAreaMarkers=[];
	},
	//��������Maker
	singleDistrictMarker:function(point,html){
		// map.setZoom(mapInfo.singleDistrictZoom);
		// map.panTo(point);
        // var marker = new SquareOverlay(point, 100,html,10000,"","",districtAreaInfo[0].px,districtAreaInfo[0].py,districtAreaInfo[0].name,"","");
        // map.addOverlay(marker);
        // districtAreaMarkers.push(marker);
	},
	
	getFilterAjaxUrl:function(){
		// var urlParam = 'type/'+escape(mapInfo.maptype)+'/district/'+escape(searchHouseInfo.district)+'/x1/'+ escape(searchHouseInfo.x1) + '/x2/' + escape(searchHouseInfo.x2) + '/y1/' + escape(searchHouseInfo.y1) + '/y2/' + escape(searchHouseInfo.y2) + '/page/' + escape(searchHouseInfo.projpageindex)+'/keyword/'+escape(searchHouseInfo.keyword)+'/';
		// var url = CMS_ABS + uri2MVC('ajax/newmap/entry/CommunityPointData/'+urlParam);
	},
	/**
		ȡһ������ĳ���ʱ���磺 object.length��ȡ������Ϊundefined. 
		ȡ����� ���� �ַ����ĺ��� 
	 *  ȡString ���� object�ĳ���
	 * 
	 * */
	count:function(o){
		var t = typeof o;
		if(t == 'string'){
				return o.length;
		}else if(t == 'object'){
				var n = 0;
				for(var i in o){
						n++;
				}
				return n;
		}
		return false;
	},
    //��ȡ����
    getURLRequest: function() {
        var url = window.location.href;
        var theRequest = {};
        if (url.indexOf("#") != -1) {
            var strs = url.split("#")[1].split("&");
            for (var i = 0; i < strs.length; i++) {
                theRequest[strs[i].split("=")[0]] = decodeURIComponent(strs[i].split("=")[1]);
            }
        }
        return theRequest;
    }
};
