/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.entity;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.google.common.collect.Lists;
import com.starsoft.ezicloud.common.persistence.DataEntity;
import com.starsoft.ezicloud.modules.sys.entity.User;

/**
 * 个人任务Entity
 * @author tcf
 * @version 2017-09-19
 */
public class DbJobSelf extends DataEntity<DbJobSelf> {
	
	private static final long serialVersionUID = 1L;
	private DbJob jobId;		// job_id
	private User target;		// 考评目标
	private User participant;		// 参评人
	private String name;		// 名称
	private String type;		// 考评类型
	private DbQuestionnaire questionnaireId;		// 问卷id
	private Date startDate;		// 考评开始时间
	private Date endDate;		// 考评结束时间
	private String score;		// 总得分
	
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
	private String def5;		// 自定义5
	private List<ReJobSelefAssess> reJobSelefAssessList = Lists.newArrayList();
	
	
	private String isAssess;   //能否评分
	
	
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

	public DbJobSelf() {
		super();
	}

	public DbJobSelf(String id){
		super(id);
	}

	public DbJob getJobId() {
		return jobId;
	}

	public void setJobId(DbJob jobId) {
		this.jobId = jobId;
	}

	public User getTarget() {
		return target;
	}

	public void setTarget(User target) {
		this.target = target;
	}

	public User getParticipant() {
		return participant;
	}

	public void setParticipant(User participant) {
		this.participant = participant;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

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

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getScore() {
		return score;
	}

	public void setScore(String score) {
		this.score = score;
	}

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

	public List<ReJobSelefAssess> getReJobSelefAssessList() {
		return reJobSelefAssessList;
	}

	public void setReJobSelefAssessList(List<ReJobSelefAssess> reJobSelefAssessList) {
		this.reJobSelefAssessList = reJobSelefAssessList;
	}

	public String getIsAssess() {
		return isAssess;
	}

	public void setIsAssess(String isAssess) {
		this.isAssess = isAssess;
	}
	
	
}