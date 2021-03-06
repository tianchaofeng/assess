/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.entity;

import org.hibernate.validator.constraints.Length;
import java.util.List;
import com.google.common.collect.Lists;

import com.starsoft.ezicloud.common.persistence.DataEntity;

/**
 * 问卷Entity
 * @author zsd
 * @version 2017-09-19
 */
public class DbQuestionnaire extends DataEntity<DbQuestionnaire> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 问卷名称
	private String score;		// score
	private String def1;		// 自定义1
	private String def2;		// 自定义2
	private String def3;		// 自定义3
	private String def4;		// 自定义4
	private String def5;		// 自定义5
	private List<ReQuestionnaireAssess> reQuestionnaireAssessList = Lists.newArrayList();		// 子表列表
	
	public DbQuestionnaire() {
		super();
	}

	public DbQuestionnaire(String id){
		super(id);
	}

	@Length(min=0, max=64, message="评价工具名称长度必须介于 0 和 64 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=64, message="score长度必须介于 0 和 64 之间")
	public String getScore() {
		return score;
	}

	public void setScore(String score) {
		this.score = score;
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
	
	public List<ReQuestionnaireAssess> getReQuestionnaireAssessList() {
		return reQuestionnaireAssessList;
	}

	public void setReQuestionnaireAssessList(List<ReQuestionnaireAssess> reQuestionnaireAssessList) {
		this.reQuestionnaireAssessList = reQuestionnaireAssessList;
	}
}