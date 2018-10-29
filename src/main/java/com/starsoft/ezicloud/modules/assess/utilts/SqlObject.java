package com.starsoft.ezicloud.modules.assess.utilts;

import java.util.ArrayList;
import java.util.List;

import com.starsoft.ezicloud.common.utils.StringUtils;

public class SqlObject {

	private String cloums; //列
	private String conditions;//条件
	private String table;//表
	private String joins;//join
	private String group; //group
	private String order; //排序项
	private String ord; //排序方式
	private String def1;
	private String def2;
	private String def3;
	
	
	
	public String getDef1() {
		return def1;
	}

	public void setDef1(String def1) {
		this.def1 = def1;
	}

	public String getDef2() {
		return def2;
	}

	public void setDef2(String def2) {
		this.def2 = def2;
	}

	public String getDef3() {
		return def3;
	}

	public void setDef3(String def3) {
		this.def3 = def3;
	}

	public String getCloums() {
		return cloums;
	}

	public void setCloums(String cloums) {
		this.cloums = cloums;
	}

	public String getConditions() {
		return conditions;
	}

	public void setConditions(String conditions) {
		this.conditions = conditions;
	}

	public String getTable() {
		return table;
	}

	public void setTable(String table) {
		this.table = table;
	}

	public String getJoins() {
		return joins;
	}

	public void setJoins(String joins) {
		this.joins = joins;
	}

	public String getGroup() {
		return group;
	}

	public void setGroup(String group) {
		this.group = group;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public String getOrd() {
		return ord;
	}

	public void setOrd(String ord) {
		this.ord = ord;
	}

	@Override
	public String toString() {
		
		 StringBuffer bf = new StringBuffer();
		 bf.append("Select ").append(cloums).append(" from ").append(table);
		 if(StringUtils.isNotBlank(joins)){
			bf.append(joins);
		 }
		 if(StringUtils.isNotBlank(conditions)){
		 bf.append(" where ").append(conditions);
		 }
		 if(group != null){
		 bf.append(" group by ").append(group);
		 }
		 if(order != null){
		 bf.append(" order by ").append(order);
		 }
		 if(StringUtils.isNotBlank(ord)){
		 bf.append(" ").append(ord);
		 }
		return bf.toString();
	}
	
	public static void main(String[] args) {
		
	}
}
