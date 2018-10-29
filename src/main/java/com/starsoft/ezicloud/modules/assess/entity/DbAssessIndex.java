/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.entity;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.starsoft.ezicloud.common.persistence.DataEntity;

/**
 * 考核指标Entity
 * @author zsd
 * @version 2017-09-18
 */
public class DbAssessIndex extends DataEntity<DbAssessIndex> {
	
	private static final long serialVersionUID = 1L;
	private DbLevel levelId;		// 评价级别id
	private DbLevel levelId1;		// 评价级别id一级
	private DbLevel levelId2;		// 评价级别id二级
	private String content;		// 内容
	private String def1;		// 自定义1
	private String def2;		// 自定义2
	private String def3;		// 自定义3
	private String def4;		// 自定义4
	private String def5;		// 自定义5
	
	private List<String> list = new ArrayList<String>();
	public DbAssessIndex() {
		super();
	}

	public DbAssessIndex(String id){
		super(id);
	}

	
	
	

	public DbLevel getLevelId() {
		return levelId;
	}

	public void setLevelId(DbLevel levelId) {
		this.levelId = levelId;
	}

	@Length(min=0, max=64, message="内容长度必须介于 0 和 64 之间")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	@Length(min=0, max=255, message="自定义1长度必须介于 0 和 255 之间")
	public String getDef1() {
		return def1;
	}

	public void setDef1(String def1) {
		this.def1 = def1;
	}
	
	@Length(min=0, max=255, message="自定义2长度必须介于 0 和 255 之间")
	public String getDef2() {
		return def2;
	}

	public void setDef2(String def2) {
		this.def2 = def2;
	}
	
	@Length(min=0, max=255, message="自定义3长度必须介于 0 和 255 之间")
	public String getDef3() {
		return def3;
	}

	public void setDef3(String def3) {
		this.def3 = def3;
	}
	
	@Length(min=0, max=255, message="自定义4长度必须介于 0 和 255 之间")
	public String getDef4() {
		return def4;
	}

	public void setDef4(String def4) {
		this.def4 = def4;
	}
	
	@Length(min=0, max=255, message="自定义5长度必须介于 0 和 255 之间")
	public String getDef5() {
		return def5;
	}

	public void setDef5(String def5) {
		this.def5 = def5;
	}

	public DbLevel getLevelId1() {
		return levelId1;
	}

	public void setLevelId1(DbLevel levelId1) {
		this.levelId1 = levelId1;
	}

	public DbLevel getLevelId2() {
		return levelId2;
	}

	public void setLevelId2(DbLevel levelId2) {
		this.levelId2 = levelId2;
	}

	public List<String> getList() {
		return list;
	}

	public void setList(List<String> list) {
		this.list = list;
	}
	
}