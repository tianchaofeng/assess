/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.starsoft.ezicloud.common.persistence.DataEntity;
import com.starsoft.ezicloud.modules.sys.entity.User;

/**
 * 任务创建Entity
 * @author suxl
 * @version 2017-09-19
 */
public class DbJob extends DataEntity<DbJob> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 名称
	private String type;		// 考评类型
	private DbQuestionnaire questionnaireId;		// 问卷id
	private User evaluationTarget;		// 考评目标
	private DbEvaluatingTeam teamId;		// 参评小组
	private User participantId;		// 参评人
	private Date startDate;		// 考评开始时间
	private Date endDate;		// 考评结束时间
	
	private String version;		// 版本
	private String grade;		// 年级
	private DbClassCourse discipline;		// 学科
	private String ce;		// 上下册
	private String bookunit;		// 单元
	private String chapter;	
	
	private String def1;		// 自定义1
	private String def2;		// 自定义2
	private String def3;		// 自定义3
	private String def4;		// 自定义4
	private String def5;		// 教案
	
	
	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public DbClassCourse getDiscipline() {
		return discipline;
	}

	public void setDiscipline(DbClassCourse discipline) {
		this.discipline = discipline;
	}

	public String getCe() {
		return ce;
	}

	public void setCe(String ce) {
		this.ce = ce;
	}

	public String getBookunit() {
		return bookunit;
	}

	public void setBookunit(String bookunit) {
		this.bookunit = bookunit;
	}

	public String getChapter() {
		return chapter;
	}

	public void setChapter(String chapter) {
		this.chapter = chapter;
	}

	public DbJob() {
		super();
	}

	public DbJob(String id){
		super(id);
	}

	@Length(min=0, max=64, message="名称长度必须介于 0 和 64 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=1, message="考评类型长度必须介于 1 和 1 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public DbQuestionnaire getQuestionnaireId() {
		return questionnaireId;
	}

	public void setQuestionnaireId(DbQuestionnaire questionnaireId) {
		this.questionnaireId = questionnaireId;
	}
	
	public User getEvaluationTarget() {
		return evaluationTarget;
	}

	public void setEvaluationTarget(User evaluationTarget) {
		this.evaluationTarget = evaluationTarget;
	}
	
	public DbEvaluatingTeam getTeamId() {
		return teamId;
	}

	public void setTeamId(DbEvaluatingTeam teamId) {
		this.teamId = teamId;
	}
	
	public User getParticipantId() {
		return participantId;
	}

	public void setParticipantId(User participantId) {
		this.participantId = participantId;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		if (startDate == null) {
			startDate = new Date();
		}
		this.startDate = startDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	public String getDef1() {
		return def1;
	}

	public void setDef1(String def1) {
		this.def1 = def1;
	}
	
	@Length(min=0, max=64, message="自定义2长度必须介于 0 和 64 之间")
	public String getDef2() {
		return def2;
	}

	public void setDef2(String def2) {
		this.def2 = def2;
	}
	
	@Length(min=0, max=64, message="自定义3长度必须介于 0 和 64 之间")
	public String getDef3() {
		return def3;
	}

	public void setDef3(String def3) {
		this.def3 = def3;
	}
	
	@Length(min=0, max=64, message="自定义4长度必须介于 0 和 64 之间")
	public String getDef4() {
		return def4;
	}

	public void setDef4(String def4) {
		this.def4 = def4;
	}
	
	public String getDef5() {
		return def5;
	}

	public void setDef5(String def5) {
		this.def5 = def5;
	}
	
}