package com.starsoft.ezicloud.modules.assess.utilts;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 将实体类装换为echarts的json串集合
 * @author tcf
 * @date  2017/09/21
 * */
public class EchartsDateUtils {


	/** 
	 * 获取legend
	 * List<Date.name>
	 * legend      
	 * 整条数据名称
	 * ['预算分配（Allocated Budget）', '实际开销（Actual Spending）','哈哈哈!!!!!']
	 * */
	public static List<String> getLegend(List<EchartsDate> list){
		List<String> legend = new ArrayList<String>();
		for(EchartsDate date : list){
			legend.add(date.getName());
		}
		return legend;
	}
	
	
	/**
	 * 雷达图元素整合
	 * 只展示所共有的元素
	 * List<Element.k,Element.m>
	 * indicator
	 * 统计元素名称
	 * [
     *     { name: '销售（sales）', max: 6500},
     *     { name: '管理（Administration）', max: 16000},
     *     { name: '信息技术（Information Techology）', max: 30000},
     *     { name: '客服（Customer Support）', max: 38000},
     *     { name: '研发（Development）', max: 52000},
     *     { name: '市场（Marketing）', max: 25000},
     *     { name: '人脉（Friends）', max: 100}
     *  ]
	 * */
	public static List<Map<String,Object>> getIndicator(List<EchartsDate> list){
		List<Map<String,Object>> legend = new ArrayList<Map<String,Object>>();
		Map <String,Double> map = new HashMap<String, Double>();//统计元素,最大值
		
		List<Element> datum = list.get(0).getList();//去重基准初始化数据
		List<String> datumstr = new ArrayList<String>();//去重基准线
		for(Element dat:datum){
			datumstr.add(dat.getK());
		}
		
		List<String> datumstr1 = new ArrayList<String>();//新去重基准线
		int n=0;
		for(EchartsDate date : list){
			n++;
			List<Element> elementlist = date.getList();
			datumstr1.clear();//新的去重基准线清空
			for(Element e:elementlist){
			 
				String k = e.getK();
				if(datumstr.contains(k)){//k值在去重基准线内
					datumstr1.add(k);//新去重基准线可能会比旧值少
					
					if(map.containsKey(k)){//统计元素在去重基准线内
						
						if(map.get(k)<e.getM()){//更新最大值
							map.put(k, e.getM());
						}
							
					}else{//统计元素不在去重基准线内
						if(n>1){
							map.remove(k);
						}else{
							map.put(k, e.getM());
						}
					}
				}else{//k值不在去重基准线内
					map.remove(k);
				}
			}
			datumstr.clear();//旧的去重基准线清空
			datumstr.addAll(datumstr1);//新值赋予旧值
		}
		
		for(String k:map.keySet()){
			
			if(datumstr.contains(k)){
				Map<String,Object> mm = new HashMap<String, Object>();
				mm.put("name", k);
				mm.put("max", map.get(k));
				legend.add(mm);
			}
			
			
		}
		return legend;
	}
	
	/**  
	 * 数据集合
	 * @param t 数据格式  0为int 1为double
	 * 
	 * List<name,List<Element.v>>
	 * series
	 * 具体数据,顺序和名称需对应
	 * [
     *  {value : [4, 1, 2, 3, 5, 5,3],name : '预算分配（Allocated Budget）'},
     *  {value : [5, 1, 2, 3, 4, 2,4],name : '实际开销（Actual Spending）'},
     *  {value : [3, 1, 2, 2, 4, 1,4],name : '哈哈哈!!!!!'}
     * ]
	 * */
	
	public static List<Map<String,Object>> getSeries(List<EchartsDate> list,String t){
		List<Map<String,Object>> series = new ArrayList<Map<String,Object>>();//具体数据
		List<Map<String, Object>> indicator = getIndicator(list);//元素
		List<String> ind= new ArrayList<String>();//元素
		for(Map<String, Object> m: indicator){
			String key = (String)m.get("name");
			ind.add(key);
		}
		
		for(EchartsDate date : list){
			List<Element> elementlist = date.getList();
			List<Object> vlist = new ArrayList<Object>();
			Map<Integer,Object> im = new HashMap<Integer, Object>();
			for(Element e:elementlist){
				String k = e.getK();
				double v = e.getV();
				double v1 = e.getV1();
				if(ind.contains(k)){
					int indexOf = ind.indexOf(k);
                     if(t.equals("1")){
						im.put(indexOf, v1);//位置,数据
					}else{
					im.put(indexOf, v);//位置,数据
					}
				}
			}
			for(int i=0;i<im.size();i++){
				vlist.add(im.get(i));
			}
			Map<String,Object> mm = new HashMap<String, Object>();
			mm.put("name", date.getName());
			mm.put("value", vlist);
			
			series.add(mm);
		}
		
		return series;
	}
	

