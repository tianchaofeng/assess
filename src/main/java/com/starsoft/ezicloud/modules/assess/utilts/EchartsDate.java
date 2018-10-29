package com.starsoft.ezicloud.modules.assess.utilts;

import java.util.List;
/**
 * 数据
 * name   数据名称or数据所有者
 * list   数据具体值
 * */
public class EchartsDate {

	private String Name;
	private List<Element> list;
	
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public List<Element> getList() {
		return list;
	}
	public void setList(List<Element> list) {
		this.list = list;
	}
	
}
