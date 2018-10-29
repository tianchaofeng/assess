/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.entity;

import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;
import com.starsoft.ezicloud.common.persistence.DataEntity;

/**
 * 统计汇总Entity
 * @author tcf
 * @version 2017-10-24
 */
public class ViewJob extends DataEntity<ViewJob> {
	
	private static final long serialVersionUID = 1L;
	private String job;		// 任务名称
	private String course;		// 科目
	private String teacher;		// 教师
	private String area;		// 区域
	private String school;		// 学校
	private Date startDate;		// 考评开始时间
	private Date endDate;		// 考评结束时间
	private String score;		// 分数
	private String version;		// 版本
	private String grade;		// 年级
	private String ce;		// 上下册
	private String bookunit;		// 单元
	private String chapter;		// 章节
	
	private String def1;
	private String def2;
    private String def3;
	
	private List<String> viewJobL = Lists.newArrayList();		// 子表列表
	
	
	public ViewJob() {
		super();
	}

	public ViewJob(String id){
		super(id);
	}

	@Length(min=0, max=64, message="任务名称长度必须介于 0 和 64 之间")
	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}
	
	@Length(min=0, max=64, message="科目长度必须介于 0 和 64 之间")
	public String getCourse() {
		return course;
	}

	public void setCourse(String course) {
		this.course = course;
	}
	
	@Length(min=0, max=100, message="教师长度必须介于 0 和 100 之间")
	public String getTeacher() {
		return teacher;
	}

	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}
	
	@Length(min=0, max=100, message="区域长度必须介于 0 和 100 之间")
	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}
	
	@Length(min=0, max=100, message="学校长度必须介于 0 和 100 之间")
	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
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
	
	@Length(min=0, max=64, message="版本长度必须介于 0 和 64 之间")
	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}
	
	
	@Length(min=0, max=64, message="年级长度必须介于 0 和 64 之间")
	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}
	
	@Length(min=0, max=64, message="上下册长度必须介于 0 和 64 之间")
	public String getCe() {
		return ce;
	}

	public void setCe(String ce) {
		this.ce = ce;
	}
	
	@Length(min=0, max=64, message="单元长度必须介于 0 和 64 之间")
	public String getBookunit() {
		return bookunit;
	}

	public void setBookunit(String bookunit) {
		this.bookunit = bookunit;
	}
	
	@Length(min=0, max=64, message="章节长度必须介于 0 和 64 之间")
	public String getChapter() {
		return chapter;
	}

	public void setChapter(String chapter) {
		this.chapter = chapter;
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

	public List<String> getViewJobL() {
		return viewJobL;
	}

	public void setViewJobL(List<String> viewJobL) {
		this.viewJobL = viewJobL;
	}
	
}