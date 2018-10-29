/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.entity;

import org.hibernate.validator.constraints.Length;

import com.starsoft.ezicloud.common.persistence.DataEntity;

/**
 * 问卷Entity
 * @author zsd
 * @version 2017-09-19
 */
public class ReQuestionnaireAssess extends DataEntity<ReQuestionnaireAssess> {
	
	private static final long serialVersionUID = 1L;
	private DbQuestionnaire questionnaireId;		// 问卷id
	private DbAssessIndex assessId;		// 三级指标id
	private String assessId1;		// 一级指标id
	private String assessId2;		// 二级指标id
	private String proportion;		// 比重   改成排序
	private String def1;		// 自定义1
	private String def2;		// 自定义2
	private String def3;		// 自定义3
	private String def4;		// 自定义4
	private String def5;		// 自定义5
	
	private String content;		//评分要点
	private String score;       //分
	
	public ReQuestionnaireAssess() {
		super();
	}

	public ReQuestionnaireAssess(String id){
		super(id);
	}

	
	
	public DbQuestionnaire getQuestionnaireId() {
		return questionnaireId;
	}

	public void setQuestionnaireId(DbQuestionnaire questionnaireId) {
		this.questionnaireId = questionnaireId;
	}

	
	
	public DbAssessIndex getAssessId() {
		return assessId;
	}

	public void setAssessId(DbAssessIndex assessId) {
		this.assessId = assessId;
	}

	@Length(min=0, max=64, message="比重长度必须介于 0 和 64 之间")
	public String getProportion() {
		return proportion;
	}

	public void setProportion(String proportion) {
		this.proportion = proportion;
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

	public String getAssessId1() {
		return assessId1;
	}

	public void setAssessId1(String assessId1) {
		this.assessId1 = assessId1;
	}

	public String getAssessId2() {
		return assessId2;
	}

	public void setAssessId2(String assessId2) {
		this.assessId2 = assessId2;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getScore() {
		return score;
	}

	public void setScore(String score) {
		this.score = score;
	}
	
}