	/**
	 *  条形图的y轴
	 *  type = category
	 * */ 
	public static Map<String,Object> getyAxis(List<String> list, String type,String name){
		Map<String,Object>  yAxis = new HashMap<String, Object>();
		yAxis.put("data", list);
		yAxis.put("type", type);
		if(name!=null){
			yAxis.put("name", name);
		}
		return yAxis;
	}
	
	/**
	 * 条形图数据集合
	 * @param t  返回数据类型  1：double  0：int
	 * @param  li  统计基数，y轴数据
	 * type =bar
	 * */
	public static List<Map<String,Object>> getSeries2(List<EchartsDate> list,String type,List<String> li,String t){
		List<Map<String,Object>> series = new ArrayList<Map<String,Object>>();//具体数据

		
		
		
		for(EchartsDate date : list){
			List<Element> elementlist = date.getList();
			List<Object> vlist = new ArrayList<Object>();//数据集
			Map<Integer,Object> im = new HashMap<Integer, Object>();//位置,数据
			for(Element e:elementlist){
				String k = e.getK();//元素
				double v = e.getV();//数据
				double v1 = e.getV1();//数据
				if(li.contains(k)){//数据是要统计的数据
					int indexOf = li.indexOf(k); //位置
					if(t.equals("1")){
						
						im.put(indexOf, v1);//位置,数据
					}
					im.put(indexOf, v);//位置,数据
				}
			}
			for(int i=0;i<li.size();i++){
				if(im.containsKey(i)){
					vlist.add(im.get(i));
				}else{
					vlist.add(null);
				}
			}
			Map<String,Object> mm = new HashMap<String, Object>();
			mm.put("name", date.getName());
			mm.put("type", type);
			mm.put("data", vlist);
			
			series.add(mm);
		}
		
		return series;
	}
	
	
	public static void main(String[] args) {
		
		List<EchartsDate> listdate = new ArrayList<EchartsDate>();
//		for(int j = 1;j<6;j++){
		EchartsDate date = new EchartsDate();
			date.setName("数据1");
		List<Element> list = new ArrayList<Element>();
		Element e = new Element();
		e.setK("key1");
		e.setV(1);
		e.setM(3);
		list.add(e);
		Element e1 = new Element();
		e1.setK("key2");
		e1.setV(2);
		e1.setM(3);
		list.add(e1);
		Element e2 = new Element();
		e2.setK("key3");
		e2.setV(5);
		e2.setM(5);
		list.add(e2);
		/*for(int i=1;i<5;i++){
			Element e = new Element();
			e.setK("key"+i);
			e.setV(i%3+j);
			e.setM(i+j);
			list.add(e);
		}*/
		date.setList(list);
		listdate.add(date);
		
		
		EchartsDate date2 = new EchartsDate();
		date2.setName("数据2");
		List<Element> list2 = new ArrayList<Element>();
		Element e11 = new Element();
		e11.setK("key1");
		e11.setV(1);
		e11.setM(3);
		list2.add(e11);
		Element e12 = new Element();
		e12.setK("key3");
		e12.setV(2);
		e12.setM(3);
		list2.add(e12);
		Element e22 = new Element();
		e22.setK("key5");
		e22.setV(5);
		e22.setM(5);
		list2.add(e22);
		/*for(int i=1;i<5;i++){
			Element e = new Element();
			e.setK("key"+i);
			e.setV(i%3+j);
			e.setM(i+j);
			list.add(e);
		}*/
		date2.setList(list2);
		listdate.add(date2);
		
		
		
		
		EchartsDate date3 = new EchartsDate();
		date3.setName("数据3");
		List<Element> list3 = new ArrayList<Element>();
		Element e31 = new Element();
		e31.setK("key5");
		e31.setV(1);
		e31.setM(3);
		list3.add(e31);
		Element e13 = new Element();
		e13.setK("key2");
		e13.setV(2);
		e13.setM(33);
		list3.add(e13);
		Element e23 = new Element();
		e23.setK("key3");
		e23.setV(5);
		e23.setM(7);
		list3.add(e23);
		/*for(int i=1;i<5;i++){
			Element e = new Element();
			e.setK("key"+i);
			e.setV(i%3+j);
			e.setM(i+j);
			list.add(e);
		}*/
		date3.setList(list3);
		listdate.add(date3);
//		}
		/*for(Date d:listdate){
			for(Element e:d.getList()){
				System.out.println(d.getName() +"\n"+e.getK()+":"+e.getV()+";"+e.getM());
				System.out.println();
			}
		}*/
		
		EchartsDateUtils  util = new EchartsDateUtils();
		List<String> l  = new ArrayList<String>();
		l.add("key1");
		l.add("key2");
		l.add("key3");
		l.add("key4");
		l.add("key5");
		Map<String, Object> y = util.getyAxis(l, "category", null);
		System.out.println(y);
		List<Map<String, Object>> indicator = util.getSeries2(listdate,"bar",l,"0");
		System.out.println(indicator);
		
	}
	
}
