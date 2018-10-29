/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.entity;

import org.hibernate.validator.constraints.Length;
import java.util.List;
import com.google.common.collect.Lists;

import com.starsoft.ezicloud.common.persistence.DataEntity;

/**
 * 班级课程信息Entity
 * @author suxl
 * @version 2017-10-10
 */
public class DbClassCourse extends DataEntity<DbClassCourse> {
	
	private static final long serialVersionUID = 1L;
	private String version;		// 版本
	private String grade;		// 年级
	private DbCourseinfo discipline;		// 学科
	private String ce;		// 上下册
	private String bookunit;		// 单元
	private String def1;		// 自定义1
	private String def2;		// 自定义2
	private String def3;		// 自定义3
	private String def4;		// 自定义4
	private String def5;		// 自定义5
	private List<DbClassCourseChild> dbClassCourseChildList = Lists.newArrayList();		// 子表列表
	
	
	private List<String> dbList=Lists.newArrayList();
	
	
	
	public List<String> getDbList() {
		return dbList;
	}

	public void setDbList(List<String> dbList) {
		this.dbList = dbList;
	}

	public DbClassCourse() {
		super();
	}

	public DbClassCourse(String id){
		super(id);
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
	
//	@Length(min=0, max=64, message="学科长度必须介于 0 和 64 之间")
	public DbCourseinfo getDiscipline() {
		return discipline;
	}

	public void setDiscipline(DbCourseinfo discipline) {
		this.discipline = discipline;
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
	
	public List<DbClassCourseChild> getDbClassCourseChildList() {
		return dbClassCourseChildList;
	}

	public void setDbClassCourseChildList(List<DbClassCourseChild> dbClassCourseChildList) {
		this.dbClassCourseChildList = dbClassCourseChildList;
	}
}